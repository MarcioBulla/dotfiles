#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
pacman_packages="${repo_dir}/packages/pacman-native.txt"
aur_packages="${repo_dir}/packages/aur.txt"

if [ -s "$pacman_packages" ]; then
  sudo pacman -S --needed - < "$pacman_packages"
fi

if [ -s "$aur_packages" ]; then
  if command -v paru >/dev/null 2>&1; then
    paru -S --needed - < "$aur_packages"
  elif command -v yay >/dev/null 2>&1; then
    yay -S --needed - < "$aur_packages"
  else
    printf 'No AUR helper found; install paru or yay, then run:\n' >&2
    printf '  paru -S --needed - < %s\n' "$aur_packages" >&2
    exit 1
  fi
fi
