import os
import re
import json
from openai import OpenAI
from dotenv import load_dotenv

load_dotenv()

def read_file(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()

def load_context_scripts(script_paths, model):
    max_lines = -1  # Default to no limit
    if model.startswith("model_name"):  # change to any model if error in input token limit
        max_lines = 200

    context = {}
    for path in script_paths:
        filename = os.path.basename(path)
        content = read_file(path)
        if max_lines > 0:
            lines = content.splitlines()
            if len(lines) > max_lines:
                content = "\n".join(lines[:max_lines]) + "\n... (truncated) ...\n"
        context[filename] = content
    return context

def build_prompt(mode, script_code, log, script_name, paper=None, context_scripts=None):
    if mode == "minimal":
        return f"""You are an AI assistant helping to fix an R script that has failed.

        --- Error Log ---
        {log}

        --- R Script ({script_name}) ---
        {script_code}

        Fix the script so it runs successfully. Add #comments to beside explain your changes.
        VERY IMPORTANT: Return only the corrected R code. Do not include any explanatory text, markdown formatting, or any other tags like <think> or ```r."""

    elif mode == "medium":
        return f"""You are an AI assistant helping to fix an R script using paper context and error log.
        Below is an R script that is either incomplete or failing due to errors. Error logs (below) are provided to help you understand the issues.
        Use the paper's context (below) to understand what the script is trying to do and fix any issues, 
        including missing code, incorrect file paths, maskedout or NotImplemented functions, or undefined functions or dependencies issues.\n\n
        --- Paper (Markdown) ---
        {paper}

        --- Error Log ---
        {log}

        --- R Script ({script_name}) ---
        {script_code}

        Fix the script so it runs successfully. Add #comments to beside explain your changes.
        VERY IMPORTANT: Return only the corrected R code. Do not include any explanatory text, markdown formatting, or any other tags like <think> or ```r."""

    elif mode == "full":
        context = "\n\n".join([f"# File: {name}\n{code}" for name, code in context_scripts.items()])
        return f"""You are an AI assistant fixing an R script using full context.
        You are an AI R programmer helping with computational reproducibility.\n
        You are given:

        1. The R script (below), which contains errors and those can be including missing code, incorrect file paths, maskedout or NotImplemented functions, or undefined functions or dependencies issues.\n\n
        2. Several other R scripts, which may help with context.\n
        3. A markdown version of the research paper to understand what the function should do.\n
        4. The error log from the last time the script was run.\n

        Your task: Read the log file and see the Script to modify and understand the error and fix the error in the file listed below, using the provided context.\n
        The function to implement is in the file: {script_name}\n\n
        --- Paper (Markdown) ---
{paper}\n\n
        --- Other R Scripts (Context) ---
{context}\n\n
        --- Last Run Error Log ---\n{log}\n\n
        --- Script to Modify ({script_name}) ---
        {script_code}\n\n
        --- Task ---


        If there are NotImplemented functions, implement them **in-place** within the script above. Use the paper, other scripts, and log to help.

        Fix the script so it runs successfully, using context from the paper and other scripts. 

        Add #comments to beside explain your changes.

        VERY IMPORTANT: Return only the corrected R code. Do not include any explanatory text, markdown formatting, or any other tags like <think> or ```r."""

    else:
        raise ValueError("Invalid mode. Use: minimal, medium, or full")

def get_openai_client(api_provider, api_key=None):
    if api_provider == "openai":
        return OpenAI(api_key=api_key)
    elif api_provider == "openrouter":
        return OpenAI(
            api_key=api_key,
            base_url="https://openrouter.ai/api/v1"
        )
    elif api_provider == "chatai":
        return OpenAI(
            api_key=api_key,
            base_url="https://chat-ai.academiccloud.de/v1"
        )
    else:
        raise ValueError(f"Unknown API provider: {api_provider}")

def clean_response(response):
    # Remove <think> tags
    response = re.sub(r"<think>.*?</think>", "", response, flags=re.DOTALL)
    # Remove ```r markdown
    if response.startswith("```r") and response.endswith("```"):
        response = response[4:-3].strip()
    return response

def fix_multiple_files(target_scripts, contextual_scripts, markdown_path, log_path, api_key, model, mode, api_provider):
    client = get_openai_client(api_provider, api_key)
    
    paper = read_file(markdown_path) if mode in ["medium", "full"] else None
    context_scripts = load_context_scripts(contextual_scripts, model) if mode == "full" else None
    log = read_file(log_path)

    fixed_script_paths = []
    for script_path in target_scripts:
        script_name = os.path.basename(script_path)
        script_code = read_file(script_path)

        prompt = build_prompt(mode, script_code, log, script_name, paper, context_scripts)

        try:
            response = client.chat.completions.create(
                model=model,
                messages=[
                    {"role": "system", "content": "You are a helpful AI R programmer."},
                    {"role": "user", "content": prompt}
                ],
                temperature=0.2,
                max_tokens=24000,
                extra_body={"provider": {
                    "allow_fallbacks": True
                }}
            )

            fixed_code = response.choices[0].message.content.strip()
            fixed_code = clean_response(fixed_code)
            
            if script_name.startswith("fixed_"):
                output_path = os.path.join(os.path.dirname(script_path), script_name)
            else:
                output_path = os.path.join(os.path.dirname(script_path), f"fixed_{script_name}")
            with open(output_path, "w", encoding="utf-8") as f:
                f.write(fixed_code)
            print(f" Fixed: {output_path}")
            fixed_script_paths.append(output_path)

        except json.JSONDecodeError:
            print("  ERROR: Failed to decode JSON response from API. The API might be down or returning an error page.")
            print("  Skipping this fix attempt.")

    return fixed_script_paths
