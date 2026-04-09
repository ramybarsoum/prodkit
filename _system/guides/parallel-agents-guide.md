# Parallel Agents Guide

Run multiple AI agents simultaneously to accomplish complex tasks faster.

## What Are Parallel Agents?

Instead of one AI doing tasks sequentially, you run multiple AI instances working on different parts of a problem at the same time.

**Sequential (Old Way):**

1. Research competitors (15 min)
2. Analyze user feedback (15 min)
3. Draft PRD (20 min)
4. Get sub-agent reviews (15 min)
   **Total: 65 minutes**

**Parallel (New Way):**

1. Agent 1: Research competitors (15 min)
2. Agent 2: Analyze user feedback (15 min)
3. Agent 3: Draft PRD outline (10 min)
4. Agent 4-7: Sub-agent reviews ready (5 min)
   **Total: 25 minutes** (overlap maximized)

---

## When to Use Parallel Agents

### Good Use Cases ✅

**1. Multi-Source Research**

- Agent 1: Competitor analysis
- Agent 2: User research synthesis
- Agent 3: Market trends
- Agent 4: Internal data analysis

**2. Multi-Perspective Reviews**

- Agent 1: Engineering review
- Agent 2: Design review
- Agent 3: Executive review
- Agent 4: Customer perspective

**3. Multi-Document Creation**

- Agent 1: PRD
- Agent 2: One-pager
- Agent 3: Presentation
- Agent 4: Email announcement

**4. Multi-Variant Testing**

- Agent 1: Approach A draft
- Agent 2: Approach B draft
- Agent 3: Approach C draft
- Compare and pick best

### Bad Use Cases ❌

**Sequential Dependencies:**

- Need output of Agent 1 before Agent 2 can start
- Just run them in sequence instead

**Simple Tasks:**

- Single task that takes 5 minutes
- Overhead of parallelization not worth it

**Limited Context:**

- Each agent needs same large context
- You'll spend more time uploading than saving

---

## How to Run Parallel Agents

### Method 1: Multiple Browser Windows/Tabs

**Setup (Simple):**

1. Open Claude.ai in 4 different browser windows
2. Or use 4 different browsers (Chrome, Firefox, Safari, Edge)
3. Load context in each
4. Start all agents simultaneously

**Example Workflow:**

**Window 1: Competitive Research**

```
Use /competitor-analysis to run competitive analysis on:
- Competitor A
- Competitor B
- Competitor C

Focus on: pricing, features, positioning
```

**Window 2: User Feedback Analysis**

```
Use /user-research-synthesis to analyze these 50 user feedback items:
[paste feedback]

Extract:
- Top pain points
- Feature requests
- Sentiment trends
```

**Window 3: PRD Draft**

```
Use /prd-draft to draft PRD for [feature] based on:
- Problem: [description]
- Users: [who]
- Business goal: [what]
```

**Window 4: Market Analysis**

```
Search the web for:
- Market size for [category]
- Growth trends
- Key players
- Recent funding

Create market opportunity report.
```

**Results:** All 4 complete in ~15 minutes instead of 60 minutes sequential.

---

### Method 2: Claude Projects (Recommended)

**Setup:**

1. Create 4 Claude Projects with different purposes:
   - "Research & Analysis"
   - "Document Creation"
   - "Reviews & Feedback"
   - "Data Analysis"

2. Load relevant context in each:
   - Business info
   - Past work examples
   - Specific knowledge

3. Open all 4 projects in different tabs
4. Run tasks in parallel

**Benefits:**

- Context persists across sessions
- Each project optimized for its purpose
- Can reference past work in that project

---

### Method 3: API + Parallel Requests

**For advanced users with coding skills:**

```python
import anthropic
import asyncio

client = anthropic.Anthropic(api_key="your-key")

async def run_agent(task, context):
    """Run a single agent task"""
    response = await client.messages.create(
        model="claude-sonnet-4-20250514",
        max_tokens=4000,
        messages=[{
            "role": "user",
            "content": f"{context}\n\n{task}"
        }]
    )
    return response.content[0].text

async def run_parallel_agents():
    """Run multiple agents in parallel"""

    # Define tasks
    tasks = [
        ("Research competitor pricing", context_1),
        ("Analyze user feedback", context_2),
        ("Draft PRD outline", context_3),
        ("Create market analysis", context_4)
    ]

    # Run all in parallel
    results = await asyncio.gather(
        *[run_agent(task, context) for task, context in tasks]
    )

    return results

# Run
results = asyncio.run(run_parallel_agents())
```

