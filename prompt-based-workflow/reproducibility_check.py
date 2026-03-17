import os
from openai import OpenAI
from dotenv import load_dotenv
import glob
import argparse
from config import SAMPLES_CONFIG

load_dotenv()

def read_markdown(md_path: str) -> str:
    with open(md_path, "r", encoding="utf-8") as f:
        return f.read()

def read_result_files(result_paths: list) -> str:
    combined = ""
    for path in result_paths:
        if os.path.isfile(path):
            with open(path, "r", encoding="utf-8") as f:
                combined += f"--- File: {os.path.basename(path)} ---\n{f.read().strip()}\n\n"
        else:
            combined += f"--- File Missing: {path}---\n\n"
    return combined

def summarize_comparison_with_openai(markdown_text: str, result_text: str, api_key: str, model="gpt-4.1-2025-04-14", max_tokens=5000) -> str:
    client = OpenAI(api_key=api_key, base_url="https://openrouter.ai/api/v1")
    prompt = (
        f"""You are an academic AI assistant. Compare the following **code execution results** with the findings reported in the **paper section below**.
        Identify any inconsistencies, missing values, or mismatches. Comment on the validity, reproducibility, and accuracy of results and then respond
        === Code Execution Results ===
        {result_text}
        === Paper Markdown Section ===
        {markdown_text}"""
    )
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "system", "content": "You are a rigorous and detail-oriented research assistant."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.8,
        max_tokens=max_tokens
    )
    return response.choices[0].message.content

def compare_markdown_and_results(md_path: str, result_files: list, api_key: str, output_txt: str):
    if not result_files:
        print(f"  ERROR: No result files found. Terminating check for this path.")
        return

    markdown_text = read_markdown(md_path)
    result_text = read_result_files(result_files)
    summary = summarize_comparison_with_openai(markdown_text, result_text, api_key)

    with open(output_txt, "w", encoding="utf-8") as f:
        f.write("Summary of comparison between paper and code-generated results:\n\n")
        f.write(summary)
        print(f"Reproducibility check complete.\nSummary saved to {output_txt}")

def main():
    parser = argparse.ArgumentParser(description="Run the reproducibility check for specified samples.")
    parser.add_argument(
        "samples", 
        nargs='+', 
        help="A list of sample directories to process (e.g., sample1 sample2)."
    )
    args = parser.parse_args()

    api_key = os.getenv("OPEN_ROUTER_API_KEY")
    if not api_key:
        print("OPEN_ROUTER_API_KEY not found in environment variables. Aborting.")
        return

    for sample_path in args.samples:
        # Find the base configuration for the given path (e.g., 'sample1' for 'sample1/easy/error_101')
        base_name = next((key for key in SAMPLES_CONFIG.keys() if sample_path.startswith(key)), None)

        if base_name:
            print(f"\n--- Processing {sample_path} (using config from {base_name}) ---")
            config = SAMPLES_CONFIG[base_name]
            
            # Construct paths relative to the specific sample_path provided
            paper_path = os.path.join(sample_path, config['paper'])
            results_glob_pattern = os.path.join(sample_path, config['results_glob'])
            result_files = glob.glob(results_glob_pattern)
            output_summary_path = os.path.join(sample_path, "paper_vs_results_summary.txt")

            if not os.path.exists(paper_path):
                print(f"  ERROR: Paper not found at {paper_path}")
                continue
            
            compare_markdown_and_results(
                md_path=paper_path,
                result_files=result_files,
                api_key=api_key,
                output_txt=output_summary_path
            )
        else:
            print(f"\n--- Skipping '{sample_path}': No base configuration found in SAMPLES_CONFIG ---")

if __name__ == "__main__":
    main()
