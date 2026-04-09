# Journey Step Mapping: [Product Area Name]

**Product Area:** [Product Area Name]
**Product Owner:** [Name, Title]
**Dedicated Engineer:** [Name, Role]
**Journey:** [One-sentence journey statement from org doc]
**Date Created:** [Date]
**Last Updated:** [Date]
**Version:** 1.0

---

## How This Works

This document maps every step in your end-to-end journey. It becomes the denominator for your two KPIs:

- **Interim KPI:** % of steps automated (measures build progress)
- **North Star KPI:** % of end-to-end outcomes achieved without human intervention (measures impact)

If a step isn't in this map, it doesn't exist for measurement purposes.

**Rules:**
- One row per discrete step. If you can't tell whether it's done or not done, it's not discrete enough.
- Steps follow the real-world sequence that stakeholders experience.
- Include every step regardless of current state (manual, partial, or fully automated).
- Mark which stakeholders each step impacts. This is a horizontal org. Every step touches at least one stakeholder.
- Mark dependencies on other product areas. These become integration contracts.

---

## Stakeholders

Reference the five stakeholders your product area serves. Mark which are primary (P) and which are secondary (S) for your area.

| # | Stakeholder | Relevance | How Your Area Serves Them |
|---|-------------|-----------|---------------------------|
| S1 | Facility | P / S | [Brief description] |
| S2 | Clinic | P / S | [Brief description] |
| S3 | Pharmacy | P / S | [Brief description] |
| S4 | Patient / POA | P / S | [Brief description] |
| S5 | RPM / Remote Care | P / S | [Brief description] |

---

## Journey Maps

Your product area may have multiple journeys, interaction types, or building blocks. Create one section per journey. Each section has its own step table.

**Structuring guidance by product area:**
- **AI Concierge (CPO):** One journey map per interaction type (appointment booking, Rx refill, care question, facility alert, RPM escalation, etc.)
- **Onboarding & Logistics (P1):** Separate journey maps for patient onboarding and facility onboarding
- **Patient Care & Clinical Flow (P2):** One journey from care plan creation through encounter documentation through claim submission, with branching refresh triggers
- **Med Mgmt & ePrescription (P3):** One journey map per building block (7 total: Med Reconciliation, Prescriptions & Refills, Typing & Billing, Filling, Checking, Delivery, Verification)
- **Facility Platform (P4):** One journey from resident admission through daily operations through invoicing

---

### Journey Map: [Journey/Interaction Type/Building Block Name]

