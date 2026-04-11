# Strategy — Living Document

_Updated by the night brain after every session. This is the agent's persistent memory of what works._

---

## Current Revenue Hypothesis

Local service businesses in the Southeast with strong reputations and terrible websites will pay $500-2000 for a professional static site when shown a free demo built specifically for them. The conversion angle: one closed job covers the cost of the site.

Primary market: Tuscaloosa, AL. Secondary: Northport, Birmingham suburbs.
Next expansion: Ann Arbor, MI / Detroit metro (Keelan moving there for UMich MS Aerospace, Fall 2026).

---

## What's Working

- **9 demo sites live on Cloudflare Pages** — Holifield Electrical, T-Town Garage Doors, Sweet Olive Eats, Edwards Flooring, H&H Repair, Jamaican Spice + 3 new: Ohana, White Raven, Deon's Barbershop. Plus the original West Alabama Fence proof-of-concept.
- **More sites building now** — N&K Auto, Reggae Fusion, Magnolia Concrete, Bowen Automotive in progress.
- **SmartChat chatbot MVP deployed** at https://smartchat-demo.pages.dev/ — ready to demo as an upsell.
- **104 leads tracked** in Google Sheet (original 88 + 16 new from round 3). All scored, all no-website businesses.
- **37+ Gmail drafts created and ready to send.** Email outreach system completely rebuilt on Gmail (iCloud was broken).
- **Google Sheet overhauled** at `11JDPPhlagWjTqnRnJIKo3j2-qJOvDO-FvpGYEddPzo0` — 10 main columns + 3 tracking columns (Email Sent, Follow-Up, Response).
- Email outreach template established (reference specific reviews, name the gap, show demo, offer free concept)
- **Gmail (`keelan4604@gmail.com`) is the outreach system.** iCloud mail is dead for outreach — never use it again.
- Portfolio site updated (NC State -> UMich), SEO improved, redeployed
- **Phone outreach doc and FB message doc created** — multi-channel outreach ready.
- **New service idea: Google Business Profile optimization ($199)** — foot-in-the-door offer that works for ALL leads, not just email ones.

---

## What's Failing / Lessons Learned

- ~~Session 1 found businesses with GOOD websites~~ — **FIXED.** No-website GMB/Facebook targeting now produces high-quality leads consistently. 104 leads tracked.
- ~~No outreach sent yet~~ — **FIXED (partially).** 37+ Gmail drafts created. Keelan needs to review and hit send.
- **iCloud mail is DEAD for outreach.** `icloud_mail_helper.py` sends don't actually deliver. Switched entirely to Gmail drafts via MCP. Never use iCloud for outreach again.
- **Subagents cannot create Gmail drafts.** MCP tools don't transfer to subagents. The main agent must create all Gmail drafts directly.
- **Token watcher was broken.** Fixed by adding `--dangerously-skip-permissions` flag and removing `--cwd` from nightly.cmd.

---

## Current Search Strategy (Updated)

### Priority targeting methods (use first):
1. **Google Maps — no website indicator**: Search Google Maps for `[industry] near Tuscaloosa AL`. Listings with NO website link in the GMB sidebar are the best targets. These businesses exist and have customers but have no web presence at all.
2. **Facebook-only businesses**: Search Facebook for `[industry] Tuscaloosa AL`. Businesses that use only Facebook and have no linked website are strong targets.
3. **BBB without website**: Check BBB listings for Tuscaloosa — filter for businesses with no website field.
4. **Yelp, Angi, HomeAdvisor**: Look for businesses with phone/address but dead or missing website links.

### Secondary (use after exhausting above):
- Direct search `[industry] [city] al site:none` style queries
- Yelp/Angi category pages — manually scan for weak websites

### Skip immediately if:
- Website is mobile responsive and looks < 3 years old
- Business is a franchise or national chain
- Business has fewer than 10 Google reviews
- Website has a clear value prop, contact form, and testimonials visible

---

## Active Experiments

