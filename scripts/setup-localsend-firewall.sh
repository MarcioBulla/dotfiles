#!/usr/bin/env sh
set -eu

localsend_port="${LOCALSEND_PORT:-53317}"

if command -v ufw >/dev/null 2>&1; then
  sudo ufw allow "${localsend_port}/tcp" comment 'LocalSend'
  sudo ufw allow "${localsend_port}/udp" comment 'LocalSend'
  exit 0
fi

if command -v firewall-cmd >/dev/null 2>&1; then
  sudo firewall-cmd --permanent --add-port="${localsend_port}/tcp"
  sudo firewall-cmd --permanent --add-port="${localsend_port}/udp"
  sudo firewall-cmd --reload
  exit 0
fi

printf 'No supported firewall tool found. Open LocalSend port %s/tcp and %s/udp manually.\n' "$localsend_port" "$localsend_port" >&2
