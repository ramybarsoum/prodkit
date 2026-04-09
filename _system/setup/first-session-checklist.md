# First Session Checklist

Verify your PM Operating System is working perfectly.

## Overview

This checklist walks you through testing every major component of your PM OS. By the end, you'll have:

- ✅ Verified Claude Code works
- ✅ Uploaded your existing work documents
- ✅ Customized your context
- ✅ Tested skills (slash commands)
- ✅ Created your first output
- ✅ Run a complete workflow

**Time needed:** 30-40 minutes

---

## Pre-Flight Check

Before starting, verify:

```bash
# 1. You're in the right directory
pwd
# Should show: /path/to/pm-operating-system

# 2. Claude is installed
claude --version
# Should show version number

# 3. API key is set
echo $ANTHROPIC_API_KEY
# Should show: sk-ant-api03-...

# 4. Core files exist
ls CLAUDE.md README.md
# Should list both files without errors
```

All good? Let's go.

---

## Setup Step 1: Upload Your Existing Work Documents

**What we're doing:** Importing your existing context into PM OS

Before testing features, let's get your real work documents into the system:

```bash
claude "I have existing work documents to upload. Can you help me organize them?

I have:
- [List your documents: PRDs, strategy docs, research, OKRs, etc.]

Please read each one and organize them into the appropriate folders in knowledge/:
- PRDs/specs/one-pagers → knowledge/prds/
- Roadmaps/OKRs/strategy docs → knowledge/strategy/
- User research/competitive analysis → knowledge/research/
- Decision logs/trade-off docs → knowledge/decisions/
- Launch plans/release notes → knowledge/launches/
- Analytics reports/A/B tests → knowledge/metrics/
- Meeting notes/retros → knowledge/meetings/
- Other docs → knowledge/other/
"
```

**Then upload your documents** (drag and drop or paste content)

**Expected result:**

- Claude reads each document
- Organizes them into appropriate folders
- Confirms where each file was placed

**Most helpful to upload:**

- Current quarter strategy/roadmap
- Active PRDs you're working on
- Key stakeholder information
- Recent user research
- Competitive analysis
- Important decision logs
- Recent launch plans
- Key metrics/analytics reports
- Critical meeting notes

**General rule:** Upload any document that helps Claude understand your product/company context

✅ **Mark complete when:** Your work documents are organized in knowledge/

---

## Setup Step 2: Fill Out Context Templates

**What we're doing:** Customizing PM OS for your company

```bash
# First, let's see what context files exist
ls knowledge/

# Now customize one
claude "Help me fill out the business-info-template.md file. My company is called [YourCompany], we make [product description]. Our main competitor is [competitor]. We have [user count] users and are [stage], growing [growth rate]."
```

**Expected result:**

- Claude helps you fill out the template
- Creates or updates the file
- Asks clarifying questions if needed

**Manual option:**
Open `knowledge/business-info-template.md` in your editor and fill it out yourself.

**Also fill out:**

- Stakeholder profiles (`stakeholder-template.md`)
- Writing style preferences (`writing-style-*.md`)
- Personal context (`personal-context-*.md`)

✅ **Mark complete when:** Key context files are filled out

---

## Test 1: Basic Claude Interaction

**What we're testing:** Claude Code can read files and respond

```bash
claude "Read CLAUDE.md and summarize what this PM Operating System does in 2 sentences"
```

**Expected result:**

- Claude reads the file
- Provides a 2-sentence summary
- No errors

**If it fails:**

- Check you're in the pm-operating-system directory
- Verify CLAUDE.md exists: `ls -la CLAUDE.md`
- Try with absolute path: `claude "Read /full/path/to/CLAUDE.md"`

✅ **Mark complete when:** Claude successfully reads and summarizes

---

## Test 2: Skills - Meeting Notes

**What we're testing:** Structured skills/commands work

```bash
claude "/meeting-notes

'Had a sync with Sarah from Design and Mike from Engineering. Sarah showed mockups for the new dashboard—looks great but we need to validate load times. Mike mentioned the API refactor is almost done, should ship next Tuesday. Action items: I'll schedule usability testing for the dashboard, Sarah will send final Figma files by EOD, Mike will update us in Slack when API is live. Follow-up meeting scheduled for next Friday at 2pm.'
"
```

**Expected result:**

