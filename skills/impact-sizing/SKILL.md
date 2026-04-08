---
name: impact-sizing
description: Quantify feature value with driver trees, confidence levels, and the 4-step sizing framework.
disable-model-invocation: false
user-invocable: true
---


> **Interaction style:** Use the `AskUserQuestion` tool for all structured questions in this skill. Group related questions together (2-3 per call) rather than asking one at a time.

# /impact-sizing - Quantify Feature Value

Systematically estimate the impact of a feature using the 4-step framework.

## Context Routing Logic (Internal - for Claude)

**Automatic Context Checks:**
When this skill is invoked, immediately check:

| Source          | Files/Folders                               | Search Terms                          | What to Extract                         |
| --------------- | ------------------------------------------- | ------------------------------------- | --------------------------------------- |
| Current PRD     | `projects/*/`                 | feature name from chat                | User impact, problem severity           |
| User Research   | `knowledge/research/*.md`             | feature problem, user quotes          | Addressable users, pain severity        |
| Business Model  | `knowledge/company/business-info.md` | pricing, revenue model, TAM           | Revenue impact drivers                  |
| Historical Data | `knowledge/metrics/*.md`              | similar features, baseline conversion | Reference adoption rates                |
| Strategy        | `knowledge/strategy/*.md`             | feature strategic fit                 | Resource availability, priority context |
| Product Principles | `knowledge/company/product-principles.md` | product principles, core values | Which principles this feature embodies and how |

**Context Priority:**

1. Product principles alignment FIRST
2. Feature definition and user impact SECOND
3. Business model and pricing THIRD
4. User base size and addressable segment FOURTH
5. Historical precedent for similar features FIFTH

**Cross-Skill Links:**

- If sizing is unclear → Link to `/impact-sizing` (this skill)
- If comparing options → Use this to inform `/experiment-decision`
- If building business case → Reference in PRD and `/write-prod-strategy`
- If identifying leading metrics → Connect to `/feature-metrics` and `/metrics-framework`

