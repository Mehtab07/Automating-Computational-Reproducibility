import argparse
import os
import subprocess
import csv
import json
import time
import tempfile
from datetime import datetime, timedelta
from dotenv import load_dotenv

load_dotenv()

def get_exit_status_description(exit_code):
    """
    Returns a human-readable description for common shell exit codes.
    """
    if exit_code == 0:
        return "Success"
    elif exit_code == 1:
        return "Error"
    elif exit_code == 126:
        return "Command cannot execute"
    elif exit_code == 127:
        return "Command not found"
    elif exit_code == 128:
        return "Invalid argument to exit"
    elif exit_code == 130:
        return "Terminated by Ctrl+C"
    elif exit_code == 137:
        return "Terminated by SIGKILL (Container Stopped, timeout, OOM)"
    elif exit_code is None:
        return "Process still running or no exit code"
    else:
        return f"Exited with code {exit_code}"

def main():
    parser = argparse.ArgumentParser(description="Run Gemini or OpenCode CLI Agents in a Docker container to analyze or fix an R scripts.")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--single", help="Path to the single sample folder to mount.")
    group.add_argument("--batch", help="Path to the batch folder to search for error folders.")
    parser.add_argument("--agent", required=False, default="opencode", choices=["gemini", "opencode", "claude"], help="Which agent CLI to use.")
    parser.add_argument("--timeout", type=int, help="Timeout in seconds for the agent to run.")
    args = parser.parse_args()

    folders_to_process = []
    if args.single:
        single_folder_path = os.path.abspath(args.single)
        if not os.path.isdir(single_folder_path):
            print(f"Error: Folder not found at {single_folder_path}")
            return
        folders_to_process.append(single_folder_path)
    elif args.batch:
        batch_folder_path = os.path.abspath(args.batch)
        if not os.path.isdir(batch_folder_path):
            print(f"Error: Folder not found at {batch_folder_path}")
            return
        
        for root, dirs, files in os.walk(batch_folder_path):
            for dir_name in dirs:
                if dir_name.startswith('error'):
                    folders_to_process.append(os.path.join(root, dir_name))

    base_dir = os.path.dirname(os.path.abspath(__file__))
    prompt_file = os.path.join(base_dir, "prompt.txt")
    with open(prompt_file, "r", encoding="utf-8") as f:
        prompt = f.read()
        
    image_name = "my-agent-base:latest"
    agent = args.agent
    
    model_name = "N/A"
    if agent == "opencode":
        config_path = os.path.join(base_dir, "opencode_config", "opencode.json")
        try:
            with open(config_path, "r") as f:
                config = json.load(f)
                model_name = config.get("agent", {}).get("build", {}).get("model", "N/A")
        except FileNotFoundError:
            print(f"Warning: opencode.json not found at {config_path}")
            model_name = "N/A"
        except json.JSONDecodeError:
            print(f"Warning: Could not decode opencode.json at {config_path}")
            model_name = "N/A"
    elif agent == "claude":
        config_path = os.path.join(base_dir, "claude_code_router_config", "config.json")
        try:
            with open(config_path, "r") as f:
                config = json.load(f)
                model_name = config.get("Router", {}).get("default", "N/A").split(',')[1]
        except FileNotFoundError:
            print(f"Warning: claude_code_router_config/config.json not found at {config_path}")
            model_name = "N/A"
        except (json.JSONDecodeError, IndexError):
            print(f"Warning: Could not decode or parse model from claude_code_router_config/config.json at {config_path}")
            model_name = "N/A"

    env_vars = []
    if agent == "opencode":
        openrouter_api_key = os.environ.get("OPENROUTER_API_KEY")
        if openrouter_api_key:
            env_vars = ["-e", f"OPENROUTER_API_KEY={openrouter_api_key}"]
            config_path = os.path.join(base_dir, "opencode_config")
            command = 'opencode --log-level DEBUG run "$(< /prompt.txt)" --agent build'
            if args.timeout:
                command = f"timeout {args.timeout} {command}"
        else:
            print("No OPENROUTER_API_KEY found — cannot run OpenCode CLI.")
            return
    elif agent == "claude":
        openrouter_api_key = os.environ.get("OPENROUTER_API_KEY")
        if openrouter_api_key:
            env_vars = ["-e", f"OPENROUTER_API_KEY={openrouter_api_key}"]
            config_path = os.path.join(base_dir, "claude_code_router_config")
            command = 'ccr stop; nohup ccr start & sleep 5 && ANTHROPIC_BASE_URL=http://localhost:3456 ANTHROPIC_API_KEY=dummy claude -p "$(< /prompt.txt)" --permission-mode acceptEdits --allowedTools "Bash,Edit,Write,Read,TodoWrite,Grep" --verbose --output-format stream-json'
            if args.timeout:
                command = f"timeout {args.timeout} {command}"
        else:
            print("No OPENROUTER_API_KEY found — cannot run Claude CLI via router.")
            return
    else: # gemini agent
        google_api_key = os.environ.get("GOOGLE_API_KEY")
        if google_api_key:
            env_vars = ["-e", f"GOOGLE_API_KEY={google_api_key}"]
            print("Using GOOGLE_API_KEY from environment.")
        else:
            print("No GOOGLE_API_KEY found — running Gemini CLI in unauthenticated mode.")
        config_path = None # Gemini does not use a config path
        command = 'gemini -p "$(< /prompt.txt)" --output-format json'

    with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix=".txt", encoding='utf-8') as tmp_prompt:
        tmp_prompt.write(prompt)
        prompt_file_path = tmp_prompt.name

    try:
        for folder_path in folders_to_process:
            print(f"\nProcessing folder: {folder_path}\n")

            path_parts = folder_path.split(os.sep)
            sample_folder = None
            for part in path_parts:
                if part.startswith("sample"):
                    sample_folder = part
                    break
            
            # Create a list for the base results mount
            base_mount = []
            if sample_folder:
                base_results_dir = os.path.join(base_dir, sample_folder, "base")
                if os.path.isdir(base_results_dir):
                    base_mount = ["-v", f"{base_results_dir}:/base_results"]

            max_retries = 3
            retries_count = 0
            for attempt in range(max_retries):
                retries_count = attempt
                print(f"--- Starting attempt {attempt + 1}/{max_retries} ---")
                
                # Construct the docker command
                docker_command = [
                    "docker", "run", "--rm",
                    "-v", f"{folder_path}:/workspace",
                    "-v", f"{prompt_file_path}:/prompt.txt",
                    *env_vars,
                    *base_mount,
                ]
                if config_path:
                    docker_command.extend(["-v", f"{config_path}:/root/.config/opencode" if agent == "opencode" else f"{config_path}:/root/.claude-code-router"])
                docker_command.extend([
                    image_name,
                    "bash", "-c", command
                ])

                agent_log_file = os.path.join(folder_path, "run.log")
                start_time = datetime.now()

                with open(agent_log_file, "w", encoding="utf-8") as log_file:
                    process = subprocess.Popen(docker_command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, encoding='utf-8', errors='replace')
                    
                    print("--- AGENT LOGS ---")
                    log_file.write("--- AGENT LOGS ---\n")

                    for line in process.stdout:
                        print(line, end='')
                        log_file.write(line)
                    
                    process.wait()
                    print("--- END AGENT LOGS ---")
                    log_file.write("--- END AGENT LOGS ---\n")

                end_time = datetime.now()
                duration = (end_time - start_time).total_seconds()
                exit_status = process.returncode

                log_parser_path = os.path.join(base_dir, "log_parser.py")

                # Pretty-print the log file if it was a claude run
                if agent == "claude":
                    if os.path.exists(log_parser_path):
                        pretty_log_path = os.path.join(os.path.dirname(agent_log_file), "pretty_run.log")
                        print("\n--- Parsing Agent Logs for Pretty Print ---")
                        subprocess.run(["python", log_parser_path, "--pretty-print", agent_log_file, "-o", pretty_log_path])
                        print(f"--- Parsed Agent Logs saved to {pretty_log_path} ---")
                
                print(f"\nAgent output saved to {agent_log_file}")

                status_file_path = os.path.join(folder_path, "status.txt")
                
                # Check for silent exit
                log_file_size = os.path.getsize(agent_log_file)
                status_file_exists = os.path.exists(status_file_path)

                if status_file_exists or exit_status == 124:
                    break  # Success or timeout, exit retry loop
                else:
                    print(f"Agent exited without creating status.txt on attempt {attempt + 1}/{max_retries}. Retrying in 5 seconds...")
                    if attempt < max_retries - 1:
                        time.sleep(5)

            input_tokens = "N/A"
            output_tokens = "N/A"
            if agent == "claude" and os.path.exists(log_parser_path):
                print("\n--- Calculating Token Usage ---")
                try:
                    token_result = subprocess.run(
                        ["python", log_parser_path, "--count-tokens", agent_log_file],
                        capture_output=True, text=True, check=True
                    )
                    token_data = json.loads(token_result.stdout)
                    input_tokens = token_data.get("total_input_tokens", "N/A")
                    output_tokens = token_data.get("total_output_tokens", "N/A")
                    print(f"Input tokens: {input_tokens}, Output tokens: {output_tokens}")
                except (subprocess.CalledProcessError, json.JSONDecodeError, FileNotFoundError) as e:
                    print(f"Could not calculate tokens: {e}")


            reproducibility_status = "Not available"
            if os.path.exists(status_file_path):
                try:
                    with open(status_file_path, "r", encoding="utf-8") as f:
                        reproducibility_status = f.read().strip()
                except UnicodeDecodeError:
                    reproducibility_status = "Error parsing status.txt"

            log_file = "Categories.csv"
            file_exists = os.path.isfile(log_file)
            
            dir_name = os.path.basename(folder_path)
            error_name = '_'.join(dir_name.split('_')[2:]) if dir_name.startswith('error') else 'N/A'
            error_type = os.path.basename(os.path.dirname(folder_path))

            with open(log_file, "a", newline="", encoding="utf-8") as csvfile:
                writer = csv.writer(csvfile)
                if not file_exists:
                    writer.writerow(["timestamp", "folder", "error_type", "error_name", "agent", "model_used", "time_taken_s", "exit_status", "exit_status_description", "reproducibility_status", "retries", "input_tokens", "output_tokens"])
                try:
                    writer.writerow([
                        start_time.strftime("%Y-%m-%d %H:%M:%S"),
                        folder_path,
                        error_type,
                        error_name,
                        agent,
                        model_name,
                        f"{duration:.2f}",
                        exit_status,
                        get_exit_status_description(exit_status),
                        reproducibility_status,
                        retries_count,
                        input_tokens,
                        output_tokens
                    ])
                except UnicodeEncodeError:
                    writer.writerow([
                        start_time.strftime("%Y-%m-%d %H:%M:%S"),
                        folder_path,
                        error_type,
                        error_name,
                        agent,
                        model_name,
                        f"{duration:.2f}",
                        exit_status,
                        get_exit_status_description(exit_status),
                        reproducibility_status.encode("utf-8").decode("ascii", "ignore"),
                        retries_count,
                        input_tokens,
                        output_tokens
                    ])

            print(f"\n Run complete. Exit status: {exit_status}. Logged to {log_file}.")
    finally:
        os.unlink(prompt_file_path)

if __name__ == "__main__":
    main()