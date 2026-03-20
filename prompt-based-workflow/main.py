import os
import glob
import subprocess
import argparse
import csv
import json
from datetime import datetime, timedelta
from dotenv import load_dotenv
import docker
from docker.errors import DockerException
import re

from error_fix import fix_multiple_files
from reproducibility_check import compare_markdown_and_results
from hallucination_check import get_hallucination_status_and_reason
from config import SAMPLES_CONFIG

load_dotenv()

# Select the AI model to use for fixing errors.
# Available models:
# - gpt-4o-2024-08-06
# - google/gemini-2.5-pro-preview-06-05
# - qwen/qwen3-coder

SELECTED_MODEL = "qwen/qwen3-coder"

# Select the API provider.
# Available providers: "openai", "openrouter", "chatai"
SELECTED_API_PROVIDER = "openrouter"

ENABLE_REPRO_CHECK = False # Set to True to enable reproducibility check, False to disable
ENABLE_HALLUCINATION_CHECK = True # Set to True to enable hallucination check, False to disable

MAX_FIX_ATTEMPTS = 5 # Maximum number of times to attempt fixing a script

def _filter_install_logs(log_content):
    """Filters out verbose R package installation messages."""
    if not log_content:
        return ""

    # List of regex patterns to identify and remove installation logs
    install_patterns = [
        re.compile(r"^\* installing \*source\* package.*"),
        re.compile(r"^\*\*.*"),
        re.compile(r"^\* DONE.*"),
        re.compile(r"^gfortran.*"),
        re.compile(r"^gcc.*"),
        re.compile(r"^installing to.*"),
        re.compile(r"^The downloaded source packages are in.*"),
        re.compile(r"^trying URL.*"),
        re.compile(r"^Content type.*"),
        re.compile(r"^downloaded.*"),
        re.compile(r"^Installing package into.*"),
        re.compile(r"^\(as ‘lib’ is unspecified\)"),
        re.compile(r"^also installing the dependencies.*"),
    ]

    filtered_lines = []
    for line in log_content.splitlines():
        if not any(pattern.match(line) for pattern in install_patterns):
            filtered_lines.append(line)

    return "\n".join(filtered_lines)


def read_result_files(result_paths: list) -> str:
    combined = ""
    for path in result_paths:
        if os.path.isfile(path):
            with open(path, "r", encoding="utf-8") as f:
                combined += f"""--- File: {os.path.basename(path)} ---
{f.read().strip()}

"""
        else:
            combined += f"""--- File Missing: {path} ---

"""
    return combined


def run_r_script(container, script_path, log_path):
    """Executes an R script inside a given Docker container."""
    script_name = os.path.basename(script_path)
    print(f"Running R script '{script_name}' in existing container...")

    try:
        # Use exec_run on the existing container
        exit_code, (stdout_bytes, stderr_bytes) = container.exec_run(
            cmd=f"Rscript {script_name}",
            demux=True  # demux separates stdout and stderr
        )

        stdout = stdout_bytes.decode('utf-8') if stdout_bytes else ""
        stderr = stderr_bytes.decode('utf-8') if stderr_bytes else ""

        # Filter out installation noise from logs
        filtered_stdout = _filter_install_logs(stdout)
        filtered_stderr = _filter_install_logs(stderr)

        # Write filtered logs to file
        with open(log_path, 'w') as log_file:
            log_file.write(f"--- STDOUT ---\n{filtered_stdout}\n")
            log_file.write(f"--- STDERR ---\n{filtered_stderr}\n")

        return stdout, stderr, exit_code

    except Exception as e:
        error_message = f"An unexpected error occurred with Docker exec_run: {e}"
        print(f"Error: {error_message}")
        with open(log_path, 'w') as log_file:
            log_file.write(f"--- STDERR ---\n{error_message}\n")
        return "", str(e), -1

