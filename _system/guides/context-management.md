# Context Management

Master the art of managing AI context for better outputs and efficiency.

## What is Context?

Everything you give AI to work with:

- Instructions
- Background information
- Examples
- Previous conversation
- Files uploaded
- Past project knowledge

**Context window:** How much AI can "remember" at once (Claude: 200K tokens ≈ 150K words)

---

## Why Context Management Matters

### Good Context = Good Outputs

**With great context:**

- AI writes in your style
- Understands your business
- Makes relevant suggestions
- Avoids repeating info

**With poor context:**

- Generic outputs
- Missing critical context
- Repeats things you've told it
- Doesn't match your needs

### Context is Expensive

**Costs:**

- Token usage (API)
- Processing time
- Your time managing it

**Optimization matters.**

---

## Context Management Strategies

### Strategy 1: Layered Context

**Concept:** Different levels of context for different tasks

**Layer 1: Core (Always Include)**

- Company info
- Product overview
- Your role
- Writing style

**Layer 2: Task-Specific (Include as Needed)**

- Specific project details
- Relevant past work
- Subject matter expertise

**Layer 3: Ephemeral (One-Time)**

- This specific task
- Temporary constraints
- Immediate context

**Example:**

```
CORE (stored in Claude Project):
- business-info-template.md
- writing-style-internal.md
- personal-context-pm-background.md

TASK (add for this conversation):
- Current feature we're working on
- Recent user feedback
- Competitive landscape

EPHEMERAL (this message only):
- "Draft PRD for dark mode feature"
- Specific requirements
```

---

### Strategy 2: Context Summarization

**Problem:** Context grows too large over long conversations

**Solution:** Periodically summarize

**Method:**

```
Summarize our conversation so far:
- Key decisions made
- Important context established
- Action items
- Open questions

Format as:
1. Context summary (3-5 bullets)
2. Decisions (list)
3. Next steps

I'll use this summary to continue in a fresh conversation.
```

**When to summarize:**

- Every 10-15 exchanges
- When context feels scattered
- Before switching topics
- At end of session

---

### Strategy 3: Progressive Context Loading

**Concept:** Don't dump everything upfront. Add context as needed.

**Bad approach:**

```
Here's everything about our company, product, market, competitors,
users, tech stack, team, strategy, OKRs, past work...
[20,000 words]

Now write a PRD.
```

**Good approach:**

```
[Start with essential context only]

"Write a PRD for feature X"

[If AI needs more context, it will ask or you'll see gaps]

"Here's additional context on [specific area]"

[Iteratively add what's needed]
```

---

### Strategy 4: Reference Files

**Concept:** Store reusable context externally, reference when needed

**Using Claude Projects:**

1. Upload key docs once (business info, style guides, etc.)
2. Reference in prompts: "Use business-info-template.md for context"
3. AI pulls context automatically

**Using File References:**

```
Read these files for context:
- knowledge/business-info-template.md
- knowledge/writing-style-internal.md

Then: [your task]
```

**Benefits:**

- Reusable across conversations
- Versioned and updatable
- Don't repeat yourself
- Cleaner prompts

---

### Strategy 5: Context Templating

**Concept:** Standard context blocks for common tasks

**Template Example:**

```
STANDARD PRD CONTEXT:
- Company: [from business-info-template.md]
- Product: [from business-info-template.md]
- Target users: [from business-info-template.md]
- Writing style: Internal (knowledge/writing-style-internal.md)
- OKRs: [current quarter OKRs]

[Then add task-specific context]
```

**Save as snippets:**

- Text expander
- Notion templates
- Saved prompts
- Keyboard shortcuts

---

## Context Optimization Techniques

### Technique 1: Context Compression

**Problem:** Context too large

**Solutions:**

**A. Summarize verbose content**

```
Instead of: [50 pages of user interviews]
Use: [2-page summary of key insights]
```

**B. Extract essentials**

```
Instead of: [Complete competitive analysis]
Use: [Key differentiators only]
```

**C. Use structured data**

```
Instead of: Paragraphs of information
Use: Tables, bullets, JSON
```

### Technique 2: Context Chunking

**Problem:** Need to process large documents

**Solution:** Break into chunks, process sequentially

**Example:**

```
"I have a 100-page document to analyze"

Chunk 1: Pages 1-25 → Summarize key points
Chunk 2: Pages 26-50 → Summarize key points
Chunk 3: Pages 51-75 → Summarize key points
Chunk 4: Pages 76-100 → Summarize key points

Then: Synthesize all summaries into final analysis
```

### Technique 3: Context Indexing

**Problem:** Need to reference lots of past work

**Solution:** Create index of past work, pull as needed

**Index Example:**

```
PAST PRDS:
1. Dark mode feature (Feb 2025)
2. API v2 launch (Jan 2025)
3. Mobile redesign (Dec 2024)

[Don't include full PRDs, just reference]

When needed: "Reference PRD #1 (Dark mode)"
```