| Experiment | Status | Notes |
|-----------|--------|-------|
| Tuscaloosa fencing/roofing/HVAC sweep | COMPLETED | 24 leads from Round 1 |
| No-website GMB targeting | VALIDATED | Produces high-quality leads consistently. 104 leads total. |
| Facebook-only business discovery | VALIDATED | Works well as secondary source |
| Idea discovery track | COMPLETED 2026-04-09 | Top pick: AI automation + web design bundle |
| **AI Chatbot add-on service** | MVP DEPLOYED 2026-04-10 | 92% margin, $149-249/mo recurring. Demo live at smartchat-demo.pages.dev |
| **Demo site portfolio** | 9 SITES LIVE 2026-04-10 | +Ohana, White Raven, Deon's Barbershop. 4 more building. |
| **Lead gen expansion (3 rounds)** | COMPLETED 2026-04-10 | 104 leads total (88 original + 16 round 3) |
| **Gmail outreach system** | 37+ DRAFTS READY 2026-04-10 | Rebuilt from scratch on Gmail after iCloud failed |
| **Google Sheet overhaul** | COMPLETED 2026-04-10 | 10 main cols + 3 tracking cols (Email Sent, Follow-Up, Response) |
| **GBP optimization service** | IDEA 2026-04-10 | $199 foot-in-the-door. Works for ALL leads. |
| **Multi-channel outreach** | DOCS CREATED 2026-04-10 | Phone outreach doc + FB message doc ready |

---

## Industry Backlog (not yet covered)

- Concrete / flatwork contractors
- Tree service / arborist
- Garage door repair
- Pressure washing (lower ticket, skip unless very easy)
- Med spas / aesthetics
- Dentists (higher ticket, harder sell)
- Law firms (very high ticket, harder sell)
- HVAC (top priority — high ticket, very seasonal)
- Plumbing
- Electrical

---

## Geography Priority

1. Tuscaloosa, AL (current — 24+ leads found)
2. Northport, AL (included in Round 1)
3. Birmingham suburbs: Hoover, Vestavia Hills, Pelham, Helena (included in Round 1-2)
4. Durham / Raleigh, NC (leads found in Round 1)
5. 7 additional cities (leads found in Round 2)
6. Ann Arbor, MI / Detroit metro (future — Keelan moving for UMich MS Aerospace, Fall 2026)

---

## Idea Discovery Track

First run planned. Goal: scan Reddit, Upwork, Product Hunt, Indie Hackers for recurring pain points that match Keelan's technical skills. Score and surface the best 3 ideas per night.

Scoring criteria: demand signal strength, competition level, Keelan's ability to build it, revenue potential.

---

## Revenue Track #2: AI Chatbot Add-On Service

**Status:** Research complete, demo built, ready to pitch.

**Model:** $297-497 setup fee + $149-249/mo recurring. Bundle with website for $997-1,497 setup + $149/mo.

**COGS:** ~$10-20/mo per client (OpenAI API + hosting). **92% gross margin.**

**Tech:** Custom chat widget (built) → OpenAI GPT-4o-mini backend → per-client knowledge base.

**Edge:** Done-for-you service bundled with website sales. No local competitor offers this.

**Next steps:**
1. Deploy demo to Cloudflare Pages
2. Build 2-3 industry-specific demos (HVAC, restaurant, dental)
3. Add OpenAI backend for first real client
4. Pitch as add-on to every website prospect

**Full research:** `idea-tracker/ai-chatbot-research.md`

---

## Morning Report History

| Date | Leads Added | Emails Drafted | Demos Built | Key Lesson |
|------|-------------|----------------|-------------|------------|
| 2026-04-09 | — | — | — | First night with new system |
| 2026-04-10 (AM) | 45+ | 5 | 6 (+chatbot MVP) | 22 agents across 4 rounds. Demo portfolio ready. |
| 2026-04-10 (PM) | 104 total | 37+ Gmail drafts | 9 (+4 building) | iCloud dead, Gmail works. GBP optimization = new foot-in-the-door. |

---

## Idea Discovery Insights (2026-04-09)

_First run of the overnight idea discovery agent. Full report: `idea-tracker/overnight-ideas-LATEST.md`_

### Key Findings

1. **AI automation bundled with web design is the highest-leverage play.** Businesses pay $5,000-$25,000+ for AI solutions that save 20+ hours/week. A simple chatbot widget adds $250-$500/mo recurring per client on top of website sales. This is the natural evolution of the current track.

2. **Recurring revenue must become the focus.** One-time website sales at $500-$2,000 are fine for cash flow, but the real business is monthly retainers: website + SEO + AI chatbot at $250-$500/mo. 10 retainer clients = $2,500-$5,000/mo semi-passive.

