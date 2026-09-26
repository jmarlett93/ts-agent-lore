#!/usr/bin/env bash
set -euo pipefail

force=false
if [[ "${1:-}" == "--force" ]]; then
  force=true
  shift
fi

target="${1:-.}"
target="$(cd "$target" && pwd)"
repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -e "$target/AGENTS.md" && "$force" != true ]]; then
  printf 'AGENTS.md already exists in %s; use --force to replace it.\n' "$target" >&2
  exit 1
fi

cp "$repo/AGENTS.md" "$target/AGENTS.md"
mkdir -p "$target/.agents/skills"
cp -a "$repo/.agents/skills/." "$target/.agents/skills/"

printf 'Installed agent lore in %s\n' "$target"
