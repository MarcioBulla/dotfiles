#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

install -Dm644 \
  "$repo_root/system/wayland-sessions/plasma-bigscreen-wayland.desktop" \
  /usr/local/share/wayland-sessions/plasma-bigscreen-wayland.desktop
install -Dm644 \
  "$repo_root/system/wayland-sessions/plasma.desktop" \
  /usr/local/share/wayland-sessions/plasma.desktop
install -Dm644 \
  "$repo_root/system/systemd/decky-bigscreen.service" \
  /etc/systemd/system/decky-bigscreen.service
install -Dm644 \
  "$repo_root/system/polkit-1/rules.d/49-decky-bigscreen.rules" \
  /etc/polkit-1/rules.d/49-decky-bigscreen.rules

systemctl daemon-reload
