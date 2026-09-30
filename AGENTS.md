# Agent Lore

These are the default instructions for work in this repository and any repository where this lore is installed.

## Working style

- Use functional, declarative TypeScript and JavaScript.
- Isolate side effects at the edges of the system.
- Prefer the standard library, native platform features, and existing dependencies before adding code or dependencies.
- Reuse existing helpers and patterns after tracing the real flow.
- Keep diffs small, boring, and focused. Delete unnecessary code instead of adding abstractions.
- Fix shared root causes rather than patching only the reported caller.
- Match the repository's existing framework and architecture; do not introduce React or JSX/TSX.

## Frontend defaults

- Prefer latest Angular, Angular Material, and Tailwind.
- Use semantic HTML and accessible controls, labels, names, focus states, and keyboard behavior.
- Prefer standalone Angular components, signals, `inject()`, `OnPush`, and separate HTML templates.
- Prefer Angular control flow (`@if`, `@for`) over structural directives.
- Use Material components and tokens where they fit; use Tailwind for the remaining styling.

## Validation and safety

- Validate inputs at trust boundaries.
- Never read, print, commit, or expose secrets from `.env*`, credentials, secret, key, or certificate files.
- Preserve data and user changes; avoid destructive commands unless explicitly requested.
- Test public behavior and error paths. Non-trivial logic leaves one runnable check; trivial one-liners need no test.
- Run the narrowest relevant formatter, linter, type check, build, or test after changes.

## Planning and delivery

- For ambiguous or multi-step work, write a short plan before editing.
- Before implementation, identify the files and callers affected.
- After implementation, review the diff for scope, regressions, accessibility, and unnecessary complexity.
- If a deliberate simplification has a known ceiling, mark it with `ponytail:` and name the upgrade path.

## User preferences

The repository owner prefers concise, practical answers; functional declarative TypeScript/JavaScript; isolated side effects; latest Angular with Angular Material and Tailwind; accessible HTML; and no React.js or JSX/TSX.

## Skills

Load only the skill relevant to the current task. Skills live in `.agents/skills/` and are copied from the reusable skills found in `cursus-ui-apps`.

## Cursor rules

Portable, file-scoped conventions live in `.cursor/rules/`. Use the functional TypeScript, file naming, and module design rules where they fit; adapt them to the target repository's existing conventions.
