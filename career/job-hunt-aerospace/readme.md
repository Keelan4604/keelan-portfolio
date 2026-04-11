# Raleigh-First Aerospace Job Hunt System

This project is the local operating system for Keelan's NC State MS Aerospace plan.

The goal is simple: find good aerospace and adjacent hardware roles that keep life anchored in Raleigh, rank them honestly, and make each application easy to execute.

## What this system does
- discovers roles from multiple sources (company boards, Google search exports, manual finds)
- filters by Raleigh-first commuting logic
- deduplicates repeated postings across sources
- scores roles for fit, location, school compatibility, and urgency
- keeps a local canonical tracker
- syncs the tracker to the Google Sheet
- prepares per-role application folders with notes + cover-letter scaffolding

## Canonical tracker
- Local CSV: `tracker/job_tracker.csv`
- Google Sheet: `NCSU Job hunt`
- Sheet ID: `1Ai0SI73whnjJD704LDx4eTGYQTOFl0O0znrTL21nGEo`

## Project layout
- `agents/` - human/agent operating prompts
- `applications/` - generated company/role folders for actual applications
- `companies/` - target company dossiers and source notes
- `config/` - Raleigh commute + scoring configuration
- `data/` - raw discovery inputs and source registry
- `docs/` - operating docs and workflow notes
- `materials/` - local resume / cover-letter seed files for tailoring
- `scripts/` - local automation entry points
- `strategy/` - search strategy and targeting
- `tracker/` - canonical CSV tracker + Google Sheet sync

## Quick start

### 1) Add or refresh raw leads
Populate one of these:
- `data/discovery/manual_leads.csv`
- `data/discovery/google_search_export.csv`
- source-specific CSV files with the same columns

Expected lead columns:
`company,role,location,job_type,source,source_url,description,posted_date,source_id`

### 2) Build a cleaned tracker candidate set
```powershell
py -3 scripts/build_tracker.py
```

This will:
- load raw leads
- apply Raleigh-first distance bucketing
- dedupe near-duplicate roles
- score/rank them
- write `tracker/job_tracker.csv`

### 3) Scaffold application folders for top roles
```powershell
py -3 scripts/prepare_applications.py --decision "Apply now" --limit 5
```

### 4) Push local tracker to Google Sheets
```powershell
py -3 tracker/sync_to_gsheet.py
```

## Recommended weekly loop
1. Search local target companies and boards.
2. Append raw finds to `data/discovery/*.csv`.
3. Run `py -3 scripts/build_tracker.py`.
4. Review the top `Apply now` and `Apply this week` roles.
5. Run `py -3 scripts/prepare_applications.py` for the roles worth pursuing.
6. Tailor resume/cover letter in each application folder.
7. Sync to Google Sheets.

## Honest seeding
The tracker is seeded with a few real, Raleigh-relevant roles/sources, but this repo is intentionally conservative.
It prefers fewer honest leads over a bloated spreadsheet full of weak or stale noise.
