# No mutations

Prefer immutable data. Use `const`, avoid `push`/`splice` in favor of spread/concat, use readonly types in TypeScript.

If mutation is truly necessary, isolate it and document why.
