import type { Plugin } from "@opencode-ai/plugin"
import { tool } from "@opencode-ai/plugin"

export default (async ({ client }) => {
  return {
    tool: {
      spawn: tool({
        description:
          "Spawn a subagent with a specific provider and model to run a task. " +
          "Use this when you need a different model than the current one. " +
          "The subagent runs independently and returns its result.",
        args: {
          providerId: tool.schema
            .string()
            .describe(
              "Provider ID (e.g. 'commandcode', 'openai', 'github-copilot', 'opencode')"
            ),
          modelId: tool.schema
            .string()
            .describe(
              "Model ID (e.g. 'gpt-5.5', 'claude-sonnet-4-6', 'deepseek-v4-pro')"
            ),
          prompt: tool.schema
            .string()
            .describe("The task for the subagent to complete"),
        },
        async execute(args) {
          try {
            const session = await client.session.create({
              body: { title: `spawn: ${args.modelId}` },
            })

            const result = await client.session.prompt({
              path: { id: session.data.id },
              body: {
                model: {
                  providerID: args.providerId,
                  modelID: args.modelId,
                },
                parts: [{ type: "text", text: args.prompt }],
              },
            })

            const parts = result.data.parts ?? []
            const text = parts
              .filter((p: any) => p.type === "text")
              .map((p: any) => p.text)
              .join("\n")

            return text || "(subagent returned no output)"
          } catch (err: any) {
            return `spawn failed: ${err.message}`
          }
        },
      }),
    },
  }
}) satisfies Plugin
