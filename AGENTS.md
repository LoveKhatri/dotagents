# dotagents

This repo contains personal AI coding agent configuration.

## How skills, rules, and memory are discovered

Skills live in `agents/skills/<name>/SKILL.md`. OpenCode discovers them via the `~/.agents/skills/` symlink. Rules are loaded contextually from `agents/rules/<domain>/*.md`. Memory is read from `agents/memory/MEMORY.md`.

## Available skills

All 63 skills are documented in `skills-lock.json`. Key ones:

- `brainstorming` — mandatory before creative work
- `diagnose` / `systematic-debugging` — bug investigation
- `writing-plans` / `executing-plans` — plan → execute workflow
- `review` — two-axis PR review (standards + spec)
- `cso` — security audit (OWASP, STRIDE, secrets, CI/CD)
- `impeccable` — frontend design/critique/audit
- `test-driven-development` — TDD workflow
- `using-git-worktrees` — isolated feature work
- `handoff` — compact conversation for another agent
- `caveman` — ultra-compressed communication