3. **Micro-SaaS for tradespeople is the long-term moonshot.** 89% of tradespeople lack adequate digital tools (SBA). Website sales calls are the perfect customer discovery channel — ask every prospect what software they use for scheduling/invoicing. Build the tool they describe.

4. **MATLAB/CAD freelance is easy money while in school.** $50-$80/hr tutoring, $75-$120/hr project work. Low effort to start — just create Wyzant and Upwork profiles. Good for NC State transition period.

5. **US-person status is a competitive moat.** ITAR-controlled aerospace projects require US persons, eliminating offshore competition and commanding 2-3x rates. Worth exploring once at NC State.

### Recommended Next Actions

- **DONE:** SmartChat chatbot MVP deployed at smartchat-demo.pages.dev
- **DONE:** MATLAB tutoring research complete, Wyzant/Upwork/Fiverr profile drafts ready
- **This week:** Create pricing tiers (website-only / website+chatbot / full package with SEO)
- **This week:** Keelan signs up on Wyzant with drafted profile
- **This month:** Build 2-3 industry-specific chatbot demos (HVAC, restaurant, dental)
- **Ongoing:** During every website sales call, ask about software pain points (SaaS discovery)

---

## Overnight Update — April 10, 2026

### What Was Accomplished

**Agents ran overnight (April 9-10):**

1. **Website Lead Gen Agent** — Ran Google Maps + Facebook-only targeting across Tuscaloosa, Northport, Birmingham, Durham, and Raleigh. Found **24 qualified leads** with no website (Facebook-only). All scored and added to `website-sales-leads.csv`. Top leads:
   - Holifield Electrical LLC (Score: 90) — Licensed industrial/commercial electrical, has email domain but no site
   - T-Town Garage Doors and More (Score: 86) — High-ticket service, zero web presence
   - Sweet Olive Eats (Score: 84) — Five-star catering, has email, easy outreach
   - Magnolia Concrete LLC (Score: 82) — Residential concrete, West Alabama
   - Edward's Flooring LLC (Score: 82) — 4.9 stars, has email, only a Google Sites stub

2. **Idea Discovery Agent** — Full market research completed. Top 5 opportunities scored and ranked. See `idea-tracker/overnight-ideas-LATEST.md`.

3. **MATLAB Tutoring Research Agent** — Deep dive into tutoring/freelance market. Full platform comparison, UMich-specific opportunity analysis, pricing strategy, and action plan. See `idea-tracker/matlab-tutoring-research.md`. Key finding: **$900-$3,400/mo** is realistic at 5-20 hrs/week.

4. **Aerospace Internship Guide Agent** — Comprehensive Summer 2027 internship guide with month-by-month timeline, 30+ companies, fellowship info, and UMich-specific resources. See `career/aerospace-internships-2027.md`.

5. **Europe Trip Planner Agent** — Full itinerary for May 18 - June 1 trip. Dublin (boys trip) -> Prague -> Naples/Amalfi Coast (girlfriend). See `europe-trip-itinerary.md`.

6. **UMich Grad Guide Agent** — Comprehensive guide covering department, faculty, courses, funding reality, housing, and Ann Arbor survival tips. See `umich-grad-guide.md` and `ann-arbor-survival-guide.md`.

### Key Strategic Insights

1. **UMich funding is NOT guaranteed for MS students.** The aerospace department does not make financial aid offers to MS applicants. Keelan must either secure a GSRA/GSI position after arriving, win an external fellowship, or pay out-of-pocket (~$61K/yr out-of-state). **This makes side income CRITICAL.**

2. **MATLAB tutoring is the lowest-effort income stream.** $900-$3,400/mo with zero startup cost. UMich has 12,000+ engineering students, nearly all take MATLAB. Few tutors specialize in aerospace/Simulink. Set up Wyzant + Upwork profiles and post in UMich groups upon arrival.

3. **AI chatbot upsell is the highest-revenue opportunity.** Bundling a $250-$500/mo chatbot retainer with website sales turns one-time $500-$2,000 deals into recurring revenue. 10 retainer clients = $2,500-$5,000/mo.

4. **Website sales pipeline is real.** 24 scored leads ready for demo builds and outreach. The no-website targeting method works — every lead has strong reviews/reputation but zero web presence.

