# Contractor Micro-SaaS Research — April 11, 2026

_Customer discovery intel for the contractor job tracker idea (scored 76/100 in idea discovery)._

---

## The Opportunity

Small contractors (1-5 person shops) need job tracking + invoicing but existing tools are overbuilt and overpriced. The gap: a dead-simple $29-$39/mo tool that does jobs, invoices, and customer contacts. Nothing else.

---

## Competitor Pain Points (Why Contractors Leave)

### Jobber ($39-$599/mo)
- **Per-user pricing is the #1 complaint.** "Once we hit 8 employees, the per-user cost became absurd."
- $900/year just for QuickBooks integration
- "Pricing has become so confusing with squeeze tactics to get users into more expensive plans"
- App is "very slow and lagging, half the time it doesn't even work"
- Overengineered: "still lacks basic functionality" like confirmation emails with service lists
- Limited customization of workflows and documents
- Features locked behind higher tiers (Marketing Suite, AI receptionist)
- **1-star reviews common on Trustpilot, Capterra, G2**

### Housecall Pro
- "Recent app changes made it harder to access key client records"
- Photo upload issues — critical for field teams
- Users switching TO Housecall Pro from Jobber for pricing, but then hitting different frustrations

### General Pattern
- Contractors want SIMPLE. They're getting COMPLEX.
- The tools are designed for 10-50 person companies and retrofitted for solo operators
- Solo contractors end up using: paper, text messages, Google Sheets, or QuickBooks Desktop (accounting only, no scheduling)
- "Even with one contractor, software can save time and reduce errors"

---

## What Solo Contractors Actually Need (MVP Feature List)

Based on complaints and recommendations across forums:

### Must Have (V1):
1. **Job creation** — name, customer, address, description, status (quoted/scheduled/in progress/complete/invoiced)
2. **Customer contact list** — name, phone, email, address, notes
3. **Simple invoicing** — generate PDF invoice from job, mark paid/unpaid
4. **Calendar view** — see scheduled jobs on a calendar
5. **Mobile-first** — must work perfectly on a phone in the field

### Nice to Have (V2):
6. **Photo attachments** — before/after photos per job
7. **QuickBooks sync** — major selling point, but keep it simple
8. **Text/email reminders** — send appointment reminders to customers
9. **Basic reporting** — revenue this month, jobs completed, unpaid invoices
10. **Estimate → Invoice** — convert a quote to an invoice with one tap

### Do NOT Build (Complexity Trap):
- Route optimization
- Inventory management
- Marketing tools
- AI anything
- Team management / dispatch
- Multi-location support
- Deep customization

---

## Pricing Intelligence

| Tool | Solo Price | Small Team Price | Notes |
|------|-----------|-----------------|-------|
| Jobber Lite | $39/mo | $169/mo (5 users) | Per-user pricing adds up fast |
| Housecall Pro | $79/mo | $189/mo (5 users) | Heavy feature set |
| ServiceTitan | ~$200+/mo | Enterprise pricing | Way too much for small shops |
| GorillaDesk | $49/mo | $129/mo | Mid-range |
| FieldVibe | Free | Free (limited) | Very basic scheduling only |
| Clientility | $43/mo ($516/yr) | Similar | Budget option with QB integration |
| **Gap target** | **$29-$39/mo** | **$39-$49/mo** | Simple, flat pricing, no per-user |

**Key pricing insight:** Contractors repeatedly cite $29-$49/mo as what they'd pay for a simple tool. The moment pricing hits $69+ per user, complaints spike.

---

## Distribution Channels

1. **Keelan's website sales pipeline** — every outreach call is a free customer discovery call. Ask: "How do you track jobs and invoices?" Document answers.
2. **ContractorTalk forums** — active community, contractors recommend tools to each other
3. **Reddit trade subreddits** — r/electricians, r/plumbing, r/HVAC, r/contractor
4. **App Store / Google Play** — contractors search "job tracker" and "invoicing app"
5. **Facebook trade groups** — local and national contractor groups
6. **Thumbtack/Bark Pro** — list as a complementary tool ("track the leads you get from Thumbtack")
7. **Bundle with website sales** — "I built your website AND here's a tool to manage the leads it generates"

---

## Build vs. Buy Analysis

### Build Approach (Recommended)
- **Stack:** Next.js or SvelteKit + Supabase (auth, DB, realtime) + Cloudflare Pages
- **COGS:** ~$0-$25/mo total (Supabase free tier handles up to 500 users)
- **Timeline:** MVP in 2-4 weekends (job CRUD, customer list, simple invoices, calendar)
- **Advantage:** Zero infrastructure cost until scale, can iterate based on real user feedback

### Revenue Model
- $39/mo flat (no per-user pricing — this IS the differentiator)
- 50 users = $1,950/mo
- 200 users = $7,800/mo
- 500 users = $19,500/mo
- Gross margin: ~95%+ (near-zero COGS on Supabase/Cloudflare)

---

## Customer Discovery Questions (Add to Website Sales Outreach)

During every website sales call or email, ask:
1. "How do you currently track your jobs — paper, phone, spreadsheet, or software?"
2. "How do you send invoices — email, paper, app?"
3. "What's the most frustrating part about managing your schedule?"
4. "Have you tried Jobber or Housecall Pro? What did you think?"
5. "If I could build you a simple app that tracked your jobs and sent invoices for $39/month flat, would that be interesting?"

---

## Additional Insights (from training data analysis)

### Biggest Technical Differentiator: Offline Mode
None of the incumbents handle offline well. Contractors work in basements, crawl spaces, rural areas. Building reliable offline-first (view jobs, add notes/photos, create invoices, sync when back online) would be a genuine competitive moat.

### Estimate-to-Invoice Flow is the Core UX
The magic workflow: create estimate → customer approves → tap "start job" → tap "complete" → tap "invoice" → send via text with "Pay Now" link. In Jobber this is 8-12 clicks. Making it 3-4 taps is the product.

### Supply House Partnerships (Underutilized Channel)
Contractors visit supply houses (Ferguson, Winsupply, local electrical supply) daily. Counter cards, flyers, or referral deals with supply houses is a distribution channel nobody in SaaS uses. Worth exploring in Ann Arbor.

### Recommended Pricing (Refined)
- **Starter: $29/mo** — 1 user, unlimited jobs/estimates/invoices/payments
- **Crew: $49/mo** — up to 5 users, team scheduling, customer notifications
- No per-user fees. No annual lock-in. Month-to-month.
- Position directly under Jobber ($69/mo Core) and above the "free = sketchy" threshold.

---

## Recommended Next Steps

1. **This week:** Add customer discovery questions to the phone outreach script
2. **After 10-15 conversations:** Map the feature set contractors actually describe
3. **June-July (before UMich):** Build MVP with: job CRUD, customer contacts, PDF invoicing, calendar
4. **August (at UMich):** Offer free to first 5 website clients as a bundle bonus
5. **September:** Start charging $39/mo, iterate based on usage data
6. **Fall 2026:** If traction, pitch at UMich entrepreneurship events (MPowered, Desai Accelerator)

---

_Research compiled April 11, 2026. Sources: Trustpilot, Capterra, G2, ContractorTalk, FieldCamp, BuildOps, various review sites._
