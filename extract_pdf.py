from pathlib import Path
import sys

p = Path(r"C:\Users\Keela\.openclaw\workspace\special project 1.pdf")
text = ""

err = None
try:
    import pypdf
    reader = pypdf.PdfReader(str(p))
    for i, page in enumerate(reader.pages, 1):
        t = page.extract_text() or ""
        text += f"\n\n--- PAGE {i} ---\n" + t
except Exception as e:
    err = e
    try:
        import PyPDF2
        reader = PyPDF2.PdfReader(str(p))
        for i, page in enumerate(reader.pages, 1):
            t = page.extract_text() or ""
            text += f"\n\n--- PAGE {i} ---\n" + t
    except Exception as e2:
        print("ERROR", err, e2)
        sys.exit(1)

out = Path(r"C:\Users\Keela\.openclaw\workspace\special_project_1_extracted.txt")
out.write_text(text, encoding="utf-8")
print("WROTE", out, "chars", len(text))
