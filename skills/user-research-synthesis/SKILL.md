---
name: user-research-synthesis
description: Turn user interviews into actionable insights. Advanced synthesis techniques and frameworks.
disable-model-invocation: false
user-invocable: true
---


> **Interaction style:** Use the `AskUserQuestion` tool for all structured questions in this skill. Group related questions together (2-3 per call) rather than asking one at a time.

# /user-research-synthesis - Turn Interview Data Into Insights

When the PM types `/user-research-synthesis`, transform raw user interview notes, transcripts, and observations into actionable product insights.

## Context Routing Logic (Internal - for Claude)

**Automatic Context Checks:**
When this skill is invoked, immediately check:

| Source             | Files/Folders                                | Search Terms                   | What to Extract                        |
| ------------------ | -------------------------------------------- | ------------------------------ | -------------------------------------- |
| Product Principles | `knowledge/company/product-principles.md` | product principles, core values | Which principles this feature embodies and how |
| Existing Research  | `knowledge/research/*.md`              | topic from chat, user segments | Previous findings to avoid duplication |
| Related PRDs       | `projects/*/`                  | problem related to interviews  | Problem framing and hypothesis         |
| Strategy Context   | `knowledge/strategy/*.md`              | user segment, strategic fit    | How findings ladder to strategy        |
| Previous Synthesis | `work/research/`                | topic name                     | Past research to build on              |
| Interview Guides   | `knowledge/research/interview-guides/` | topic                          | What questions were asked              |

**Context Priority:**

1. Product principles alignment FIRST
2. Raw interview data SECOND (always use verbatim quotes)
3. Related PRDs and problem statements THIRD
4. Previous research on related topics FOURTH
5. Strategic context FIFTH

**Cross-Skill Links:**

- After synthesis → Link to `/prd-draft` to turn insights into feature spec
- If about competitor mentions → Link to `/competitor-analysis`
- If about retention → Link to `/retention-analysis` for churn patterns
- If informing strategy → Link to `/write-prod-strategy`

