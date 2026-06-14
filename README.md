# dotagents

Standard `.agents/` setup that I copy into every project. Contains skills, memory system, rules, and plugins — everything an AI coding agent (Claude Code, CommandCode, OpenCode) needs to be productive from day one.

## Quick Start

```bash
# Clone this repo
git clone https://github.com/LoveKhatri/dotagents.git ~/dotagents

# In any project root:
cp -r ~/dotagents/.agents .

# Or run the setup script (clones skills from GitHub):
cd my-project
bash ~/dotagents/setup.sh
```

## What's Inside

```
.agents/
├── skills/          # Agent skills (superpowers, mattpocock, gstack)
│   └── installed/   # Cloned skill repos go here
├── memory/          # Session and project memory
│   ├── daily/       # Daily session logs
│   ├── weekly/      # Weekly summaries
│   └── MEMORY.md    # Global accumulated memory
├── rules/           # Domain-specific rules (semantic folders)
│   ├── typescript/
│   ├── testing/
│   ├── architecture/
│   ├── workflow/
│   ├── code-quality/
│   ├── git/
│   ├── debugging/
│   ├── documentation/
│   └── security/
└── plugins/         # Agent plugins/extensions
```

## Skills

Three skill collections I use across projects:

### obra/superpowers
The most comprehensive collection. Includes sub-agent orchestration, TDD workflows, code review, shell mastery, and thinking/taste patterns. I install all of them — they're interconnected and hard to cleanly separate.

```bash
git clone https://github.com/obra/superpowers.git .agents/skills/installed/superpowers
```

### mattpocock/skills
TypeScript-focused. The ones I use regularly: `handoff`, `caveman`, and `grill-me`. There are others worth checking out (code review rubrics, XState patterns, API design) but I haven't fully explored them yet.

```bash
git clone https://github.com/mattpocock/skills.git .agents/skills/installed/mattpocock
```

### garrytan/gstack
Full-stack AI agent scaffolding with Google Cloud. Haven't installed this yet because setup is involved and it pushes for global installation. I might install globally or per-project depending on tool compatibility (CommandCode vs OpenCode vs Claude Code handle global skills differently).

```bash
git clone https://github.com/garrytan/gstack.git .agents/skills/installed/gstack
```

## Memory System

Three layers:

1. **Daily logs** (`.agents/memory/daily/YYYY-MM-DD.md`) — Session-by-session activity, decisions, discoveries
2. **Weekly summaries** (`.agents/memory/weekly/YYYY-Www.md`) — Key outcomes from the week, distilled from dailies
3. **Global memory** (`.agents/memory/MEMORY.md`) — Accumulated project intelligence. What we've learned, built, decided. This is the file agents reference for context.

The daily → weekly → global flow prevents memory bloat. Agents read MEMORY.md for long-term context, weekly files for recent history, daily files for specifics.

## Rules

Rules are organized into semantic folders so agents can load only what's relevant to the task at hand:

| Folder | When it loads |
|--------|--------------|
| `typescript/` | Working with TypeScript files |
| `testing/` | Writing or modifying tests |
| `architecture/` | System design, refactoring, new features |
| `workflow/` | CI/CD, task management, process |
| `code-quality/` | Reviews, linting, formatting |
| `git/` | Commits, branching, PRs |
| `debugging/` | Bug hunts, error investigation |
| `documentation/` | Docs, READMEs, comments |
| `security/` | Auth, input validation, secrets |

Files within each folder have descriptive names (`no-any.md`, `test-naming.md`, `error-boundaries.md`) so it's obvious which rules to grab.

## Plugins

For agent extensions that don't fit the skills/rules model. Currently a placeholder — populate as needed.

## Setup Script

The `setup.sh` script handles:
- Cloning all three skill repos into `.agents/skills/installed/`
- Creating `MEMORY.md` if it doesn't exist
- Setting up the `.gitignore`

## Tools I Use This With

- **CommandCode** — reads `.agents/rules/` automatically when rules are referenced
- **Claude Code** — uses `/skill-name` with repos in the skills directory
- **OpenCode** — similar skills/rules convention

Global vs per-project: I prefer per-project because different projects need different skills and rules. But gstack's global-first design is worth evaluating.
