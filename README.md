# ts-agent-lore

Portable agent instructions, skills, and preferences extracted from `cursus-ui-apps`.

## Install

From this repository:

```bash
./install.sh /path/to/another/repo
```

The installer adds `AGENTS.md`, `.agents/skills/`, `.cursor/rules/`, and the
Universal Flow orchestration package by default. It will not overwrite an existing
`AGENTS.md` unless explicitly forced:

```bash
./install.sh --force /path/to/another/repo
```

Skip Universal Flow when only repository guidance is needed:

```bash
./install.sh --without-universal-flow /path/to/another/repo
```

Review the installed instructions and remove any skill that does not fit the target repository.

## Where installation applies

Install `AGENTS.md`, `.cursor/rules/`, and `.agents/skills/` inside each target
repository. This makes the guidance part of the repository context and keeps it
versioned with the code.

Universal Flow itself is installed globally at `$UNIVERSAL_FLOW_HOME` or
`$HOME/tools/universal-flow` and linked into Cursor's local plugin directory. It is
orchestration tooling, so it does not need to be copied into every repository.

## Contents

- `AGENTS.md` — portable default instructions and preferences.
- `.agents/skills/` — reusable skills from `cursus-ui-apps`, plus the canonical Ponytail skill suite from [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail).
- `.cursor/rules/` — portable Cursor rules for Ponytail, functional TypeScript, file naming, module design, Angular, Hapi, and Drizzle.
- `packages/universal-flow/` — pinned installation metadata for the Universal Flow orchestration plugin.
- `DECISIONS-GAPS-WORKFLOW.md` — decisions, known gaps, and the rerunnable plan/build/review/repair workflow.
- `source/` — preserved Cursus-specific `AGENTS.md`, Cursor rules, and skill lock metadata.

This is intentionally a plain Git repository with no runtime dependency.
