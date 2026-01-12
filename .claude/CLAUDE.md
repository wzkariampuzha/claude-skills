# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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

## Development Commands

### Installing Skills Locally

```bash
# Install a skill to your local Claude Code instance
cp -r skills/{skill-name} ~/.claude/skills/

# Verify installation
ls ~/.claude/skills/{skill-name}
```

### Testing Skills

Skills use TDD methodology with subagents:

```bash
# Testing is done via Claude Code Task tool with subagent_type: "general-purpose"
# See superpowers:writing-skills for full testing methodology
```

**Testing workflow:**
1. **RED Phase:** Run pressure scenarios WITHOUT skill to establish baseline behavior
2. **GREEN Phase:** Write minimal skill addressing baseline failures
3. **REFACTOR Phase:** Identify and close loopholes through iterative testing

### Git Workflow

```bash
# Standard commit workflow
git add skills/{skill-name}/
git commit -m "Add {skill-name} skill

[Description of skill purpose and key features]

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

git push
```

## Skill Development Methodology

**Required Background:** Must understand `superpowers:writing-skills` skill before creating new skills.

**Core Process (TDD for Documentation):**

1. **Write failing test first** - Run pressure scenario with subagent WITHOUT skill
2. **Document exact rationalizations** - Capture verbatim how agents cut corners
3. **Write minimal skill** - Address those specific failures only
4. **Test with skill present** - Verify agent now complies
5. **Close loopholes** - Add explicit counters for new rationalizations discovered

**Quality Requirements:**
- YAML frontmatter: name (letters/numbers/hyphens only), description (starts with "Use when...")
- Description describes WHEN to use (triggers/symptoms), NOT WHAT skill does (workflow)
- Flowcharts for non-obvious decisions only (not for reference material or linear steps)
- Red flags section listing rationalization patterns
- Common mistakes table
- Quality checklist for verification

**Anti-Patterns to Avoid:**
- Creating skills without testing first (violates TDD)
- Verbose descriptions that summarize workflow (Claude follows description, ignores skill body)
- Multi-language code examples (one excellent example beats many mediocre ones)
- Flowcharts with generic labels (step1, helper2) or for linear instructions
- Skills for one-off solutions or project-specific conventions

## Skills Inventory

### frontend-styleguide

**Purpose:** Efficiently create and edit frontend style guides without wasting context on repeated exploration

**Core principle:** Explore once with subagent, document findings permanently to CLAUDE.md, never explore again

**Key features:**
- Distinguishes between creating new vs editing existing style guides
- Creating: Uses Explore subagent, documents to CLAUDE.md, uses frontend-design skill
- Editing: Uses CLAUDE.md context ONLY (never re-explores)
- Asks about design system (shadcn/ui, Material UI, Bootstrap, Tailwind)
- Asks about fonts (Google Fonts vs system fonts)
- Creates reusable component functions

**Critical decision:** If CLAUDE.md has "Frontend Style Guide" section → editing workflow (no exploration)

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
   - Public repo with manual installation support
   - Tagged releases for version tracking

2. **Community Aggregators:**
   - Listed in awesome-claude-skills
   - Auto-indexed by SkillsMP.com

3. **Plugin Marketplace:**
   - Users add via: `/plugin marketplace add wzkariampuzha/claude-skills`
   - Install skills via: `/plugin install {skill-name}@wzkariampuzha-claude-skills`

### Adding New Skills to Marketplace

When creating a new skill:

1. Create skill directory: `skills/{new-skill-name}/SKILL.md`
2. **NO changes to marketplace.json needed** - Skills are auto-discovered from `skills/` directory
3. Increment version numbers in both `plugin.json` and `marketplace.json`
4. Update `.claude/CLAUDE.md` Skills Inventory section with new skill documentation
5. Commit changes and create new Git tag
6. Push tag to GitHub: `git push origin vX.Y.Z`

**Note:** With the auto-discovery approach, you don't need to register each skill in marketplace.json. Just create the skill file in the `skills/` directory and increment the version numbers.

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
