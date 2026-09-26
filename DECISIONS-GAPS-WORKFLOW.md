# Decisions

- `AGENTS.md` is the primary portable instruction file. `Agents.md` is not a separate convention; use the uppercase filename.
- The legacy `.cursorrules` file was not present in `cursus-ui-apps`. Its current guidance came from `AGENTS.md`, `.cursor/rules/`, `.agents/skills/`, `skills-lock.json`, and the owner preferences.
- All 33 source skills are included because they are reusable, while the original Cursor rules are preserved under `source/` for reference.
- Project-specific rules were not installed by default because names such as `quaestor-ui-app` and `crss:` would impose the wrong assumptions on unrelated repositories.
- The installer copies the portable `AGENTS.md` and skills. It refuses to overwrite an existing `AGENTS.md` unless `--force` is supplied.

# Gaps

- There is no universal standard for merging a shared `AGENTS.md` with a repository's existing agent instructions; review the resulting file after installation.
- Source skills can become stale as their upstream repositories change. Refresh `source/cursus-ui-apps/skills-lock.json` and review copied skills periodically.
- The original project rules contain useful Angular, testing, API, security, and infrastructure patterns, but they are still coupled to the Cursus workspace. Promote a rule into the portable set only after proving it applies elsewhere.
- The installer does not yet support version pinning, remote updates, or conflict-aware merging of individual skills.
- Ponytail is now installed from the canonical MIT-licensed GitHub repository, including its main skill, five companion skills, and Cursor rule. Use it to question YAGNI, reuse existing code, standard-library alternatives, dependency growth, and unnecessary abstractions.
- The portable Cursor rules extract the reusable parts of Cursus conventions: functional collection transformations, pure functions, side-effect isolation, responsibility-based TypeScript suffixes, module boundaries, public exports, and behavior-focused tests. Cursus-specific framework and domain rules remain in `source/`.
- Angular, Hapi, and Drizzle rules now preserve the Cursus conventions nearly verbatim while removing only Cursus-specific paths, prefixes, and domain names.
- Universal Flow is installed at `/home/jmarlett/tools/universal-flow` from `jmarlett93/universal-flow`; its `cursor.simple` preset uses Claude Opus for orchestration, technical specs, Ponytail review, recovery, and reporting, with Cursor models for discovery and implementation.
- The workflow intentionally has one human approval gate: approve the Ponytail-reviewed technical-spec set before parallel implementation. Separate PR sequencing and per-PR approval are disabled for the simple preset.
- Universal Flow now creates a bounded, hashed guidance manifest per technical-spec packet. Builders receive that exact manifest and record guidance used or explicitly skipped in their build reports.
- Universal Flow is distributed as an optional pinned package from `packages/universal-flow`; `install.sh --with-universal-flow` installs the checkout and Cursor plugin link without changing the default lightweight install.

# Workflow

1. Spec: Opus reads the project requirements and runs only the necessary frontend, backend, and infrastructure discovery in parallel. It emits independent technical-spec packets with dependencies, ownership, acceptance checks, and the smallest viable implementation.
2. Spec review: Ponytail reviews the full spec set for YAGNI, scope drift, unnecessary abstractions, missing validation, and missing tests. Opus repairs rejected specs; obtain one human approval for the accepted version.
3. Parallel build/review: dispatch one Cursor implementation subagent per ready spec in its own worktree. Run Ponytail on each completed diff and repair only rejected units while accepted units continue.
4. Recovery: Opus reads persisted artifacts, Git state, checks, and reviews. Retry or repair only failed units; if a contract changes, invalidate and regenerate only dependent specs. Finish with a concise evidence-based report.
