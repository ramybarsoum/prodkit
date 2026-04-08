---
name: define-north-star
description: Identify and validate your North Star Metric. Aligns product strategy with key business metric.
disable-model-invocation: false
user-invocable: true
---


> **Interaction style:** Use the `AskUserQuestion` tool for all structured questions in this skill. Group related questions together (2-3 per call) rather than asking one at a time.

# Define North Star Metric

**When to use:** During strategy planning, when metrics feel scattered, or when teams are optimizing different things

**Framework source:** Aakash Gupta's "Do you really need a North Star Metric?"

## Quick Start

1. Tell me: "Help me define our North Star metric" (or "Validate our current North Star")
2. I will check `knowledge/company/business-info.md` and `knowledge/strategy/` for your business model, growth stage, and existing metrics
3. I will ask about your core value, retention drivers, and business model to narrow candidates
4. We work through: Core Value identification, Metric formula (Frequency x Core Action x Breadth), Validation tests, Input metrics, and Guardrails
5. Output goes to `work/analyses/north-star-[quarter].md`

**Key decision:** Not every product needs a single North Star. Marketplaces, multi-product companies, and complex B2B may need a constellation of 2-4 metrics instead. I will help you decide which approach fits.

## Context Routing Logic (Internal - for Claude)

**Automatic Context Checks:**
When this skill is invoked, immediately check:

| Source          | Files/Folders                               | Search Terms                             | What to Extract                       |
| --------------- | ------------------------------------------- | ---------------------------------------- | ------------------------------------- |
| Strategy Docs   | `knowledge/strategy/*.md`             | objective, business goal, success metric | Current metric direction, if any      |
| Business Model  | `knowledge/company/business-info.md` | revenue model, growth focus, metrics     | What drives the business              |
| Metrics History | `knowledge/metrics/*.md`              | baseline, trends, retention data         | Current metric baselines and movement |
| Meetings        | `work/meeting-notes/*.md`             | "North Star", "KPI", "success metric"    | Stakeholder expectations              |
| PRDs            | `projects/*/`                 | success metric, target                   | Feature-level success indicators      |
| Product Principles | `knowledge/company/product-principles.md` | product principles, core values | Which principles this feature embodies and how |

**Context Priority:**

1. Product principles alignment FIRST
2. Business model and revenue drivers SECOND
3. Current product stage and growth focus THIRD
4. Historical metrics data FOURTH
5. Stakeholder expectations FIFTH

**Cross-Skill Links:**

- If building strategy → Link to `/write-prod-strategy` which uses North Star
- If defining feature metrics → Link to `/feature-metrics` which should ladder to North Star
- If analyzing retention → Link to `/retention-analysis` to identify leading indicators
- If setting up metrics framework → Link to `/metrics-framework`

