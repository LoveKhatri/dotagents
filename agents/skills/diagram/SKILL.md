---
name: diagram
description: Turn an English description into a mermaid diagram with source file, SVG, and PNG outputs. Use when asked to make a diagram, draw architecture, create a flowchart, or visualize a flow.
triggers:
  - make a diagram
  - draw a diagram
  - create a flowchart
  - diagram this
  - visualize this flow
  - architecture diagram
---

# Diagram Generator

Generate diagrams from English descriptions using Mermaid syntax. Every run produces:
- `<slug>.mmd` — the mermaid source (editable, version-controllable)
- `<slug>.svg` — vector output for docs
- `<slug>.png` — raster output for chat/issues/READMEs

## Step 1 — Detect mermaid CLI

```bash
which mmdc >/dev/null 2>&1 && echo "MMDC_READY" || echo "MMDC_MISSING"
```

If `MMDC_MISSING`: `npm install -g @mermaid-js/mermaid-cli` is needed for SVG/PNG output. Without it, still write the `.mmd` source file (GitHub renders mermaid natively in markdown).

## Step 2 — Author the diagram

Write mermaid from the user's request:

- **`graph LR`** for pipelines/flows (left to right)
- **`graph TD`** for hierarchies (top to bottom)
- **`sequenceDiagram`** for API/auth flows
- **`flowchart`** for complex branching

Rules:
- 5-15 nodes is the readable range. Split into multiple diagrams if the ask is larger.
- Keep node labels short; use edge labels for detail.
- Choose output directory: `./diagrams/` in a git repo, else `/tmp/diagrams/`.
- Derive `<slug>` from the subject (kebab-case, ≤40 chars).

## Step 3 — Write and render

1. Write `<outdir>/<slug>.mmd` using the Write tool.
2. If `mmdc` is available, render:

```bash
mmdc -i <outdir>/<slug>.mmd -o <outdir>/<slug>.svg
mmdc -i <outdir>/<slug>.mmd -o <outdir>/<slug>.png -w 1950 -s 2
```

## Step 4 — Deliver

1. Read the PNG with the Read tool to show the diagram inline.
2. List the output files.
3. If the user wants changes, edit the `.mmd` source and re-render.

## Completion

- **DONE** — source + renders delivered.
- **DONE_WITH_CONCERNS** — `.mmd` written but mmdc unavailable (GitHub still renders mermaid).
