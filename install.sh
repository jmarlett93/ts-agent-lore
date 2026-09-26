#!/usr/bin/env bash
set -euo pipefail

force=false
with_universal_flow=true
target=

while (($#)); do
  case "$1" in
    --force) force=true ;;
    --with-universal-flow) with_universal_flow=true ;;
    --without-universal-flow) with_universal_flow=false ;;
    -*) printf 'Unknown option: %s\n' "$1" >&2; exit 2 ;;
    *) [[ -z "$target" ]] || { printf 'Only one target path is allowed.\n' >&2; exit 2; }; target="$1" ;;
  esac
  shift
done

target="${target:-.}"
target="$(cd "$target" && pwd)"
repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

if [[ "$with_universal_flow" == true ]]; then
  flow_home="${UNIVERSAL_FLOW_HOME:-$HOME/tools/universal-flow}"
  flow_ref="c3e37bd"
  flow_repo="https://github.com/jmarlett93/universal-flow.git"

  if [[ -e "$flow_home" ]]; then
    printf 'Universal Flow already exists at %s; leaving it unchanged.\n' "$flow_home"
  else
    mkdir -p "$(dirname "$flow_home")"
    git clone --depth 1 "$flow_repo" "$flow_home"
    git -C "$flow_home" fetch --depth 1 origin "$flow_ref"
    git -C "$flow_home" checkout --detach "$flow_ref"
  fi

  plugin_dir="$HOME/.cursor/plugins/local"
  plugin_link="$plugin_dir/universal-flow"
  mkdir -p "$plugin_dir"
  if [[ -e "$plugin_link" || -L "$plugin_link" ]]; then
    printf 'Cursor Universal Flow link already exists at %s; leaving it unchanged.\n' "$plugin_link"
  else
    ln -s "$flow_home" "$plugin_link"
    printf 'Linked Universal Flow into Cursor.\n'
  fi
fi
