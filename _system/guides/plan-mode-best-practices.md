# Plan Mode Best Practices

Master extended thinking mode for complex problems that require deep reasoning.

## What is Plan Mode?

Claude can use extended thinking (also called "plan mode") to spend more time reasoning through complex problems before responding. Think of it as Claude taking a deep breath and thinking step-by-step.

**Regular mode:** Quick responses (seconds)  
**Plan mode:** Deep thinking (minutes) for complex tasks

---

## When to Use Plan Mode

### Perfect For ✅

**1. Multi-Step Strategy**

- Roadmap planning
- Competitive strategy
- OKR setting
- Prioritization frameworks

**2. Complex Analysis**

- Root cause analysis
- Data interpretation
- Trade-off decisions
- Risk assessment

**3. System Design**

- Architecture decisions
- Technical specifications
- Integration planning
- Scalability planning

**4. Creative Problem-Solving**

- Novel feature ideation
- Differentiation strategy
- User experience challenges
- Business model innovation

### Don't Use For ❌

**Simple tasks:**

- Quick emails
- Simple questions
- Formatting changes
- Straightforward edits

**Rule:** If task is < 5 min of human thinking, don't use plan mode.

---

## How to Activate Plan Mode

### In Claude.ai

```
Use extended thinking to [complex task]
```

Or explicitly:

```
Think deeply about this before responding:
[complex problem]

Take your time to:
1. Analyze all angles
2. Consider trade-offs
3. Evaluate options
4. Provide reasoned recommendation
```

### In API

```python
response = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=16000,  # Extended for plan mode
    thinking={
        "type": "enabled",
        "budget_tokens": 10000  # How much thinking to allow
    },
    messages=[{
        "role": "user",
        "content": "Complex problem here..."
    }]
)
```

---

## Best Practices

### 1. Frame the Problem Well

**Bad:**
"Help me prioritize features"

**Good:**

```
Use extended thinking to help me prioritize these 10 features:

[List features with context]

Consider:
- Business impact (revenue, growth, retention)
- Engineering effort (complexity, dependencies)
- Strategic alignment (OKRs, vision)
- Customer value (pain point severity, reach)
- Competitive positioning

Recommend: Top 3 to build this quarter with detailed rationale.
```

### 2. Provide Full Context

Plan mode works best with complete information:

- Business context
- Constraints
- Past attempts
- Success criteria
- Known trade-offs

### 3. Ask for Reasoning

```
Show your thinking process:
- What options did you consider?
- How did you evaluate each?
- What trade-offs exist?
- Why this recommendation over alternatives?
```

### 4. Use for Frameworks

Plan mode excels at creating frameworks:

```
Create a decision framework for [problem]:

Requirements:
- Comprehensive (covers all factors)
- Practical (actually usable)
- Weighted (some factors matter more)
- Measurable (quantifiable where possible)

Provide:
- Framework structure
- How to score each factor
- Example scoring 3 options
- Sensitivity analysis
```

---

## Real-World Examples

### Example 1: Roadmap Prioritization

```
Use extended thinking to prioritize our Q2 roadmap:

CONTEXT:
- Company OKR: Increase enterprise ARR 50%
- Current gaps: Security, scale, integrations
- Eng capacity: 3 engineers × 12 weeks = 36 eng-weeks
- Must ship: 2-3 enterprise-ready features

CANDIDATE FEATURES:
1. SSO/SAML (8 weeks, table stakes for enterprise)
2. Advanced permissions (6 weeks, requested by 70% of pipeline)
3. Salesforce integration (4 weeks, requested by 40% of pipeline)
4. Audit logs (3 weeks, compliance requirement)
5. API rate limiting (2 weeks, technical necessity)
6. Bulk operations (4 weeks, high user demand but not enterprise)
7. Custom branding (3 weeks, nice-to-have)
8. Advanced analytics (6 weeks, medium demand)

TRADE-OFFS:
- Can't do everything (only 36 weeks available)
- Enterprise vs. SMB features (different buyer priorities)
- Must-haves vs. nice-to-haves
- Quick wins vs. strategic bets

PROVIDE:
- Recommended roadmap (which features, in what order)
- Rationale for each decision
- What we're NOT building and why
- Risk mitigation for hard choices
- Alternative scenarios (if we had more/less capacity)
```

### Example 2: Strategic Decision

```
Use extended thinking to evaluate whether we should build vs. buy:

DECISION: Customer data platform (CDP)

BUILD OPTION:
- Cost: 2 engineers × 6 months = $200K
- Ongoing: 1 engineer maintenance = $50K/year
- Pros: Custom to our needs, IP ownership, competitive advantage
- Cons: 6-month delay, technical risk, maintenance burden

BUY OPTION:
- Cost: Segment at $50K/year
- Ongoing: Same $50K/year
- Pros: Immediate, proven, no maintenance
- Cons: Vendor lock-in, less customization, ongoing cost

CONTEXT:
- CDP is core to our product roadmap
- 5-year planning horizon
- Team has eng capacity
- $2M in funding, need to be capital-efficient

EVALUATE:
- Financial (NPV over 5 years)
- Strategic (competitive advantage)
- Risk (technical, execution, vendor)
- Time (opportunity cost of 6-month delay)
- Flexibility (future optionality)

RECOMMEND: Build, buy, or hybrid approach with full reasoning
```

