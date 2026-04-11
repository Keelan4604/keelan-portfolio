import csv
import json
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List

ROOT = Path(r"C:\Users\Keela\.openclaw\workspace\career\job-hunt-aerospace")
LEADS_CSV = ROOT / "data" / "discovery" / "manual_leads.csv"
TRACKER_CSV = ROOT / "tracker" / "job_tracker.csv"
COMMUTE_JSON = ROOT / "config" / "commute_zones.json"
WEIGHTS_JSON = ROOT / "config" / "scoring_weights.json"

FIELDNAMES = [
    "date_added",
    "company",
    "role",
    "location",
    "distance_bucket",
    "commute_minutes",
    "commute_miles",
    "job_type",
    "fit_level",
    "resume_lane",
    "score",
    "decision_bucket",
    "cover_letter",
    "status",
    "source",
    "source_url",
    "why_it_matches",
    "next_step",
    "notes",
]

@dataclass
class Lead:
    row: Dict[str, str]


def load_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def load_leads() -> List[Lead]:
    with LEADS_CSV.open(newline="", encoding="utf-8") as f:
        return [Lead(r) for r in csv.DictReader(f)]


def normalize_location(value: str) -> str:
    return (value or "").strip().lower()


def infer_resume_lane(role: str, description: str) -> str:
    text = f"{role} {description}".lower()
    if any(k in text for k in ["flight", "test", "validation", "environmental", "lab"]):
        return "Flight/Test"
    if any(k in text for k in ["systems", "hardware", "embedded", "avionics", "integration", "controls"]):
        return "Systems/Hardware"
    return "Mechanical/Design"


def score_fit(role: str, description: str) -> int:
    text = f"{role} {description}".lower()
    score = 0
    for keyword in ["aerospace", "flight", "airborne", "uav", "systems", "hardware", "test", "validation", "mechanical", "integration", "controls"]:
        if keyword in text:
            score += 1
    return min(score, 5)


def bucket_fit_level(score: int) -> str:
    if score >= 4:
        return "High"
    if score >= 2:
        return "Medium"
    return "Low"


def rank_decision(total_score: float) -> str:
    if total_score >= 4.1:
        return "Apply now"
    if total_score >= 3.4:
        return "Apply this week"
    if total_score >= 2.6:
        return "Hold / watch"
    return "Skip"


def should_cover_letter(decision: str, fit_level: str) -> str:
    return "Yes" if decision in {"Apply now", "Apply this week"} and fit_level != "Low" else "Optional"


def dedupe(leads: List[Lead]) -> List[Lead]:
    seen = set()
    kept = []
    for lead in leads:
        key = (
            lead.row.get("company", "").strip().lower(),
            lead.row.get("role", "").strip().lower(),
            lead.row.get("location", "").strip().lower(),
        )
        if key in seen:
            continue
        seen.add(key)
        kept.append(lead)
    return kept


def build_rows() -> List[Dict[str, str]]:
    commute = load_json(COMMUTE_JSON)
    weights = load_json(WEIGHTS_JSON)
    lookup = commute["location_lookup"]

    rows = []
    for lead in dedupe(load_leads()):
        location = lead.row.get("location", "")
        normalized = normalize_location(location)
        commute_info = lookup.get(normalized, {"bucket": "Too far", "minutes": 999, "miles": 999})
        distance_bucket = commute_info["bucket"]
        resume_lane = infer_resume_lane(lead.row.get("role", ""), lead.row.get("description", ""))
        role_fit = score_fit(lead.row.get("role", ""), lead.row.get("description", ""))
        location_fit_map = {"Raleigh core": 5, "Triangle commute": 4, "Extended drive": 2, "Too far": 0}
        resume_fit_map = {"Flight/Test": 5, "Systems/Hardware": 5, "Mechanical/Design": 4}
        job_type = lead.row.get("job_type", "")
        ms_compatibility = 5 if distance_bucket in {"Raleigh core", "Triangle commute"} else 2 if distance_bucket == "Extended drive" else 0
        career_upside = 5 if "aerospace" in (lead.row.get("description", "") + lead.row.get("role", "")).lower() else 3
        application_effort = 4 if "lever.co" in lead.row.get("source_url", "") else 3
        urgency = 3
        total_score = (
            role_fit * weights["role_fit"] +
            location_fit_map[distance_bucket] * weights["location_fit"] +
            resume_fit_map[resume_lane] * weights["resume_fit"] +
            ms_compatibility * weights["ms_compatibility"] +
            career_upside * weights["career_upside"] +
            application_effort * weights["application_effort"] +
            urgency * weights["urgency"]
        )
        fit_level = bucket_fit_level(role_fit)
        decision_bucket = rank_decision(total_score)
        why = lead.row.get("description", "").strip()
        notes = f"Source ID: {lead.row.get('source_id', '').strip()}"
        next_step = "Validate posting details and tailor resume" if decision_bucket != "Skip" else "Ignore unless role updates"
        rows.append({
            "date_added": lead.row.get("posted_date", "") or lead.row.get("date_added", ""),
            "company": lead.row.get("company", ""),
            "role": lead.row.get("role", ""),
            "location": location,
            "distance_bucket": distance_bucket,
            "commute_minutes": str(commute_info.get("minutes", "")),
            "commute_miles": str(commute_info.get("miles", "")),
            "job_type": job_type,
            "fit_level": fit_level,
            "resume_lane": resume_lane,
            "score": f"{total_score:.2f}",
            "decision_bucket": decision_bucket,
            "cover_letter": should_cover_letter(decision_bucket, fit_level),
            "status": "New",
            "source": lead.row.get("source", ""),
            "source_url": lead.row.get("source_url", ""),
            "why_it_matches": why,
            "next_step": next_step,
            "notes": notes,
        })
    rows.sort(key=lambda r: (-float(r["score"]), r["company"], r["role"]))
    return rows


def write_tracker(rows: List[Dict[str, str]]) -> None:
    TRACKER_CSV.parent.mkdir(parents=True, exist_ok=True)
    with TRACKER_CSV.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=FIELDNAMES)
        writer.writeheader()
        writer.writerows(rows)


if __name__ == "__main__":
    rows = build_rows()
    write_tracker(rows)
    print(f"wrote {len(rows)} tracker rows to {TRACKER_CSV}")
