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

### generating-frontend-styleguides

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
