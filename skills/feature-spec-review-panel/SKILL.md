---
name: feature-spec-review-panel
description: Multi-agent Feature Spec review from 7 perspectives (engineering, design, executive, legal, UX research, skeptic, customer voice). Spawns parallel sub-agents for comprehensive feedback.
allowed-tools: Agent, Read, Glob, Grep, AskUserQuestion, TodoWrite
---

> **Note:** This skill is an alias for `feature-doc-review-panel`. "Feature Spec" and "Feature Doc" are treated identically. The canonical term is "Feature Doc" but this skill exists for backward compatibility.

> **Interaction style:** Use the `AskUserQuestion` tool for all structured questions in this skill. Group related questions together (2-3 per call) rather than asking one at a time.

## Purpose

Get comprehensive feedback on your Feature Spec/Doc from 7 different perspectives in parallel: Engineering, Design, Executive, Legal, UX Research, Skeptic, and Customer Voice.

Catches gaps, challenges assumptions, and surfaces conflicts before stakeholder review.

## Usage

- `/feature-spec-review-panel` - Review a Feature Spec with all 7 sub-agents
- `/feature-spec-review-panel [file-path]` - Review specific Feature Spec by path
- `/feature-spec-review-panel --perspectives "eng,design,exec"` - Review with subset of agents
- `/feature-spec-review-panel --extended` - Include 6 additional perspectives (architecture, data, devops, performance, security, testing)

## Execution Steps

### Step 1: Locate the Feature Spec/Doc

If a file path was provided as an argument, use that. Otherwise:

1. Search for Feature Specs/Docs in the workspace: `Glob("**/FEATURE-DOC.md")`, `Glob("**/feature-doc*.md")`, `Glob("**/feature-spec*.md")`, `Glob("projects/**/FEATURE-DOC.md")`
2. If multiple found, ask the user which one to review using `AskUserQuestion`
3. If none found, ask the user to provide the path or paste the content

Read the full document content. Store it as `DOC_CONTENT`.

### Step 2: Load context files (if they exist)

Attempt to read these context files. Skip any that don't exist:

- `reference/company/product-principles.md` (product principles to evaluate against)
- `reference/company/business-info.md` (company context)
- `reference/strategy/` (any strategy docs)

Combine available context into `CONTEXT_SUMMARY` (keep it under 500 words).

### Step 3: Determine which perspectives to run

**Default 7 (core panel):**

| Perspective  | Sub-Agent File                             | Key        |
| ------------ | ------------------------------------------ | ---------- |
| Engineering  | `_system/sub-agents/engineer-reviewer.md`  | `eng`      |
| Design       | `_system/sub-agents/designer-reviewer.md`  | `design`   |
| Executive    | `_system/sub-agents/executive-reviewer.md` | `exec`     |
| Legal        | `_system/sub-agents/legal-advisor.md`      | `legal`    |
| UX Research  | `_system/sub-agents/uxr-analyst.md`        | `uxr`      |
| Skeptic      | `_system/sub-agents/skeptic.md`            | `skeptic`  |
| Customer Voice | `_system/sub-agents/customer-voice.md`   | `customer` |

**Extended 6 (with --extended flag):**

| Perspective   | Sub-Agent File                                | Key        |
| ------------- | --------------------------------------------- | ---------- |
| Architecture  | `_system/sub-agents/architecture-reviewer.md` | `arch`     |
| Data          | `_system/sub-agents/data-reviewer.md`         | `data`     |
| DevOps        | `_system/sub-agents/devops-reviewer.md`       | `devops`   |
| Performance   | `_system/sub-agents/performance-reviewer.md`  | `perf`     |
| Security      | `_system/sub-agents/security-reviewer.md`     | `security` |
| Testing       | `_system/sub-agents/testing-reviewer.md`      | `testing`  |

If `--perspectives` flag is provided, filter to only the specified keys.

### Step 4: Read sub-agent persona files

Read each required sub-agent file from `_system/sub-agents/`. Store the content for each.

### Step 5: Spawn parallel review agents

**CRITICAL: Spawn ALL selected agents in a SINGLE message using multiple Agent tool calls.** This runs them in parallel for speed.

For each perspective, use the `Agent` tool with:

```text
Agent({
  description: "[Perspective] review of Feature Spec",
  prompt: `You are reviewing a Feature Spec. Adopt the following persona and review framework:

---
[PASTE THE FULL SUB-AGENT PERSONA FILE CONTENT HERE]
---

## Company Context
[PASTE CONTEXT_SUMMARY HERE]

## Feature Spec to Review
[PASTE DOC_CONTENT HERE]

## Your Task

Review this Feature Spec thoroughly from your perspective. Structure your review as:

1. **Verdict**: PASS / NEEDS WORK / BLOCK (one word)
2. **Strengths** (2-4 bullets): What's done well
3. **Issues** (prioritized list): Each with severity (Critical / Major / Minor), description, and recommended fix
4. **Questions**: Open questions that need answers before implementation
5. **Score**: Rate 1-10 from your perspective

Keep your review focused and actionable. No filler. Under 500 words.`
})
```

### Step 6: Synthesize results

After all agents return, compile the unified review:

```markdown
# Feature Spec Review Panel

**Document:** [document name/path]
**Date:** [today]
**Perspectives:** [list of perspectives used]

## Summary Verdict

| Perspective | Verdict | Score | Critical Issues |
| ----------- | ------- | ----- | --------------- |
| Engineering | [PASS/NEEDS WORK/BLOCK] | [X/10] | [count] |
| Design | ... | ... | ... |
| ... | ... | ... | ... |

**Overall:** [PASS if all pass, NEEDS WORK if any need work, BLOCK if any block]
**Average Score:** [X/10]

## Critical Issues (must fix before implementation)

[List all Critical-severity issues from all perspectives, grouped by theme]

## Major Issues (should fix)

[List all Major-severity issues, grouped by theme]

## Conflicting Feedback

[Flag any cases where two perspectives contradict each other]

## Consensus Strengths

[Items praised by 3+ perspectives]

## Open Questions

[Consolidated list of all open questions, deduplicated]

## Recommended Next Steps

1. [Prioritized action items]
2. ...
```

### Step 7: Present and offer to save

Present the synthesized review to the user. Then ask:

> "Want me to save this review? I can write it to `[project-folder]/reviews/spec-review-[date].md`."

If yes, save the file.

## Notes

- Each sub-agent runs independently. They don't see each other's feedback.
- The synthesis step is where conflicts get surfaced and themes emerge.
- For AllCare projects, the Legal and Security perspectives are especially important due to HIPAA requirements.
- If `reference/company/product-principles.md` exists, every perspective should evaluate alignment with those principles.
