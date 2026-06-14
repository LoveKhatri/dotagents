---
name: context-restore
description: Restore working context saved earlier by context-save. Load the most recent saved state so you can pick up where you left off. Use when asked to resume, restore context, or pick up where I left off.
triggers:
  - resume where i left off
  - restore context
  - where was i
  - pick up where i left off
  - context restore
---

# Context Restore

Load a previously saved context so the user can resume work without losing any state.

## Restore flow

### Step 1: Find saved contexts

```bash
if [ -d .agents/context ]; then
  find .agents/context -maxdepth 1 -name "*.md" -type f 2>/dev/null | sort -r | head -20
else
  echo "NO_CHECKPOINTS"
fi
```

Search across all branches by default (the branch is recorded in frontmatter, not used for filtering).

### Step 2: Load the right file

- If the user specified a title fragment or number: find the matching file.
- Otherwise: load the **first file** (newest by `YYYYMMDD-HHMMSS` filename prefix).

Read the file and present:

```
RESUMING CONTEXT
================
Title:       <title>
Branch:      <branch>
Saved:       <timestamp, human-readable>
Duration:    <formatted duration, if available>
Status:      <status>
================

### Summary
<summary>

### Remaining Work
<remaining items>

### Notes
<notes>
```

If the current branch differs from the saved context's branch:
"This context was saved on branch `<branch>`. You are currently on `<current>`. You may want to switch branches."

### Step 3: Offer next steps

Ask the user:
- A) Continue working on the remaining items
- B) Show the full saved file
- C) Just needed the context, thanks

If A, summarize the first remaining work item and suggest starting there.

## If no saved contexts exist

"No saved contexts yet. Run `context-save` first to save your current working state, then `context-restore` will find it."

## Rules

- Never modify code. This skill only reads saved files.
- Always search across all branches by default.
- "Most recent" means the filename timestamp prefix, not filesystem mtime.
