---
name: feature-doc-review-panel
description: Multi-agent Feature Doc review (7 perspectives)
---


> **Interaction style:** Use the `AskUserQuestion` tool for all structured questions in this skill. Group related questions together (2-3 per call) rather than asking one at a time.

## Purpose

Get comprehensive feedback on your Feature Doc from 7 different perspectives in parallel: Engineering, Design, Executive, Legal, UX Research, Skeptic, and Customer Voice.

Catches gaps, challenges assumptions, and surfaces conflicts before stakeholder review.

## Usage

- `/feature-doc-review-panel` - Review a Feature Doc with all 7 sub-agents
- `/feature-doc-review-panel [prd-name]` - Review specific Feature Doc
- `/feature-doc-review-panel --perspectives "eng,design,exec"` - Review with subset of agents

