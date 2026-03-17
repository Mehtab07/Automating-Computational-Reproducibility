import os
import json
from openai import OpenAI
from dotenv import load_dotenv
import re

load_dotenv()

def get_hallucination_status_and_reason(markdown_text: str, result_text: str, base_result_text: str, api_key: str, model: str, api_provider: str, max_tokens=3000):
    client = OpenAI(api_key=api_key)
    if api_provider == "openrouter":
        client.base_url = "https://openrouter.ai/api/v1"
    elif api_provider == "chatai":
        client.base_url = "https://chat-ai.academiccloud.de/v1"

    prompt = (
        f"""You are an academic AI assistant. Your task is to compare a script's execution results against two sources: the original research paper and the results from a 'base' version of the script.

        Your response must be a single JSON object with three keys:
        1.  `base_reproducibility_status`: Classify the reproducibility against the base script's results.
        2.  `paper_reproducibility_status`: Classify the reproducibility against the paper.
        3.  `paper_reproducibility_reason`: A concise, one-sentence explanation for the comparison with paper and base script results.
        

        For both `status` keys, use one of the following classifications: "Reproduced", "Partially Reproduced", or "Not Reproduced".

        Example:
        {{
            "paper_reproducibility_status": "Partially Reproduced",
            "paper_reproducibility_reason": "The script produced the main figures, but statistical values in Table 2 did not match the paper.",
            "base_reproducibility_status": "Reproduced"
        }}

        === Current Script Execution Results ===
        {result_text}

        === Base Script Execution Results ===
        {base_result_text}

        === Paper Markdown Section ===
        {markdown_text}
        """
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
    
    content = response.choices[0].message.content.strip()

    # Extract JSON from markdown code block if present
    json_match = re.search(r"```json\n([\s\S]*?)\n```", content)
    if json_match:
        json_string = json_match.group(1)
    else:
        json_string = content 

    paper_status = "Not Reproduced"
    paper_reason = "LLM failed to provide a valid JSON response."
    base_status = "Not Reproduced"

    try:
        data = json.loads(json_string)
        if isinstance(data, dict):
            if "paper_reproducibility_status" in data and data["paper_reproducibility_status"] in ["Reproduced", "Partially Reproduced", "Not Reproduced"]:
                paper_status = data["paper_reproducibility_status"]
            if "paper_reproducibility_reason" in data:
                paper_reason = data["paper_reproducibility_reason"]
            if "base_reproducibility_status" in data and data["base_reproducibility_status"] in ["Reproduced", "Partially Reproduced", "Not Reproduced"]:
                base_status = data["base_reproducibility_status"]
    except json.JSONDecodeError:
        paper_reason = f"LLM response was not valid JSON: {json_string[:100]}..."

    return paper_status, paper_reason, base_status