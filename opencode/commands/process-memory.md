---
description: Compact agent memory logs into durable memory and prune stale handoff notes.
agent: build
subtask: false
---

Process the agent memory system for this repo. Read AGENTS.md, .agents/rules/RULES.md, .agents/MEMORY.md, .agents/ONGOING.md, .agents/FUTURE.md, and the daily/weekly logs under .agents/memory/. 
Promote only durable repo-wide facts into .agents/MEMORY.md, keep only live streams in .agents/ONGOING.md, keep deferred ideas in .agents/FUTURE.md, and leave raw daily/weekly logs as history unless I explicitly ask to rewrite or delete them. 
Remove stale migration/maintenance phrasing and duplicate or completed items from the core memory files. Do not change runtime code. Verify with code-review-graph on the changed docs and summarize what was promoted, pruned, and left as raw history.