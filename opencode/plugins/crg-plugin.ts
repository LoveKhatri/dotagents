import type { Plugin } from "@opencode-ai/plugin"

/**
 * code-review-graph plugin for OpenCode.
 *
 * Keeps the knowledge graph up-to-date and surfaces status
 * information automatically during coding sessions.
 *
 * Installed by: code-review-graph install --platform opencode
 */

export const CodeReviewGraphPlugin: Plugin = async ({ $ }) => {
  return {
    event: async ({ event }) => {
      if (event.type === "file.edited") {
        try {
          await $`code-review-graph update --skip-flows`.quiet()
        } catch {
          // Swallow — graph may not be built yet for this project.
        }
      } else if (event.type === "session.created") {
        try {
          const result = await $`code-review-graph status`.quiet()
          const output = result.stdout?.toString().trim()
          if (output) {
            console.log("[code-review-graph]", output)
          }
        } catch {
          // Swallow — not every project has a graph.
        }
      }
    },
    "tool.execute.before": async (input, output) => {
      if (input.tool !== "bash") return
      const cmd = output?.args?.command ?? ""
      if (typeof cmd === "string" && /^git\s+commit/i.test(cmd)) {
        try {
          const result = await $`code-review-graph detect-changes --brief`.quiet()
          const out = result.stdout?.toString().trim()
          if (out) {
            console.log("[code-review-graph] Pre-commit analysis:\n" + out)
          }
        } catch {
          // Swallow — never block a commit.
        }
      }
    },
  }
}
