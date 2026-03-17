import fitz
import re
import os

def extract_text_from_pdf(pdf_path: str) -> str:
    doc = fitz.open(pdf_path)
    full_text = "\n".join(page.get_text() for page in doc)
    doc.close()
    return full_text.strip()

def split_text_or_return_whole(text: str, headers=None, min_headers=3) -> dict:
    if headers is None:
        headers = [
            "Abstract", "Introduction", "Related Work", "Methodology", "Method", "Methods",
            "Limitations", "Results", "Discussion", "Conclusion", "Conclusions",
            "References","REFERENCES AND NOTES", "Appendix", "Acknowledgments", "COMMENTARY"
        ]

    # Build regex pattern
    pattern = "|".join([rf"\n\s*{header}\s*\n" for header in headers])
    matches = list(re.finditer(pattern, text, flags=re.IGNORECASE))

    # Too few headers? Just return the whole text
    if len(matches) < min_headers:
        return {"Full Text": text.strip()}

    # Otherwise, do section splitting
    sections = {}
    for i in range(len(matches)):
        start = matches[i].end()
        end = matches[i+1].start() if i + 1 < len(matches) else len(text)
        header = matches[i].group().strip()
        section_text = text[start:end].strip()
        sections[header] = section_text

    return sections

def save_sections_to_markdown(section_dict: dict, output_path: str):
    with open(output_path, "w", encoding="utf-8") as f:
        for header, content in section_dict.items():
            f.write(f"## {header.strip()}\n\n{content.strip()}\n\n")

def pdf_to_markdown(pdf_path: str, md_path: str):
    text = extract_text_from_pdf(pdf_path)
    sections = split_text_or_return_whole(text)
    save_sections_to_markdown(sections, md_path)
    print(f"✅ Markdown saved to: {md_path}")

pdf_to_markdown("sampleX/paper.pdf", "sampleX/paper.md")