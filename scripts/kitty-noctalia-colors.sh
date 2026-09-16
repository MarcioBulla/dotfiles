#!/usr/bin/env bash
# Update every Kitty instance without reloading fonts or other configuration.
set -euo pipefail

theme_file="${1:-$HOME/.config/kitty/themes/noctalia.conf}"
: "${XDG_RUNTIME_DIR:?XDG_RUNTIME_DIR is required to locate Kitty sockets}"

if [[ ! -r "$theme_file" ]]; then
    printf 'Kitty theme is not readable: %s\n' "$theme_file" >&2
    exit 1
fi

shopt -s nullglob
result=0
for socket_path in "$XDG_RUNTIME_DIR"/kitty-noctalia-*; do
    [[ -S "$socket_path" ]] || continue
    if ! kitten @ --to "unix:$socket_path" --use-password never \
        set-colors --all --configured "$theme_file"; then
        printf 'Failed to update Kitty colors: %s\n' "$socket_path" >&2
        result=1
    fi
done
exit "$result"
