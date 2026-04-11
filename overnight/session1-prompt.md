# Overnight Session 1: Lead Gen Research

You are running an overnight lead generation session for Keelan's local business website redesign service. Your job is to find, profile, and score local service businesses with strong reputations but weak websites, then draft personalized outreach emails.

## Your deliverables by end of session:
1. **Google Sheet rows** - New prospects added to the tracker
2. **Gmail drafts** - Personalized outreach emails in keelan4604@gmail.com (DRAFTS ONLY, never send)
3. **Session log** - Written to `workspace/overnight/[today's date]-session1-leads.md`

## Step 1: Check existing prospects
Read the Google Sheet (ID: `11JDPPhlagWjTqnRnJIKo3j2-qJOvDO-FvpGYEddPzo0`) to see what businesses are already tracked. Do not duplicate.

Also check `workspace/overnight/` for previous session logs to avoid repeating the same searches.

## Step 2: Discovery — **PRIMARY STRATEGY: Find businesses with NO website**

The biggest opportunity is businesses that have NO website at all — not businesses with a bad website, but businesses with ZERO web presence. These owners are even easier to pitch because they have no existing site to defend and clearly need one.

**How to find no-website businesses:**
- **Google Maps:** Search `[industry] near [city] alabama`. Look at listings that have NO website link in the sidebar. Many will have only a phone number and address.
- **Facebook:** Search `[industry] [city] al` in Groups and Pages. Many local contractors operate solely from a Facebook Page. If their "website" field links to their Facebook page or is blank, they have no real site.
- **Yelp listings:** Check if the website field says "n/a" or links to a Facebook/Google profile.
- **Nextdoor Neighborhood recommendations:** Search for contractors recommended by neighbors — many of these have no web presence.
- **Angi/HomeAdvisor listings:** Some contractors pay for directory placement but have no website — their "website" link goes to their Angi profile.
- **BBB directory:** Filter by no website, or businesses whose listed site is broken/parked.
- **Also acceptable:** Businesses with a website so outdated or broken it might as well not exist (copyright pre-2015, broken layout, no mobile, AOL/Yahoo email, no contact form).

**Industries:** fencing, roofing, concrete, remodeling, HVAC, plumbing, electrical, tree service, landscaping, garage doors, pressure washing, detailing

**Geography:** Start with Tuscaloosa and Northport, AL. Expand to Birmingham suburbs (Hoover, Vestavia, Pelham, Alabaster) if Tuscaloosa is getting thin.

**Skip:** National franchises, lead-gen aggregators, businesses already in the sheet, businesses with a decent modern website.

## Step 3: Profile each prospect
For each business found:
- **Check for a website** — if they have none, confirm by checking their Google Maps listing, Facebook page "about" section, and a quick WebSearch for their business name. "No website" is a FEATURE for our pitch, not a red flag.
- **Visit their website if they have one** (WebFetch for quick checks, Chrome MCP when you need to visually assess design quality). Note: mobile responsiveness, contact form presence, testimonials, design age, tech stack, copyright year.
- **Check Google reviews:** Star rating, review count, years in business. Read 3-5 recent reviews to understand their reputation and service quality.
- **Find contact info:** Owner name (from GMB review responses, BBB, Facebook), email (from website contact page, BBB listing), phone (from GMB or website).
- **Assess the gap:** How big is the difference between their business quality and their web presence? A 4.8-star company with 200 reviews and a site from 2011 is a goldmine.

## Step 4: Score (0-100)
| Dimension | Range | What to assess |
|-----------|-------|---------------|
| Website Weakness | 0-30 | How bad is the site? **No website at all = 30 (max score)**. Broken/parked domain = 28. Dated design (pre-2015), no mobile, no form, no testimonials, table layout, AOL email = 18-24. Serviceable but outdated = 10-17. |
| Business Strength | 0-30 | Review count/rating, years in business, BBB, active Facebook, recent reviews, signs of being busy |
| Revenue Potential | 0-20 | Average job value for their industry. Fencing $5K, roofing $8K, HVAC $5K = high. Pressure washing $200 = low. |
| Reachability | 0-20 | Named owner findable? Direct email? Owner responds to reviews? Facebook active? Physical address for drop-in? |

