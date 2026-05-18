#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
expected_repo_dir="${HOME}/.dotfiles"

if [ "$repo_dir" != "$expected_repo_dir" ] && [ "${ALLOW_NONSTANDARD_DOTFILES:-0}" != "1" ]; then
  printf 'This repo should live at %s to keep symlinks correct.\n' "$expected_repo_dir" >&2
  printf 'Clone or move the repo to that path and run the installer again.\n' >&2
  printf 'To force another path: ALLOW_NONSTANDARD_DOTFILES=1 ./install.sh\n' >&2
  exit 1
fi
