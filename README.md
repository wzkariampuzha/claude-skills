# Claude Skills Collection
Custom Claude skills for my specialized workflows.
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
### test-execution-manager
**Location:** `skills/test-execution-manager/SKILL.md`
**Purpose:** Manage test execution via test-runner subagents with incremental timeout escalation strategy.
**Use when:**
- Running tests via test-runner subagents
- Test suites have variable execution times
- Need to show progress quickly while handling slow tests
- Working within timeout constraints
**Key features:**
- Incremental timeout escalation (10s→20s→30s→45s→60s→90s→120s→180s→300s→600s max)
- Delegates to test-runner subagents (never reads terminal output directly)
- Test inclusion verification after each pass
- User confirmation before expanding test scope
- Creates fix plans when tests fail (not just listing failures)
- Hard limit enforcement at 600s (10 minutes)
**Core principle:** Start fast. Escalate incrementally. Never exceed limits.
## Installation
### Method 1: Plugin Marketplace (Recommended)
Add the marketplace to Claude Code:
```bash
/plugin marketplace add wzkariampuzha/claude-skills
```
Install skills:
```bash
/plugin install frontend-styleguide@wzkariampuzha-claude-skills
/plugin install test-execution-manager@wzkariampuzha-claude-skills
```
### Method 2: Manual Installation
Clone the repository:
```bash
git clone https://github.com/wzkariampuzha/claude-skills.git
```
Copy the skills to your local Claude Code skills directory:
```bash
cp -r claude-skills/skills/frontend-styleguide ~/.claude/skills/
cp -r claude-skills/skills/test-execution-manager ~/.claude/skills/
```
The skills will be automatically available in your Claude Code sessions.