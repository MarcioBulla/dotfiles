#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
backup_dir="${HOME}/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

backup_target() {
  target=$1

  if [ -L "$target" ]; then
    return 0
  fi

  if [ -e "$target" ]; then
    backup_path="${backup_dir}${target}"
    mkdir -p "$(dirname -- "$backup_path")"
    mv -- "$target" "$backup_path"
    printf 'backup: %s -> %s\n' "$target" "$backup_path"
  fi
}

link_path() {
  source=$1
  target=$2

  mkdir -p "$(dirname -- "$target")"
  backup_target "$target"
  ln -sfn -- "$source" "$target"
  printf 'link: %s -> %s\n' "$target" "$source"
}

link_path "${repo_dir}/config/zshrc" "${HOME}/.zshrc"
link_path "${repo_dir}/gitconfig" "${HOME}/.gitconfig"

mkdir -p "${HOME}/.config"
for source in "${repo_dir}"/config/*; do
  [ -e "$source" ] || continue
  name=$(basename -- "$source")
  link_path "$source" "${HOME}/.config/${name}"
done

if [ -d "${repo_dir}/local/share" ]; then
  find "${repo_dir}/local/share" -type f | while IFS= read -r source; do
    relative_path=${source#"${repo_dir}/local/share/"}
    link_path "$source" "${HOME}/.local/share/${relative_path}"
  done
fi