def execute_workflow(execution_path, config, mode, selected_script, args, error_type, error_name="N/A"):
    """Runs the full workflow for a single execution path and returns the summary data."""
    print(f"\n{'='*20} Processing: {execution_path} {'='*20}")

    # --- Load Test-Specific Config ---
    test_config = {}
    test_config_path = os.path.join(execution_path, 'test_config.json')
    if os.path.exists(test_config_path):
        try:
            with open(test_config_path, 'r') as f:
                test_config = json.load(f)
            print(f"Loaded test-specific config from {test_config_path}")
        except json.JSONDecodeError:
            print(f"Warning: Could not decode JSON from {test_config_path}. Using defaults.")

    # --- Determine which scripts to use ---
    main_script_name = selected_script or test_config.get("script_to_run") or config["r_scripts"][0]
    target_script_for_fixing = test_config.get("script_with_error") or main_script_name

    print(f"Script to run: {main_script_name}")
    if target_script_for_fixing != main_script_name:
        print(f"Script to fix: {target_script_for_fixing}")

    original_main_script_path = os.path.join(execution_path, main_script_name)
    log_path = os.path.join(execution_path, config["log"])

    # --- Initialize run variables ---
    successful_script_path = None
    fix_attempted_flag = False
    fixed_script_exit_code_val = "N/A"
    initial_error_message = "N/A"
    attempts_taken = 0
    llm_cumulative_time = timedelta(0)
    start_time = datetime.now()
    script_to_run = original_main_script_path

    # --- Docker Setup ---
    client = docker.from_env()
    try:
        client.ping()
    except (DockerException, FileNotFoundError):
        print("Error: Docker is not running or not installed. Please start Docker and try again.")
        return None, None

    host_project_path = os.getenv("HOST_PROJECT_PATH")
    if not host_project_path:
        print("Error: HOST_PROJECT_PATH environment variable is not set.")
        return None, None
    host_volume_path = os.path.join(host_project_path, execution_path)

    container = None
    try:
        print("Starting a dedicated Docker container for this test case...")
        container = client.containers.run(
            image="r-image",
            command="tail -f /dev/null",  # Keep container running
            volumes={host_volume_path: {'bind': '/workspace', 'mode': 'rw'}},
            working_dir="/workspace",
            detach=True
        )

        for attempt in range(1, MAX_FIX_ATTEMPTS + 1):
            attempts_taken = attempt
            print(f"\n--- Attempt {attempt} of {MAX_FIX_ATTEMPTS} ---")

            if not os.path.exists(script_to_run):
                if initial_error_message == "N/A":
                    initial_error_message = f"Script '{os.path.basename(script_to_run)}' not found."
                print(f"Error: {initial_error_message} Aborting this run.")
                break

            _, stderr, exit_code = run_r_script(container, script_to_run, log_path)

            if exit_code == 0:
                print(f"Script '{os.path.basename(script_to_run)}' executed successfully.")
                successful_script_path = script_to_run
                break

            print(f"Script '{os.path.basename(script_to_run)}' failed. Attempting to fix...")
            if not fix_attempted_flag:
                fix_attempted_flag = True
                fixed_script_exit_code_val = exit_code
                if os.path.exists(log_path):
                    with open(log_path, 'r', encoding='utf-8') as f:
                        initial_error_message = f.read().strip()
                else:
                    initial_error_message = stderr.strip() if stderr else "R script failed with no stderr output."

            target_script_names = [target_script_for_fixing]
            context_script_names = config["r_scripts"]
            api_key = os.getenv({"openai": "OPENAI_API_KEY", "openrouter": "OPENROUTER_API_KEY", "chatai": "CHAT_AI_API_KEY"}.get(SELECTED_API_PROVIDER))
            if not api_key:
                print(f"{SELECTED_API_PROVIDER.upper()}_API_KEY not found. Skipping fix attempts.")
                break

            paper_path = os.path.join(execution_path, config["paper"])
            llm_start_time = datetime.now()
            fixed_script_paths = fix_multiple_files(
                target_scripts=[os.path.join(execution_path, name) for name in target_script_names],
                contextual_scripts=[os.path.join(execution_path, name) for name in context_script_names],
                markdown_path=paper_path,
                log_path=log_path, api_key=api_key, model=SELECTED_MODEL, mode=mode, api_provider=SELECTED_API_PROVIDER
            )
            llm_cumulative_time += (datetime.now() - llm_start_time)

            if not fixed_script_paths:
                print("Fixer did not generate a fixed script on this attempt. Continuing to next attempt.")
                continue

            fixed_script_path = fixed_script_paths[0]
            if not os.path.exists(fixed_script_path):
                print(f"Fixed script '{os.path.basename(fixed_script_path)}' was not created. Aborting.")
                break

            fixed_main_script_path = os.path.join(execution_path, f"fixed_{main_script_name}")
            script_to_run = fixed_main_script_path if os.path.exists(fixed_main_script_path) else original_main_script_path
            target_script_for_fixing = os.path.basename(fixed_script_path)

            _, stderr, exit_code = run_r_script(container, script_to_run, log_path)

            if exit_code == 0:
                print(f"Script '{os.path.basename(script_to_run)}' executed successfully after fix.")
                successful_script_path = script_to_run
                break
            else:
                print(f"Script still failed after fix.")

    finally:
        if container:
            print("Stopping and removing the Docker container...")
            container.stop()
            container.remove()

    # --- FINALIZE AND SUMMARIZE ---
    final_status = "Failed"
    if successful_script_path:
        final_status = "Success (Fixed)" if fix_attempted_flag else "Success"

        if ENABLE_REPRO_CHECK:
            print("\n--- Starting Reproducibility Check ---")
            # ... (rest of the reproducibility check logic)

        if ENABLE_HALLUCINATION_CHECK:
            print("\n--- Starting Hallucination Check ---")
            paper_path = os.path.join(execution_path, config["paper"])

            markdown_text = ""
            if os.path.exists(paper_path):
                with open(paper_path, 'r', encoding='utf-8') as f:
                    markdown_text = f.read()
            else:
                print(f"Warning: Paper markdown file not found at {paper_path}. Skipping hallucination check.")

            results_glob_pattern = os.path.join(execution_path, config["results_glob"])
            result_files = glob.glob(results_glob_pattern)
            result_text = read_result_files(result_files) if result_files else ""

            # --- Find and read base results ---
            sample_name = execution_path.split(os.sep)[0]
            base_path = os.path.join(sample_name, 'base')
            base_results_glob = os.path.join(base_path, config["results_glob"])
            base_result_files = glob.glob(base_results_glob)
            base_result_text = read_result_files(base_result_files) if base_result_files else ""

            if markdown_text and result_text and base_result_text:
                api_key = os.getenv({"openai": "OPENAI_API_KEY", "openrouter": "OPENROUTER_API_KEY", "chatai": "CHAT_AI_API_KEY"}.get(SELECTED_API_PROVIDER))
                if not api_key:
                    print(f"{SELECTED_API_PROVIDER.upper()}_API_KEY not found. Skipping hallucination check.")
                    paper_status, paper_reason, base_status = "Skipped", f"{SELECTED_API_PROVIDER.upper()} API key not found.", "Skipped"
                else:
                    paper_status, paper_reason, base_status = get_hallucination_status_and_reason(
                        markdown_text=markdown_text,
                        result_text=result_text,
                        base_result_text=base_result_text,
                        api_key=api_key,
                        model="gpt-4.1-2025-04-14", 
                        api_provider=SELECTED_API_PROVIDER
                    )
                print(f"Paper Reproducibility Status: {paper_status} - Reason: {paper_reason}")
                print(f"Base Reproducibility Status: {base_status}")
            else:
                paper_status, paper_reason, base_status = "Skipped", "Missing paper, current results, or base results.", "Skipped"
    else:
        paper_status, paper_reason, base_status = "N/A", "Script failed, check not performed.", "N/A"

    run_data = {
        "timestamp": start_time.strftime("%Y-%m-%d %H:%M:%S"),
        "execution_path": execution_path,
        "error_type": error_type,
        "error_name": error_name,
        "prompt_mode": mode,
        "main_script": main_script_name,
        "fix_attempted": fix_attempted_flag,
        "fixed_script_exit_code": fixed_script_exit_code_val,
        "final_status": final_status,
        "log_file": log_path,
        "error_message": initial_error_message,
        "attempts_taken": attempts_taken,
        "total_time_taken": str(datetime.now() - start_time),
        "llm_time_taken": str(llm_cumulative_time) if fix_attempted_flag else "N/A",
        "model_used": SELECTED_MODEL,
        "base_reproducibility_status": base_status,
        "paper_reproducibility_status": paper_status,
        "paper_reproducibility_reason": paper_reason,
    }
    return run_data, successful_script_path



