---
name: careful
description: Warns before destructive commands like rm -rf, force-push, DROP TABLE, kubectl delete. Use when touching prod, debugging live systems, or working in shared environments.
triggers:
  - be careful
  - warn before destructive
  - safety mode
  - careful mode
  - prod mode
---

# Careful Mode

When this skill is active, review every bash command before execution and warn the user if it matches destructive patterns.

## Protected patterns

| Pattern | Example | Risk |
|---------|---------|------|
| `rm -rf` / `rm -r` / `rm --recursive` | `rm -rf /var/data` | Recursive delete |
| `DROP TABLE` / `DROP DATABASE` | `DROP TABLE users;` | Data loss |
| `TRUNCATE` | `TRUNCATE orders;` | Data loss |
| `git push --force` / `-f` | `git push -f origin main` | History rewrite |
| `git reset --hard` | `git reset --hard HEAD~3` | Uncommitted work loss |
| `git checkout .` / `git restore .` | `git checkout .` | Uncommitted work loss |
| `kubectl delete` | `kubectl delete pod` | Production impact |
| `docker rm -f` / `docker system prune` | `docker system prune -a` | Container/image loss |

## Safe exceptions

These patterns are allowed without warning:
- `rm -rf node_modules` / `.next` / `dist` / `__pycache__` / `.cache` / `build` / `.turbo` / `coverage`

## How to use

Before executing any bash command that matches the protected patterns, ask the user:
"⚠ Destructive command detected: `<command>`. Proceed?"

Present two options:
- A) Proceed with the command
- B) Cancel

Do not execute until the user confirms.

## Deactivation

This skill is session-scoped. End the conversation or start a new session to deactivate.
