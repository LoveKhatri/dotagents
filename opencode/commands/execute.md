---
description: Execute a plan file directly
agent: build
subtask: false
---

Execute the plan in $ARGUMENTS directly.

Rules:

- Do not use subagents.
- Work inline in this session.
- Treat the argument as a plan file reference, usually passed like `@docs/superpowers/plans/<name>.md`.
- Read the plan first, then execute it in order.
- If questions are needed, batch them into one message.
- Create a worktree directly in `.worktrees/`.
- Create a new branch for that worktree.
- Commit regularly as milestones land.
- Push to GitHub during the work and again at the end if needed.
- Open a PR when the plan is complete.
- Stay within the plan scope and follow the repo rules in `AGENTS.md`, `.agents/RULES.md`, `.agents/MEMORY.md`, and `.agents/ONGOING.md`.
- No asking the user for browser permission to show mockups, diagrams, proceed directly with the work.

If the plan argument is missing or not a file reference, ask for the plan path before doing anything else.
