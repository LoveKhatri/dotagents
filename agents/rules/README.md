# Rules

Domain-specific constraints that shape agent behavior. Organized into semantic folders so agents load only what's relevant to the current task.

## How It Works

When an agent works on a task, it should load rules from the relevant folder(s):
- Editing a `.ts` file → load `typescript/`
- Writing tests → load `testing/`
- Designing a feature → load `architecture/`
- Making a commit → load `git/` + `code-quality/`

Files are named descriptively so what each rule does is obvious from the name.

## Folder Map

| Folder | Load when... |
|--------|-------------|
| `typescript/` | Working with TS/TSX files |
| `testing/` | Writing or modifying tests |
| `architecture/` | Designing features, refactoring, system-level changes |
| `workflow/` | CI/CD, task management, development process |
| `code-quality/` | Reviews, lint formatting, general code standards |
| `git/` | Commits, branching, PR workflows |
| `debugging/` | Investigating bugs, error tracing |
| `documentation/` | Writing docs, READMEs, code comments |
| `security/` | Auth, validation, secrets, threat models |

## Adding Rules

1. Identify which domain folder fits
2. Create `domain/descriptive-name.md`
3. Write the rule in clear, imperative language
4. Keep rules atomic — one concern per file

Rule files should be short. If a rule is longer than ~30 lines, it's probably multiple rules.
