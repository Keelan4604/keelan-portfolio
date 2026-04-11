# Application Workflow

## Goal
Turn a strong tracker row into an organized application packet fast.

## Folder convention
Each role gets:
`applications/<Company>/<Role>/`

Generated files:
- `job_snapshot.md`
- `company_notes.md`
- `tailoring_notes.md`
- `cover_letter.md`
- `README.md`

## Workflow
1. Build tracker from raw leads.
2. Review `decision_bucket` + score.
3. For any role worth pursuing, run:
   ```powershell
   py -3 scripts/prepare_applications.py --decision "Apply now"
   ```
4. Open the generated folder.
5. Paste the full job description into `job_snapshot.md`.
6. Tailor resume lane noted in tracker.
7. Draft or refine `cover_letter.md`.
8. Apply and update status locally.
9. Sync to Google Sheets.

## Resume lane rules
- `Flight/Test`: validation, instrumentation, acoustics/thrust research, MATLAB/data work
- `Systems/Hardware`: integration, embedded/electrical, hardware/software interface, automation
- `Mechanical/Design`: CAD, SolidWorks, FEA/CFD, prototyping, fabrication

## Important rule
Do not generate folders for junk. The app prep script is for roles that survived Raleigh filtering and ranking.
