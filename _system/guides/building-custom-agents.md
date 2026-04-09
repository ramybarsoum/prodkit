# Building Custom Agents

Create specialized AI agents tailored to your specific PM workflows.

## What are Custom Agents?

Specialized AI instances with:

- Specific knowledge
- Defined personality/perspective
- Consistent behavior
- Reusable across tasks

**Think:** Sub-agents++ with persistence and specialization.

---

## Why Build Custom Agents?

**Benefits:**

- Consistency (same quality every time)
- Efficiency (no re-explaining context)
- Specialization (expert-level in narrow domain)
- Reusability (use again and again)

**Example:**
Instead of explaining "review this PRD from engineering perspective" every time,
you have an Engineering Reviewer Agent that knows your tech stack, your standards,
and your team's constraints.

---

## Types of Custom Agents

### 1. Role-Based Agents

**Examples:**

- Engineering Reviewer
- Design Reviewer
- Customer Voice
- Executive Advisor
- Data Analyst

**Use for:** Getting specific perspectives consistently

### 2. Task-Based Agents

**Examples:**

- PRD Writer
- Research Synthesizer
- Competitive Analyst
- Meeting Summarizer
- Email Drafter

**Use for:** Repeating specific tasks with quality

### 3. Knowledge-Domain Agents

**Examples:**

- Healthcare Compliance Expert
- AI/ML Product Specialist
- Enterprise SaaS Expert
- Mobile App Designer
- API Documentation Writer

**Use for:** Domain expertise on demand

### 4. Workflow Agents

**Examples:**

- Weekly Standup Prep
- Launch Coordinator
- Feedback Processor
- Sprint Planner

**Use for:** Orchestrating complex multi-step workflows

---

## How to Build a Custom Agent

### Method 1: Claude Projects (Easiest)

**Step 1: Create Project**

1. Go to claude.ai
2. Click "Projects"
3. Create new project with specific name

**Step 2: Add Knowledge**
Upload relevant documents:

- Context files
- Examples of good work
- Domain knowledge
- Standards and guidelines

**Step 3: Set Instructions**
Define agent behavior in project instructions:

```
You are an Engineering Reviewer for [Company].

Your role: Review PRDs and technical specs from an engineering perspective.

Your expertise:
- Our tech stack: [list]
- Our architecture: [description]
- Our engineering standards: [link]

When reviewing, focus on:
1. Technical feasibility
2. Complexity and effort estimation
3. Dependencies and risks
4. Performance and scale
5. Edge cases and error handling

Always provide:
- Specific concerns
- Estimated effort
- Alternative approaches
- Risk mitigation suggestions

Tone: Direct but constructive. You're helping, not blocking.
```

**Step 4: Use Consistently**
Open this project whenever you need that agent.

---

### Method 2: System Prompts (API/Cursor)

**For API usage:**

```python
import anthropic

client = anthropic.Anthropic()

ENGINEERING_REVIEWER = """
You are an Engineering Reviewer for [Company].
[Full agent definition here]
"""

response = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=4000,
    system=ENGINEERING_REVIEWER,
    messages=[{
        "role": "user",
        "content": "Review this PRD: [content]"
    }]
)
```

**For Cursor:**
Add to `.cursorrules` or project docs.

---

### Method 3: Custom GPTs (ChatGPT)

**For ChatGPT users:**

1. Go to ChatGPT
2. Create Custom GPT
3. Define behavior, knowledge, actions
4. Share with team or keep private

---

## Agent Design Framework

### 1. Define Purpose

**Questions:**

- What specific problem does this agent solve?
- What tasks will it handle?
- What's out of scope?

**Example:**

```
AGENT: Competitive Intel Analyst

PURPOSE: Monitor competitors and provide weekly analysis

IN SCOPE:
- Pricing changes
- Feature launches
- Market positioning
- Strategic moves

OUT OF SCOPE:
- Our own product strategy
- Implementation details
- Customer research
```

### 2. Define Personality

**Characteristics:**

- Tone (formal, casual, direct)
- Perspective (engineer, user, executive)
- Communication style
- Level of detail

**Example:**

```
PERSONALITY:
- Direct and data-driven
- Focuses on facts, not speculation
- Flags uncertainty clearly
- Provides confidence levels
- Suggests validation methods
```

### 3. Define Knowledge

**What does the agent know?**

- Domain expertise
- Company context
- Process knowledge
- Examples of good work

**Example:**

```
KNOWLEDGE BASE:
- Our current product (feature list, architecture)
- Our target market (ICP, personas)
- Our competitors (list, analysis)
- Our tech stack (languages, frameworks)
- Our processes (PRD template, review process)
```

### 4. Define Outputs

**What does the agent produce?**

- Format (structured, freeform)
- Length (brief, detailed)
- Components (always includes X)

**Example:**

```
OUTPUT FORMAT:
1. Executive Summary (3 bullets)
2. Detailed Findings
   - What changed
   - Impact on us
   - Recommended response
3. Supporting Data
4. Confidence Level (High/Medium/Low)
```

### 5. Define Constraints

**Rules the agent follows:**

- What it never does
- When it declines
- When it asks for more info

**Example:**

```
CONSTRAINTS:
- Never speculate without flagging uncertainty
- Never make strategic recommendations (that's human decision)
- Always cite sources
- If data insufficient, say so explicitly
```

---

