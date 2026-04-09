# Environment Keys Setup

Configure API keys for the tools you'll use with your PM Operating System.

## Why You Need This

The PM OS can integrate with various services to supercharge your workflow:

- **OpenAI** - For testing prompts across GPT models
- **Google Gemini** - Alternative LLM for comparison
- **MCP Servers** - Connect to Slack, Google Drive, Reddit, etc.

You don't need all of these. Set up what you'll actually use.

---

## Required: Anthropic API Key

**You need this for Claude Code to work.**

### Get Your Key

1. Visit: https://console.anthropic.com
2. Sign up or log in
3. Navigate to "API Keys"
4. Create a new key
5. Copy it (you won't see it again!)

### Set It Up

**MacOS/Linux:**

```bash
export ANTHROPIC_API_KEY='sk-ant-api03-...'

# Make it permanent
echo 'export ANTHROPIC_API_KEY="sk-ant-api03-..."' >> ~/.zshrc  # or ~/.bashrc
source ~/.zshrc
```

**Windows (PowerShell):**

```powershell
$env:ANTHROPIC_API_KEY='sk-ant-api03-...'

# Make it permanent
[Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', 'sk-ant-api03-...', 'User')
```

### Verify

```bash
echo $ANTHROPIC_API_KEY
```

Should print your key.

---

## Optional: OpenAI API Key

**Use case:** Test your prompts across GPT-4, compare outputs, use GPT for specific tasks.

### Get Your Key

1. Visit: https://platform.openai.com
2. Sign up or log in
3. Go to "API Keys"
4. Create new secret key
5. Copy it

### Set It Up

```bash
export OPENAI_API_KEY='sk-proj-...'

# Make it permanent
echo 'export OPENAI_API_KEY="sk-proj-..."' >> ~/.zshrc
source ~/.zshrc
```

### Test It

```bash
curl https://api.openai.com/v1/models \
  -H "Authorization: Bearer $OPENAI_API_KEY"
```

Should list available models.

---

## Optional: Google Gemini API Key

**Use case:** Another perspective for testing prompts, free tier is generous.

### Get Your Key

1. Visit: https://makersuite.google.com/app/apikey
2. Sign in with Google account
3. Create API key
4. Copy it

### Set It Up

```bash
export GOOGLE_API_KEY='AIza...'

# Make it permanent
echo 'export GOOGLE_API_KEY="AIza..."' >> ~/.zshrc
source ~/.zshrc
```

---

## Optional: MCP Server Keys

MCPs (Model Context Protocols) let Claude access external tools. Use the `/connect-mcps` skill in Claude Code for guided setup.

### Common MCP Integrations

**Slack:**

- Get OAuth token from your Slack workspace settings
- Needed for: Reading channels, searching messages, posting updates

**Google Drive:**

- OAuth credentials from Google Cloud Console
- Needed for: Accessing docs, sheets, presentations

**Jira:**

- API token from Atlassian account settings
- Needed for: Reading tickets, updating status, creating issues

**Reddit:**

- Client ID and secret from Reddit app settings
- Needed for: Research, competitive intelligence, user sentiment

**GitHub:**

- Personal access token from GitHub settings
- Needed for: Code reviews, issue tracking, documentation

### Store MCP Keys Securely

Create a `.env` file in your pm-operating-system folder:

```bash
# .env (DO NOT COMMIT TO GIT!)
SLACK_TOKEN=xoxb-...
GOOGLE_DRIVE_CLIENT_ID=...
GOOGLE_DRIVE_CLIENT_SECRET=...
JIRA_TOKEN=...
REDDIT_CLIENT_ID=...
REDDIT_CLIENT_SECRET=...
GITHUB_TOKEN=ghp_...
```

Add to `.gitignore`:

```bash
echo ".env" >> .gitignore
```

Load them when needed:

```bash
source .env
```

---

## Key Management Best Practices

### Security Rules

1. **Never commit keys to Git** - Use .env files and .gitignore
2. **Don't share keys** - Even with teammates (they should get their own)
3. **Rotate regularly** - Especially if you suspect exposure
4. **Use environment variables** - Not hardcoded in files
5. **Minimum permissions** - Give keys only the access they need

### Organization Tips

Create a **keys-template.txt** file (NOT committed):

```
# API Keys for PM OS
# Last updated: [date]

ANTHROPIC_API_KEY=sk-ant-api03-...
OPENAI_API_KEY=sk-proj-...
GOOGLE_API_KEY=AIza...

# MCP Servers
SLACK_TOKEN=xoxb-...
GOOGLE_DRIVE_CLIENT_ID=...
JIRA_TOKEN=...

# Notes
# - Anthropic key: Personal account, updated Jan 2025
# - OpenAI key: Company account, shared billing
# - Slack token: Personal workspace, read-only
```

Store this file in a password manager like 1Password, LastPass, or Bitwarden.

---

## Rate Limits & Costs

### Anthropic

- **Claude Pro** ($20/mo) or **Claude Max** ($100-200/mo) - Recommended for PM OS usage
- **Pay-as-you-go API**: Usage-based pricing (check console.anthropic.com/settings/billing for current rates)
- Check: console.anthropic.com/settings/billing

### OpenAI

- Usage-based pricing varies by model
- Check: platform.openai.com/usage

### Google Gemini

- Generous free tier
- Good for testing without burning credits
- Check: makersuite.google.com/app/billing

### Tips to Reduce Costs

1. Use a Claude subscription (Pro or Max) for predictable costs
2. Be specific in prompts to avoid long responses
3. Test prompts on Gemini first (free)
4. Cache common context in CLAUDE.md to avoid re-sending

---

## Testing Your Setup

Run this command to verify all keys:

```bash
# Test Anthropic
echo "Testing Anthropic..."
claude "Say hello"

# Test OpenAI (if set up)
if [ ! -z "$OPENAI_API_KEY" ]; then
    echo "Testing OpenAI..."
    curl https://api.openai.com/v1/models \
      -H "Authorization: Bearer $OPENAI_API_KEY" \
      --silent | grep -q "gpt-4" && echo "✓ OpenAI working" || echo "✗ OpenAI failed"
fi

# Test Google (if set up)
if [ ! -z "$GOOGLE_API_KEY" ]; then
    echo "Testing Google..."
    echo "✓ Google key set (manual test required)"
fi

echo "Environment check complete!"
```

Save as `test-keys.sh`, make executable, and run:

```bash
chmod +x test-keys.sh
./test-keys.sh
```

---

## Troubleshooting

### Keys Not Persisting

**Problem:** Keys work in current session but disappear after closing terminal

**Fix:** Make sure you added to shell config file

```bash
# Check which shell you're using
echo $SHELL

# If /bin/zsh, edit ~/.zshrc
# If /bin/bash, edit ~/.bashrc

nano ~/.zshrc  # or ~/.bashrc

# Add your export commands
# Save and reload
source ~/.zshrc
```

### Wrong Permissions

**Problem:** "Invalid API key" errors

**Fix:**

1. Check key format (should start with expected prefix)
2. Verify no extra spaces: `echo "$ANTHROPIC_API_KEY" | wc -c`
3. Regenerate key if needed

### Rate Limit Errors

**Problem:** "Rate limit exceeded" messages

**Fix:**

1. Wait a minute and try again
2. Check your usage dashboard
3. Upgrade tier if needed
4. Reduce frequency of calls

---

## Quick Reference

| Service       | Get Key From               | Environment Variable | Prefix        |
| ------------- | -------------------------- | -------------------- | ------------- |
| Anthropic     | console.anthropic.com      | ANTHROPIC_API_KEY    | sk-ant-api03- |
| OpenAI        | platform.openai.com        | OPENAI_API_KEY       | sk-proj-      |
| Google Gemini | makersuite.google.com      | GOOGLE_API_KEY       | AIza          |
| Slack         | api.slack.com              | SLACK_TOKEN          | xoxb-         |
| GitHub        | github.com/settings/tokens | GITHUB_TOKEN         | ghp\_         |

---

## Next Steps

1. ✅ Keys are set up
2. ✅ Next: Run through first session checklist → `first-session-checklist.md`
3. 📝 Then: Fill out your context library → `knowledge/`

---

**Time Investment:** 10-20 minutes (depending on services)  
**Skill Level:** Basic terminal usage  
**Security:** Keep keys private, rotate regularly
