---
name: competitor-analysis
description: Deep competitive analysis + ongoing monitoring. Checks user research for competitor mentions, sales notes, existing analysis. Integrates with retention-analysis and user-research-synthesis.
disable-model-invocation: false
user-invocable: true
---


> **Interaction style:** Use the `AskUserQuestion` tool for all structured questions in this skill. Group related questions together (2-3 per call) rather than asking one at a time.

# /competitor-analysis - Strategic Competitive Intelligence

Two modes: **Deep Analysis** (comprehensive one-time research) + **Ongoing Monitoring** (weekly/monthly tracking)

## Quick Start

1. Name the competitor(s) you want to analyze
2. Choose mode: **Deep Analysis** (full research) or **Ongoing Monitoring** (monthly check-in)
3. I check your workspace first -- user research, meeting notes, churn data, past analysis
4. I show what we already know, identify gaps, then fill gaps with web research
5. I deliver a strategic report with defensive, offensive, and innovative plays

**Example:** "Analyze Competitor X -- we're losing enterprise deals to them"

**Output:** `work/research/competitor-analysis-[name]-[date].md`

**Time:** Deep Analysis: 2-4 hours | Monitoring: 30 min/month

## Context Routing Logic (Internal - for Claude)

**Automatic Context Checks:**
When this skill is invoked, immediately check:

| Source            | Files/Folders                               | Search Terms                                                             | What to Extract                                   |
| ----------------- | ------------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------------------- |
| Product Principles | `knowledge/company/product-principles.md` | product principles, core values | Which principles this feature embodies and how |
| User Research     | `knowledge/research/*.md`             | competitor name, "switched to", "chose", "vs [competitor]", "competitor" | Customer quotes, pain points, feature comparisons |
| Existing Analysis | `knowledge/research/competitive-*.md` | competitor name                                                          | Past findings, dates, trends, avoid duplication   |
| Meeting Notes     | `work/meeting-notes/*.md`             | competitor name, "lost deal", "churn", sales, CS                         | Sales losses, CS feedback, win/loss patterns      |
| PRDs              | `projects/*/`                 | competitor name, "competitive", "positioning"                            | Feature decisions, positioning rationale          |
| Strategy          | `knowledge/strategy/*.md`             | competitor name, "positioning", "differentiation"                        | Strategic context, counter-positioning            |
| Metrics           | `knowledge/metrics/*.md`              | "churn", "retention", competitor name                                    | Churn to competitors, competitive benchmarks      |

**Context Priority:**

1. Product principles alignment FIRST
2. Internal context SECOND (user research, meetings, PRDs)
3. Analytics MCP THIRD (if connected - query churn cohorts)
4. Web search LAST (only for gaps not covered by internal intel)

**Cross-Skill Links:**

- If churn mentioned → Link to `retention-analysis`
- If user feedback → Link to `user-research-synthesis`
- If positioning mentioned → Link to `write-prod-strategy`