## Example Custom Agents

### Agent 1: PRD Quality Checker

**Purpose:** Ensure PRDs meet quality bar before review

**Instructions:**

```
You are a PRD Quality Checker.

Your job: Review PRDs for completeness and clarity before stakeholder review.

Check for:
1. Problem clearly defined?
2. Target users specified?
3. Success metrics defined?
4. User stories included?
5. Technical approach outlined?
6. Edge cases considered?
7. Go-to-market plan included?
8. Open questions documented?

Output format:
- ✅ Pass / 🟡 Needs work / ❌ Incomplete
- For each section: status + specific issues
- Overall readiness score (1-10)
- Blockers before review
- Nice-to-haves to add

Never review for strategic merit (that's for stakeholders).
Only check completeness and clarity.
```

---

### Agent 2: User Feedback Synthesizer

**Purpose:** Weekly synthesis of user feedback

**Instructions:**

```
You are a User Feedback Synthesizer.

Weekly task: Analyze all user feedback and extract insights.

Sources:
- Support tickets
- User interviews
- In-app feedback
- Social media
- Sales calls

For each week, provide:
1. Top 3 themes (what users are talking about most)
2. New themes (what emerged this week)
3. Sentiment trend (better/worse/same)
4. Feature requests (with frequency)
5. Pain points (with severity)
6. Suggested actions (for PM to consider)

Format:
- Executive summary (3 bullets)
- Detailed analysis by theme
- Specific user quotes (for each theme)
- Recommended investigations
- Questions to explore

Update every Monday based on past 7 days of feedback.
```

---

### Agent 3: Launch Checklist Manager

**Purpose:** Ensure nothing is forgotten for launches

**Instructions:**

```
You are a Launch Checklist Manager.

Your job: Guide PMs through complete launch process.

For each launch, track:

PRE-LAUNCH (4 weeks out):
- [ ] PRD finalized
- [ ] Design complete
- [ ] Engineering estimate
- [ ] QA plan created
- [ ] Beta users identified
- [ ] Marketing brief drafted
- [ ] Support docs planned
- [ ] Success metrics defined

LAUNCH WEEK (1 week out):
- [ ] Beta complete
- [ ] Final QA pass
- [ ] Marketing materials ready
- [ ] Support trained
- [ ] Documentation complete
- [ ] Rollout plan defined
- [ ] Rollback plan ready
- [ ] Monitoring configured

LAUNCH DAY:
- [ ] Deploy to production
- [ ] Monitor metrics
- [ ] Customer announcement sent
- [ ] Internal announcement sent
- [ ] Social posts live
- [ ] Support standing by

POST-LAUNCH (1 week after):
- [ ] Metrics review
- [ ] User feedback collected
- [ ] Issues logged
- [ ] Success assessment
- [ ] Retrospective scheduled

For each item, track:
- Status (done/in-progress/blocked)
- Owner
- Deadline
- Blockers

Send reminders for overdue items.
Flag risks early.
```

---

## Agent Testing

### Test Your Agent

**Test scenarios:**

1. Typical case (should handle well)
2. Edge case (should handle gracefully)
3. Missing info (should ask for it)
4. Out of scope (should decline politely)

**Quality checks:**

- ✅ Consistent behavior
- ✅ Follows instructions
- ✅ Produces expected format
- ✅ Stays in scope
- ✅ Quality matches humans

### Iterate Based on Results

**After each use:**

- What worked well?
- What was missing?
- What was confusing?
- How to improve?

**Update agent:**

- Refine instructions
- Add examples
- Update knowledge base
- Adjust personality

---

## Agent Library

**Build a collection:**

1. Start with 3-5 core agents
2. Add specialized agents as needed
3. Maintain and improve over time
4. Share successful agents with team

**Suggested starter set:**

1. Engineering Reviewer
2. PRD Writer
3. Research Synthesizer
4. Weekly Update Generator
5. Launch Coordinator

---

## Advanced: Agent Orchestration

**Agents working together:**

**Example: Feature Development Workflow**

```
Agent 1: Research Synthesizer
→ Analyzes user feedback and creates research summary

Agent 2: PRD Writer
→ Takes research summary, creates PRD draft

Agent 3-5: Reviewers (parallel)
→ Engineering, Design, Executive review in parallel

Agent 6: Synthesis
→ Incorporates all feedback, creates final PRD

Agent 7: Launch Coordinator
→ Takes approved PRD, manages launch checklist
```

**Coordination:**

- Use APIs or automation tools
- Define handoff points
- Standard output formats
- Error handling

---

## Best Practices

**Do:**

- ✅ Start simple, add complexity gradually
- ✅ Test thoroughly before relying on
- ✅ Document what each agent does
- ✅ Version your agent definitions
- ✅ Share successful agents with team

**Don't:**

- ❌ Make agents too broad (be specific)
- ❌ Set and forget (iterate based on use)
- ❌ Replace human judgment
- ❌ Skip quality checks
- ❌ Ignore edge cases

---

## Next Steps

1. Identify one repetitive task you do
2. Design a custom agent for it
3. Build in Claude Projects
4. Test on 5 examples
5. Refine based on results
6. Use consistently for 2 weeks
7. Measure time saved

---

**Goal:** Agents that consistently deliver quality outputs for specific tasks.

**ROI:** 50-70% time savings on repetitive specialized work 🤖
