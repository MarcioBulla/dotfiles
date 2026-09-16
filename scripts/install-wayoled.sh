#!/usr/bin/env sh
set -eu
repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
revision=2fde47fa51fa28ff4b0aa0aa1bc3983f28d7e0f0
build_root=$(mktemp -d)
trap 'rm -rf -- "$build_root"' EXIT HUP INT TERM
for tool in git meson ninja cc pkg-config; do
  command -v "$tool" >/dev/null || { printf 'Missing build dependency: %s\n' "$tool" >&2; exit 1; }
done
pkg-config --exists wayland-client wayland-protocols wayland-scanner
git init -q "$build_root/source"
git -C "$build_root/source" fetch -q --depth 1 https://github.com/Youwes09/WayOLED.git "$revision"
git -C "$build_root/source" checkout -q --detach FETCH_HEAD
git -C "$build_root/source" apply "$repo_dir/patches/wayoled/niri-bar.patch"
meson setup "$build_root/build" "$build_root/source" --buildtype=release -Dinstall-systemd-unit=false
ninja -C "$build_root/build" src/wayoled oledctl/oledctl
install -d "$HOME/.local/lib/wayoled"
install -m 0755 "$build_root/build/src/wayoled" "$HOME/.local/lib/wayoled/wayoled"
install -m 0755 "$build_root/build/oledctl/oledctl" "$HOME/.local/lib/wayoled/oledctl"
printf 'WayOLED %s installed in ~/.local/lib/wayoled.\n' "$revision"
