#!/bin/bash
# PM Operating System (PM-OS) - Setup Script
# Run this once to set up everything: GSD, Agent Teams, directory structure, and skills.
#
# Usage:
#   bash _system/setup/install.sh                    # Full setup
#   bash _system/setup/install.sh --skip-gsd         # Skip GSD installation
#   bash _system/setup/install.sh --dry-run          # Preview without writing anything

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PMOS_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Parse flags
SKIP_GSD=false
DRY_RUN=false

while [[ "${1:-}" == --* ]]; do
  case "$1" in
    --skip-gsd) SKIP_GSD=true; shift ;;
    --dry-run) DRY_RUN=true; shift ;;
    *) echo "Unknown flag: $1"; exit 1 ;;
  esac
done

echo ""
echo "============================================"
echo "  PM Operating System - Setup"
echo "============================================"
echo ""

if $DRY_RUN; then
  echo "[DRY RUN] No files will be written."
  echo ""
fi

# ============================================================
# STEP 1: Prerequisites
# ============================================================
echo "Step 1: Checking prerequisites..."
echo "-------------------------------------------"

# Check Node.js (needed for GSD)
if ! command -v node &> /dev/null; then
    echo "  Node.js: NOT FOUND"
    if ! $SKIP_GSD; then
        echo "  ERROR: Node.js is required for GSD installation."
        echo "  Install from https://nodejs.org/ or run with --skip-gsd"
        exit 1
    fi
else
    echo "  Node.js: $(node --version)"
fi

# Check npx
if command -v npx &> /dev/null; then
    echo "  npx: available"
else
    echo "  npx: NOT FOUND"
fi

# Check Claude Code
if command -v claude &> /dev/null; then
    CLAUDE_VERSION=$(claude --version 2>/dev/null | head -1 || echo "unknown")
    echo "  Claude Code: $CLAUDE_VERSION"
else
    echo "  Claude Code: NOT FOUND"
    echo "  Install with: curl -fsSL https://claude.ai/install.sh | bash"
fi

echo ""

# ============================================================
# STEP 2: Install GSD (get-shit-done)
# ============================================================
if ! $SKIP_GSD; then
  echo "Step 2: Installing GSD (get-shit-done)..."
  echo "-------------------------------------------"

  if $DRY_RUN; then
    echo "  [DRY RUN] Would run: npx get-shit-done-cc@latest --claude --local"
  else
    npx get-shit-done-cc@latest --claude --local
    echo ""
    echo "  GSD installed successfully."
  fi

  echo ""
fi

# ============================================================
# STEP 3: Verify PM-OS directory structure
# ============================================================
echo "Step 3: Verifying PM-OS directory structure..."
echo "-------------------------------------------"

DIRS=(
    ".claude/skills"
    ".claude/agents"
    ".claude/commands/team"
    "knowledge/company/design-system"
    "knowledge/company/hipaa"
    "knowledge/writing-styles"
    "knowledge/strategy/frameworks"
    "knowledge/strategy/allcare"
    "knowledge/research"
    "knowledge/decisions"
    "knowledge/launches"
    "knowledge/meetings"
    "knowledge/metrics"
    "knowledge/example-prds"
    "projects"
    "work/analyses"
    "work/decisions"
    "work/meeting-notes"
    "work/research"
    "work/roadmaps"
    "work/status-updates"
    "work/slack-messages"
    "work/presentations"
    "work/guides"
    "work/handoffs"
    "work/plans"
    "work/journey-maps"
    "work/mcp-integration-logs"
    "work/weekly-plans"
    "work/weekly-reviews"
    "prototypes"
    "templates"
    "_system/sub-agents"
    "_system/setup"
    "_system/guides"
)

CREATED_COUNT=0
for DIR in "${DIRS[@]}"; do
    if [ ! -d "$PMOS_DIR/$DIR" ]; then
        if $DRY_RUN; then
          echo "  [DRY RUN] Would create: $DIR"
        else
          mkdir -p "$PMOS_DIR/$DIR"
          echo "  CREATED: $DIR"
        fi
        CREATED_COUNT=$((CREATED_COUNT + 1))
    fi
done

if [ "$CREATED_COUNT" -eq 0 ]; then
    echo "  All directories verified."
fi

# Check critical files
echo ""
echo "  Checking critical files..."
CRITICAL_FILES=(
    "CLAUDE.md"
    "README.md"
    "LICENSE.md"
)

for FILE in "${CRITICAL_FILES[@]}"; do
    if [ -f "$PMOS_DIR/$FILE" ]; then
        echo "    [OK] $FILE"
    else
        echo "    [MISSING] $FILE"
    fi
