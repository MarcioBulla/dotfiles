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

link_tree() {
  tree_source=$1
  tree_target=$2

  find "$tree_source" -mindepth 1 -type d -print | while IFS= read -r source; do
    relative=${source#"${tree_source}/"}
    mkdir -p "$tree_target/$relative"
  done
  find "$tree_source" -mindepth 1 \( -type f -o -type l \) -print | while IFS= read -r source; do
    relative=${source#"${tree_source}/"}
    link_path "$source" "$tree_target/$relative"
  done
}

setup_split_config() {
  split_source=$1
  split_target=$2
  shift 2

  migration_dir=$(mktemp -d "${HOME}/.config/.dotfiles-generated.XXXXXX")
  target_was_repo_link=false

  if [ -L "$split_target" ]; then
    source_real=$(readlink -f -- "$split_source")
    target_real=$(readlink -f -- "$split_target")
    if [ "$source_real" != "$target_real" ]; then
      printf 'refusing to replace unrelated config symlink: %s -> %s\n' \
        "$split_target" "$target_real" >&2
      exit 1
    fi
    target_was_repo_link=true
  else
    mkdir -p "$split_target"
  fi

  for relative in "$@"; do
    source_path="$split_source/$relative"
    target_path="$split_target/$relative"

    if [ -e "$source_path" ] || [ -L "$source_path" ]; then
      if [ "$target_was_repo_link" = false ] && { [ -e "$target_path" ] || [ -L "$target_path" ]; }; then
        if [ -L "$target_path" ] && [ "$(readlink -f -- "$target_path")" = "$(readlink -f -- "$source_path")" ]; then
          unlink -- "$target_path"
        else
          printf 'refusing to overwrite local generated path: %s\n' "$target_path" >&2
          exit 1
        fi
      fi
      mkdir -p "$migration_dir/$(dirname -- "$relative")"
      mv -- "$source_path" "$migration_dir/$relative"
    elif [ "$target_was_repo_link" = false ] && [ -L "$target_path" ]; then
      if [ "$(readlink -- "$target_path")" = "$source_path" ]; then
        unlink -- "$target_path"
      fi
    fi
  done

  if [ "$target_was_repo_link" = true ]; then
    unlink -- "$split_target"
    mkdir -p "$split_target"
  fi

  for relative in "$@"; do
    if [ -e "$migration_dir/$relative" ] || [ -L "$migration_dir/$relative" ]; then
      mkdir -p "$split_target/$(dirname -- "$relative")"
      mv -- "$migration_dir/$relative" "$split_target/$relative"
    fi
  done
  rm -rf -- "$migration_dir"

  link_tree "$split_source" "$split_target"
}

keep_generated_file_local() {
  generated_source=$1
  generated_target=$2

  if [ -L "$generated_target" ]; then
    migration_dir=$(mktemp -d "${HOME}/.config/.dotfiles-generated-file.XXXXXX")
    if [ -e "$generated_source" ] || [ -L "$generated_source" ]; then
      mv -- "$generated_source" "$migration_dir/value"
    fi
    unlink -- "$generated_target"
    if [ -e "$migration_dir/value" ] || [ -L "$migration_dir/value" ]; then
      mv -- "$migration_dir/value" "$generated_target"
    else
      : > "$generated_target"
    fi
    rmdir -- "$migration_dir"
  elif [ -e "$generated_source" ] || [ -L "$generated_source" ]; then
    if [ -e "$generated_target" ] || [ -L "$generated_target" ]; then
      printf 'refusing to overwrite local generated file: %s\n' "$generated_target" >&2
      exit 1
    fi
    mkdir -p "$(dirname -- "$generated_target")"
    mv -- "$generated_source" "$generated_target"
  fi
}

seed_local_file() {
  seed_source=$1
  seed_target=$2

  if [ ! -e "$seed_target" ] && [ ! -L "$seed_target" ]; then
    mkdir -p "$(dirname -- "$seed_target")"
    cp -- "$seed_source" "$seed_target"
    printf 'seed: %s <- %s\n' "$seed_target" "$seed_source"
  fi
}

link_path "${repo_dir}/config/zshrc" "${HOME}/.zshrc"

mkdir -p "${HOME}/.config"
for source in "${repo_dir}"/config/*; do
  [ -e "$source" ] || [ -L "$source" ] || continue
  name=$(basename -- "$source")
  case "$name" in
    zshrc|noctalia|niri|btop|kitty|zathura|gtk-3.0|gtk-4.0|qt5ct|qt6ct|kdeglobals|starship.toml|starship.base.toml)
      continue
      ;;
  esac
  link_path "$source" "${HOME}/.config/${name}"
done

setup_split_config "${repo_dir}/config/noctalia" "${HOME}/.config/noctalia" \
  colors.json colorschemes
setup_split_config "${repo_dir}/config/niri" "${HOME}/.config/niri" noctalia.kdl
setup_split_config "${repo_dir}/config/btop" "${HOME}/.config/btop" themes/noctalia.theme
setup_split_config "${repo_dir}/config/kitty" "${HOME}/.config/kitty" \
  current-theme.conf themes/noctalia.conf
setup_split_config "${repo_dir}/config/zathura" "${HOME}/.config/zathura" noctaliarc
setup_split_config "${repo_dir}/config/gtk-3.0" "${HOME}/.config/gtk-3.0" noctalia.css
setup_split_config "${repo_dir}/config/gtk-4.0" "${HOME}/.config/gtk-4.0" noctalia.css
setup_split_config "${repo_dir}/config/qt5ct" "${HOME}/.config/qt5ct" colors/noctalia.conf
setup_split_config "${repo_dir}/config/qt6ct" "${HOME}/.config/qt6ct" colors/noctalia.conf
keep_generated_file_local "${repo_dir}/config/kdeglobals" "${HOME}/.config/kdeglobals"
keep_generated_file_local "${repo_dir}/config/starship.toml" "${HOME}/.config/starship.toml"
seed_local_file "${repo_dir}/config/starship.base.toml" "${HOME}/.config/starship.toml"

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
