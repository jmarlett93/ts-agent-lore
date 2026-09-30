#!/usr/bin/env bash
set -euo pipefail

force=false
personal=false
with_lore_flow=true
target=

while (($#)); do
  case "$1" in
    --force) force=true ;;
    --personal) personal=true ;;
    --with-lore-flow) with_lore_flow=true ;;
    --without-lore-flow) with_lore_flow=false ;;
    -*) printf 'Unknown option: %s\n' "$1" >&2; exit 2 ;;
    *) [[ -z "$target" ]] || { printf 'Only one target path is allowed.\n' >&2; exit 2; }; target="$1" ;;
  esac
  shift
done

target="${target:-.}"
target="$(cd "$target" && pwd)"
repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copies each entry of $1 into $2, leaving existing entries alone unless --force.
copy_entries () {
  local src="$1" dest="$2" entry name
  mkdir -p "$dest"
  for entry in "$src"/*; do
    name="$(basename "$entry")"
    if [[ -e "$dest/$name" && "$force" != true ]]; then
      printf 'Skipped %s; it already exists (use --force to replace).\n' "$dest/$name" >&2
      continue
    fi
    rm -rf "$dest/$name"
    cp -a "$entry" "$dest/$name"
    printf '%s\n' "$name"
  done
}

# Appends a pattern to the clone's untracked exclude file once.
exclude_path () {
  local pattern="$1"
  grep -qxF "$pattern" "$exclude_file" 2>/dev/null || printf '%s\n' "$pattern" >> "$exclude_file"
}

if [[ "$personal" == true ]]; then
  git_dir="$(git -C "$target" rev-parse --path-format=absolute --git-common-dir 2>/dev/null)" || {
    printf '%s is not a Git repository; --personal needs one.\n' "$target" >&2
    exit 1
  }
  exclude_file="$git_dir/info/exclude"
  mkdir -p "$git_dir/info"

  copy_entries "$repo/.agents/skills" "$HOME/.claude/skills" > /dev/null
  printf 'Installed Claude skills in %s\n' "$HOME/.claude/skills"

  while IFS= read -r name; do
    exclude_path ".agents/skills/$name/"
  done < <(copy_entries "$repo/.agents/skills" "$target/.agents/skills")

  while IFS= read -r name; do
    exclude_path ".cursor/rules/$name"
  done < <(copy_entries "$repo/.cursor/rules" "$target/.cursor/rules")

  exclude_path '.lore-flow/'
  exclude_path 'product/'

  printf 'Installed personal agent lore in %s; its files are listed in %s\n' "$target" "$exclude_file"
else
  if [[ -e "$target/AGENTS.md" && "$force" != true ]]; then
    printf 'AGENTS.md already exists in %s; use --force to replace it.\n' "$target" >&2
    exit 1
  fi

  cp "$repo/AGENTS.md" "$target/AGENTS.md"
  mkdir -p "$target/.agents/skills"
  cp -a "$repo/.agents/skills/." "$target/.agents/skills/"
  mkdir -p "$target/.cursor/rules"
  cp -a "$repo/.cursor/rules/." "$target/.cursor/rules/"

  printf 'Installed agent lore in %s\n' "$target"
fi

if [[ "$with_lore_flow" == true ]]; then
  flow_home="${LORE_FLOW_HOME:-$HOME/tools/lore-flow}"
  flow_ref="82abc3a"
  flow_repo="https://github.com/jmarlett93/lore-flow.git"

  if [[ -e "$flow_home" ]]; then
    printf 'Lore Flow already exists at %s; leaving it unchanged.\n' "$flow_home"
  else
    mkdir -p "$(dirname "$flow_home")"
    git clone --depth 1 "$flow_repo" "$flow_home"
    git -C "$flow_home" fetch --depth 1 origin "$flow_ref"
    git -C "$flow_home" checkout --detach "$flow_ref"
  fi

  plugin_dir="$HOME/.cursor/plugins/local"
  plugin_link="$plugin_dir/lore-flow"
  mkdir -p "$plugin_dir"
  if [[ -e "$plugin_link" || -L "$plugin_link" ]]; then
    printf 'Cursor Lore Flow link already exists at %s; leaving it unchanged.\n' "$plugin_link"
  else
    ln -s "$flow_home" "$plugin_link"
    printf 'Linked Lore Flow into Cursor.\n'
  fi
fi
