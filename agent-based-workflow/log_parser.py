import json
import sys
import argparse

def count_tokens(log_file_path):
    total_input_tokens = 0
    total_output_tokens = 0
    found_final_result = False

    try:
        with open(log_file_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        # First, try to find the final 'result' block which has the grand total
        for line in reversed(lines):
            try:
                entry = json.loads(line.strip())
                if entry.get("type") == "result" and "usage" in entry:
                    usage = entry["usage"]
                    total_input_tokens = usage.get('input_tokens', 0)
                    total_output_tokens = usage.get('output_tokens', 0)
                    found_final_result = True
                    break
            except (json.JSONDecodeError, KeyError):
                continue
        
        # If no final result block is found, sum up the individual messages
        if not found_final_result:
            for line in lines:
                try:
                    entry = json.loads(line.strip())
                    if entry.get("type") == "assistant" and "message" in entry and "usage" in entry["message"]:
                        usage = entry["message"]["usage"]
                        total_input_tokens += usage.get('input_tokens', 0)
                        total_output_tokens += usage.get('output_tokens', 0)
                except (json.JSONDecodeError, KeyError):
                    continue

        # Output in a structured way that can be parsed
        print(json.dumps({
            "total_input_tokens": total_input_tokens,
            "total_output_tokens": total_output_tokens,
            "total_tokens": total_input_tokens + total_output_tokens
        }))

    except FileNotFoundError:
        print(json.dumps({"error": f"Log file not found at {log_file_path}"}))
    except Exception as e:
        print(json.dumps({"error": f"An error occurred: {e}"}))


def parse_and_pretty_print_log(log_file_path, output_file_path=None):
    output_lines = []

    try:
        with open(log_file_path, 'r', encoding='utf-8') as f:
            for line_num, line in enumerate(f, 1):
                # This is a workaround for the Claude CLI which sometimes prints "--- AGENT LOGS ---"
                if "--- AGENT LOGS ---" in line or "--- END AGENT LOGS ---" in line:
                    continue
                try:
                    entry = json.loads(line.strip())
                    output_lines.append(f"--- Log Entry {line_num} ---")
                    
                    entry_type = entry.get("type", "UNKNOWN_TYPE")
                    session_id = entry.get("session_id", "N/A")
                    uuid = entry.get("uuid", "N/A")

                    output_lines.append(f"Type: {entry_type}")
                    output_lines.append(f"Session ID: {session_id}")
                    output_lines.append(f"UUID: {uuid}")

                    if entry_type == "assistant":
                        message = entry.get("message", {})
                        role = message.get("role", "N/A")
                        content = message.get("content", [])
                        model = message.get("model", "N/A")
                        stop_reason = message.get("stop_reason", "N/A")

                        output_lines.append(f"Role: {role} (Model: {model})")
                        output_lines.append(f"Stop Reason: {stop_reason}")
                        
                        for item in content:
                            item_type = item.get("type", "UNKNOWN_CONTENT_TYPE")
                            if item_type == "text":
                                output_lines.append(f"  Text: {item.get('text', '')}")
                            elif item_type == "tool_use":
                                tool_name = item.get("name", "N/A")
                                tool_input = item.get("input", {})
                                output_lines.append(f"  Tool Use: {tool_name}")
                                output_lines.append(f"    Input: {json.dumps(tool_input, indent=2)}")
                            else:
                                output_lines.append(f"  Content Type: {item_type}")
                                output_lines.append(f"    Content: {json.dumps(item, indent=2)}")
                    elif entry_type == "user":
                        message = entry.get("message", {})
                        role = message.get("role", "N/A")
                        content = message.get("content", [])
                        
                        output_lines.append(f"Role: {role}")
                        for item in content:
                            item_type = item.get("type", "UNKNOWN_CONTENT_TYPE")
                            if item_type == "tool_result":
                                output_lines.append(f"  Tool Result for ID: {item.get('tool_use_id', 'N/A')}")
                                output_lines.append(f"    Content: {item.get('content', '')}")
                                output_lines.append(f"    Is Error: {item.get('is_error', False)}")
                            else:
                                output_lines.append(f"  Content Type: {item_type}")
                                output_lines.append(f"    Content: {json.dumps(item, indent=2)}")
                    elif entry_type == "result":
                        subtype = entry.get("subtype", "N/A")
                        result_message = entry.get("result", "N/A")
                        output_lines.append(f"Result Subtype: {subtype}")
                        output_lines.append(f"Result: {result_message}")
                        if entry.get("permission_denials"):
                            output_lines.append("  Permission Denials:")
                            for denial in entry["permission_denials"]:
                                output_lines.append(f"    - Tool: {denial.get('tool_name', 'N/A')}, Input: {json.dumps(denial.get('tool_input', {}), indent=2)}")
                    else:
                        output_lines.append(f"Raw Entry: {json.dumps(entry, indent=2)}")
                    output_lines.append("\n" + "="*50 + "\n") # Separator

                except json.JSONDecodeError:
                    # Don't print errors for non-json lines, just skip them
                    pass
                except Exception as e:
                    output_lines.append(f"An unexpected error occurred on line {line_num}: {e}")
                    output_lines.append(f"Problematic line: {line.strip()}")

    except FileNotFoundError:
        output_lines.append(f"Error: Log file not found at {log_file_path}")
    except Exception as e:
        output_lines.append(f"An error occurred: {e}")

    if output_file_path:
        with open(output_file_path, 'w', encoding='utf-8') as f:
            for line in output_lines:
                f.write(line + '\n')
        print(f"Pretty-printed log saved to {output_file_path}")
    else:
        for line in output_lines:
            print(line)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Parse agent logs. Can pretty-print or count tokens.")
    parser.add_argument("log_file", help="Path to the agent's run.log file.")
    
    action_group = parser.add_mutually_exclusive_group(required=True)
    action_group.add_argument("--count-tokens", action="store_true", help="Count the total tokens from the log file.")
    action_group.add_argument("--pretty-print", action="store_true", help="Generate a pretty-printed version of the log.")

    parser.add_argument("-o", "--output", help="Output file path for the pretty-printed log.")

    args = parser.parse_args()

    if args.count_tokens:
        if args.output:
            print("Warning: --output is ignored when using --count-tokens.")
        count_tokens(args.log_file)
    elif args.pretty_print:
        parse_and_pretty_print_log(args.log_file, args.output)
