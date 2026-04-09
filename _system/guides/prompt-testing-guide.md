# Prompt Testing Guide

A reference guide for testing AI prompts across multiple LLMs.

> **Note:** This is a reference guide, not an interactive skill. Use these techniques manually when optimizing prompts for production.

---

## Overview

**Time:** 20-30 minutes per test
**Tools:** Claude, ChatGPT, Gemini APIs
**When:** Before rolling out new prompts to production

---

## Current Models (January 2026)

### Model Recommendations

| Provider      | Model               | Best For                         | Cost (per 1M input)    |
| ------------- | ------------------- | -------------------------------- | ---------------------- |
| **Anthropic** | Claude Opus 4.5     | Complex reasoning, nuanced tasks | ~$15                   |
| **Anthropic** | Claude Sonnet 4     | Writing, analysis, instructions  | ~$3                    |
| **OpenAI**    | GPT-5.2 (default)   | General purpose, fast            | Check current pricing  |
| **OpenAI**    | GPT-5-mini          | Cost-effective simple tasks      | Check current pricing  |
| **OpenAI**    | GPT-5.2-codex       | Agentic coding tasks             | Check current pricing  |
| **Google**    | Gemini 3 Pro        | Advanced math, coding            | Check current pricing  |
| **Google**    | Gemini 3 Flash      | Fast, cost-effective             | Free tier, then ~$0.10 |
| **Google**    | Gemini 3 Deep Think | Complex problems, creativity     | Premium tier           |

### Model Selection Guide

- **Complex reasoning/analysis:** Claude Opus 4.5 or GPT-5.2
- **Writing & instructions:** Claude Sonnet 4
- **Fast structured outputs:** GPT-5.2 or Gemini 3 Flash
- **Cost-sensitive tasks:** Gemini 3 Flash or GPT-5-mini
- **Coding tasks:** GPT-5.2-codex or Gemini 3 Pro

---

## Quick Test Process

### Step 1: Define Test Cases (5 min)

Create 3-5 representative examples:

```markdown
Test Case 1: Simple email draft
Input: "Draft response to pricing inquiry from enterprise customer"
Expected: Professional, includes pricing tiers, CTA to schedule call

Test Case 2: Complex PRD
Input: "Create PRD for dark mode feature"
Expected: Complete structure, technical considerations, success metrics

Test Case 3: Data analysis
Input: "Analyze these user feedback themes"
Expected: Grouped themes, frequency, insights, recommendations
```

### Step 2: Run Tests (10 min)

**Manually:**

- Open Claude.ai
- Open ChatGPT
- Open Gemini
- Run same prompt in each
- Compare outputs

**Via API (faster):**

```python
import anthropic
import openai
import google.generativeai as genai

def test_prompt(prompt, test_case):
    # Claude Opus 4.5
    claude = anthropic.Client()
    claude_response = claude.messages.create(
        model="claude-opus-4-5-20251101",
        max_tokens=1000,
        messages=[{"role": "user", "content": f"{prompt}\n\n{test_case}"}]
    )

    # GPT-5.2
    openai_response = openai.ChatCompletion.create(
        model="gpt-5.2",
        messages=[{"role": "user", "content": f"{prompt}\n\n{test_case}"}]
    )

    # Gemini 3 Pro
    genai.configure(api_key=GEMINI_KEY)
    gemini = genai.GenerativeModel('gemini-3-pro')
    gemini_response = gemini.generate_content(f"{prompt}\n\n{test_case}")

    return {
        "claude": claude_response.content[0].text,
        "gpt5": openai_response.choices[0].message.content,
        "gemini": gemini_response.text
    }
```

### Step 3: Evaluate Results (10 min)

**Scoring criteria:**

- Accuracy (did it solve the problem?)
- Format (is output structured correctly?)
- Completeness (all required elements?)
- Quality (is it production-ready?)
- Cost (tokens used)

**Score each 1-5:**

| Test Case     | Claude | GPT-5.2 | Gemini 3 | Winner  |
| ------------- | ------ | ------- | -------- | ------- |
| Email draft   | 5      | 4       | 4        | Claude  |
| Complex PRD   | 5      | 5       | 4        | Tie     |
| Data analysis | 4      | 5       | 4        | GPT-5.2 |

### Step 4: Pick Winner & Document (5 min)

```markdown
## Prompt Testing Results - [Date]

**Prompt tested:** [Prompt name/description]

**Winner:** [Model name]

**Rationale:**

- [Reason 1]
- [Reason 2]
- [Reason 3]

**Cost comparison:**

- Claude Opus 4.5: ~$0.015 per use
- GPT-5.2: ~$X per use
- Gemini 3 Pro: ~$X per use
- Decision: [Which model and why]

**Deployment:**

- Use [Model] for this use case
- Monitor for 30 days
- Re-evaluate if costs spike
```

---

## Automated Testing

### Using Make.com or n8n

**Build workflow:**

1. Trigger: New test prompt added to Airtable
2. Run prompt through all 3 models
3. Log responses
4. Score automatically (using Claude meta-evaluation)
5. Update Airtable with results

**Setup once, test anytime.**

---

## Advanced: Evaluation Framework

For critical prompts, use LLM-as-judge:

```bash
claude "Evaluate these 3 responses to the same prompt:

Prompt: [original prompt]

Response A (Claude Opus 4.5): [output]
Response B (GPT-5.2): [output]
Response C (Gemini 3 Pro): [output]

Score each 1-10 on:
1. Accuracy (correctly addresses prompt)
2. Completeness (includes all required elements)
3. Quality (production-ready)
4. Format (properly structured)
5. Usability (easy to use/understand)

Provide:
- Scores table
- Best response
- Specific improvements for each"
```

---

## Cost Optimization

**Testing budget:**

- Set aside $50/month for prompt testing
- Track costs per test
- ROI: Better prompts = better outputs = less rework

**Optimization tactics:**

- Use cheaper models for simple tasks (Gemini 3 Flash, GPT-5-mini)
- Reserve expensive models for complex work (Claude Opus 4.5)
- Cache common prompts
- Batch API calls

---

**Time saved:** Prevents hours of debugging bad prompts
**Cost savings:** 30-50% by using right model for each task
**Quality gain:** 2x better outputs with optimized prompts
