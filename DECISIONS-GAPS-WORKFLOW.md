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
- New suggestion: add the Ponytail simplicity rule as a default review skill. It is included here as `.agents/skills/ponytail/SKILL.md`; use it to question YAGNI, reuse existing code, standard-library alternatives, dependency growth, and unnecessary abstractions.

# Workflow

1. Plan: inspect the repository instructions, architecture, callers, and constraints; write a short plan and identify the smallest affected surface.
2. Build: implement the smallest root-cause change, keeping side effects at boundaries and preserving accessibility, validation, and security requirements.
3. Review: inspect the diff and run the narrowest relevant checks. Apply Ponytail: delete unnecessary code, avoid speculative abstractions, and verify that the chosen solution is simpler without weakening correctness.
4. Repair: fix failures or review findings at their source, rerun the affected checks, and repeat steps 3–4 until the diff is clean.
