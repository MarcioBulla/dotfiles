#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
theme_name="where_is_my_sddm_theme"
theme_repo="https://github.com/stepanzubkov/where-is-my-sddm-theme.git"
theme_dir="/usr/share/sddm/themes/${theme_name}"

if ! command -v git >/dev/null 2>&1; then
  printf 'git was not found; unable to clone the SDDM theme.\n' >&2
  exit 1
fi

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT INT HUP TERM

git clone --depth 1 "$theme_repo" "${tmp_dir}/${theme_name}"

sudo mkdir -p "$(dirname -- "$theme_dir")"
sudo rm -rf "$theme_dir"
sudo cp -a "${tmp_dir}/${theme_name}" "$theme_dir"

sudo install -Dm644 "${repo_dir}/sddm.conf" /etc/sddm.conf
sudo install -Dm644 "${repo_dir}/sddm-theme.conf" "${theme_dir}/theme.conf"

printf 'SDDM theme installed at %s\n' "$theme_dir"
