# Aerospace Job Hunt System

This folder is the operating system for Keelan's aerospace job search.

## Live tracker
- Google Sheet: https://docs.google.com/spreadsheets/d/1Ai0SI73whnjJD704LDx4eTGYQTOFl0O0znrTL21nGEo/edit
- Local CSV mirror: `tracker/job_tracker.csv`

## Core rule
This system is now Raleigh-first and driving-distance only.
Only track jobs that are realistically close enough to support living in the Raleigh area while doing NC State.

## Agents
- `agents/finder.md` — finds nearby roles and appends strong local candidates to tracker
- `agents/ranker.md` — scores and prioritizes Raleigh-area roles
- `agents/cover_letter_writer.md` — drafts targeted cover letters for selected local roles

## Key folders
- `tracker/` — canonical local tracker files / export helpers
- `strategy/` — search strategy and targeting logic
- `applications/` — company-role specific application materials
- `companies/` — notes on target companies
- `docs/` — recommendations and operating notes

## Working rule
The tracker should always be updated locally first, then pushed to the Google Sheet.
Do not let distant roles pollute the tracker unless Keelan explicitly asks for stretch opportunities.