done

# Count installed components
SKILL_COUNT=$(find "$PMOS_DIR/.claude/skills" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
AGENT_COUNT=$(find "$PMOS_DIR/.claude/agents" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
COMMAND_COUNT=$(find "$PMOS_DIR/.claude/commands/team" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
TEMPLATE_COUNT=$(find "$PMOS_DIR/templates" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
SUBAGENT_COUNT=$(find "$PMOS_DIR/_system/sub-agents" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

echo ""
echo "  PM Skills:        $SKILL_COUNT"
echo "  Team Agents:      $AGENT_COUNT"
echo "  Team Commands:    $COMMAND_COUNT"
echo "  Templates:        $TEMPLATE_COUNT"
echo "  Sub-agents:       $SUBAGENT_COUNT"

echo ""

# ============================================================
# STEP 4: Enable Agent Teams
# ============================================================
echo "Step 4: Configuring Agent Teams..."
echo "-------------------------------------------"

SETTINGS_FILE="$PMOS_DIR/.claude/settings.local.json"

if [ -f "$SETTINGS_FILE" ]; then
    if grep -q "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS" "$SETTINGS_FILE" 2>/dev/null; then
        echo "  [OK] Agent Teams already enabled in settings"
    else
        echo "  [INFO] Agent Teams env var not found in settings"
        echo "  Add manually to .claude/settings.local.json:"
        echo '  "env": { "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1" }'
    fi
else
    echo "  [INFO] No settings.local.json found"
    echo "  Agent Teams will use global settings if configured"
fi

echo ""

# ============================================================
# STEP 5: Verify Agent and Command files
# ============================================================
echo "Step 5: Verifying team agent and command files..."
echo "-------------------------------------------"

AGENT_FILES=(
    ".claude/agents/team-executor.md"
    ".claude/agents/team-planner.md"
    ".claude/agents/team-researcher.md"
    ".claude/agents/team-verifier.md"
    ".claude/agents/team-mapper.md"
)

for FILE in "${AGENT_FILES[@]}"; do
    if [ -f "$PMOS_DIR/$FILE" ]; then
        echo "    [OK] $FILE"
    else
        echo "    [MISSING] $FILE"
    fi
done

COMMAND_FILES=(
    ".claude/commands/team/execute-phase.md"
    ".claude/commands/team/plan-phase.md"
    ".claude/commands/team/new-project.md"
    ".claude/commands/team/map-codebase.md"
    ".claude/commands/team/verify-phase.md"
    ".claude/commands/team/help.md"
)

for FILE in "${COMMAND_FILES[@]}"; do
    if [ -f "$PMOS_DIR/$FILE" ]; then
        echo "    [OK] $FILE"
    else
        echo "    [MISSING] $FILE"
    fi
done

echo ""

# ============================================================
# SUMMARY
# ============================================================
echo "============================================"
echo "  Setup Complete!"
echo "============================================"
echo ""

if $DRY_RUN; then
  echo "[DRY RUN] No changes were made. Run without --dry-run to apply."
  echo ""
fi

echo "What's installed:"
echo ""
echo "  1. 41 PM Skills           Strategy, PRDs, metrics, meetings, and more"
echo "  2. GSD Framework          AI-driven project planning and execution"
echo "  3. Agent Teams            Multi-agent coordination with /team:* commands"
echo "  4. 5 Team Agents          Executor, planner, researcher, verifier, mapper"
echo "  5. 7 Sub-agent Reviewers  Multi-perspective PRD/doc reviews"
echo "  6. 8 Templates            PRD, OKR, roadmap, launch checklist, etc."
echo ""
echo "---"
echo ""
echo "Quick Start:"
echo ""
echo "  PM Skills:"
echo "    /prd-draft              Draft a PRD with guided questions"
echo "    /daily-plan             Get your prioritized daily plan"
echo "    /meeting-notes          Process a meeting transcript"
echo "    /status-update          Generate stakeholder updates"
echo ""
echo "  GSD (AI Execution):"
echo "    /gsd:new-project        Initialize a new project"
echo "    /gsd:plan-phase 1       Plan phase 1"
echo "    /gsd:execute-phase 1    Execute phase 1"
echo "    /gsd:progress           Check project status"
echo ""
echo "  Agent Teams (Experimental):"
echo "    /team:new-project       Initialize with parallel research"
echo "    /team:plan-phase 1      Plan with researcher + planner + checker"
echo "    /team:execute-phase 1   Execute with dependency-aware parallelism"
echo "    /team:help              Show all team commands"
echo ""
