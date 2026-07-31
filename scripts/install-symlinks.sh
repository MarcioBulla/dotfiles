#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
backup_dir="${HOME}/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
backup_zip="${backup_dir}/old-configs.zip"

zip_backup_target() {
  target=$1

  if ! command -v zip >/dev/null 2>&1; then
    printf 'zip was not found; unable to create config backup archive.\n' >&2
    exit 1
  fi

  mkdir -p "$backup_dir"
  (cd / && zip -qry "$backup_zip" "${target#/}")
  printf 'zip-backup: %s -> %s\n' "$target" "$backup_zip"
}

backup_target() {
  target=$1

  if [ -L "$target" ]; then
    return 0
  fi

  if [ -e "$target" ]; then
    zip_backup_target "$target"
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
  ln -sfnT -- "$source" "$target"
  printf 'link: %s -> %s\n' "$target" "$source"
}

link_path "${repo_dir}/config/zshrc" "${HOME}/.zshrc"

mkdir -p "${HOME}/.config"
for source in "${repo_dir}"/config/*; do
  [ -e "$source" ] || [ -L "$source" ] || continue
  name=$(basename -- "$source")
  [ "$name" != "zshrc" ] || continue
  link_path "$source" "${HOME}/.config/${name}"
done

if [ -d "${repo_dir}/local/share" ]; then
  mkdir -p "${HOME}/.local/share"
  for source in "${repo_dir}"/local/share/*; do
    [ -e "$source" ] || [ -L "$source" ] || continue
    name=$(basename -- "$source")
    link_path "$source" "${HOME}/.local/share/${name}"
  done
fi

if [ -d "${repo_dir}/local/bin" ]; then
  mkdir -p "${HOME}/.local/bin"
  for source in "${repo_dir}"/local/bin/*; do
    [ -e "$source" ] || [ -L "$source" ] || continue
    name=$(basename -- "$source")
    link_path "$source" "${HOME}/.local/bin/${name}"
  done
fi