### Technique 4: Context Scoping

**Problem:** AI focuses on wrong context

**Solution:** Explicitly scope context relevance

**Example:**

```
RELEVANT CONTEXT:
[What AI should focus on]

IGNORE:
[What's not relevant for this task]

TASK:
[What you want done]
```

---

## Context Patterns by Task

### For PRD Writing

**Minimal context:**

- Problem statement
- Target users
- Business goal

**Standard context:**

- Writing style
- Past PRD examples
- Company strategy

**Complete context:**

- User research
- Competitive analysis
- Technical constraints
- Stakeholder input

### For Code Review

**Minimal:**

- Code snippet
- Specific question

**Standard:**

- Project architecture
- Coding standards
- Known issues

**Complete:**

- Full codebase context
- Team conventions
- Performance requirements

### For Research Synthesis

**Minimal:**

- Raw research data
- Synthesis goal

**Standard:**

- Research methodology
- Target audience
- Key questions

**Complete:**

- Past research
- Product strategy
- Business context

---

## Context Anti-Patterns

### ❌ Anti-Pattern 1: Context Dump

**Problem:**
Providing everything "just in case"

**Fix:**
Provide only what's relevant for this task

### ❌ Anti-Pattern 2: Context Rot

**Problem:**
Old, outdated context still being used

**Fix:**
Regular context audits and updates

### ❌ Anti-Pattern 3: Duplicate Context

**Problem:**
Same info repeated multiple times

**Fix:**
Reference once, don't repeat

### ❌ Anti-Pattern 4: Vague Context

**Problem:**
"You know our company..." (AI doesn't)

**Fix:**
Be explicit, assume zero knowledge

### ❌ Anti-Pattern 5: Contradictory Context

**Problem:**
Different parts of context contradict each other

**Fix:**
Review for consistency before submitting

---

## Context Auditing

**Monthly context audit checklist:**

**Business Context:**

- [ ] Company info current?
- [ ] OKRs updated?
- [ ] Strategy still accurate?
- [ ] Metrics up to date?

**Project Context:**

- [ ] Active projects listed?
- [ ] Completed projects archived?
- [ ] Stakeholders current?
- [ ] Priorities accurate?

**Personal Context:**

- [ ] Role still accurate?
- [ ] Preferences unchanged?
- [ ] Style guides current?
- [ ] Examples relevant?

**Remove:**

- Outdated information
- Completed projects
- Old strategies
- Irrelevant examples

---

## Advanced: Context Windows

### Understanding Token Limits

**Claude Context Windows (January 2026):**

- Claude Opus 4.5: 200K tokens (flagship model)
- Claude Sonnet 4: 200K tokens (best balance of speed/quality)
- Claude Haiku 3.5: 200K tokens (fastest, most cost-effective)

**What fits:**

- 200K tokens ≈ 150K words
- ≈ 500 pages of text
- ≈ 50-100 documents

**Practical limits:**

- Don't use full window (slower, expensive)
- Aim for 10-20K tokens for most tasks
- Reserve large context for when truly needed

### Token Counting

**Rough estimates:**

- 1 word ≈ 1.3 tokens
- 1 page ≈ 400 tokens
- 1 long email ≈ 500 tokens
- 1 PRD ≈ 2,000 tokens

**Check exact count:**

```python
import anthropic
client = anthropic.Anthropic()

token_count = client.count_tokens("Your text here")
```

---

## Context Management Tools

### Claude Projects

**Best for:**

- Persistent context
- Multiple conversations
- Team collaboration
- Large knowledge bases

**Setup:**

1. Create project
2. Upload core documents
3. Set instructions
4. Start conversations

### Text Expanders

**Tools:**

- TextExpander
- aText
- Keyboard Maestro (Mac)
- AutoHotkey (Windows)

**Use for:**

- Common context blocks
- Standard prompts
- Frequent references

### Notion/Obsidian

**Use for:**

- Context library
- Template storage
- Version control
- Team sharing

---

## Quick Reference

### Context Checklist

**Before each AI session:**

- [ ] What's the task?
- [ ] What context is essential?
- [ ] What context is optional?
- [ ] What can be referenced vs. pasted?
- [ ] Is my context current?

**During session:**

- [ ] Is AI missing context?
- [ ] Is context too much?
- [ ] Should I summarize and restart?

**After session:**

- [ ] Did I discover useful context to save?
- [ ] Should I update my context library?
- [ ] What worked well for next time?

---

## Next Steps

1. Audit your current context usage
2. Build your context library (knowledge/)
3. Create reusable context templates
4. Set calendar reminder for monthly context audits
5. Track which context patterns work best for you

---

**Goal:** Maximum output quality with minimum context overhead.

**ROI:** 30-50% faster with better results through smart context management 📚
