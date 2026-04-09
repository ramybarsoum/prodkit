# PRD Template

> **What this is:** The document that scopes a large initiative (too big for one Feature Doc, too detailed for Product Strategy). One per initiative. Written before any Feature Docs begin.
>
> **What this is NOT:** A strategy doc, a Feature Doc, or a sprint plan. No acceptance criteria here. No solution-level detail. If a section starts growing into engineering specifics, move it to a Feature Doc.
>
> **Stage guidance:** Write sections 0-5 before kickoff. Fill the Component Map (section 6) as Feature Docs are created. Section 7 (Risks) is live until the initiative ships.

---

## 0) Meta

| Field | Value |
| ----- | ----- |
| **Initiative Name** | [Name] |
| **DRI (PM)** | [Your name] |
| **Eng Lead** | [Name] |
| **Design Lead** | [Name] |
| **Stage** | Draft / Approved / In Delivery / Shipped |
| **Last Updated** | [Date] |
| **Target Ship Window** | [e.g., Feb-Apr 2026] |
| **Linear Project** | Create in Linear (required before Feature Docs begin) |
| **Links** | [Roadmap]() \| [Strategy Doc]() \| [Figma]() |

---

## 1) TL;DR

> One paragraph. What is this initiative, why does it matter, and what will be different when it ships? Write this for someone who has never heard of it. No jargon.

[2-4 sentences. What we're building. Who benefits. What changes for them.]

---

## 2) Problem and Why Now

**Problem** (2 sentences max):
[What breaks for users or the business without this initiative? Be specific about who feels it and how often.]

**Why Now:**
[What changed (market, user demand, regulation, competitive pressure) that makes this the right time? "It's important" is not an answer.]

**Strategy Fit:**
This initiative supports [specific strategic bet/pillar] because [why this, not something else].

**Supporting Evidence:**

- [Data point or user signal]
- [Data point or user signal]
- [Competitive pressure or market signal]

---

## 3) User Impact

> Who are the humans this initiative serves, and what changes for them? This is the "so what" for users, distinct from the business problem above.

| User Segment | Pain Today | After This Ships |
| ------------ | ---------- | ---------------- |
| [e.g., Care coordinators] | [Current friction] | [Specific improvement] |
| [e.g., Patients] | [Current friction] | [Specific improvement] |

**Quotes from users or research:**

- "[Direct quote]" ([source or interview date])
- "[Direct quote]" ([source or interview date])

---

## 4) Scope

**What this initiative covers:**

- [Component 1: one line description]
- [Component 2: one line description]
- [Component 3: one line description]
- [Add all major components]

**Non-Goals** (explicit, max 5):

- [What we are NOT doing in this initiative] ([why])
- [What we are NOT doing in this initiative] ([why])
- [What we are NOT doing in this initiative] ([why])

**Constraints:**

| Type | Detail |
| ---- | ------ |
| Timeline | [Hard deadline or target window] |
| Budget | [Headcount, infra, or spend cap if known] |
| Dependencies | [Other teams, vendors, infra] |
| Regulatory | [HIPAA, state-level, payer rules, if applicable] |

**Alternatives Considered:**

- [Alternative approach]: Not doing because [reason]
- [Alternative approach]: Not doing because [reason]

> The above belongs here, not in the Appendix. If you're not writing it down, you're not making a real decision.

---

## 5) Success Metrics

> Initiative-level metrics only. Feature-level metrics belong in each Feature Doc.

**Primary Metric:**

- Metric: [name]
- Baseline: [current value or "not yet tracked"]
- Target: [goal]
- Timeline: [when we expect to see impact post-ship]

**Secondary Metrics:**

- [Metric]: [target]
- [Metric]: [target]

**Guardrail Metrics** (must not harm):

- [Metric]: [acceptable range]
- [Metric]: [acceptable range]

**Definition of Done:**
This initiative is complete when: [specific, observable conditions, not "all tickets closed"].

**Kill Criteria:**
If [specific condition], we pause or kill the initiative.

---

## 6) Component Map

> One row per major component. Link to Feature Doc as it's created. This table is a living artifact. Update it as Feature Docs are written and delivered.

| Sprint | PM Owner | Eng Owner | Feature Doc | Effort (S/M/L) | Status |
| ------ | -------- | --------- | ----------- | -------------- | ------ |
| [Sprint N: Component 1] | [name] | [name] | [link or TBD] | [S/M/L] | Not Started / In Progress / Shipped |
| [Sprint N: Component 2] | [name] | [name] | [link or TBD] | [S/M/L] | Not Started / In Progress / Shipped |
| [Sprint N: Component 3] | [name] | [name] | [link or TBD] | [S/M/L] | Not Started / In Progress / Shipped |

**Total Effort Estimate:** [Sum or range in sprints]

---

## 7) Risks

| Risk | Likelihood | Impact | Mitigation | Owner |
| ---- | ---------- | ------ | ---------- | ----- |
| [e.g., Integration complexity underestimated] | High/Med/Low | High/Med/Low | [What we do about it] | [@name] |
| [e.g., Regulatory blocker] | High/Med/Low | High/Med/Low | [What we do about it] | [@name] |
| [e.g., Key dependency slips] | High/Med/Low | High/Med/Low | [What we do about it] | [@name] |

---

## 8) Sprints and Open Questions

**Sprints:**

| Target Date | Sprint | Exit Criteria |
| ----------- | ------ | ------------- |
| [date] | [e.g., Sprint 1: Core feature shipped] | [What must be true] |
| [date] | [e.g., Sprint 2: Integration complete] | [What must be true] |
| [date] | [e.g., Initiative complete] | [What must be true] |

**Open Questions:**

- [ ] [Question that must be resolved before work starts] (@[owner], due [date])
- [ ] [Dependency confirmation needed] (@[owner], due [date])
- [ ] [Design or technical decision still open] (@[owner], due [date])

---

## 9) Appendix

**Changelog:**

| Date | Change | Who |
| ---- | ------ | --- |
| [date] | [what changed and why] | [name] |

**Related Docs:** [Links to research, competitive analysis, strategy references, past decisions]

---

## PRD Quality Checklist

### Before Kickoff (required before any Feature Docs begin)

- [ ] TL;DR written: someone new to this initiative can understand it in 30 seconds
- [ ] Problem stated in 2 sentences: specific about who feels it and how often
- [ ] "Why now" answered with a real signal, not just "it's important"
- [ ] User impact section has real user segments and specific changes
- [ ] All major components listed: no hidden scope
- [ ] Non-goals are explicit and agreed on by key stakeholders
- [ ] Alternatives considered are documented (not in appendix)
- [ ] Primary success metric defined with a baseline
- [ ] Definition of Done is specific and observable
- [ ] Kill criteria exist and are concrete
- [ ] Owners assigned in Meta (PM, Eng Lead, Design Lead)

### Before Feature Docs Start

- [ ] Component Map has a PM owner and eng owner per component
- [ ] Dependencies identified and confirmed with owners
- [ ] Regulatory/compliance risks explicitly flagged
- [ ] Open questions have owners and due dates
- [ ] Effort estimates in Component Map are rough but documented

### At Initiative Close

- [ ] All components shipped or explicitly deferred (with rationale)
- [ ] Primary metric tracked and reported against baseline
- [ ] Changelog updated with key pivots and decisions
- [ ] Learnings captured for next initiative

---

> **Size check:** This document should be 1-2 pages. If it's longer, you're writing Feature Docs inside it. Move that detail down to the Component Map and link to a Feature Doc instead.