- Claude processes the meeting transcript
- Formats the transcript into structured notes
- Extracts action items with owners
- Notes the follow-up meeting

**If it fails:**

- Try the command again with a simpler transcript
- Check that slash commands are working: type `/` to see autocomplete

✅ **Mark complete when:** You get formatted meeting notes back

---

## Test 3: Skills - PRD Draft

**What we're testing:** Complex skills with examples work

```bash
claude "/prd-draft

Create a PRD for: A feature that lets users set custom notification sounds for different types of alerts in our project management app. Users have complained that all notifications sound the same and they miss important updates."
```

**Expected result:**

- Claude uses the PRD slash command
- Generates a structured PRD
- Includes problem, solution, success metrics
- Follows modern PRD format (not old-school MRD style)

**If it fails:**

- Try a simpler feature description
- Check that slash commands are working: type `/` to see autocomplete

✅ **Mark complete when:** You get a complete PRD document

---

## Test 4: Creating Files

**What we're testing:** Claude can write files to disk

```bash
claude "Create a one-pager called 'mobile-offline-mode.md' for a feature that lets users work offline in our mobile app and sync when back online. Save it to the current directory."
```

**Expected result:**

- Claude creates a new file
- File appears in your directory: `ls mobile-offline-mode.md`
- Can view it: `cat mobile-offline-mode.md`
- Contains structured content

**If it fails:**

- Check file permissions: `ls -la`
- Try specifying absolute path
- Make sure you have write access to the directory

✅ **Mark complete when:** You have a new .md file with content

---

## Test 5: Sub-Agent Review

**What we're testing:** Different perspectives work

```bash
claude "Read _system/sub-agents/engineer-reviewer.md

Now review this PRD from an engineering perspective: [paste the PRD you created in Test 3]"
```

**Expected result:**

- Claude adopts engineer perspective
- Points out technical concerns
- Flags complexity, dependencies, edge cases
- Provides constructive feedback

**Alternative test if file doesn't exist yet:**

```bash
claude "Review this PRD from an engineering perspective, focusing on technical feasibility, complexity, and potential issues: [paste PRD]"
```

✅ **Mark complete when:** You get technical feedback

---

## Test 6: User Research Synthesis

**What we're testing:** Analysis commands work

```bash
claude "/user-research-synthesis

Analyze these interview excerpts:

User 1: 'I love the app but the search is frustrating. I can never find old tasks.'
User 2: 'Search is my biggest pain point. Wish it was more like Google.'
User 3: 'The app is great! Though finding completed tasks from last month is hard.'
User 4: 'Everything works well except search. It's pretty basic.'
User 5: 'I end up scrolling through lists instead of using search because it's unreliable.'
"
```

**Expected result:**

- Claude identifies the pattern (search is the problem)
- Synthesizes across interviews
- Suggests solutions
- Quotes specific users

✅ **Mark complete when:** You get research insights

---

## Test 7: Context Personalization

**What we're testing:** You can customize the system

```bash
# First, let's see what context files exist
ls knowledge/

# Now customize one
claude "Help me fill out the business-info-template.md file. My company is called TaskFlow, we make a project management app for remote teams. Our main competitor is Asana. We have 50K users and are pre-product-market-fit, growing 20% month over month."
```

**Expected result:**

- Claude helps you fill out the template
- Creates or updates the file
- Asks clarifying questions if needed

**Manual option:**
Open `knowledge/business-info-template.md` in Cursor or any editor and fill it out yourself.

✅ **Mark complete when:** You have at least one context file filled out

---

## Test 8: Complete Workflow

**What we're testing:** End-to-end process works

```bash
claude "/prd-draft

Help me create a PRD for: Adding a dark mode to our app

Please:
1. Create initial PRD
2. Review it from an engineering perspective
3. Review it from a UX perspective
4. Create a final version incorporating both reviews
5. Save the final PRD as 'dark-mode-prd.md'
"
```

**Expected result:**

- Claude follows the workflow
- Creates initial PRD
- Gets both perspectives
- Refines the PRD
- Saves final version
- You have a polished document

✅ **Mark complete when:** You have a refined PRD file

---

## Test 9: Rapid Fire Skills

**What we're testing:** System handles multiple quick requests

Run these one after another:

