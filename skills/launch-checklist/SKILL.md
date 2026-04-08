---
name: launch-checklist
description: Comprehensive product launch planning
---


> **Interaction style:** Use the `AskUserQuestion` tool for all structured questions in this skill. Group related questions together (2-3 per call) rather than asking one at a time.

## Quick Start

1. Tell me what you are launching (feature name, PRD link, or description)
2. I check the PRD, past launches, and stakeholder profiles for context
3. I ask about launch type: **Small feature**, **Major launch**, or **Regulatory product**
4. I generate a prioritized checklist with owners, dependencies, and due dates
5. I identify the critical path so you know what cannot slip

**Example:** "Create a launch checklist for the checkout redesign, targeting March 15"

**Output:** Saved to `work/launches/[feature-name]-launch-checklist.md`

**Time:** 15-20 minutes to generate, then ongoing tracking

## Purpose

Generate comprehensive launch checklist ensuring nothing falls through the cracks. Covers pre-launch prep, launch execution, and post-launch monitoring.

## Usage

- `/launch-checklist` - Create checklist for a feature/product
- `/launch-checklist [prd-name]` - Create for specific PRD
- `/launch-checklist --template small|major|regulatory` - Use specific template

