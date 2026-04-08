# Prodkit - Schema

This file is the schema layer of prodkit's knowledge system (inspired by Karpathy's LLM Wiki pattern). It tells the LLM how to maintain the user's product knowledge base and how skills interact with it.

Two jobs: (1) define the three-layer knowledge architecture, and (2) encode 7 passive automations that make skills smarter across sessions.

No setup required. Everything activates on first use.

---

## Knowledge Architecture

Prodkit maintains a three-layer knowledge system. The LLM writes and maintains the wiki. The user curates sources and asks questions.

### Layer 1: Raw Sources (user-owned, immutable)

Location: `knowledge/raw/`

Drop original documents here. The LLM reads but never writes to this folder. These are the source of truth for verification.

Examples: uploaded PRDs, interview transcripts, strategy decks, exported analytics, competitive screenshots, research papers, Slack threads, email chains.

**Rules:**
- Never modify, rename, or delete files in `raw/`
- Subfolders are fine for organization (`raw/interviews/`, `raw/competitor-decks/`, `raw/analytics-exports/`)
- If the user pastes content inline (no file), offer to save it to `raw/` for future reference

### Layer 2: The Wiki (LLM-owned, compounding)

Location: `knowledge/wiki/`

LLM-generated and maintained markdown pages. This is where knowledge compounds. Every source ingested, every skill run, every good answer gets compiled here.

**Page types:**

| Type | Naming convention | Purpose |
|------|------------------|---------|
| Index | `INDEX.md` | Front page. Categorized table of contents with one-line summaries. The LLM reads this first to navigate the wiki. |
| Entity | `entity-<name>.md` | A person, company, product, or team. Key facts, relationships, context. |
| Concept | `concept-<name>.md` | A domain concept, framework, or pattern. Definition, examples, cross-links. |
| Feature | `feature-<name>.md` | Synthesized knowledge about a feature. Aggregates spec, sizing, research, decisions. |
| Comparison | `comparison-<topic>.md` | Side-by-side analysis. Competitors, approaches, trade-offs. |
| Synthesis | `synthesis-<topic>.md` | Cross-cutting insight that connects multiple sources or features. |
| Decision | `decision-<topic>.md` | Why a decision was made, alternatives considered, trade-offs accepted. |

**Page format (every wiki page):**

```markdown
# [Page Title]

> Sources: [[raw/source1.md]], [[raw/source2.pdf]]
> Last updated: YYYY-MM-DD
> Updated by: /skill-name or manual ingest

[Content organized by the page type's natural structure]

## Links
- [[Related: entity-team-name]]
- [[See also: concept-framework-name]]
- [[Contradicts: synthesis-old-assumption]] (if applicable)
```

**INDEX.md structure:**

```markdown
# Wiki Index

## Entities
- [[entity-<name>]] - one-line summary

## Features
- [[feature-<name>]] - one-line summary with current status

## Concepts
- [[concept-<name>]] - one-line summary

## Comparisons
- [[comparison-<topic>]] - what's compared

## Syntheses
- [[synthesis-<topic>]] - cross-cutting insight

## Decisions
- [[decision-<topic>]] - what was decided and when

## Recent Activity
- YYYY-MM-DD: Ingested [source], updated N pages
- YYYY-MM-DD: /skill-name produced [output], updated N pages
```

### Layer 3: The Schema (this file)

This CLAUDE.md is the schema. It tells the LLM how to ingest, query, maintain, and connect knowledge. The user and LLM co-evolve this over time.

### Operations

**Ingest (when user drops a new source or shares context):**

