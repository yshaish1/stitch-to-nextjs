#!/bin/bash
# stitch-to-nextjs installer
# Installs the plugin, configures MCP server, and adds marketplace - all automatically.

set -e

CLAUDE_DIR="$HOME/.claude"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
COMMANDS_DIR="$CLAUDE_DIR/commands"
SKILL_URL="https://raw.githubusercontent.com/yshaish1/stitch-to-nextjs/main/skills/stitch-to-nextjs/SKILL.md"

echo ""
echo "  stitch-to-nextjs installer"
echo "  Pixel-perfect Stitch designs to Next.js components"
echo "  ------------------------------------------------"
echo ""

# Check for jq
if ! command -v jq &> /dev/null; then
  echo "[!] jq is required for JSON merging. Installing..."
  if command -v brew &> /dev/null; then
    brew install jq
  elif command -v apt-get &> /dev/null; then
    sudo apt-get install -y jq
  else
    echo "[x] Please install jq manually: https://jqlang.github.io/jq/download/"
    exit 1
  fi
fi

# Ensure directories exist
mkdir -p "$COMMANDS_DIR"

# Step 1: Install skill file
echo "[1/3] Installing skill file..."
curl -sL -o "$COMMANDS_DIR/stitch-to-nextjs.md" "$SKILL_URL"
echo "      Saved to $COMMANDS_DIR/stitch-to-nextjs.md"

# Step 2: Add marketplace to settings.json
echo "[2/3] Adding plugin marketplace..."
if [ ! -f "$SETTINGS_FILE" ]; then
  echo '{}' > "$SETTINGS_FILE"
fi

# Check if marketplace already exists
if jq -e '.extraKnownMarketplaces."stitch-to-nextjs"' "$SETTINGS_FILE" &> /dev/null; then
  echo "      Marketplace already configured"
else
  jq '.extraKnownMarketplaces["stitch-to-nextjs"] = {
    "source": {"source": "github", "repo": "yshaish1/stitch-to-nextjs"}
  }' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp" && mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
  echo "      Marketplace added to settings.json"
fi

# Step 3: Check stitch-mcp auth
echo "[3/3] Checking stitch-mcp setup..."
if command -v stitch-mcp &> /dev/null || npx --yes @_davideast/stitch-mcp doctor &> /dev/null 2>&1; then
  echo "      stitch-mcp already configured"
else
  echo ""
  echo "      stitch-mcp needs one-time Google authentication."
  echo "      Run this command to complete setup:"
  echo ""
  echo "        npx @_davideast/stitch-mcp init"
  echo ""
fi

echo ""
echo "  Done! Restart Claude Code, then run:"
echo ""
echo "    /stitch-to-nextjs list"
echo ""
echo "  Or install as a full plugin:"
echo ""
echo "    /plugin install stitch-to-nextjs"
echo ""
