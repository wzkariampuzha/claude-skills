#!/usr/bin/env bash
# Install ruff PostToolUse hook to ~/.claude/hooks/

set -e

echo "========================================="
echo "  Ruff PostToolUse Hook Installer"
echo "========================================="
echo ""

# Get script directory (where hook file is located)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HOOK_FILE="$SCRIPT_DIR/PostToolUse.ruff-python"

# Validate hook file exists
if [ ! -f "$HOOK_FILE" ]; then
  echo "Error: Hook file not found at $HOOK_FILE"
  exit 1
fi

# Check if jq is installed (required for hook to work)
if ! command -v jq &> /dev/null; then
  echo "❌ Error: jq is required but not installed."
  echo ""
  echo "Install jq:"
  echo "  macOS:  brew install jq"
  echo "  Linux:  sudo apt-get install jq  (or yum install jq)"
  echo ""
  exit 1
fi

# Check if ruff is installed (warn but don't fail)
if ! command -v ruff &> /dev/null; then
  echo "⚠️  Warning: ruff is not installed."
  echo ""
  echo "Install ruff:"
  echo "  pip install ruff"
  echo "  or: pipx install ruff"
  echo "  or: brew install ruff"
  echo ""
  echo "Hook will be installed but won't work until ruff is available."
  echo ""
  read -p "Continue anyway? (y/N) " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 0
  fi
fi

# Create hooks directory if it doesn't exist
HOOKS_DIR="$HOME/.claude/hooks"
mkdir -p "$HOOKS_DIR"

# Copy hook file
cp "$HOOK_FILE" "$HOOKS_DIR/PostToolUse.ruff-python"
chmod +x "$HOOKS_DIR/PostToolUse.ruff-python"

echo "✅ Hook installed successfully!"
echo ""
echo "Location: $HOOKS_DIR/PostToolUse.ruff-python"
echo ""
echo "========================================="
echo "  Next Steps"
echo "========================================="
echo ""
echo "Enable the hook globally by adding to ~/.claude/settings.json:"
echo ""
cat << 'EOF'
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/PostToolUse.ruff-python"
          }
        ]
      }
    ]
  }
}
EOF
echo ""
echo "Or enable per-project in .claude/settings.json (same format)"
echo ""
echo "Hook will run automatically after editing Python files!"
echo ""