1. Save to `knowledge/raw/` if not already there
2. Read the source fully
3. Discuss key takeaways with the user (don't silently process)
4. Create or update wiki pages: extract entities, concepts, claims
5. Add backlinks between new and existing pages
6. Flag contradictions: "This conflicts with [[decision-X]] from [date]. Which is current?"
7. Update `INDEX.md` with new/changed entries
8. Log the operation in the learning log

**Query (when user asks a question):**

1. Read `knowledge/wiki/INDEX.md` to find relevant pages
2. Load 2-5 relevant wiki pages
3. Synthesize answer with citations to wiki pages (and through them, raw sources)
4. If the answer is valuable enough to persist (comparison, analysis, new insight), offer to file it back as a new wiki page
5. If the question reveals a gap in the wiki, note it

**Maintain (periodic, suggest but don't auto-run):**

After 10+ wiki pages exist, periodically suggest maintenance:
- Find contradictions between pages
- Flag stale pages (sources older than 30 days for research, 90 days for strategy)
- Suggest new cross-links between pages that reference similar concepts
- Identify missing entity or concept pages (mentioned in other pages but no dedicated page)
- Check if any raw sources haven't been ingested yet

### How Skills Feed the Wiki

Every prodkit skill run should update the wiki, not just produce a standalone file.

| Skill | Wiki effect |
|-------|-------------|
| `/feature-spec-interview` | Create or update `feature-<name>.md` with spec details. Create entity pages for new stakeholders mentioned. |
| `/feature-doc-review-panel` | Append review findings to `feature-<name>.md`. Log key concerns as cross-links. |
| `/impact-sizing` | Add sizing data to `feature-<name>.md`. Update entity pages with addressable user segments. |
| `/prioritize` | Update INDEX.md with current priority rankings. Tag feature pages with L/N/O classification. |
| `/define-north-star` | Create `concept-north-star.md`. Cross-link to all feature pages that ladder to it. |
| `/competitor-analysis` | Create or update `entity-<competitor>.md` and `comparison-<market>.md`. |
| `/user-research-synthesis` | Create `synthesis-<theme>.md` for each major theme. Link to `raw/` interview sources. |
| `/decision-doc` | Create `decision-<topic>.md`. Backlink to features and entities affected. |
| `/launch-checklist` | Update `feature-<name>.md` with launch status and checklist link. |

**Where skill outputs land:**

| Output type | Destination | Why |
|-------------|------------|-----|
| Feature specs, review reports, launch checklists | `projects/<initiative>/` | Scoped to a named feature or project |
| Research synthesis, competitor analysis, decisions, impact sizing, prioritization, North Star | `knowledge/wiki/` | Cross-cutting knowledge that compounds |

The test: can you name the initiative? If yes, `projects/`. If it's general knowledge, `knowledge/wiki/`.

**Rules:**
- Don't block skills if the wiki or projects folder doesn't exist yet. Create on first use.
- Keep wiki pages concise. Link to raw sources rather than duplicating content.
- When updating an existing page, note what changed and why in the page's content.

---

## 1. MCP Routing Engine

Route natural language questions to the right data source automatically. Check MCPs first, fall back to workspace files, then ask the user.

**Routing table:**

| Query pattern | Primary source | Fallback |
|---------------|---------------|----------|
| Metrics, funnels, retention, conversion | Analytics MCPs (Amplitude, Mixpanel, Posthog, Pendo) | `knowledge/wiki/` (any page with metrics data) |
| Feature performance, adoption numbers | Analytics MCPs | `knowledge/wiki/feature-*.md` |
| Open tasks, ticket status, epic progress | PM MCPs (Linear, Jira) | `knowledge/wiki/` (action items in feature or decision pages) |
| User quotes, research themes, pain points | Research MCPs (Dovetail) | `knowledge/wiki/synthesis-*.md` and `knowledge/raw/` |
| Competitor moves, market intel | Web search | `knowledge/wiki/entity-*.md` and `knowledge/wiki/comparison-*.md` |
| Past decisions, strategy rationale | `knowledge/wiki/decision-*.md` | `knowledge/wiki/concept-*.md` |
| Meeting action items, follow-ups | `knowledge/wiki/` | PM MCPs for task status |

**Rules:**
- If multiple MCPs of the same category are connected, ask which one to use
- If no MCP is available, use workspace files without mentioning the gap
- If workspace files are also missing, ask the user to provide the data inline
- Never fabricate metrics. If data is unavailable, say so

## 2. Self-Updating Learning Log

Track usage patterns and corrections to improve skill quality over time. Maintain a lightweight log at `knowledge/prodkit-learning-log.md`. This log also serves as the wiki's operation history, recording every ingest, skill run, and maintenance task.

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

## 3. File Routing

Two output destinations. No exceptions.

| Question | Destination |
|----------|------------|
| Can you name the feature or project? | `projects/<name>/` |
| Is it general knowledge, cross-cutting analysis, or a reusable insight? | `knowledge/wiki/` |

**Rules:**

- If the folder doesn't exist, create it
- If a file with the same name exists, append a version suffix (`-v2`, `-v3`) rather than overwriting
- Never save outputs to the repo root

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
- When a skill checks for context files and finds none (e.g., `/impact-sizing` looks for user research but no `synthesis-*.md` pages exist in `knowledge/wiki/`), note the gap
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
1. Check if upstream skills have produced relevant output in `projects/` or `knowledge/wiki/`
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
