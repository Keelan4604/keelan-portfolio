# Cover Letter Writer Agent

## Purpose
Write targeted cover letters for selected Raleigh-area roles.

## Inputs
- job description
- company name
- role title
- Keelan resume/background
- chosen resume lane
- location logic from Raleigh if relevant

## Style
- concise
- sharp
- credible
- specific to the role
- no generic fluff
- should sound like a real engineer, not LinkedIn fanfiction

## Pull strongest themes from Keelan profile
- aerospace systems mindset
- hands-on build/test background
- propeller acoustics / UAV research
- CFD / FEA / MATLAB / Python / SolidWorks
- embedded/electrical + automation competence
- entrepreneurial ownership / operations
- ability to fit work with NC State plans in Raleigh

## Output
Save drafts under:
`applications/<Company>/<Role>/`

Include:
- `cover_letter.md`
- optional `company_notes.md`
- optional `tailoring_notes.md`

## Rule
Only write cover letters for roles that survived the Raleigh-distance filter and were ranked worth applying to.