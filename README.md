# dotagents

My personal `.agents/` and `.opencode/` setup — everything AI coding agents need to be productive. Designed to be cloned anywhere and symlinked into place.

## Quick Start

```bash
git clone https://github.com/LoveKhatri/dotagents.git ~/dotagents

# Set up global symlinks
ln -sf ~/dotagents/agents ~/.agents
ln -sf ~/dotagents/opencode ~/.config/opencode
```

That's it. OpenCode now gets skills, rules, memory, and config from this repo.

## Structure

```
dotagents/
├── agents/              # Universal agent brain (works with any tool)
│   ├── skills/          # 63 skills — all flat, all discoverable
│   ├── rules/           # Domain-specific rules (TS, testing, git, etc.)
│   ├── memory/          # Long-term project memory
│   │   ├── MEMORY.md    # Accumulated project intelligence
│   │   ├── daily/       # Per-session logs
│   │   └── weekly/      # Weekly summaries
│   ├── context/         # Saved contexts (context-save / context-restore)
│   ├── learnings/       # Cross-session learnings (learn skill)
│   └── plugins/         # Agent extensions (placeholder)
├── opencode/            # OpenCode-specific config
│   ├── skills -> ../agents/skills/   # Symlinked to agents
│   ├── plugins/         # crg-plugin, etc.
│   └── opencode.jsonc   # Provider config, models, plugins
└── skills-lock.json     # Skill manifest (sources, hashes)
```

## Skills (63 total)

Organized by source. See `skills-lock.json` for full manifest.

| Source | Count | Notable skills |
|--------|-------|---------------|
| `obra/superpowers` | 14 | brainstorming, dispatching-parallel-agents, executing-plans, test-driven-development, using-superpowers |
| `mattpocock/skills` | 10 | caveman, diagnose, grill-with-docs, handoff, improve-codebase-architecture, prototype, review, triage, zoom-out |
| `garrytan/gstack` | 6 | careful, context-save, context-restore, cso, diagram, learn (rewritten — zero gstack deps) |
| `anthropics/skills` | 6 | docx, frontend-design, mcp-builder, pdf, pptx, xlsx |
| `mongodb/agent-skills` | 7 | mongodb-atlas-stream-processing, mongodb-connection, mongodb-schema-design, mongodb-search-and-ai |
| `neondatabase/agent-skills` | 4 | neon, neon-postgres, neon-postgres-branches, neon-postgres-egress-optimizer |
| `Leonxlnx/taste-skill` | 6 | design-taste-frontend, gpt-taste, high-end-visual-design, industrial-brutalist-ui, minimalist-ui, redesign-existing-projects |
| Other | 3 | find-skills, shadcn, ui-ux-pro-max |
| `local` (custom) | 2 | idea-shredder, stitch-design-taste |
| `local` (from gstack, rewritten) | 5 | careful, context-save, context-restore, cso, diagram, learn |

## Rules

Rules are in `agents/rules/` organized by domain. Each file is a markdown file the agent loads contextually:

| Folder | Files |
|--------|-------|
| `typescript/` | `const-over-let.md`, `no-any.md` |
| `testing/` | `test-naming.md`, `test-structure.md` |
| `architecture/` | `prefer-simple.md`, `single-responsibility.md` |
| `code-quality/` | `no-mutations.md`, `no-swallowed-errors.md` |
| `git/` | `branch-naming.md`, `conventional-commits.md`, `small-prs.md` |
| `security/` | `validate-boundaries.md` |
| `debugging/` | (empty — add as needed) |
| `documentation/` | (empty — add as needed) |
| `workflow/` | (empty — add as needed) |

## Memory System

Three layers:

1. **Daily logs** (`memory/daily/YYYY-MM-DD.md`) — Session-by-session activity
2. **Weekly summaries** (`memory/weekly/YYYY-Www.md`) — Key outcomes distilled from dailies
3. **Global memory** (`memory/MEMORY.md`) — Accumulated project intelligence agents reference

## OpenCode Config

`opencode/opencode.jsonc` contains provider setup (CommandCode with multiple models), shell config (`zsh`), and plugin declarations.

`opencode/plugins/` has the code-review-graph plugin. Add more as needed.

## Adding New Skills

1. Drop `SKILL.md` into `agents/skills/<skill-name>/`
2. Run `opencode skill add` if using the CLI, or manually add to `skills-lock.json`
3. Works immediately — no restart needed

## Custom Skills

These were forked from gstack and rewritten to be self-contained:
- **careful** — Warns before destructive bash commands
- **context-save** / **context-restore** — Save and restore working state
- **cso** — Full security audit (secrets, CI/CD, OWASP, STRIDE)
- **diagram** — English → mermaid diagrams (mmd + SVG + PNG)
- **learn** — Cross-session project learnings (file-based)

See their `SKILL.md` files for details.
