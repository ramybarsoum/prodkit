# Impact Sizing: [Feature or Opportunity Name]

> **What this is:** A structured analysis that quantifies the value of a feature or initiative before committing to build it. Forces the PM to think in numbers, not vibes.
>
> **What this is NOT:** A business case deck or a wishful projection. Use real baselines. Flag confidence levels honestly.
>
> **Feeds into:** Initiative Brief (Section 3), Feature Spec (Strategic Fit section), prioritization decisions.

---

## 0) Meta

| Field | Value |
|---|---|
| **Feature / Opportunity** | [Name] |
| **DRI** | [PM name] |
| **Date** | [Date] |
| **Linked Research** | [Link to user-research-synthesis doc, if any] |
| **Decision Needed By** | [Date] |

---

## 1) What We're Sizing

**One sentence:** [What is this feature? Who does it serve? What does it do?]

**The hypothesis:** If we build [X], then [Y metric] will [change by Z], because [assumption about behavior].

---

## 2) Step 1 — Estimate Usage (Funnel)

Start broad, narrow down to actual engaged users.

| Funnel Stage | Est. Users | Assumption |
|---|---|---|
| Total active users in the product | [N] | [Source or basis] |
| Users who encounter this surface | [N] | [% of total, why] |
| Users eligible for this feature | [N] | [Eligibility criteria] |
| Users who engage with it | [N] | [Expected adoption rate, why] |
| Users who complete the core action | [N] | [Completion rate, friction estimate] |

**Key assumption being made:** [What has to be true for this funnel to hold?]

---

## 3) Step 2 — Calculate Impact

**Engagement Impact:**
- Metric: [e.g., task completion rate / time-on-task / DAU]
- Baseline: [current value]
- Expected change: [+X% or -Xmin or similar]
- Method: [how you calculated this]

**Revenue / Business Impact:**
- Metric: [e.g., retention / NRR / conversion]
- Baseline: [current value]
- Expected change: [estimate]
- Method: [calculation]

**Cost / Efficiency Impact** (if applicable):
- Metric: [e.g., support tickets / manual work hours / error rate]
- Baseline: [current]
- Expected change: [estimate]
- Method: [calculation]

**Summary:**
- Users directly affected: [N or %]
- Revenue impact (annual est.): [$X — confidence: High / Med / Low]
- Strategic value: High / Medium / Low

---

## 4) Step 3 — Confidence Assessment

| Assumption | Confidence | Risk If Wrong | How to De-risk |
|---|---|---|---|
| [Assumption 1] | High / Med / Low | [What breaks] | [Validation action] |
| [Assumption 2] | High / Med / Low | [What breaks] | [Validation action] |
| [Assumption 3] | High / Med / Low | [What breaks] | [Validation action] |

**Overall confidence:** High / Medium / Low

**Biggest unknown:** [The one thing that could make this sizing completely wrong]

---

## 5) Step 4 — Effort Estimate

> Engineering should own this section. PM fills in best guess until eng weighs in.

| Component | Effort Estimate | Notes |
|---|---|---|
| [Component / epic] | S / M / L / XL | [Assumptions, dependencies] |
| [Component] | S / M / L / XL | [Notes] |

**Total estimated effort:** [X sprints / weeks — rough]

---

## 6) Recommendation

**Should we build this?** Yes / No / Needs more data

**Rationale:** [2-3 sentences. What's the upside, what's the risk, what tipped the decision?]

**If yes — what's the minimum v1 that captures most of the value?**
[Describe the scoped version.]

**If no or defer — revisit when:**
[Condition that would change this decision.]

---

## 7) Comparison Table (if sizing multiple options)

| Option | Reach | Impact | Confidence | Effort | Rec |
|---|---|---|---|---|---|
| [Option A] | [N users] | [Value] | High/Med/Low | S/M/L/XL | ✓ Preferred |
| [Option B] | [N users] | [Value] | High/Med/Low | S/M/L/XL | — |
| [Option C] | [N users] | [Value] | High/Med/Low | S/M/L/XL | — |
