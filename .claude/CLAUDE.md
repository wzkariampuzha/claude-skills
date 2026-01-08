# Claude Skills Repository

## Project Overview

This repository contains custom Claude skills developed using the TDD methodology from superpowers:writing-skills.

## Repository Structure

```
claude-skills/
├── skills/
│   └── generating-frontend-styleguides/
│       └── SKILL.md
├── .claude/
│   ├── settings.local.json
│   └── CLAUDE.md (this file)
└── README.md
```

## Skills Inventory

### generating-frontend-styleguides

**Location:** `skills/generating-frontend-styleguides/SKILL.md`

**Status:** Completed, tested with pressure scenarios

**Purpose:** Efficiently create and edit frontend style guides without wasting context

**Testing results:**
- RED phase: Identified baseline failures (time pressure shortcuts, not documenting, skipping Explore)
- GREEN phase: Skill addresses all baseline failures
- REFACTOR phase: Added creating vs editing workflow distinction based on user feedback

**Key learnings:**
- Agents naturally skip documentation under time pressure
- Re-exploration wastes 50-100x more context than using documented knowledge
- Need explicit flowchart to distinguish creating new vs editing existing style guides

## Development Methodology

All skills in this repository follow the TDD approach:

1. **RED Phase:** Run pressure scenarios WITHOUT skill, document exact rationalizations
2. **GREEN Phase:** Write minimal skill addressing those specific failures
3. **REFACTOR Phase:** Close loopholes discovered during testing

## Files Added

| File | Purpose | Created |
|------|---------|---------|
| `skills/generating-frontend-styleguides/SKILL.md` | Main skill file | 2026-01-08 |
| `README.md` | Repository documentation | 2026-01-08 |
| `.claude/CLAUDE.md` | Project context (this file) | 2026-01-08 |

## Usage

To use the generating-frontend-styleguides skill:

```bash
cp -r skills/generating-frontend-styleguides ~/.claude/skills/
```

The skill will then be available in all Claude Code sessions.

## Testing Approach

Skills are tested with:
- Baseline scenarios (no skill)
- Pressure scenarios (time constraints, rushed deliverables)
- Edge case scenarios (editing vs creating)
- Compliance verification (agent follows all required steps)

## Quality Standards

- YAML frontmatter max 1024 characters
- Description starts with "Use when..." and includes triggers
- Flowcharts only for non-obvious decisions
- Red flags section for common rationalizations
- Common mistakes table
- Quality checklist for verification