**Benefits:**

- True parallel execution
- Scriptable and repeatable
- Can process large batches
- Full automation possible

**Costs:**

- API costs (but time savings worth it)
- Requires coding knowledge
- Setup overhead

---

### Method 4: Automation Tools (Make.com, n8n, Zapier)

**For no-code parallel execution:**

**Make.com Example:**

```
Trigger: Manual or scheduled
  ↓
Split into 4 parallel paths:
  ↓
Path 1: HTTP → Claude API → Competitor analysis
Path 2: HTTP → Claude API → User research
Path 3: HTTP → Claude API → PRD draft
Path 4: HTTP → Claude API → Market data
  ↓
Aggregate results
  ↓
Send to Notion/Slack
```

**Benefits:**

- No coding required
- Can schedule recurring runs
- Integrates with other tools
- Results automatically saved

**Example Scenario:**
Every Monday at 9am:

1. Scrape competitor sites
2. Pull user feedback from last week
3. Analyze support tickets
4. Generate weekly report
   All in parallel, results in Slack by 9:15am.

---

## Parallel Agent Patterns

### Pattern 1: Divide and Conquer

**Use case:** Large research project

**Setup:**

- Split research into 4 domains
- Each agent takes one domain
- Combine results at end

**Example:**

```
Agent 1: Healthcare market research
Agent 2: Fintech market research
Agent 3: E-commerce market research
Agent 4: SaaS market research

Then: Synthesize all 4 into one report
```

### Pattern 2: Multi-Perspective Review

**Use case:** Comprehensive PRD review

**Setup:**

- Same document to all agents
- Different review perspectives
- Combine feedback

**Example:**

```
All agents read same PRD:

Agent 1: Engineering review (sub-agents/engineer-reviewer.md)
Agent 2: Design review (sub-agents/designer-reviewer.md)
Agent 3: Executive review (sub-agents/executive-reviewer.md)
Agent 4: Customer voice (sub-agents/customer-voice.md)

Results: Comprehensive feedback from 4 perspectives in 5 minutes
```

### Pattern 3: Multi-Format Creation

**Use case:** Launch announcement

**Setup:**

- Same content, different formats
- All agents work simultaneously
- Get all formats at once

**Example:**

```
Same launch info to all agents:

Agent 1: Internal email announcement
Agent 2: Customer-facing blog post
Agent 3: Social media posts (Twitter, LinkedIn)
Agent 4: Press release

Results: All launch materials in 10 minutes
```

### Pattern 4: Variant Testing

**Use case:** Exploring different approaches

**Setup:**

- Same problem to all agents
- Different solution approaches
- Compare and choose best

**Example:**

```
Same feature request to all agents:

Agent 1: "Design this as a wizard (step-by-step)"
Agent 2: "Design this as a dashboard (all-at-once)"
Agent 3: "Design this as a modal (overlay)"
Agent 4: "Design this as a sidebar (persistent)"

Results: 4 approaches to evaluate quickly
```

### Pattern 5: Iterative Improvement

**Use case:** Refining a document

**Setup:**

- Each agent focuses on one aspect
- All improve same document
- Combine improvements

**Example:**

```
All agents read same draft PRD:

Agent 1: "Improve clarity and readability"
Agent 2: "Add more specific metrics"
Agent 3: "Strengthen business case"
Agent 4: "Add missing edge cases"

Then: Synthesize all improvements
```

---

## Coordinating Parallel Agents

### The Coordination Problem

When you run multiple agents in parallel, you need to:

1. **Split work clearly** (no overlap)
2. **Combine results** (synthesis)
3. **Resolve conflicts** (different recommendations)

### Solution 1: Clear Division of Labor

**Before starting:**

- Define exactly what each agent does
- Ensure no overlap
- Specify output format

**Example:**

```
Agent 1: Analyze Q1 data ONLY
Agent 2: Analyze Q2 data ONLY
Agent 3: Analyze Q3 data ONLY
Agent 4: Analyze Q4 data ONLY

Then: Combine into yearly report
```