**Scope:** [What this journey covers, start to end]
**Entry Trigger:** [What kicks off this journey]
**Exit Condition:** [What's true when this journey is complete]

#### Steps

| # | Step Name | Description | Trigger | Current State | Stakeholders Impacted | Owner (Product Area) | Dependency | Automation Potential |
|---|-----------|-------------|---------|---------------|----------------------|---------------------|------------|---------------------|
| 1 | | | | | | | | |
| 2 | | | | | | | | |
| 3 | | | | | | | | |

**Column definitions:**

- **Trigger:** What starts this step (previous step completion, external event, time-based, system alert)
- **Current State:** Manual / Tool-Assisted / Partially Automated / Fully Automated
  - **Manual** - Fully human-driven, no software support
  - **Tool-Assisted** - Human does it with software support (forms, dashboards, alerts)
  - **Partially Automated** - Software handles some sub-steps, human handles others
  - **Fully Automated** - No human intervention required
  - **Must Stay Manual** - Regulatory or safety requirement (e.g., pharmacist clinical check)
- **Stakeholders Impacted:** List which stakeholders (S1-S5) this step affects
- **Owner:** Which product area owns this step. If yours, just write your area code. If another PM's, write theirs (e.g., "P2: Patient Care")
- **Dependency:** If this step requires input from or output to another product area, write: `[Area Code] - [What you need/provide]`
- **Automation Potential:** High / Medium / Low / Must Stay Manual

*(Copy this section for each journey map you need)*

---

## Capabilities Coverage

Map your steps back to the capabilities defined in the org doc. This ensures no capability is orphaned (defined but not in any journey) and no step is disconnected (in a journey but not tied to a capability).

| Capability (from org doc) | Steps that deliver this capability | Coverage |
|--------------------------|-----------------------------------|----------|
| [Capability 1] | Steps #__, #__, #__ | Full / Partial / None |
| [Capability 2] | Steps #__, #__, #__ | Full / Partial / None |
| [Capability 3] | Steps #__, #__, #__ | Full / Partial / None |

**Orphaned capabilities** (defined in org doc but no steps cover them):
- [List any gaps]

---

## Cross-Area Dependencies

Every point where your journey touches another product area. These are integration contracts that need to be agreed on by both PMs.

| # | Your Step | Direction | Other Product Area | Their Step | Data/Trigger Exchanged | Status |
|---|-----------|-----------|-------------------|------------|----------------------|--------|
| 1 | | Sends to / Receives from | | | | Not started / In discussion / Agreed |
| 2 | | Sends to / Receives from | | | | Not started / In discussion / Agreed |

**Dependency format reference (from org doc Section 5):**
- P2 (Patient Care) to P3 (Med Mgmt): ePrescribing flows from clinical charting into pharmacy dispensing
- P2 (Patient Care) to CPO (Concierge): Care plan data powers concierge triage intelligence
- P1 (Onboarding) to P3 (Med Mgmt): Pharmacy delivery routing uses logistics engine
- P4 (Facility) to P2 (Patient Care): Facility ADL data enriches patient care plan
- P4 (Facility) to P3 (Med Mgmt): Facility MAR reads from pharmacy dispensing
- P1 (Onboarding) to P4 (Facility): Facility onboarding in CRM triggers facility platform setup
- CPO (Concierge) to All: Task management and notifications span all product areas
- P3 (Med Mgmt) to P1 (Onboarding): Building Block 6 (Delivery) hands off to logistics for last-mile

---

## KPI Baseline

Calculate from your step maps above.

### Summary Across All Journeys

| Journey / Block | Total Steps | Manual | Tool-Assisted | Partially Automated | Fully Automated | Must Stay Manual |
|----------------|-------------|--------|---------------|--------------------|-----------------|-----------------|
| [Journey 1] | | | | | | |
| [Journey 2] | | | | | | |
| **TOTAL** | | | | | | |

### KPI Calculation

**Interim KPI (% of steps automated):**
- Numerator: Steps that are Fully Automated + Partially Automated = ___
- Denominator: Total steps minus Must Stay Manual = ___
- **Interim KPI (today):** ___%
- **Interim KPI target ([date]):** ___%

**North Star KPI (% of outcomes without human intervention):**
- Numerator: End-to-end journeys completable with zero human touch = ___
- Denominator: Total journey types = ___
- **North Star KPI (today):** ___%
- **North Star KPI target ([date]):** ___%

---

## Product Principles Check

Validate your journey against AllCare's four product principles. For each principle, identify which steps embody it and which steps violate it.

| Principle | Steps That Embody It | Steps That Violate It | Notes |
|-----------|---------------------|-----------------------|-------|
| **Dining Table** (shared record, shared accountability) | | | |
| **Invisible Pen** (AI documentation, no manual data entry) | | | |
| **AI Battalion** (devices and integrations write to EMR automatically) | | | |
| **Early Whisper** (risk signals surfaced before escalation) | | | |

---

## Open Questions

Bring these to the weekly product sync for resolution.

| # | Question | Relevant Step(s) | Who Needs to Answer | Status |
|---|----------|-------------------|--------------------| -------|
| 1 | | | | Open / Resolved |
| 2 | | | | Open / Resolved |
| 3 | | | | Open / Resolved |

---

## Changelog

| Date | Version | What Changed | Why |
|------|---------|-------------|-----|
| [Date] | 1.0 | Initial step map | Action Item #0 |
