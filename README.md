# ts-agent-lore

Portable agent instructions, skills, and preferences extracted from `cursus-ui-apps`.

## Install

From this repository:

```bash
./install.sh /path/to/another/repo
```

The installer adds `AGENTS.md` and `.agents/skills/`. It will not overwrite an existing `AGENTS.md` unless explicitly forced:

```bash
./install.sh --force /path/to/another/repo
```

Review the installed instructions and remove any skill that does not fit the target repository.

## Contents

- `AGENTS.md` — portable default instructions and preferences.
- `.agents/skills/` — reusable skills from `cursus-ui-apps`, plus the proposed Ponytail skill.
- `DECISIONS-GAPS-WORKFLOW.md` — decisions, known gaps, and the rerunnable plan/build/review/repair workflow.
- `source/` — preserved Cursus-specific `AGENTS.md`, Cursor rules, and skill lock metadata.

This is intentionally a plain Git repository with no runtime dependency.
