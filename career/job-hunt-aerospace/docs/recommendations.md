# Recommendations

## Best way to optimize this search
For Keelan's situation, the winning system is **not** "scrape literally everything."
It is:

1. **Anchor on Raleigh/Triangle-first employers and boards**
   - local aerospace
   - defense hardware
   - autonomy/UAV
   - hardware test/validation
   - systems/integration
2. **Separate raw discovery from ranked tracker**
   - dump noisy finds into `data/discovery/manual_leads.csv`
   - only push scored, filtered roles into `tracker/job_tracker.csv`
3. **Score for grad-school compatibility, not just title prestige**
   - Raleigh core and Triangle commute should dominate ranking
4. **Generate application packets only for top roles**
   - avoid wasting time on generic cover letters for weak jobs
5. **Use the Google Sheet as the dashboard, not the raw ingest bucket**

## Practical source strategy
### Tier 1 - highest-value recurring checks
- BETA Careers
- RTX / Collins Aerospace
- Honeywell Careers
- GE Aerospace Careers
- Northrop Grumman Careers
- Sierra Nevada Corporation Careers
- Handshake

### Tier 2 - good for discovery, must validate
- LinkedIn Jobs
- Google search queries
- Lever boards
- Greenhouse boards
- Ashby boards

### Tier 3 - backup lanes
- staffing/contract boards like Latitude Inc
- local manufacturing/hardware employers with aerospace overlap

## Current blocker
The system is ready for role discovery/ranking, but custom cover letters will get much better once Keelan's current resume and an existing strong cover letter are placed somewhere accessible in or near the workspace.

## Immediate operating loop
- Add leads weekly
- Rebuild tracker
- Generate folders for `Apply now`
- Paste the real job descriptions
- Tailor resume + cover letter
- Apply
- Sync sheet
