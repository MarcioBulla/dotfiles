#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

"${repo_dir}/scripts/ensure-standard-location.sh"

if [ "${SKIP_PACKAGES:-0}" != "1" ]; then
  "${repo_dir}/scripts/install-packages.sh"
fi

"${repo_dir}/scripts/setup-bluetooth.sh"
"${repo_dir}/scripts/setup-localsend-firewall.sh"

if [ "${SKIP_SDDM:-0}" != "1" ]; then
  "${repo_dir}/scripts/install-sddm-theme.sh"
fi

"${repo_dir}/scripts/install-symlinks.sh"
