#!/usr/bin/env sh
set -eu

if command -v rfkill >/dev/null 2>&1; then
  sudo rfkill unblock bluetooth
fi

sudo systemctl enable --now bluetooth.service
