# Automating Computational Reproducibility in Social Science

![Project Illustration](prompt-based-workflow/workflow.png)

## Abstract

Reproducing computational research is often assumed to be as simple as re-running the original code with the provided data. In practice, this rarely works. Missing packages, fragile file paths, version conflicts, or incomplete logic frequently cause published analyses to fail, even when authors share all materials. This study asks whether large language models (LLMs) and AI agents can help automate the practical work of diagnosing and repairing such failures, making computational results easier to reproduce and verify.

We evaluate this idea using a controlled reproducibility testbed built from five fully reproducible R-based social science studies. We deliberately injected realistic failures ranging from simple issues to complex missing logic and tested two automated repair workflows in clean Docker environments. The first workflow followed a prompt-based approach, where LLMs were repeatedly queried with structured prompts of varying contextual richness, while the second used agent-based systems that could inspect files, modify code, and re-run analyses inside the environment.

Across prompt-based runs, reproduction success ranged from 31–78%, with performance strongly influenced by prompt context and error complexity. Complex cases benefited most from additional context. Agent-based workflows performed substantially better across all levels of complexity, with success rates ranging from 69–96%. Overall, our results suggest that automated workflows, especially agent-based repair systems, can significantly reduce the manual effort required for computational reproducibility and improve reproduction success across a wide range of error types in research workflows. Unlike prior reproducibility benchmarks that focus on replication from minimal artifacts, our benchmark isolates post-publication repair under controlled failure modes, enabling a direct comparison between prompt-based and agent-based workflows.

## Repository Overview

This repository contains the code and data for research study investigating the use of Large Language Models (LLMs) and AI agents to automate the repair of computational reproducibility failures in R-based scientific code. It features two distinct, self-contained workflows: an **Agent-Based Workflow** and a **Prompt-Based Workflow**, each designed to diagnose and fix common issues encountered when reproducing computational research.

## Repository Structure

The repository is organized into two primary directories, each encapsulating a complete workflow:

```
.
├── prompt-based-workflow/          # Contains the Prompt-Based Reproducibility Workflow
└── agent-based-workflow/           # Contains the Agent-Based Reproducibility Workflow
```

## Workflow 1: Prompt-Based Reproducibility

This workflow implements an Reproducibility workflow that directly queries LLMs with structured prompts to diagnose and repair R script failures. It includes sophisticated validation steps to check for hallucination and scientific reproducibility.

### Directory Structure

The `prompt-based-workflow/` directory contains:

```
prompt-based-workflow/
├── __pycache__/
├── .gitattributes
├── .gitignore
├── Categories.csv                  # Results log for this workflow
├── config.py                       # Configuration settings for the workflow
├── docker-compose.yml              # Docker Compose file for environment setup
├── Dockerfile                      # Main Dockerfile for the prompt-based environment
├── Dockerfile.r-image              # Dockerfile for the R execution environment
├── error_fix.py                    # LLM-based script fixer engine
├── hallucination_check.py          # Script for checking LLM output against the original script results
├── main.py                         # Main orchestrator script for this workflow
├── pdftomd.py                      # Utility for PDF to Markdown conversion
├── reproducibility_check.py        # Script for verifying scientific claims against the paper
├── requirements.txt                # Python dependencies for this workflow
└── samples                         # Test cases for this workflow (sample1-5)
    ├── sample1/
    │   ├── base/                   # Reference output for sample1
    │   └── ... (error_XXX folders with R scripts, data, paper.md)
    └── ... (sample2-5 structured similarly)
```

### How It Works

Orchestrated by `main.py`, this workflow operates within an isolated Docker environment defined by `Dockerfile` and `Dockerfile.r-image`. When an R script fails, the system gathers the broken code, error logs, and contextual intent (from `paper.md`). It then constructs a structured prompt for an LLM (e.g., Qwen-Coder, GPT-4o) to generate a fix. After patching the code, it re-executes and proceeds to validate the results using `hallucination_check.py` and `reproducibility_check.py`.

### Setup

1.  **Navigate:** Change directory to `prompt-based-workflow/`.
    ```bash
    cd prompt-based-workflow/
    ```
2.  **Build Docker Images:** Build the necessary Docker images.
    ```bash
    docker build -f Dockerfile.r-image -t r-image .
    docker build -f Dockerfile -t prompt-repro-env .
    # Or use docker-compose for convenience
    # docker-compose up --build -d
    ```
