# Memory System

Three-layer memory that scales from detailed sessions to concise global context.

## Layers

```
daily/          → Per-session activity logs (detailed, high volume)
    └─weekly/   → Weekly summaries distilled from dailies (medium detail)
        └─MEMORY.md → Global accumulated memory (concise, long-lived)
```

## Daily Logs

File: `daily/YYYY-MM-DD.md`

Records everything that happened in a session. Agents write here during/after each session.

```markdown
# YYYY-MM-DD Session Log

## Activity
- What I worked on today
- Decisions made and why
- Files created/modified

## Discoveries
- Interesting things found in the codebase
- Patterns noticed
- Gotchas to remember

## Blockers
- What's pending or stuck
- Questions for tomorrow

## Next Steps
- What to do next session
```

## Weekly Summaries

File: `weekly/YYYY-Www.md`

Distilled from the week's daily logs. Focus on outcomes, patterns, and learning.

```markdown
# Week YYYY-Www Summary

## Key Outcomes
- Major accomplishments this week
- Features shipped, bugs fixed

## Patterns & Learning
- Recurring patterns across sessions
- What worked, what didn't
- Process improvements

## Project State
- Where things stand at end of week
- Tech debt accrued or resolved

## Next Week
- Priorities for next week
```

## Global Memory

File: `MEMORY.md`

This is the single source of truth. It accumulates project intelligence over time. Agents read this for context at session start. Keep it concise — if it grows beyond 500 lines, archive older entries.

Sections:
- **Project Overview** — what we're building, why
- **Architecture Decisions** — ADRs and design choices
- **Conventions** — naming, patterns, tool choices
- **Gotchas** — tricky parts of the codebase, workarounds
- **Current State** — what's in progress, what's next

## Usage

Agents should:
1. Read `MEMORY.md` on session start for global context
2. Read the latest weekly summary for recent history
3. Reference daily logs for specific details
4. Update `MEMORY.md` when significant learning or decisions happen