```bash
# Slack message
claude "/slack-message - Write a Slack message updating the team that the API refactor shipped successfully"

# Status update
claude "/status-update - Generate a weekly update covering: shipped API refactor, started dark mode design, user research sessions scheduled"

# Competitor analysis
claude "/competitor-analysis - Analyze Notion's recent AI features"
```

**Expected result:**

- All three commands work
- Each output is contextually appropriate
- No rate limit errors
- Responses feel natural

✅ **Mark complete when:** All three commands succeed

---

## Test 10: Error Recovery

**What we're testing:** System handles problems gracefully

```bash
# Try to read a file that doesn't exist
claude "Read 99-fake-folder/fake-file.md"

# Should fail gracefully and explain what's wrong
```

**Expected result:**

- Claude tells you the file doesn't exist
- Suggests alternatives or next steps
- Doesn't crash or hang

✅ **Mark complete when:** Errors are handled well

---

## Verification Checklist

Go through this final checklist:

**Core Functionality:**

- [ ] Claude Code is installed and working
- [ ] Can read markdown files from the PM OS
- [ ] Can execute skills (slash commands)
- [ ] Can create new files
- [ ] Can provide different perspectives (sub-agents)

**Your Customization:**

- [ ] Uploaded existing work documents (PRDs, strategy, research)
- [ ] Documents organized in knowledge/ subfolders
- [ ] At least one context file is filled out (business-info or personal-context)
- [ ] You know where to add more context
- [ ] You understand the folder structure

**Practical Output:**

- [ ] Created at least one PRD
- [ ] Processed meeting notes
- [ ] Generated a status update or Slack message
- [ ] Ran a complete workflow

**You Feel Confident:**

- [ ] You can start a Claude session
- [ ] You know how to reference PM OS files
- [ ] You can create your own workflows
- [ ] You know where to find help

---

## Next Steps

### If Everything Passed ✅

**You're ready to use the PM OS for real work!**

Start with:

1. **Upload more documents** - Add more PRDs, research, strategy docs to `knowledge/`
2. **Fill out remaining context** - Complete stakeholder profiles, writing styles
3. **Try real tasks** - Use it for your next meeting, PRD, or update
4. **Customize skills** - Edit the skills in `.claude/skills/` to match your style
5. **Add tools** - Set up MCPs for Slack, Google Drive, etc. (run `/connect-mcps` in Claude Code)

### If Some Tests Failed ❌

**Don't worry, let's fix it:**

1. **Check installation** - Re-run `setup/installation-guide.md`
2. **Verify keys** - Double-check `setup/environment-keys.md`
3. **Test individually** - Isolate what's not working
4. **Try alternatives** - Some features are optional (MCPs, sub-agents)

Common fixes:

- Restart terminal
- Check file permissions
- Verify API key is set
- Ensure you're in the right directory

---

## Quick Start Commands

Save these for future reference:

```bash
# Start a PM session
cd pm-operating-system
claude "Read CLAUDE.md, ready for PM work"

# Process meeting notes
claude "/meeting-notes - Process: [your transcript]"

# Create a PRD
claude "/prd-draft - Create a PRD for: [your feature]"

# Get multiple perspectives
claude "Review this [document] from engineer, designer, and executive perspectives"

# Weekly update
claude "/status-update - Create my weekly update covering: [what you did]"
```

---

## Create Your Own Checklist

As you use the PM OS, create a personal checklist for your most common tasks:

**My Weekly PM Checklist:**

- [ ] Process all meeting notes from this week
- [ ] Update stakeholders on progress
- [ ] Review and respond to user feedback
- [ ] Competitive intelligence check
- [ ] Plan next week's priorities

Customize the PM OS to match your actual workflow!

---

## Need Help?

- **Documentation:** README.md and CLAUDE.md
- **Examples:** Check knowledge/example-prds/
- **Templates:** Browse templates/
- **Workflows:** See `.claude/skills/` for slash command workflows
- **Advanced:** Look at advanced/ for power features

---

## Congratulations!

You've successfully set up and tested your PM Operating System. You now have:

- ✅ An AI assistant that understands PM work
- ✅ Ready-to-use commands for common tasks
- ✅ Templates and examples to learn from
- ✅ Workflows to streamline your process

**Time to build great products!**

---

**Time Investment:** 30-40 minutes
**Skills Gained:** PM automation, AI-assisted workflows  
**Status:** Ready for production use 🚀
