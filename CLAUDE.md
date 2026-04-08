# Prodkit - Behavioral Automation Layer

This file encodes 7 automation systems that make prodkit skills smarter across sessions. Every automation works passively. No setup required.

## 1. MCP Routing Engine

Route natural language questions to the right data source automatically. Check MCPs first, fall back to workspace files, then ask the user.

**Routing table:**

| Query pattern | Primary source | Fallback |
|---------------|---------------|----------|
| Metrics, funnels, retention, conversion | Analytics MCPs (Amplitude, Mixpanel, Posthog, Pendo) | `knowledge/metrics/` |
| Feature performance, adoption numbers | Analytics MCPs + `projects/` | `knowledge/research/` |
| Open tasks, ticket status, epic progress | PM MCPs (Linear, Jira) | Recent meeting notes for action items |
| User quotes, research themes, pain points | Research MCPs (Dovetail) | `knowledge/research/` |
| Competitor moves, market intel | Web search | `knowledge/research/competitive-*.md` |
| Past decisions, strategy rationale | `knowledge/decisions/` | `knowledge/strategy/` |
| Meeting action items, follow-ups | `knowledge/meetings/` | PM MCPs for task status |

**Rules:**
- If multiple MCPs of the same category are connected, ask which one to use
- If no MCP is available, use workspace files without mentioning the gap
- If workspace files are also missing, ask the user to provide the data inline
- Never fabricate metrics. If data is unavailable, say so

## 2. Self-Updating Learning Log

Track usage patterns and corrections to improve skill quality over time. Maintain a lightweight log at `knowledge/prodkit-learning-log.md`.

**What to track:**

| Signal | What to record | When |
|--------|---------------|------|
| Skill usage | Which skill was invoked, date | After every skill run |
| Heavy edits | User rewrote >50% of output | When user says "too long," "wrong tone," "not specific enough," or edits the output file significantly |
| Style corrections | Specific correction (e.g., "shorter," "more data," "wrong audience") | After any output feedback |
| Sizing calibration | Estimated impact vs actual results | When `/feature-results` or similar post-launch data is shared |
| Stakeholder preferences | Audience-specific patterns (e.g., "CEO always wants metrics first") | When user corrects audience framing |
| Workflow sequences | Which skills are always run together | After 3+ occurrences of same sequence |

**Rules:**
- Create `knowledge/prodkit-learning-log.md` on first learning event (not at install)
- Never modify the learning log silently. Always tell the user what you're recording
- Append new entries. Never delete old ones (the user can prune manually)
- Format: `YYYY-MM-DD | signal_type | detail`
- Review prompt: if the log has 20+ entries and hasn't been reviewed, suggest a monthly review

## 3. Context Auto-Organization

When creating output files, detect the user's existing folder structure first. Never impose a layout on someone else's repo.

**Step 1: Detect existing structure (run once per session, cache the result)**

On first file save, scan the repo root for common PM folder patterns:

| Pattern to check | Matches |
|-----------------|---------|
| `projects/` or `specs/` or `features/` | Initiative-scoped folders |
| `work/` or `outputs/` or `docs/` or `documents/` | General work products |
| `knowledge/` or `context/` or `context-library/` or `reference/` | Reference material |
| `decisions/` (at any level) | Decision docs |
| `research/` (at any level) | Research outputs |
| `analyses/` or `analysis/` (at any level) | Analytical outputs |

Also check: CLAUDE.md for explicit path conventions. Any existing prodkit output files (via the `<!-- prodkit |` version header) to see where past outputs landed.

**Step 2: Map output types to detected folders**

If the repo already has structure, use it. Map each output type to the closest existing folder:

| Output type | Preferred folder (in priority order) |
|-------------|--------------------------------------|
| Feature specs, PRDs | First match: `projects/`, `specs/`, `features/`, `docs/` |
| Decision docs | First match: `decisions/`, `work/decisions/`, `docs/decisions/` |
| Impact analyses | First match: `analyses/`, `work/analyses/`, `docs/` |
| Prioritization results | Same as impact analyses |
| Launch checklists | First match: `checklists/`, `work/checklists/`, `docs/` |
| Competitive analyses | First match: `research/`, `work/research/`, `docs/` |
| Research synthesis | Same as competitive analyses |
| Review panel reports | Same folder as the spec being reviewed |
| North Star definitions | First match: `knowledge/strategy/`, `reference/strategy/`, `strategy/`, `docs/` |

**Step 3: If no structure exists (greenfield repo), use defaults**

| Output type | Default destination |
|-------------|-------------------|
| Feature specs | `projects/<initiative>/` |
| Decision docs | `work/decisions/` |
| Analyses and prioritization | `work/analyses/` |
| Checklists | `work/checklists/` |
| Research and competitive | `work/research/` |
| Review panel reports | Next to the reviewed spec |
| Strategy and North Star | `knowledge/strategy/` |

**Rules:**
- Detect first, default second. Never overwrite existing conventions
- If the destination folder doesn't exist, create it
- If a file with the same name exists, append a version suffix (`-v2`, `-v3`) rather than overwriting
- Never save outputs to the repo root
- If unsure which folder to use (e.g., repo has both `docs/` and `work/`), check where the most recent similar file was saved and follow that pattern

## 4. Smart Output Versioning

Prevent duplicate and stale outputs. Detect when a skill has already produced output for the same topic today.

**Before writing any output file:**

1. Check the target folder for existing files with similar names or matching topic
2. If a same-day duplicate exists (same skill, same topic, same date):
   - Ask: "You already ran this today. Want me to update the existing file or create a new version?"
   - If update: edit in place, preserving sections the user didn't ask to change
   - If new version: append `-v2`, `-v3` suffix
