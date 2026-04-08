# prodkit

PM toolkit for Claude Code. 9 skills that cover the full product management lifecycle: spec writing, doc reviews, prioritization, impact sizing, competitive analysis, and launch planning.

## Install

```bash
claude plugin add prodkit
```

## Skills

### Spec & Docs

| Skill | Command | What it does |
|-------|---------|-------------|
| **Feature Spec Interview** | `/feature-spec-interview` | Structured interview that produces gap-free feature specs. 14 prompts, 61 question groups, NLSpec format (WHAT/WHEN/WHY/VERIFY). |
| **Feature Doc Review Panel** | `/feature-doc-review-panel` | Multi-agent review from 7 perspectives: Engineering, Design, Executive, Legal, UX Research, Skeptic, Customer Voice. |
| **Decision Doc** | `/decision-doc` | Document strategic decisions with rationale, alternatives, and trade-offs. |

### Prioritization & Sizing

| Skill | Command | What it does |
|-------|---------|-------------|
| **Prioritize** | `/prioritize` | Classify tasks using the LNO Framework (Leverage/Neutral/Overhead). Target: 40% L, 35% N, 20% O. |
| **Impact Sizing** | `/impact-sizing` | Quantify feature value with driver trees, confidence levels, and a 4-step sizing framework. |

### Strategy & Analysis

| Skill | Command | What it does |
|-------|---------|-------------|
| **Define North Star** | `/define-north-star` | Identify and validate your North Star Metric. Covers formula design, input metrics, and guardrails. |
| **Competitor Analysis** | `/competitor-analysis` | Deep competitive research or ongoing monthly monitoring. Checks internal context first, fills gaps with web search. |
| **User Research Synthesis** | `/user-research-synthesis` | Turn raw interview notes and transcripts into actionable product insights with recurring themes. |

### Execution

| Skill | Command | What it does |
|-------|---------|-------------|
| **Launch Checklist** | `/launch-checklist` | Generate prioritized launch checklists with owners, dependencies, and critical path identification. |

## How it works

Each skill is a structured prompt that guides Claude Code through a specific PM workflow. Skills ask clarifying questions, check your project context, and produce artifacts (docs, analyses, checklists) saved to your workspace.

Skills reference common file paths like `knowledge/`, `projects/`, and `work/`. These are conventions, not requirements. Adapt the paths to your project structure, or the skills will work with whatever context you provide in conversation.

## The Feature Spec Interview

The headliner skill. It runs a structured interview with 14 prompts and 61 question groups to produce behavioral contracts detailed enough that a new engineer (or AI agent) can execute with at most one clarifying question.

Key concepts:
- **NLSpec format**: Every behavior has WHAT, WHEN, WHY, and VERIFY components
- **The New-Hire Test**: A spec is complete when a capable new hire with no context could implement it
- **Skip Matrix**: Not every question applies. The interview adapts based on your feature's characteristics
- **Two-tier output**: Tier 1 (behavioral contract for execution) + Tier 2 (strategic context for humans)
- **Gate check**: Before any interview, 4 gate questions validate the feature should enter the pipeline at all

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI or Desktop

## License

MIT