### Solution 2: Synthesis Agent

**After parallel agents complete:**

- Run a 5th agent to synthesize
- Resolves conflicts
- Creates unified output

**Example:**

```
Agents 1-4 complete their work
  ↓
Agent 5 (Synthesis):
"Read outputs from 4 agents:
[paste Agent 1 output]
[paste Agent 2 output]
[paste Agent 3 output]
[paste Agent 4 output]

Create unified report that:
- Combines insights
- Resolves contradictions
- Highlights patterns across all 4
- Provides single clear recommendation"
```

### Solution 3: Voting/Ranking

**When agents disagree:**

- Run a decision agent
- Compare recommendations
- Pick best or blend

**Example:**

```
Agents 1-3 each recommend different priorities:
Agent 1: Build feature A first
Agent 2: Build feature B first
Agent 3: Build feature C first

Decision Agent:
"Evaluate these 3 recommendations:
[paste all 3 with rationale]

Consider:
- Business impact
- Engineering effort
- Strategic alignment
- Customer need

Recommend: Which to build first and why"
```

---

## Advanced Parallel Patterns

### Recursive Parallel Agents

**Concept:** Agents spawn more agents

**Example:**

```
Level 1 - Master Agent:
"Break down competitive landscape analysis into 4 parts"

Level 2 - 4 Analysis Agents:
Agent 1: Competitor pricing
Agent 2: Competitor features
Agent 3: Competitor positioning
Agent 4: Competitor strengths/weaknesses

Level 3 - 12 Deep Dive Agents (3 per Level 2):
For each competitor:
  - Agent A: Detailed pricing breakdown
  - Agent B: Feature comparison matrix
  - Agent C: Customer sentiment analysis

Level 4 - Synthesis:
Roll up all findings into executive summary
```

**When to use:** Massive research projects, unlimited time/budget

**Warning:** Can get expensive fast with API costs

---

### Pipeline Parallel Agents

**Concept:** Assembly line of agents

**Example:**

```
Stage 1 (Parallel): Gather data
- Agent 1: User interviews
- Agent 2: Analytics data
- Agent 3: Support tickets
  ↓
Stage 2 (Sequential): Synthesize
- Agent 4: Combine all data
  ↓
Stage 3 (Parallel): Create outputs
- Agent 5: PRD
- Agent 6: One-pager
- Agent 7: Presentation
  ↓
Stage 4 (Parallel): Review
- Agent 8: Eng review
- Agent 9: Design review
  ↓
Stage 5 (Sequential): Finalize
- Agent 10: Incorporate feedback
```

**When to use:** Complex projects with clear stages

---

## Real-World Examples

### Example 1: Weekly Competitive Intel

**Goal:** Comprehensive competitor update

**Parallel Setup:**

```
Monday 9am, run simultaneously:

Window 1: Competitor A deep dive
- Latest features
- Pricing changes
- News/announcements
- Customer reviews

Window 2: Competitor B deep dive
[Same structure]

Window 3: Competitor C deep dive
[Same structure]

Window 4: Market trends
- Industry news
- Funding rounds
- M&A activity
- Emerging players

9:20am: Synthesis agent combines all 4
9:30am: Report in Slack
```

**Time saved:** 2 hours → 30 minutes

---

### Example 2: Feature Launch Prep

**Goal:** All launch materials ready

**Parallel Setup:**

```
Thursday, launch prep:

Agent 1: Customer announcement email
Agent 2: Internal launch doc
Agent 3: Help documentation
Agent 4: Social media posts
Agent 5: Sales talking points
Agent 6: Support FAQ

All running simultaneously with same feature context

Results ready in 15 minutes vs. 2 hours sequential
```

---

### Example 3: Quarterly Planning

**Goal:** Synthesize inputs for roadmap

**Parallel Setup:**

```
Planning week:

Agent 1: Analyze all user feedback from Q1
Agent 2: Analyze all support tickets from Q1
Agent 3: Competitive landscape changes
Agent 4: Analytics deep dive (what drove growth)
Agent 5: Sales: deals won/lost analysis
Agent 6: Engineering: tech debt assessment

Week 1: All agents run in parallel
Week 2: Synthesis agent creates roadmap recommendations
Week 3: Finalize with team
```

**Time saved:** 3 weeks → 1 week

