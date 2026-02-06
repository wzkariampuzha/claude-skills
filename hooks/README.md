# Claude Code Hooks

This directory contains distributable hooks for Claude Code that can be installed into your `~/.claude/hooks/` directory.

## Available Hooks

### ruff-python (PostToolUse)

Automatically runs `ruff check && ruff format` on Python files after Edit or Write operations.

**Triggers:** After Edit or Write tool completes on `.py` files
**Requirements:** `jq`, `ruff`
**Action:** Runs ruff, shows output to agent, never blocks edits

## Installation

### Method 1: Via Plugin Marketplace (Recommended)

1. Install the plugin:
   ```bash
   /plugin marketplace add wzkariampuzha/claude-skills
   ```

   ```bash
   /plugin install wzkariampuzha-claude-skills
   ```

2. Navigate to the hooks directory:
   ```bash
   cd ~/.claude/plugins/marketplaces/wzkariampuzha-claude-skills/hooks
   ```

3. Run the installation script:
   ```bash
   sh install-ruff-hook.sh
   ```

### Method 2: Direct from Repository

1. Clone the repository:
   ```bash
   git clone https://github.com/wzkariampuzha/claude-skills.git
   ```

2. Navigate to the hooks directory:
   ```bash
   cd claude-skills/hooks
   ```

3. Run the installation script:
   ```bash
   sh install-ruff-hook.sh
   ```

### Method 3: Manual Installation

1. Download the hook:
   ```bash
   curl -o ~/.claude/hooks/PostToolUse.ruff-python \
     https://raw.githubusercontent.com/wzkariampuzha/claude-skills/main/hooks/PostToolUse.ruff-python
   ```

2. Make it executable:
   ```bash
   chmod +x ~/.claude/hooks/PostToolUse.ruff-python
   ```

## Configuration

After installation, enable the hook by adding to your settings:

### Global Configuration

Edit `~/.claude/settings.json`:

```json
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
```

### Project-Specific Configuration

Edit `.claude/settings.json` in your project (same format as above).

## Dependencies

### jq (Required)

JSON parser for extracting event data.

**Install:**
- macOS: `brew install jq`
- Linux: `sudo apt-get install jq` or `sudo yum install jq`

### ruff (Required)

Python linter and formatter.

**Install:**
```bash
pip install ruff
# or
pipx install ruff
# or
brew install ruff
```

## How It Works

1. After you edit a Python file, Claude Code fires a PostToolUse event
2. Hook receives JSON event via stdin
3. Hook parses event to extract tool name and file path
4. If tool is Edit or Write AND file extension is `.py`:
   - Runs `ruff check <file>`
   - Runs `ruff format <file>`
   - Shows output to agent
5. Hook always exits success (never blocks your edits)

## Troubleshooting

### Hook not triggering

- Verify hook is installed: `ls -lh ~/.claude/hooks/PostToolUse.ruff-python`
- Check it's executable: Should show `-rwxr-xr-x` permissions
- Verify settings.json syntax is valid JSON
- Try restarting Claude Code session

### "jq: command not found"

Install jq (see Dependencies section above).

### "ruff: command not found"

Install ruff (see Dependencies section above).

### Hook runs but ruff fails

- Check ruff is in your PATH: `which ruff`
- Verify ruff works: `ruff --version`
- Check ruff configuration in your project (pyproject.toml or ruff.toml)

### Want to disable temporarily

**Option 1:** Comment out the hook in settings.json:
```json
{
  "hooks": {
    "PostToolUse": [
      // {
      //   "matcher": "Edit|Write",
      //   "hooks": [...]
      // }
    ]
  }
}
```

**Option 2:** Remove from settings.json entirely

**Option 3:** Rename the hook file:
```bash
mv ~/.claude/hooks/PostToolUse.ruff-python ~/.claude/hooks/PostToolUse.ruff-python.disabled
```

## Uninstallation

Remove the hook file:
```bash
rm ~/.claude/hooks/PostToolUse.ruff-python
```

Remove from your settings.json configuration.

## Contributing

Found a bug or want to improve the hook? Open an issue or PR at:
https://github.com/wzkariampuzha/claude-skills

## License

MIT License - see repository root for details.