3.  **Install Python Dependencies:**
    ```bash
    pip install -r requirements.txt
    ```
4.  **API Keys:** Ensure your `OPEN_ROUTER_API_KEY` or `OPENAI_API_KEY` are set as environment variables.

### Usage

Run the `main.py` script, specifying the desired sample and execution mode.

```bash
python main.py samples/<sample_id>/<error_path> --mode <mode>
```

*   `<sample_id>`: e.g., `sample1`.
*   `<error_path>`: e.g., `easy/error_101_wrong-path`.
*   `<mode>`: `minimal`, `medium`, or `full` (determines the contextual richness of the prompt sent to the LLM).

**Example:**

To run the full mode on `sample1`'s `error_101_wrong-path` case:

```bash
python main.py samples/sample1/easy/error_101_wrong-path --mode full
```

### Output & Analysis

This workflow logs detailed results into `prompt-based-workflow/Categories.csv`, including success status, attempts, and validation outcomes. The `hallucination_check.py` and `reproducibility_check.py` scripts provide granular insights into the quality and scientific integrity of the LLM-generated fixes.

## Workflow 2: Agent-Based Reproducibility

This workflow employs AI agents to interactively diagnose, modify, and re-run R scripts within a Dockerized environment, aiming to achieve computational reproducibility. It simulates a research assistant capable of inspecting the environment and performing fixes.

### Directory Structure

The `agent-based-workflow/` directory contains:

```
agent-based-workflow/
├── Categories.csv                  # Results log for this workflow
├── Dockerfile                      # Docker image definition for the agent environment
├── log_parser.py                   # Utility to parse agent logs
├── prompt.txt                      # The core prompt guiding the agent's behavior
├── run.py                          # Main script to orchestrate agent runs
├── claude_code_router_config/      # Configuration for claude agent 
├── opencode_config/                # Configuration for the opencode agent 
└── samples                         # Test cases for this workflow (sample 1-5)
    ├── sample1/
    │   ├── base/                   # Reference output for sample1
    │   └── ... (error_XXX folders with R scripts, data, paper.md)
    └── ... (sample2-5 structured similarly)
```

### How It Works

The `run.py` script acts as the orchestrator. It sets up a Docker container based on `Dockerfile`, which includes an R environment and necessary agent CLI tools. It then leverages an AI agent ( OpenCode, or Claude agent) to attempt to reproduce R scripts from the `samples/` directory. The agent follows instructions in `prompt.txt` to identify errors, apply minimal fixes, and report the reproducibility status (`status.txt`).

### Setup

1.  **Navigate:** Change directory to `agent-based-workflow/`.
    ```bash
    cd agent-based-workflow/
    ```
2.  **Build Docker Image:** Build the Docker image required for the agent's execution environment.
    ```bash
    docker build -t my-agent-base:latest .
    ```
3.  **API Keys:** Ensure your `OPENROUTER_API_KEY` is set as environment variables.

## Usage

The core of this project is the `run.py` script, which orchestrates the execution of the AI agents. The script can be run in two modes: `--single` and `--batch`.

### Command-Line Arguments

-   `--single`: The path to a single directory containing the R script(s) you want the agent to analyze.
-   `--batch`: The path to a directory to be searched recursively for subdirectories starting with "error". The agent will be run on each of these "error" directories.
-   `--agent`: The AI agent to use. The available options are `opencode`, and `claude`.

You must provide either the `--single` or the `--batch` argument.

### Examples

-   **Running on a single folder:**
    ```bash
    python run.py --single sample1/easy/error_101_wrong-path
    ```

-   **Running in batch mode:**
    This command will search the `sample1` directory and run the agent on all "error" folders found within it.
    ```bash
    python run.py --batch sample1
    ```
-   **Using the `claude` agent:**
    ```bash
    python run.py --single sample1/easy/error_101_wrong-path --agent claude
    ```

The script will execute the chosen agent within the Docker container, mounting the specified folder(s) as a workspace. The agent will then attempt to understand and fix the R scripts in that directory.

### Output & Analysis

Results from each run, including performance metrics and reproducibility status, are logged into `agent-based-workflow/Categories.csv`. The `log_parser.py` utility can be used for post-processing and analyzing the detailed logs generated by the `claude` agent.

---