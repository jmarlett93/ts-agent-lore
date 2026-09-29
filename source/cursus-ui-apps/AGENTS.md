<!-- nx configuration start-->
<!-- Leave the start & end comments to automatically receive updates. -->

# General Guidelines for working with Nx

- When running tasks (for example build, lint, test, e2e, etc.), always prefer running the task through `nx` (i.e. `nx run`, `nx run-many`, `nx affected`) instead of using the underlying tooling directly
- You have access to the Nx MCP server and its tools, use them to help the user
- When answering questions about the repository, use the `nx_workspace` tool first to gain an understanding of the workspace architecture where applicable.
- When working in individual projects, use the `nx_project_details` mcp tool to analyze and understand the specific project structure and dependencies
- For questions around nx configuration, best practices or if you're unsure, use the `nx_docs` tool to get relevant, up-to-date docs. Always use this instead of assuming things about nx configuration
- If the user needs help with an Nx configuration or project graph error, use the `nx_workspace` tool to get any errors

<!-- nx configuration end-->

## Lore Flow

This workspace uses the [Lore Flow](https://github.com/jmarlett93/lore-flow) Cursor plugin for PRD-to-sequenced-PR delivery. The plugin is installed outside the repo (`$LORE_FLOW_HOME`, typically `~/tools/lore-flow`) and linked at `~/.cursor/plugins/local/lore-flow` — do not vendor a second copy of `skills/` here.

- Invoke: `/orchestrate-feature` or ask to run Lore Flow with preset `cursor.normal` (or `cursor.heavy`) against a PRD and base branch.
- Run state is written under `.lore-flow/runs/<run-id>/` (gitignored).
- Repository coding standards stay in `.cursor/rules/` and `.agents/skills/`; Lore Flow does not replace them.