### Example 3: Root Cause Analysis

```
Use extended thinking for root cause analysis:

PROBLEM: Activation rate dropped from 65% to 52% over 6 weeks

DATA:
- Timeline: Steady until Week 1, then gradual decline
- Segments: Drop consistent across all user types
- Platforms: Web down 15%, Mobile down 10%
- Geography: US down 20%, International down 8%
- Product changes: 3 releases during period (details: [link])
- External: 2 competitors launched new features
- Support: Complaints up 30%, mostly "confusing interface"

CONTEXT:
- Recent redesign (Week 0) to "modernize" look
- Added 2 new signup steps for better segmentation
- Changed onboarding flow structure
- Updated copy throughout

ANALYZE:
- What's the most likely cause?
- Are there multiple contributing factors?
- What evidence supports/contradicts each hypothesis?
- What would you test to confirm?

RECOMMEND:
- Immediate actions (this week)
- Validation experiments
- Long-term fixes
```

---

## Advanced Techniques

### Technique 1: Chain of Thought Prompting

```
Think through this step-by-step:

1. First, analyze the problem from first principles
2. Then, identify all constraints and requirements
3. Next, brainstorm 5-7 possible solutions
4. Evaluate each against criteria
5. Eliminate poor options and explain why
6. Compare remaining options in detail
7. Make final recommendation with confidence level
8. Provide implementation roadmap
```

### Technique 2: Perspective Taking

```
Analyze this decision from multiple perspectives:

1. Engineering perspective:
   - Technical feasibility
   - Complexity and risk
   - Maintenance burden

2. Business perspective:
   - Revenue impact
   - Market positioning
   - Customer value

3. User perspective:
   - Solves real problem?
   - Easy to use?
   - Delightful?

4. Competitive perspective:
   - Table stakes or differentiator?
   - Response to competitors?
   - Future-proofing?

Then synthesize: What's the balanced view?
```

### Technique 3: Red Team / Blue Team

```
Play devil's advocate on this proposal:

BLUE TEAM (Advocate):
Make the strongest case FOR this approach:
- Why it's the right move
- Expected benefits
- Why alternatives are worse

RED TEAM (Critic):
Make the strongest case AGAINST:
- What could go wrong
- Hidden costs
- Why alternatives might be better

SYNTHESIS:
- Which arguments are most compelling?
- What's the balanced assessment?
- Recommendation with caveats
```

---

## Measuring Plan Mode Effectiveness

**Quality Indicators:**

✅ **Good plan mode output:**

- Shows reasoning process
- Considers multiple options
- Weighs trade-offs explicitly
- Provides clear recommendation
- Includes implementation steps
- Anticipates objections

❌ **Poor plan mode output:**

- Jumps to conclusion
- Ignores alternatives
- Doesn't explain reasoning
- Vague recommendations
- No consideration of downsides

**When to retry:**

- Output seems rushed
- Missing analysis depth
- Didn't consider alternatives
- Recommendation unclear

Try: Add more context, ask for more explicit reasoning steps.

---

## Common Pitfalls

**Pitfall 1: Not enough context**
Plan mode needs data to reason about.

Fix: Provide comprehensive context upfront.

**Pitfall 2: Too broad a question**
"Help me with strategy" → too vague

Fix: Be specific about the decision and constraints.

**Pitfall 3: Not reviewing the reasoning**
You get a recommendation but don't check the logic.

Fix: Always review the thinking process, not just the conclusion.

**Pitfall 4: Using for simple tasks**
Wasting time on problems that don't need deep thought.

Fix: Reserve for truly complex decisions.

---

## Plan Mode Templates

### Template: Strategic Decision

```
Use extended thinking to evaluate: [DECISION]

OPTIONS:
A. [Option A description]
B. [Option B description]
C. [Option C description]

EVALUATION CRITERIA:
1. [Criterion 1] (weight: X%)
2. [Criterion 2] (weight: Y%)
3. [Criterion 3] (weight: Z%)

CONSTRAINTS:
- [Constraint 1]
- [Constraint 2]

CONTEXT:
- [Relevant background]
- [Success criteria]
- [Stakeholders]

PROVIDE:
- Scoring matrix
- Detailed analysis of each option
- Recommendation with confidence level
- Implementation considerations
- Risk mitigation
```

### Template: Problem Diagnosis

```
Use extended thinking to diagnose: [PROBLEM]

SYMPTOMS:
- [Symptom 1]
- [Symptom 2]
- [Symptom 3]

DATA:
- [Relevant metrics]
- [Timelines]
- [Correlations]

CONTEXT:
- [What changed recently]
- [System architecture]
- [User behavior]

ANALYZE:
- Generate 5+ hypotheses
- Evaluate each with evidence
- Identify most likely root cause
- Propose validation experiments
- Recommend fixes
```

---

## Next Steps

1. Identify one complex decision you're facing
2. Use plan mode to analyze it
3. Compare to your own analysis
4. Refine your prompting based on quality
5. Build templates for recurring complex decisions

---

**Best for:** Strategic decisions, complex analysis, creative problem-solving  
**Time:** 2-5 min thinking time (worth it for big decisions)  
**ROI:** Better decisions on high-stakes problems 🧠
