# Claude Skills Collection

Custom Claude skills for specialized workflows.

## Skills

### frontend-styleguide

**Location:** `skills/frontend-styleguide/SKILL.md`

**Purpose:** Create comprehensive frontend style guides efficiently without wasting context on repeated exploration.

**Use when:**
- Creating new style guides for web projects
- Editing existing style guides
- Adding components to component libraries
- Documenting design systems

**Key features:**
- Explores codebase once with subagent, documents to CLAUDE.md, never re-explores
- Distinguishes between creating new vs editing existing style guides
- Integrates with frontend-design skill for professional quality
- Asks about design system preferences (shadcn/ui, Material UI, Bootstrap, Tailwind)
- Asks about font preferences (Google Fonts vs system fonts)
- Creates reusable component functions, not just documentation
- Includes comprehensive standard component checklist

**Core principle:** Explore once. Document permanently. Create professionally.

## Installation

### Method 1: Plugin Marketplace (Recommended)

Add the marketplace to Claude Code:
```bash
/plugin marketplace add wzkariampuzha/claude-skills
```

Install the skill:
```bash
/plugin install frontend-styleguide@wzkariampuzha-claude-skills
```

### Method 2: Manual Installation

Clone the repository:
```bash
git clone https://github.com/wzkariampuzha/claude-skills.git
```

Copy the skill to your local Claude Code skills directory:
```bash
cp -r claude-skills/skills/frontend-styleguide ~/.claude/skills/
```

The skill will be automatically available in your Claude Code sessions.

## Development

This repository follows the TDD approach to skill development as outlined in the superpowers:writing-skills skill:

1. **RED Phase:** Create pressure scenarios and run baseline tests without the skill
2. **GREEN Phase:** Write minimal skill addressing baseline failures
3. **REFACTOR Phase:** Identify and close loopholes through iterative testing

## Contributing

Skills are developed using the writing-skills methodology. Each skill should:
- Be tested with pressure scenarios before deployment
- Include flowcharts only for non-obvious decisions
- Have clear red flags and common mistakes sections
- Maintain concise, scannable documentation
- Follow the "explore once, document permanently" principle where applicable