---

## Best Practices

### Do's ✅

**1. Clearly define agent scope**
Each agent should have one clear job.

**2. Provide sufficient context**
Each agent needs enough context to do its job well.

**3. Standardize output format**
Makes synthesis easier.

**4. Track agent performance**
Which agents give best results? Optimize them.

**5. Build reusable patterns**
Create templates for common parallel workflows.

**6. Use synthesis agents**
Always have a plan for combining results.

### Don'ts ❌

**1. Don't over-parallelize**
20 agents is probably overkill. Diminishing returns after 5-7.

**2. Don't forget coordination cost**
Combining 10 outputs might take longer than running sequentially.

**3. Don't duplicate work**
Make sure agents aren't doing the same thing.

**4. Don't ignore quality**
Fast but wrong is worse than slow but right.

**5. Don't forget to test**
Run small before scaling to many agents.

---

## Measuring Success

**Speed Improvement:**

- Baseline: How long sequential?
- Parallel: How long with parallel agents?
- Speedup: Baseline / Parallel

**Quality Check:**

- Is parallel output as good as sequential?
- Are you catching all issues?
- Do results need more synthesis?

**Cost Analysis:**

- API costs (if using API)
- Your time saved (worth it?)
- ROI calculation

**Ideal Outcomes:**

- 3-5x speedup
- Same or better quality
- Positive ROI

---

## Troubleshooting

**Problem:** Results are inconsistent

**Solution:**

- Provide more specific instructions
- Use same context for all agents
- Standardize output format
- Add quality checks

**Problem:** Hard to combine results

**Solution:**

- Use synthesis agent
- Request structured output (JSON, tables)
- Template the output format
- Build combining scripts

**Problem:** Too expensive (API)

**Solution:**

- Use browser windows (free)
- Reduce number of parallel agents
- Optimize prompts (shorter context)
- Use cheaper models for simple tasks

**Problem:** Context window limits

**Solution:**

- Split large context into chunks
- Each agent gets only what it needs
- Use summarization for shared context
- Leverage Claude Projects (100K+ context)

---

## Advanced: Orchestration Tools

### LangChain (Python)

```python
from langchain.agents import AgentExecutor
from langchain.chat_models import ChatAnthropic

# Define agents
agents = [
    CompetitorAnalysisAgent(),
    UserResearchAgent(),
    PRDWritingAgent(),
    MarketAnalysisAgent()
]

# Run in parallel
results = await asyncio.gather(*[
    agent.run(context) for agent in agents
])

# Synthesize
synthesis = SynthesisAgent().run(results)
```

### AutoGen (Microsoft)

Multi-agent framework for complex workflows.

### CrewAI

Role-based agent framework.

---

## Starter Templates

### Template 1: PRD Creation

```
Context: [Your feature context]

Agent 1: Research
- User feedback analysis
- Competitive features
- Market trends

Agent 2: Draft PRD
- Use research from Agent 1
- Follow template
- Include metrics

Agent 3-6: Reviews (parallel)
- Engineering
- Design
- Executive
- Customer voice

Agent 7: Synthesis
- Incorporate all feedback
- Final PRD
```

### Template 2: Weekly Research

```
Every Monday 9am:

Agent 1: Competitor monitoring
Agent 2: User feedback synthesis
Agent 3: Support ticket analysis
Agent 4: Analytics anomaly detection

Agent 5 (9:15am): Weekly report
- Combines all 4
- Highlights priorities
- Sends to Slack
```

### Template 3: Launch Prep

```
Launch - 1 week:

Agent 1: Customer announcement
Agent 2: Internal docs
Agent 3: Help articles
Agent 4: Social posts
Agent 5: Sales enablement

Agent 6: Review & polish all 5

Agent 7: Publish everywhere
```

---

## Next Steps

1. ✅ Identify one repetitive multi-part task
2. 🧪 Try parallel agents for that task
3. 📊 Measure time saved vs. sequential
4. 🔄 Refine the process
5. 📚 Build reusable templates
6. 🚀 Scale to other workflows

**Goal:** 3-5x productivity on complex multi-part work.

---

**Time investment:** 2-3 hours to learn  
**Time savings:** 10-15 hours/week once mastered  
**ROI:** 5-10x return on time invested 🚀
