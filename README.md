# dotfiles

My dotfiles for CachyOS/Arch.

I use this repository to make a fresh install feel like my own setup. The installer installs my package list, applies a few system tweaks, configures the SDDM theme, and links the tracked config files into their target locations.

I intentionally do not manage `gitconfig` in this repository.

## Where I keep this repository

The installer expects this repository to live at:

```sh
~/.dotfiles
```

To clone it into the expected location:

```sh
git clone https://github.com/MarcioBulla/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

If I want to run it from another path:

```sh
ALLOW_NONSTANDARD_DOTFILES=1 ./install.sh
```

## How I apply it

To apply everything:

```sh
./install.sh
```

The installer runs these steps in order:

1. `scripts/ensure-standard-location.sh`
   Checks that the repository is at `~/.dotfiles`, unless I use `ALLOW_NONSTANDARD_DOTFILES=1`.
2. `scripts/install-packages.sh`
   Installs packages from `packages/pacman-native.txt` with `pacman`, then installs AUR/foreign packages from `packages/aur.txt` with `paru` or `yay`.
3. `scripts/setup-bluetooth.sh`
   Unblocks Bluetooth when `rfkill` is available and enables `bluetooth.service`.
4. `scripts/setup-localsend-firewall.sh`
   Opens the LocalSend ports `53317/tcp` and `53317/udp` with `ufw` or `firewall-cmd`, when either one is available.
5. `scripts/install-sddm-theme.sh`
   Installs the SDDM theme and applies the SDDM config files.
6. `scripts/install-symlinks.sh`
   Backs up existing configs and creates symlinks from system paths to the files in this repository.

## Symlinks

The original files live in this repository. The system paths become symlinks that point to them:

```text
~/.zshrc             -> ~/.dotfiles/config/zshrc
~/.config/arkrc      -> ~/.dotfiles/config/arkrc
~/.config/btop       -> ~/.dotfiles/config/btop
~/.config/dolphinrc  -> ~/.dotfiles/config/dolphinrc
~/.config/fastfetch  -> ~/.dotfiles/config/fastfetch
~/.config/glow       -> ~/.dotfiles/config/glow
~/.config/gtk-3.0    -> ~/.dotfiles/config/gtk-3.0
~/.config/gtk-4.0    -> ~/.dotfiles/config/gtk-4.0
~/.config/kdeglobals -> ~/.dotfiles/config/kdeglobals
~/.config/kde.org    -> ~/.dotfiles/config/kde.org
~/.config/kitty      -> ~/.dotfiles/config/kitty
~/.config/marimo     -> ~/.dotfiles/config/marimo
~/.config/micro      -> ~/.dotfiles/config/micro
~/.config/mimeapps.list -> ~/.dotfiles/config/mimeapps.list
~/.config/nvtop      -> ~/.dotfiles/config/nvtop
~/.config/niri       -> ~/.dotfiles/config/niri
~/.config/noctalia   -> ~/.dotfiles/config/noctalia
~/.config/nvim       -> ~/.dotfiles/config/nvim
~/.config/nwg-look   -> ~/.dotfiles/config/nwg-look
~/.config/okularpartrc -> ~/.dotfiles/config/okularpartrc
~/.config/pavucontrol.ini -> ~/.dotfiles/config/pavucontrol.ini
~/.config/qt5ct      -> ~/.dotfiles/config/qt5ct
~/.config/qt6ct      -> ~/.dotfiles/config/qt6ct
~/.config/user-dirs.dirs -> ~/.dotfiles/config/user-dirs.dirs
~/.config/starship.toml -> ~/.dotfiles/config/starship.toml
~/.config/systemd    -> ~/.dotfiles/config/systemd
~/.config/voxtype    -> ~/.dotfiles/config/voxtype
~/.config/xdg-desktop-portal -> ~/.dotfiles/config/xdg-desktop-portal
~/.config/xsettingsd -> ~/.dotfiles/config/xsettingsd
~/.config/yazi       -> ~/.dotfiles/config/yazi
~/.config/zathura    -> ~/.dotfiles/config/zathura
~/.local/bin/sync-class -> ~/.dotfiles/local/bin/sync-class
~/.local/bin/sync-doctorado -> ~/.dotfiles/local/bin/sync-doctorado
~/.local/share/kio   -> ~/.dotfiles/local/share/kio
```

In this section, `->` means the system path is a symlink pointing to the path inside this repository. This applies to both `~/.config` entries and `~/.local/share` entries.

Noctalia installs and updates its own plugin payloads under
`~/.config/noctalia/plugins/`. That directory remains local and is intentionally
ignored by Git; only the Noctalia configuration that selects and configures the
plugins is versioned here.

Before replacing existing files, `scripts/install-symlinks.sh` creates:

```text
~/.dotfiles-backup/<timestamp>/old-configs.zip
~/.dotfiles-backup/<timestamp>/<original-path>
```

Git provides history for files already in this repository. This one-time backup protects live files that are still outside Git while they are converted to symlinks, so it complements commits rather than replacing them.

## Packages

My package lists:

```text
packages/pacman-native.txt   explicit packages from official repositories
packages/aur.txt             explicit AUR/foreign packages
packages/explicit-all.txt    all explicit packages, for reference
```

The installer does not use `packages/explicit-all.txt` directly; I keep it only as a reference.

Refresh the package and enabled-unit inventories from the current machine with:

```sh
./scripts/update-snapshots.sh
```

The script records native, AUR and explicitly installed packages, plus enabled
system and user systemd units. It builds every snapshot in a temporary directory
and only replaces the tracked files after all commands succeed. It does not
install or remove packages, create an archive, or make a Git commit; review the
result with `git diff` and commit it normally.

The `sync-class` helper keeps its Google Drive folder ID outside Git. Copy
`config/sync-class.env.example` to `~/.config/sync-class.env`, fill in the value,
and protect the private file with `chmod 600 ~/.config/sync-class.env`.

## System inventory

These files are references for enabled units on the current system:

```text
system/enabled-system-units.txt
system/enabled-user-units.txt
```

## SDDM

In the SDDM step, I install the `where_is_my_sddm_theme` theme from:

```sh
https://github.com/stepanzubkov/where-is-my-sddm-theme.git
```

This step copies these repository files into system paths. These are regular copies, not symlinks:

```text
sddm.conf       -> copy to -> /etc/sddm.conf
sddm-theme.conf -> copy to -> /usr/share/sddm/themes/where_is_my_sddm_theme/theme.conf
```

## Options

To skip package installation:

```sh
SKIP_PACKAGES=1 ./install.sh
```

To skip SDDM setup:

```sh
SKIP_SDDM=1 ./install.sh
```

To skip both:

```sh
SKIP_PACKAGES=1 SKIP_SDDM=1 ./install.sh
```

## Updating these dotfiles

When an AI assistant is asked to update these dotfiles, it should first read this README and inspect the current repository state.

The update should compare the live system files against the files tracked here, then copy intentional changes into the repository instead of blindly overwriting the system. Package lists should be refreshed when installed packages changed. Existing backups must be preserved, and any destructive action must be explained before it is taken.

After updating, the assistant should summarize what changed and mention any commands that still need to be run manually.

## Repository knowledge graph

The local Graphify index lives in `graphify-out/`. It is intentionally ignored by Git because it can contain absolute paths and personal information derived from the configuration files.

Build or refresh it locally with:

```sh
graphify .
graphify . --update
```

Future sessions can query the existing graph without rebuilding it:

```sh
graphify query "How are Niri and Noctalia connected?"
```
