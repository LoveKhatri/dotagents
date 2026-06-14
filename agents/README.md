# agents

The universal agent directory. Everything an AI coding agent needs to be context-aware and productive.

## Structure

- **skills/** — Agent skills teach capabilities (how to do things). Each skill is a directory with a `SKILL.md`. Flat layout — no nesting.
- **rules/** — Domain-specific rules constrain behavior (what to do / not do). Organized by topic.
- **memory/** — Long-term project memory and context. Three layers: daily, weekly, global.
- **plugins/** — Agent extensions and plugins.
- **context/** — Saved working contexts (used by context-save / context-restore).
- **learnings/** — Cross-session learnings (used by the learn skill).

## How agents discover this

| Tool | Skills | Rules | Memory |
|------|--------|-------|--------|
| OpenCode | `~/.agents/skills/<name>/SKILL.md` | `agents/rules/*.md` when task matches | `agents/memory/MEMORY.md` |
| Claude Code | `/skill-name` in `.agents/skills/` | Reads `.agents/rules/*.md` | Reads `MEMORY.md` on start |
| CommandCode | Skills in `~/.agents/skills/` or local `.agents/skills/` | Project-level rules auto-loaded | Taste system |

The structure works with all of them with minimal adaptation.
