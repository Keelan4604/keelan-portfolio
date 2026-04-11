import argparse
import csv
import re
from pathlib import Path

ROOT = Path(r"C:\Users\Keela\.openclaw\workspace\career\job-hunt-aerospace")
TRACKER_CSV = ROOT / "tracker" / "job_tracker.csv"
APPLICATIONS = ROOT / "applications"


def safe_name(value: str) -> str:
    value = re.sub(r"[\\/:*?\"<>|]", "-", value.strip())
    value = re.sub(r"\s+", " ", value)
    value = value.rstrip(" .")
    return value[:100]


def make_packet(row):
    company = safe_name(row["company"])
    role = safe_name(row["role"])
    folder = APPLICATIONS / company / role
    folder.mkdir(parents=True, exist_ok=True)
    (folder / "README.md").write_text(
        f"# {row['company']} — {row['role']}\n\n"
        f"- Location: {row['location']}\n"
        f"- Decision: {row['decision_bucket']}\n"
        f"- Resume lane: {row['resume_lane']}\n"
        f"- Cover letter: {row['cover_letter']}\n"
        f"- Source URL: {row['source_url']}\n",
        encoding="utf-8",
    )
    (folder / "job_snapshot.md").write_text(
        "# Job Snapshot\n\nPaste the full job description here.\n",
        encoding="utf-8",
    )
    (folder / "company_notes.md").write_text(
        f"# Company Notes\n\nWhy this role/company may matter:\n- {row['why_it_matches']}\n",
        encoding="utf-8",
    )
    (folder / "tailoring_notes.md").write_text(
        f"# Tailoring Notes\n\n- Resume lane: {row['resume_lane']}\n- Next step: {row['next_step']}\n- Notes: {row['notes']}\n",
        encoding="utf-8",
    )
    (folder / "cover_letter.md").write_text(
        f"# Cover Letter Draft\n\nDear Hiring Team,\n\nI am applying for the {row['role']} role at {row['company']}.\n\n"
        "[Use Keelan's resume and the pasted job description to tailor this tightly.]\n\n"
        "Sincerely,\nKeelan O'Doherty\n",
        encoding="utf-8",
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--decision", default="Apply now")
    args = parser.parse_args()
    with TRACKER_CSV.open(newline="", encoding="utf-8") as f:
        rows = list(csv.DictReader(f))
    selected = [row for row in rows if row.get("decision_bucket") == args.decision]
    for row in selected:
        make_packet(row)
    print(f"prepared {len(selected)} application folders for decision bucket: {args.decision}")