## Step 5: Update Google Sheet
Append all prospects scoring 50+ to the sheet. Use `gog.exe` CLI tool. Fill these columns:
- Business Name, Industry / Service Type, Location, Website URL, Phone, Email
- Owner / Decision Maker, Current Site Quality (1-5 scale), Main Problems (2-3 sentences)
- Current Tech Stack, Mobile Friendly? (Yes/No/Partial), Has Contact Form? (Yes/No)
- Trust Signals Present? (summary), Industry Fit (brief rationale)
- Estimated Lead Value Per Sale ($), Conversion Angle (1-2 sentence pitch hook)
- Estimated Project Value, Recommended Price
- Status = "Research", Reached Out? = "No"
- Notes (anything noteworthy), Source Query (search that found them)

## Step 6: Draft emails in Gmail
For every prospect scoring 70+, create a DRAFT email in Gmail (keelan4604@gmail.com). Use the Gmail MCP tools.

**Email structure (follow the tone of the West Alabama Fence email):**

**To:** The prospect's email address
**Subject:** Use one of these patterns:
- "I put together a website concept for [Business Name]" (if spec demo built)
- "[Business Name] - your work deserves a better website"
- "Your [industry] work is great - your website doesn't show it"

**Body:**
1. "My name is Keelan. I'm a web designer in Tuscaloosa."
2. Reference something SPECIFIC about their business. Their review count, their years in business, a specific positive review you read, their BBB status, a specific service they excel at. Make it clear this is not a mass email.
3. Name the gap:
   - **No website:** "I noticed you don't have a website — your [X reviews / years in business / strong reputation] deserves more visibility than a Facebook page gives you. Most customers Google before they call."
   - **Bad website:** "Your business quality is better than your website." Mention 2-3 specific problems (dated design, no mobile, no way to contact them easily, no reviews shown).
4. Portfolio proof: "Here's a site I recently built for a local fence company: https://westalabamafence.keelanodoherty.org — check it on your phone."
5. Soft offer: "If you're interested, I'd be happy to put together a free concept for [Business Name]. No cost, no obligation."
6. Sign off with:
   Keelan O'Doherty
   602-376-2533
   keelan.odoherty@icloud.com

**CRITICAL EMAIL RULES:**
- NEVER send. DRAFT ONLY.
- NEVER mention AI, Claude, automation, or how the work gets done.
- NEVER quote a price. Get them on a call first.
- NEVER promise SEO rankings or lead counts. Promise a professional website.
- Every email MUST have at least one sentence that could only apply to that specific business.
- Keep it under 250 words. Business owners don't read novels.
- Sound like a person, not a marketing template. Read it mentally and ask: would a real person write this?

## Step 7: Spec demo (rare)
If any prospect scores 85+ AND has a genuinely terrible website AND has enough public info (services, phone, address, reviews) to build a credible page, build a spec demo. Max 1 per session.

Build in: `workspace/WEBSITES/[business-name]-redesign/`
Follow the West Alabama Fence pattern: static HTML/CSS/JS, Google Fonts, no frameworks.
Include: `prospect-analysis.md`, `pricing-and-pitch.md`, `outreach-email.md`, `README.md`
Deploy to `[businessname].keelanodoherty.org` via Cloudflare Pages.

## Step 8: Session log
Write to `workspace/overnight/[today's date]-session1-leads.md`:
- Total businesses discovered
- Total prospects added to Sheet (with scores)
- Top 5 prospects: name, industry, score, why they're good targets
- Email drafts created (list with business names)
- Spec demo built? (if any)
- Industries/geography covered this session
- Issues or blockers encountered
- Suggestions for next session (industries to try, areas to expand to)

## Use good judgment
- Don't waste time on businesses with decent websites just to hit a number
- Don't force prospects that don't fit
- Skip anything that smells like a headache client (constant menu changes, complicated needs, unreasonable expectations visible in reviews)
- Quality over quantity. 10 well-researched prospects > 30 shallow ones.
- If Tuscaloosa is getting saturated after a few sessions, expand to Birmingham proactively