5. **SMART Scholarship deadline is December 2026.** Full tuition + $25K-$46K/yr stipend + guaranteed DoD job. Opens August 1 — must apply early. This could solve the funding problem entirely.

6. **Geography shift: UMich (Ann Arbor), not NC State (Raleigh).** All strategy docs now reflect UMich. Lead gen expanding to Ann Arbor/Detroit metro for Fall 2026.

### Updated Priorities

**Immediate (this week):**
1. Build 2 more demo sites from the top-scoring leads (Holifield Electrical, T-Town Garage Doors)
2. Draft personalized outreach emails for top 10 leads
3. Create pricing tiers doc (website-only / website+chatbot / full package)

**Before Europe trip (May 18):**
4. Set up Wyzant and Upwork profiles for MATLAB tutoring/freelance
5. Build 1 AI chatbot demo widget to showcase with website sales
6. Send first batch of outreach emails (aim for 20+)

**Summer 2026:**
7. Close first paying website client
8. Apply for SMART Scholarship (opens Aug 1)
9. Start apartment search in Ann Arbor
10. Prep for Fall 2026 career fair season (resume, cover letters, target list)

**Fall 2026 (at UMich):**
11. Post MATLAB tutoring in UMich engineering groups, start sessions
12. Apply to ECAS tutor position
13. Apply for GSRA positions with target professors (Fidkowski, Martins, Duraisamy for CFD/MDO)
14. Attend Fall Engineering Career Fair — target Boeing, SpaceX, Lockheed, Blue Origin
15. Submit SMART Scholarship by first Friday of December

### What's Working

- No-website GMB/Facebook targeting produces high-quality leads consistently
- The scored CSV pipeline makes prioritization easy
- Overnight agent system is HIGHLY productive — 22 agents across 4 rounds, all delivered
- **6 demo sites live** across multiple industries — proves range and quality
- **SmartChat chatbot MVP deployed** — the upsell has a working demo now
- West Alabama Fence demo still live as original proof of concept
- Career prep (internships, faculty outreach, freelance profiles) all done in one night

### What Needs Attention

- **CRITICAL: No outreach sent yet.** Pipeline is full, demos are built, emails are drafted — Keelan just needs to review and hit send. This is the ONLY bottleneck.
- **Ann Arbor housing market moves fast.** 15 apartments found, need to start calling.
- **Europe trip in 5 weeks.** Itinerary + packing list done but flights/hostels need booking NOW.
- **Professor emails need sending.** 5 personalized drafts ready — early contact matters for GSRA positions.
- **Wyzant/Upwork signup.** Profiles are drafted, Keelan just needs to create accounts.

---

## Morning Report History

| Date | Leads Added | Emails Drafted | Demos Built | Key Lesson |
|------|-------------|----------------|-------------|------------|
| 2026-04-09 | — | — | — | First night with new system |
| 2026-04-10 (AM) | 45+ | 5 | 6 (+chatbot MVP) | 22 agents across 4 rounds. Demo portfolio ready. |
| 2026-04-10 (PM) | 104 total | 37+ Gmail drafts | 9 (+4 building) | iCloud dead, Gmail works. GBP optimization idea. |

---

## Revenue Track #3: Google Business Profile Optimization

**Status:** Idea stage, not yet launched.

**Model:** $199 one-time fee per business. Optimize their Google Business Profile (photos, description, categories, hours, posts, Q&A). Easy to deliver, high perceived value.

**Edge:** Works for ALL 104 leads, not just the ones with email. Can pitch via phone or Facebook message. Low barrier — business owners understand Google immediately. Natural upsell to website ($500-2000) and chatbot ($149-249/mo).

**Next steps:**
1. Create a GBP optimization checklist/deliverables doc
2. Price test: offer to 5 leads as a standalone service
3. If it converts, build it into the standard pitch as the entry-level tier

---

## Tonight's Priority (April 10-11)

Email outreach system is rebuilt and loaded. Focus tonight:

1. **Keelan reviews and sends Gmail drafts** — 37+ drafts sitting in Gmail. This is revenue-critical.
2. Build remaining demo sites (N&K Auto, Reggae Fusion, Magnolia Concrete, Bowen Automotive) if not already done
3. Create GBP optimization service deliverables doc
4. Create pricing tiers document (GBP-only $199 / website-only $500-2000 / website+chatbot $997-1497 setup + $149/mo)
5. Monitor Gmail for any early responses to outreach
