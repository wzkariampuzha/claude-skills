# Claude Skills Collection

Custom Claude skills for specialized workflows.

## Skills

### generating-frontend-styleguides

**Location:** `skills/generating-frontend-styleguides/SKILL.md`

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

To use these skills with Claude Code:

1. Copy the skill directory to your Claude skills folder:
   ```bash
   cp -r skills/generating-frontend-styleguides ~/.claude/skills/
   ```

2. The skill will be automatically available in your Claude Code sessions.

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
