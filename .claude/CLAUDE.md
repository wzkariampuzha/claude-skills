## Project Overview
This repository contains custom Claude skills for specialized workflows. Skills are markdown files with YAML frontmatter that provide procedural guidance to Claude agents.
## Architecture
**Repository Structure:**
```
skills/                              # All skill files
  {skill-name}/
    SKILL.md                        # Main skill file (YAML frontmatter + markdown)
    [supporting-files]              # Optional: tools, examples, heavy reference
```
**Skill File Format:**
- YAML frontmatter with `name` and `description` fields (max 1024 chars total)
- Description must start with "Use when..." and describe triggering conditions only
- Markdown body with workflow, patterns, examples, red flags, and quality checklist
- Flowcharts (GraphViz dot notation) only for non-obvious decision points
**Key Principle:** Skills are documentation, not code. They guide agent behavior through explicit workflows and anti-patterns.
### Git Workflow
```bash
# Standard commit workflow
git add skills/{skill-name}/
git commit -m "Add {skill-name} skill
[Description of skill purpose and key features]
Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
git push
```
## Skills Inventory
### frontend-styleguide
 Efficiently create and edit frontend style guides without wasting context on repeated exploration
### test-execution-manager
 Purpose: Manage test execution via test-runner subagents with incremental timeout escalation strategy

## Hooks Inventory

### ruff-python
**Location:** `hooks/PostToolUse.ruff-python`
**Type:** PostToolUse hook
**Purpose:** Automatically run ruff linter and formatter on Python files after Edit/Write operations
**Installation:** Run `hooks/install-ruff-hook.sh` to copy to `~/.claude/hooks/`
**Requirements:** jq, ruff
**Behavior:** Runs `ruff check && ruff format`, shows output to agent, never blocks edits

## Publishing & Distribution
### Repository Structure for Public Distribution
This repository is configured as a Claude Code plugin marketplace:
**Marketplace Manifest:** `.claude-plugin/marketplace.json`
- Defines plugin metadata and versioning
- Enables one-command installation via `/plugin marketplace add`
- Schema: https://anthropic.com/claude-code/marketplace.schema.json
### Critical Configuration Rules
**REQUIRED for skills to be discoverable:**
1. **plugin.json is required**: Must exist in `.claude-plugin/` with plugin metadata
   - Without this file, plugin installation succeeds but skill discovery fails
   - Contains name, description, version, author, repository, license, keywords
2. **Source must be relative**: Use `"source": "./"` in marketplace.json for local installations to work
   - Remote URLs (e.g., GitHub raw content) only work for remote-only installations
   - Breaks local collaborative usage (installing in project directories)
   - Relative path enables Claude to discover skills from local installation directory
3. **Plugin vs Skill naming**:
   - **Plugin name**: `wzkariampuzha-claude-skills` (the collection/repository)
   - **Skill names**: `frontend-styleguide`, etc. (individual skills)
   - Plugin is the installable unit, skills are auto-discovered within
4. **Skill discovery**: Claude auto-discovers all `skills/*/SKILL.md` files from source path
   - No need to register each skill in marketplace.json
   - Add new skills by creating `skills/{skill-name}/SKILL.md`
   - Skills appear automatically after plugin installation/reload
**Distribution Channels:**
1. **GitHub Repository:** https://github.com/wzkariampuzha/claude-skills
   - Tagged releases for version tracking
3. **Plugin Marketplace:**
   - Users add via: `/plugin marketplace add wzkariampuzha/claude-skills`
   - Install skills via: `/plugin install {skill-name}@wzkariampuzha-claude-skills`
### Adding New Skills to Marketplace
**CRITICAL RELEASE PROCESS:**
**New skills are NOT discoverable until a tagged release is created!**
The plugin marketplace reads from **tagged releases**, not from the main branch HEAD. If you add a skill and push to main without creating a tag, users will not be able to install it via the marketplace.
**Required steps for EVERY new skill release:**
1. Create skill directory: `skills/{new-skill-name}/SKILL.md`
2. Update `.claude/CLAUDE.md` Skills Inventory section with new skill documentation
3. Update `README.md` with new skill documentation in the Skills section
4. **BEFORE PUSHING:** Increment version numbers in BOTH files:
   - `.claude-plugin/marketplace.json` (lines 4 and 14)
   - `.claude-plugin/plugin.json` (line 4)
5. Commit changes with descriptive message
6. **BEFORE PUSHING:** Create annotated Git tag: `git tag -a vX.Y.Z -m "Description"`
7. Push BOTH commit and tag: `git push origin main && git push origin vX.Y.Z`
**Common mistake:** Committing new skill → pushing to main → forgetting to tag = skill invisible in marketplace
### Version Management
- Follow semantic versioning (MAJOR.MINOR.PATCH)
- Marketplace version tracks collection version
- Individual plugin versions track skill-specific updates
- Create Git tags for all releases
### No Official Anthropic Registry
**Important:** There is no centralized Anthropic registry for submitting skills. Distribution happens through:
- Personal GitHub repositories
- Community aggregators (manual PR submission)
- Third-party marketplaces (automatic indexing)
- Plugin marketplace system (self-hosted via marketplace.json)