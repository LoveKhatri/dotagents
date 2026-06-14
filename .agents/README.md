# .agents

This directory is the brain of the AI-assisted project. Everything the agent needs to be context-aware and effective lives here.

## How It Works

1. **Skills** teach the agent new capabilities (how to do things)
2. **Rules** constrain the agent's behavior (what to do / not do)
3. **Memory** gives the agent long-term context (what's happened)
4. **Plugins** extend the agent with tools and integrations

## Agent Integration

Different tools discover these differently:

| Tool | Skills | Rules | Memory |
|------|--------|-------|--------|
| Claude Code | `/skill-name` in `.agents/skills/` | Reads `.agents/rules/*.md` when task matches | Reads `MEMORY.md` on session start |
| CommandCode | Skills in `~/.agents/skills/` or local `.agents/skills/` | Project-level rules auto-loaded | Taste system in `.commandcode/taste/` |
| OpenCode | Config-based skill paths | `.cursor/rules/` or `.agents/rules/` | No built-in memory — use `MEMORY.md` |

Check your specific tool's docs for the exact discovery mechanism. The structure here is designed to work with all of them with minimal adaptation.