3. If a prior version exists from a different day:
   - Create the new version alongside it (don't overwrite)
   - Note in the new file's header: `Previous version: [filename] ([date])`

**Version header format (add to every output file):**
```
<!-- prodkit | skill: [skill-name] | date: YYYY-MM-DD | version: N -->
```

**Rules:**
- The version header is a comment. It doesn't clutter the document
- Same-day = same calendar date, not 24-hour window
- "Similar names" = same skill prefix + overlapping topic words in filename

## 5. Proactive Workflow Suggestions

Surface patterns and suggest improvements. Never apply changes automatically.

**Trigger: Style corrections (3+ threshold)**
- After 3+ similar corrections to output style (e.g., "too long" x3, or "needs more data" x3), suggest updating the relevant writing style or skill preferences
- Format: "I've noticed you've corrected [pattern] three times now. Want me to update [file] so future outputs match your preference?"
- If the user says yes, update the relevant context file and log it in the learning log

**Trigger: Repeated workflows (3+ threshold)**
- If the user runs the same skill sequence 3+ times (e.g., `/feature-spec-interview` then `/feature-doc-review-panel` then `/decision-doc`), suggest a combined workflow
- Format: "You've run [sequence] together 3 times. Want me to suggest a combined workflow that chains them?"

**Trigger: Stale context (2+ weeks)**
- If workspace files in `knowledge/` reference dates older than 2 weeks and the user is actively working in that area, flag it
- Format: "The competitive analysis in [file] is from [date]. Want me to refresh it with `/competitor-analysis`?"

**Trigger: Missing context**
- When a skill checks for context files and finds none (e.g., `/impact-sizing` looks for user research but `knowledge/research/` is empty), note the gap
- Format: "This sizing would be stronger with user research data. Run `/user-research-synthesis` first, or I'll work with what we have."

**Rules:**
- Never apply suggestions automatically. Always ask first
- Don't repeat the same suggestion in the same session
- Log all suggestions (accepted or declined) in the learning log

## 6. Parallel Execution

When processing 3+ independent items, spawn sub-agents in parallel rather than working sequentially.

**When to parallelize:**

| Scenario | Parallel strategy |
|----------|------------------|
| `/feature-doc-review-panel` with 7 reviewers | Spawn 7 sub-agents (one per perspective), synthesize at the end |
| `/user-research-synthesis` with 3+ interviews | Process each interview in parallel, then cross-reference themes |
| `/competitor-analysis` comparing 3+ competitors | Research each competitor in parallel, then build comparison matrix |
| `/launch-checklist` with multiple workstreams | Generate each workstream's checklist in parallel |
| Any skill processing a batch of inputs | Split into parallel agents if items are independent |

**Rules:**
- Only parallelize when items are genuinely independent (no cross-dependencies)
- Always synthesize parallel results into a single unified output
- Flag conflicts between parallel results (e.g., two reviewers disagree)
- Cap at 7 parallel agents maximum (Claude Code practical limit)
- For 2 items, run sequentially. Parallelization overhead isn't worth it below 3

## 7. Skill Interconnection Graph

Skills reference each other's outputs. When one skill produces data, downstream skills should find and use it automatically.

**Interconnection map:**

```
/feature-spec-interview
  -> feeds: /feature-doc-review-panel (spec to review)
  -> feeds: /launch-checklist (requirements for checklist)
  -> feeds: /impact-sizing (feature definition for sizing)
  -> feeds: /decision-doc (decisions captured during interview)

/impact-sizing
  -> feeds: /prioritize (sized value for prioritization input)
  -> calibrated by: post-launch actuals (log in learning-log.md)

/define-north-star
  -> feeds: /impact-sizing (north star as sizing anchor)
  -> feeds: /prioritize (strategic alignment check)

/competitor-analysis
  -> feeds: /feature-spec-interview (competitive context for spec)
  -> feeds: /decision-doc (competitive rationale)

/user-research-synthesis
  -> feeds: /feature-spec-interview (user quotes, pain points)
  -> feeds: /impact-sizing (addressable user segments, pain severity)

/feature-doc-review-panel
  -> feeds: /decision-doc (review-surfaced decisions)
  -> feeds: /feature-spec-interview (gaps found during review -> re-interview)

/prioritize
  -> feeds: /launch-checklist (priority ordering for launch sequence)

/launch-checklist
  -> downstream: post-launch -> calibrate /impact-sizing estimates
```

**How it works in practice:**

When any skill is invoked:
1. Check if upstream skills have produced relevant output in `projects/` or `work/`
2. If found, load that context automatically (don't ask)
3. Reference it explicitly in the output: "Based on the impact sizing from [date]..." or "The feature spec identified these requirements..."
4. If upstream output is missing but would improve quality, note the gap (see Proactive Workflow Suggestions, "Missing context" trigger)

**Calibration loop:**
- When `/impact-sizing` produces an estimate, tag it with a confidence level and date
- If the user later shares actual results (post-launch data, A/B test results), compare estimate vs actual
- Log the delta in the learning log: `YYYY-MM-DD | calibration | feature: X | estimated: Y | actual: Z | delta: N%`
- After 5+ calibration entries, surface the pattern: "Your estimates tend to be [X]% [optimistic/pessimistic]. Want me to adjust the baseline?"

**Rules:**
- Never block a skill because upstream data is missing. Always work with what's available
- Cross-references should be lightweight (one line mentioning the source, not long quotes)
- If upstream data is stale (>30 days old for research, >90 days for strategy), note the age but still use it
