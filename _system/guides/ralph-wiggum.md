# /ralph-wiggum

**Purpose:** Run autonomous iterative loops until a task is completely and accurately done

**Philosophy:** "Iteration beats perfection" - Let AI fail and self-correct until success criteria are met

---

## What This Does

The Ralph Wiggum technique runs Claude Code in a continuous autonomous loop, repeatedly working on the same task until it's truly complete. Named after The Simpsons character, it embodies the philosophy that persistent iteration eventually leads to success.

**Core concept:**

- You give Claude a task with clear completion criteria
- Claude works on it and tries to exit
- A Stop Hook blocks the exit if the task isn't done
- The same prompt gets fed back with all previous work visible
- Each iteration learns from failures (error logs, test results, git history)
- Continues until success criteria are met or iteration limit reached

---

## When to Use This

**Great for:**

- ✅ Building dashboards or prototypes from scratch
- ✅ Generating complete documents (PRDs with all stakeholder reviews)
- ✅ Tasks with clear, verifiable completion criteria
- ✅ Mechanical execution that needs iteration
- ✅ Batch operations (migrations, refactors, test coverage)
- ✅ Multi-step workflows where each step can be validated

**Not recommended for:**

- ❌ Ambiguous requirements (won't converge)
- ❌ Judgment-heavy decisions (needs human thinking)
- ❌ Strategy or architectural choices (requires human reasoning)
- ❌ Exploratory tasks ("figure out why X is slow")
- ❌ Security-sensitive work (auth, payments, data handling)

---

## How to Use

### Step 1: Install the Ralph Wiggum Plugin

```bash
# In Claude Code terminal
/plugin install ralph-wiggum@claude-plugins-official
```

### Step 2: Run the Ralph Loop

**Basic syntax:**

```bash
/ralph-loop "<your task with clear success criteria>" --max-iterations N --completion-promise "KEYWORD"
```

**Key components:**

1. **Task description**: Be specific about what "done" looks like
2. **--max-iterations**: Safety limit (start with 20-30)
3. **--completion-promise**: Text Claude must output when complete (e.g., "COMPLETE", "DONE", "READY")

### Step 3: Let It Run

- Claude will work autonomously
- Each iteration builds on the previous one
- Failures become learning data
- Loop stops when completion promise is found OR max iterations reached

---

## Example 1: Build Analytics Dashboard

**Task:** Create a working dashboard pulling real data from Amplitude

```bash
/ralph-loop "Build a dashboard that pulls analytics from Amplitude.

Requirements:
- Connect to Amplitude MCP (use OAuth)
- Pull WAU data for last 30 days
- Show conversion funnel visualization
- Display NPS scores
- Create clean UI with charts
- All data must load successfully

Success criteria:
- Dashboard loads without errors
- All charts render with real data
- No console errors
- Clean, professional layout

Output <promise>DASHBOARD_COMPLETE</promise> when done." \
--max-iterations 30 \
--completion-promise "DASHBOARD_COMPLETE"
```

**What happens:**

- Iteration 1: Sets up Amplitude connection
- Iteration 2: Fixes auth errors
- Iteration 3: Adds data fetching
- Iteration 4: Creates basic UI
- Iteration 5: Fixes rendering issues
- Iteration 6-10: Refines charts, handles edge cases
- Final: Working dashboard with all data

---

## Example 2: Complete PRD with Reviews

**Task:** Generate a full PRD and get all stakeholder reviews

```bash
/ralph-loop "Create a complete PRD for [feature name] and run it through all 7 sub-agent reviews.

Step 1: Generate PRD using:
- Context from knowledge/business-info-template.md
- Writing style from knowledge/writing-style-executive.md
- PRD workflow from .claude/skills/prd-draft

Step 2: Run reviews using all 7 sub-agents:
- _system/sub-agents/engineer-reviewer.md
- _system/sub-agents/designer-reviewer.md
- _system/sub-agents/executive-reviewer.md
- _system/sub-agents/legal-advisor.md
- _system/sub-agents/uxr-analyst.md
- _system/sub-agents/skeptic.md
- _system/sub-agents/customer-voice.md

Step 3: Address all critical feedback and iterate

Success criteria:
- PRD is 1-2 pages (not 10)
- All 6 key sections included (Hypothesis, Strategic Fit, Non-Goals, Metrics, Rollout, Behavior Examples)
- All 7 sub-agent reviews completed
- Critical issues addressed
- No major blockers remaining

Output <promise>PRD_COMPLETE</promise> when done." \
--max-iterations 25 \
--completion-promise "PRD_COMPLETE"
```

**What happens:**

- Iteration 1: Generates initial PRD
- Iteration 2-3: Runs engineering and design reviews
- Iteration 4-5: Runs executive, legal, UX reviews
- Iteration 6-7: Runs skeptic and customer reviews
- Iteration 8-15: Addresses feedback, refines PRD
- Final: Complete PRD with all reviews addressed

---

## Best Practices

### 1. Start Small

Test with smaller tasks first (--max-iterations 10-15) before running overnight loops.

### 2. Make Success Criteria Verifiable

**Bad:** "Make the dashboard look good"
**Good:** "Dashboard loads without errors, all charts render, no console warnings"

**Bad:** "Write a PRD"
**Good:** "PRD with all 6 sections, 1-2 pages, passes engineering review"

### 3. Use Feedback Loops

Include verification steps in your prompt:

- "Run tests after each change"
- "Check for console errors"
- "Validate all data loads successfully"
- "Ensure lint passes"

### 4. Set Iteration Limits

**For testing:** `--max-iterations 10-20`
**For real work:** `--max-iterations 30-50`
**For overnight runs:** `--max-iterations 50-100` (if confident)

### 5. Structure Multi-Step Tasks

Break complex tasks into phases with validation:

```
Phase 1: Setup and data connection
Phase 2: Core functionality
Phase 3: UI/UX polish
Phase 4: Testing and validation
Output <promise>COMPLETE</promise> when all phases done
```

---

## Cost Considerations

⚠️ **Important:** Ralph loops can consume significant API credits

**Typical costs:**

- Small task (10 iterations): $5-15
- Medium task (30 iterations): $15-50
- Large task (50+ iterations): $50-150+
- Overnight run on large codebase: $100-300+

**Cost control tips:**

1. Always set `--max-iterations` (never run unlimited)
2. Start with lower limits for testing
3. Use `--max-iterations 20` first, then scale up if needed
4. Monitor usage on Claude Code subscription
5. Test prompts with single runs before looping

**When it's worth it:**

- $50 in API costs < 8 hours of your time
- Overnight automation while you sleep
- Complex tasks that would take days manually
- Batch operations across multiple files

---

## Monitoring Progress

### Check Current Status

```bash
# In another terminal
tail -f ~/.local/state/claude/logs/ralph-wiggum.log
```

### Cancel a Running Loop

```bash
# In Claude Code
/cancel-ralph
```

### Resume a Cancelled Loop

Just run the same command again - Claude will see previous work in git history and continue.

---

## Common Issues & Solutions

### Issue: Loop doesn't converge

**Solution:** Make success criteria more specific and verifiable

### Issue: Hits iteration limit before completion

**Solution:**

- Increase `--max-iterations`
- OR break task into smaller sub-tasks
- OR make success criteria more achievable

### Issue: API costs too high

**Solution:**

- Reduce `--max-iterations`
- Test with smaller scope first
- Use more specific prompts (reduces trial-and-error)

### Issue: Gets stuck repeating same mistake

**Solution:**

- Add explicit feedback loop: "Run X to verify, if fails, try Y approach"
- Include error handling in prompt
- Be more specific about failure cases

---

## Advanced Techniques

### Parallel Ralph Loops

Run multiple loops on different tasks:

```bash
# Terminal 1: Build dashboard
/ralph-loop "Build analytics dashboard..." --max-iterations 30

# Terminal 2: Generate PRD
/ralph-loop "Create PRD with reviews..." --max-iterations 25

# Terminal 3: Create prototype
/ralph-loop "Build working prototype..." --max-iterations 40
```

### Overnight Batch Work

Queue up tasks before bed:

```bash
# Create script
cat > overnight-work.sh << 'EOF'
#!/bin/bash
cd /path/to/project

# Task 1
claude -p "/ralph-loop 'Build feature X...' --max-iterations 40"

# Task 2
claude -p "/ralph-loop 'Add tests...' --max-iterations 30"

# Task 3
claude -p "/ralph-loop 'Update docs...' --max-iterations 20"
EOF

chmod +x overnight-work.sh
./overnight-work.sh
```

Wake up to completed work!

### Phased Execution

Run sequential loops for dependent tasks:

```bash
# Phase 1: Foundation
/ralph-loop "Setup project structure..." --max-iterations 15 --completion-promise "FOUNDATION_DONE"

# Phase 2: Core features (after Phase 1 completes)
/ralph-loop "Build core functionality..." --max-iterations 25 --completion-promise "CORE_DONE"

# Phase 3: Polish (after Phase 2 completes)
/ralph-loop "Add UI polish and tests..." --max-iterations 20 --completion-promise "POLISH_DONE"
```

---

## Real-World PM Use Cases

### Use Case 1: Weekly Metrics Dashboard

```bash
/ralph-loop "Create automated weekly metrics dashboard.

Pull data from:
- Amplitude: WAU, conversion funnels, retention
- Pendo: NPS scores, feature adoption
- Linear: Sprint velocity, bug trends

Output format:
- Single HTML dashboard
- Auto-refreshing data
- Clean visualizations
- Exportable to PDF

Output <promise>METRICS_READY</promise> when working." \
--max-iterations 35
```

### Use Case 2: Competitive Analysis Report

```bash
/ralph-loop "Generate competitive intelligence report.

Tasks:
1. Pull latest data on 5 main competitors
2. Analyze feature comparisons
3. Track pricing changes
4. Identify market trends
5. Generate executive summary

Include:
- Feature comparison matrix
- Pricing analysis
- Recommendations section

Output <promise>ANALYSIS_COMPLETE</promise> when done." \
--max-iterations 30
```

### Use Case 3: Launch Checklist Automation

```bash
/ralph-loop "Complete pre-launch checklist for [feature].

Go through templates/launch-checklist-template.md:
- Verify all items
- Generate status report
- Flag any blockers
- Create stakeholder update

Success:
- All checklist items addressed
- Clear go/no-go recommendation
- Stakeholder update drafted

Output <promise>LAUNCH_READY</promise> when complete." \
--max-iterations 20
```

---

## Prompt Engineering for Ralph

The key to successful Ralph loops is writing prompts that **converge** toward correct solutions.

### Template Structure

```
Task: [Clear description of what to build/create]

Requirements:
- [Specific requirement 1]
- [Specific requirement 2]
- [Specific requirement 3]

Success criteria:
- [Verifiable condition 1]
- [Verifiable condition 2]
- [Verifiable condition 3]

Validation steps:
- [How to verify it works]
- [What tests to run]

Output <promise>KEYWORD</promise> when:
- [Explicit completion condition]
- [Another completion condition]
```

### Good vs Bad Prompts

**Bad prompt (won't converge):**

```
Build a dashboard and make it good.
```

**Good prompt (will converge):**

```
Build a dashboard showing product metrics.

Requirements:
- Pull data from Amplitude MCP
- Show WAU, MAU, conversion rate
- Clean UI with Chart.js
- No console errors

Success:
- All data loads
- Charts render correctly
- Responsive design works
- Page loads in < 2 seconds

Output <promise>DONE</promise> when all success criteria met.
```

---

## Integration with PM OS Workflows

Ralph Wiggum works seamlessly with other PM OS components:

### With Context Library

```bash
/ralph-loop "Create strategy doc using context from:
- knowledge/business-info-template.md
- knowledge/writing-style-executive.md
..."
```

### With Sub-Agents

```bash
/ralph-loop "Generate PRD and run all reviews from:
- _system/sub-agents/engineer-reviewer.md
- _system/sub-agents/designer-reviewer.md
..."
```

### With Workflows

```bash
/ralph-loop "Follow process in:
- .claude/skills/prd-draft
Complete all steps until PRD is done."
```

### With Templates

```bash
/ralph-loop "Use template from:
- templates/launch-checklist-template.md
Fill out completely with current project details."
```

---

## Tips for PMs

### 1. Define "Done" Clearly

PMs are great at knowing what "good" looks like. Use that skill:

- "PRD includes all 6 required sections"
- "Dashboard shows accurate data from last 30 days"
- "All stakeholder concerns addressed"

### 2. Use Ralph for Mechanical Work

Free up your brain for strategy:

- Generating first drafts
- Running reviews
- Creating visualizations
- Building prototypes

### 3. Iterate on Your Prompts

Your first Ralph prompt won't be perfect. That's okay:

- Run with `--max-iterations 10` first
- See where it gets stuck
- Refine success criteria
- Try again with `--max-iterations 30`

### 4. Combine with Human Judgment

Ralph handles execution, you handle decisions:

- Ralph generates PRD → You decide strategy
- Ralph builds prototype → You validate with users
- Ralph creates reports → You make recommendations

---

## Safety & Security

### Run in Safe Environments

Ralph often needs `--dangerously-skip-permissions` flag for full automation. Best practices:

- Use disposable cloud VMs for testing
- Don't run on production machines
- Sandbox your environment
- Review output before deploying

### Review Before Shipping

Always review Ralph's work before it goes live:

- Check generated code
- Verify data accuracy
- Test edge cases
- Validate against requirements

### Version Control

Ralph leverages git history:

- Commit before starting Ralph loops
- Each iteration creates changes
- Easy to rollback if needed
- Review diffs to understand what changed

---

## Resources

**Official Documentation:**

- Ralph Wiggum plugin: `/plugin install ralph-wiggum@claude-plugins-official`
- Anthropic docs: https://docs.anthropic.com/

**Community Resources:**

- AI Hero guide: https://www.aihero.dev/tips-for-ai-coding-with-ralph-wiggum
- Paddo.dev: https://paddo.dev/blog/ralph-wiggum-autonomous-loops/
- Awesome Claude: https://awesomeclaude.ai/ralph-wiggum

**Philosophy:**

- "Iteration beats perfection"
- "Better to fail predictably than succeed unpredictably"
- Let the loop handle mechanical execution
- Focus your energy on judgment and strategy

---

## Quick Reference

**Installation:**

```bash
/plugin install ralph-wiggum@claude-plugins-official
```

**Basic usage:**

```bash
/ralph-loop "<task>" --max-iterations N --completion-promise "KEYWORD"
```

**Cancel:**

```bash
/cancel-ralph
```

**Cost estimate:**

- Small (10 iter): $5-15
- Medium (30 iter): $15-50
- Large (50+ iter): $50-150+

**Best for:**

- Mechanical tasks with clear completion
- Multi-step workflows
- Overnight automation
- Batch operations

**Avoid for:**

- Ambiguous requirements
- Strategy decisions
- Security-sensitive work
- Pure exploration

---

**Remember:** Ralph Wiggum is about **autonomous iteration until success**. Define what "done" looks like, set your safety limits, and let the loop handle the grind. You focus on the thinking. Ralph handles the doing.

**Philosophy in action:** "I'm learning!" - Ralph Wiggum (and your AI, with every iteration)
