---
name: context-save
description: Save working context — git state, decisions made, remaining work — so any future session can resume without losing a beat. Use when asked to save progress, save state, or save my work.
triggers:
  - save progress
  - save state
  - save my work
  - context save
---

# Context Save

Capture the full working context so another session can pick up exactly where you left off via `context-restore`.

## Save flow

### Step 1: Gather state

```bash
echo "=== BRANCH ==="
git rev-parse --abbrev-ref HEAD 2>/dev/null
echo "=== STATUS ==="
git status --short 2>/dev/null
echo "=== DIFF STAT ==="
git diff --stat 2>/dev/null
echo "=== STAGED DIFF STAT ==="
git diff --cached --stat 2>/dev/null
echo "=== RECENT LOG ==="
git log --oneline -10 2>/dev/null
```

### Step 2: Summarize

Using gathered state and conversation history, produce a summary with:

1. **Title** — 3-6 words describing the current work (infer from context, or use what the user provides)
2. **What's being worked on** — high-level goal or feature (1-3 sentences)
3. **Decisions made** — architectural choices, trade-offs, approaches (bulleted list)
4. **Remaining work** — concrete next steps in priority order (numbered list)
5. **Notes** — gotchas, blocked items, open questions, things tried that didn't work

### Step 3: Write context file

```bash
mkdir -p .agents/context
```

Write `.agents/context/<YYYYMMDD-HHMMSS>-<title-slug>.md`:

```markdown
---
status: in-progress
branch: <current branch>
timestamp: <ISO-8601>
session_duration_s: <duration or omit>
files_modified:
  - path/to/file1
  - path/to/file2
---

## Working on: <title>

### Summary
<1-3 sentences>

### Decisions Made
- <decision 1>
- <decision 2>

### Remaining Work
1. <next step>
2. <next step>

### Notes
<gotchas, blocked items, open questions>
```

### Step 4: Confirm

```
CONTEXT SAVED
=============
Title:    <title>
Branch:   <branch>
File:     .agents/context/<filename>.md
Modified: <N> files
Duration: <duration or unknown>
=============

Restore later with context-restore.
```

## List saved contexts

```bash
if [ -d .agents/context ]; then
  find .agents/context -maxdepth 1 -name "*.md" -type f 2>/dev/null | sort -r
else
  echo "No saved contexts."
fi
```

Parse the frontmatter of each file to extract `status`, `branch`, and `timestamp`. Derive the title from the filename. Present as a table.

## Rules

- Never modify code. This skill captures state only.
- Saved files are append-only — never overwrite.
- Infer context; don't interrogate the user unnecessarily.
