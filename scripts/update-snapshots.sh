#!/usr/bin/env sh
set -eu
export LC_ALL=C

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp_dir=$(mktemp -d)
trap 'rm -rf -- "$tmp_dir"' EXIT HUP INT TERM

pacman -Qqen > "${tmp_dir}/pacman-native.raw"
pacman -Qqem > "${tmp_dir}/aur.raw"
pacman -Qqe > "${tmp_dir}/explicit-all.raw"

sort -u "${tmp_dir}/pacman-native.raw" > "${tmp_dir}/pacman-native.txt"
sort -u "${tmp_dir}/aur.raw" > "${tmp_dir}/aur.txt"
sort -u "${tmp_dir}/explicit-all.raw" > "${tmp_dir}/explicit-all.txt"

systemctl list-unit-files --state=enabled --no-legend --no-pager \
  > "${tmp_dir}/enabled-system-units.txt"
systemctl --user list-unit-files --state=enabled --no-legend --no-pager \
  > "${tmp_dir}/enabled-user-units.txt"

install -m 0644 "${tmp_dir}/pacman-native.txt" "${repo_dir}/packages/pacman-native.txt"
install -m 0644 "${tmp_dir}/aur.txt" "${repo_dir}/packages/aur.txt"
install -m 0644 "${tmp_dir}/explicit-all.txt" "${repo_dir}/packages/explicit-all.txt"
install -m 0644 "${tmp_dir}/enabled-system-units.txt" "${repo_dir}/system/enabled-system-units.txt"
install -m 0644 "${tmp_dir}/enabled-user-units.txt" "${repo_dir}/system/enabled-user-units.txt"

printf 'Package and systemd inventories refreshed.\n'
