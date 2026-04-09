# Installation Guide

Get your PM Operating System up and running in 15 minutes.

## What You'll Install

1. **Claude Code** - Your AI coding assistant in the terminal
2. **Cursor** - AI-powered code editor (optional but recommended)
3. **This Repository** - Your PM OS files

---

## Step 1: Install Claude Code

### Prerequisites

- MacOS, Linux, or Windows with WSL
- Terminal access
- Stable internet connection
- One of: **Claude Pro** ($20/mo), **Claude Max** ($100-200/mo), or an Anthropic API key (get one at console.anthropic.com)

### Installation

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

### Verify Installation

```bash
claude --version
```

You should see version information printed.

### Set Your API Key

```bash
export ANTHROPIC_API_KEY='your-api-key-here'
```

**Make it permanent** by adding to your shell config:

```bash
# For bash
echo 'export ANTHROPIC_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc

# For zsh
echo 'export ANTHROPIC_API_KEY="your-api-key-here"' >> ~/.zshrc
source ~/.zshrc
```

---

## Step 2: Download PM Operating System

1. Download the zip file from your purchase
2. Extract to a folder called `pm-operating-system`
3. Open terminal and navigate to that folder:

```bash
cd ~/Downloads/pm-operating-system
```

---

## Step 3: Install Cursor (Optional)

Cursor is a fork of VS Code with AI built in. Great for editing markdown files and code.

### Download

Visit: https://cursor.sh

### Why Cursor?

- Built-in AI chat (Cmd+K for inline edits, Cmd+L for chat)
- Great markdown preview
- Git integration
- File tree navigation
- Works seamlessly with Claude Code

### Alternative

You can use any text editor you prefer:

- VS Code
- Sublime Text
- Even TextEdit/Notepad works

---

## Step 4: First Test Run

Let's verify everything works:

### Test 1: Claude Code Basics

```bash
cd pm-operating-system
claude "Read CLAUDE.md and explain what this system does"
```

You should see Claude read the master context file and explain the PM OS.

### Test 2: Use a Slash Command

```bash
claude "Use /meeting-notes to process this transcript: 'Had a meeting with Sarah about the new dashboard. She wants faster load times and better mobile support. Action items: research competitors, prototype in Figma, schedule follow-up.'"
```

Claude should format this into structured meeting notes with action items.

### Test 3: Create a File

```bash
claude "Create a one-pager for a feature that adds voice notes to our task manager"
```

Claude should generate a one-pager document.

---

## Step 5: Customize Your Setup

### How Claude Code Uses Your Context

Claude Code automatically reads `CLAUDE.md` when you launch it in the PM OS directory -- no need to tell it manually. Just start Claude Code in the project folder and it will understand the full system.

### Create a Shortcut (Optional)

Add this to your `.bashrc` or `.zshrc`:

```bash
alias pm="cd ~/path/to/pm-operating-system && claude"
```

Now you can just type `pm` to start a PM session!

---

## Common Issues

### Installation timeout or network errors

- **Issue:** Connection timeout when downloading Claude Code
- **Fix:** Ensure you have a stable internet connection and retry
- **Check:** Your firewall/VPN isn't blocking access to Google Cloud Storage
- If problems persist, try from a different network

### "claude: command not found"

- Restart your terminal
- Check installation with: `which claude`
- If using npm install, make sure your npm global bin directory is in your PATH
- Re-run the installation command

### "API key not set"

- Run: `echo $ANTHROPIC_API_KEY`
- If empty, set it: `export ANTHROPIC_API_KEY='your-key'`
- Add to shell config for persistence

### Claude doesn't read files

- Check you're in the pm-operating-system directory: `pwd`
- Try absolute paths: `claude "Read /full/path/to/CLAUDE.md"`

### Rate limits

- Anthropic API has rate limits
- Wait a minute and try again
- Consider upgrading your API tier at console.anthropic.com

---

## File Structure Reminder

```
pm-operating-system/
├── CLAUDE.md                 ← Master context (read this first!)
├── .claude/skills/           ← 41 slash command skills
├── setup/                    ← You are here
├── knowledge/          ← Fill these out for your situation
├── _system/sub-agents/               ← Different reviewer perspectives
├── templates/                ← Document templates
├── work/                  ← Active work outputs
└── advanced/                 ← Power user features
```

---

## Next Steps

1. ✅ You've installed everything
2. 📝 Next: Set up your environment keys → `environment-keys.md`
3. ✅ Then: Run through the first session checklist → `first-session-checklist.md`

---

## Need Help?

**Documentation Issues:** Check the README.md in the root folder

**Claude Code Issues:** Visit docs.anthropic.com/claude/docs/claude-code

**Feature Requests:** This is your system—customize it! Add your own slash commands, sub-agents, and workflows.

---

**Time Investment:** 15 minutes  
**Skill Level:** No coding required  
**Support:** Community-maintained, modify as needed
