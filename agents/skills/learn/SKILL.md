---
name: learn
description: Manage project learnings — record, search, prune, and export patterns discovered across sessions. Use when asked to show what was learned, manage learnings, or when a pattern repeats.
triggers:
  - show learnings
  - what have we learned
  - manage project learnings
  - didn't we fix this before
---

# Project Learnings Manager

Record and retrieve durable patterns, pitfalls, and decisions discovered while working on this project. Learnings persist in `.agents/learnings/` as JSONL files.

## Storage

Learnings are stored at `.agents/learnings/learnings.jsonl`. Each line is a JSON object:

```json
{"ts":"2026-06-14T10:00:00Z","type":"pattern|pitfall|preference|architecture|tool","key":"kebab-case-key","insight":"One-sentence description","confidence":8,"source":"observed|user-stated","files":["path/to/file.ts"]}
```

## Commands

### Show recent (default)

Read `.agents/learnings/learnings.jsonl`, sort by timestamp descending, and present the 20 most recent grouped by type.

If no learnings file exists, say: "No learnings recorded yet. Learnings are saved automatically when patterns are discovered."

### Search

Search learnings for a query string (case-insensitive match on key + insight):

```bash
grep -i "<query>" .agents/learnings/learnings.jsonl 2>/dev/null || echo "No matches."
```

### Add

To record a new learning, append to the file:

```bash
mkdir -p .agents/learnings
echo '{"ts":"'"$(date -u +%Y-%m-%dT%H:%M:%SZ)"'","type":"<type>","key":"<key>","insight":"<insight>","confidence":<N>,"source":"<source>"}' >> .agents/learnings/learnings.jsonl
```

Types: `pattern`, `pitfall`, `preference`, `architecture`, `tool`

### Prune

Read all learnings. For each:
1. If it references files in the `files` field, check if they still exist. Flag stale entries.
2. Look for entries with the same key but contradicting insights.

Present flagged entries and ask whether to remove or keep each one. To remove, use sed to delete the line from the JSONL file.

### Export

Read recent learnings and format as markdown:

```markdown
## Project Learnings

### Patterns
- **{key}**: {insight} (confidence: N/10)

### Pitfalls
- **{key}**: {insight} (confidence: N/10)

### Preferences
- **{key}**: {insight}

### Architecture
- **{key}**: {insight} (confidence: N/10)
```

### Stats

```bash
if [ -f .agents/learnings/learnings.jsonl ]; then
  echo "Total: $(wc -l < .agents/learnings/learnings.jsonl | tr -d ' ') entries"
  grep -o '"type":"[^"]*"' .agents/learnings/learnings.jsonl | sort | uniq -c | sort -rn
else
  echo "No learnings yet."
fi
```
