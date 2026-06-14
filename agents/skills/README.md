# Skills

AI agent skills teach the agent how to do specific things — think of them as training modules. Each skill is a set of instructions that the agent loads when invoked.

## Installed Skills

Skills are cloned into `installed/`. See the individual skill collections below for what's available.

### obra/superpowers → `installed/superpowers/`

**Status:** Will install all

The most comprehensive skill collection. Every skill in here connects to others — they're designed as a system, not isolated tools. Key areas:

- **Sub-agent orchestration** — spawning parallel sub-agents for complex tasks
- **TDD practices** — test-first workflows with red-green-refactor
- **Code review** — self-critique and quality gates
- **Shell mastery** — effective use of terminal within agent context
- **Thinking/taste** — the inspiration for CommandCode's taste system
- **Prompt engineering** — meta-skills for improving agent behavior

Install: `git clone https://github.com/obra/superpowers.git installed/superpowers`

### mattpocock/skills → `installed/mattpocock/`

**Status:** Selected skills (handoff, caveman, grill-me)

TypeScript-heavy collection by Matt Pocock. The ones I actually use:

- **handoff** — clean handoff documentation between sessions
- **caveman** — simplify complex code to primitive structures
- **grill-me** — adversarial code review, finds edge cases

Others worth exploring when I have time:
- Code review rubrics
- TypeScript strict mode enforcement
- XState / state machine patterns
- API and library design principles

Install: `git clone https://github.com/mattpocock/skills.git installed/mattpocock`

### garrytan/gstack → `installed/gstack/`

**Status:** Not yet installed

Full-stack AI agent scaffolding with Google Cloud integration. Not installed yet because:
1. It pushes for global installation, but I prefer per-project skills
2. Setup is involved — needs understanding of the entire system first
3. Tool compatibility varies (CommandCode vs OpenCode vs Claude Code handle global skills differently)

May install globally later and symlink, or install per-project as needed.

Install: `git clone https://github.com/garrytan/gstack.git installed/gstack`

## Adding New Skills

```bash
cd .agents/skills/installed/
git clone <repo-url> <collection-name>
```

Then document it in this README. Skills are auto-discovered by the agent based on directory structure.