def write_summary_csv(summary_path, all_run_data):
    """Writes a list of run data dictionaries to a CSV file."""
    if not all_run_data:
        print("No run data to write.")
        return

    fieldnames = list(all_run_data[0].keys())
    # Simplified check for file existence
    file_exists = os.path.isfile(summary_path) and os.path.getsize(summary_path) > 0

    with open(summary_path, 'a', newline='', encoding='utf-8') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        if not file_exists:
            writer.writeheader()
        writer.writerows(all_run_data)
    print(f"Run summary updated at {summary_path}")

def main():
    """Main orchestrator for the reproducibility workflow."""
    parser = argparse.ArgumentParser(description="Run the reproducibility workflow.")
    parser.add_argument(
        "paths",
        nargs='+',
        help="One or more paths to process. Can be a base sample (e.g., sample3), a batch directory (e.g., sample3/easy), or a single test case."
    )
    parser.add_argument(
        "--script",
        default=None,
        help="Optional: The specific R script to run. If not provided, the first script in the config is used."
    )
    parser.add_argument(
        "--error",
        nargs='+',
        default=None,
        help="A list of specific R script filenames known to be corrupted. (Advanced use)"
    )
    parser.add_argument(
        "--mode", 
        choices=["minimal", "medium", "full"],
        default="full", 
        help="The prompt mode to use for the error fixer."
    )
    args = parser.parse_args()

    # Group paths by their master path to handle summary file location correctly
    grouped_paths = {}
    for path in args.paths:
        if not os.path.isdir(path):
            print(f"Warning: Provided path '{path}' is not a directory. Skipping.")
            continue
        
        # A "master" path is one that contains subdirectories like 'easy', 'medium', or 'hard'
        difficulty_levels = [d for d in os.listdir(path) if os.path.isdir(os.path.join(path, d)) and d in ['easy', 'medium', 'hard', 'mid']]
        if difficulty_levels:
            # This is a master path; its children are the process paths
            grouped_paths[path] = [os.path.join(path, level) for level in difficulty_levels]
        else:
            # This is a specific path; it is its own group
            grouped_paths[path] = [path]

    # Process each group of paths
    for summary_location, paths_to_process in grouped_paths.items():
        summary_path = os.path.join(summary_location, "run_summary.csv")
        for path in paths_to_process:
            base_name = next((key for key in SAMPLES_CONFIG.keys() if path.startswith(key)), None)
            if not base_name:
                print(f"Warning: No config found for path '{path}'. Skipping.")
                continue
            config = SAMPLES_CONFIG[base_name]

            # A path can be a batch directory (like 'easy') or a single test case (like 'error_1')
            test_case_dirs = [d for d in os.listdir(path) if 'error' in d and os.path.isdir(os.path.join(path, d))]

            if test_case_dirs:  # Batch Mode (e.g., processing 'sample2/easy')
                print(f"--- Starting Batch Run for: {path} ---")
                error_type = os.path.basename(path)
                for test_dir in sorted(test_case_dirs):
                    error_name_parts = test_dir.split('_')
                    error_name = '_'.join(error_name_parts[2:]) if len(error_name_parts) > 2 else "N/A"
                    test_path = os.path.join(path, test_dir)
                    run_data, _ = execute_workflow(test_path, config, args.mode, args.script, args, error_type, error_name)
                    if run_data:
                        write_summary_csv(summary_path, [run_data])
            else:  # Single Run Mode (e.g., processing 'sample2/easy/error_1')
                print(f"--- Starting Single Run for: {path} ---")
                error_type = os.path.basename(os.path.dirname(path))
                if error_type not in ['easy', 'medium', 'hard']:
                    error_type = 'N/A'

                test_dir_name = os.path.basename(path)
                error_name_parts = test_dir_name.split('_')
                error_name = '_'.join(error_name_parts[2:]) if len(error_name_parts) > 2 else "N/A"
                
                run_data, _ = execute_workflow(path, config, args.mode, args.script, args, error_type, error_name)
                if run_data:
                    write_summary_csv(summary_path, [run_data])

if __name__ == "__main__":
    main()
