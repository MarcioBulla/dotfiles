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
~/.config/nvim       -> ~/.dotfiles/config/nvim
~/.config/kitty      -> ~/.dotfiles/config/kitty
~/.config/niri       -> ~/.dotfiles/config/niri
~/.local/share/kio   -> ~/.dotfiles/local/share/kio
```

In this section, `->` means the system path is a symlink pointing to the path inside this repository. This applies to both `~/.config` entries and `~/.local/share` entries.

Before replacing existing files, `scripts/install-symlinks.sh` creates:

```text
~/.dotfiles-backup/<timestamp>/old-configs.zip
~/.dotfiles-backup/<timestamp>/<original-path>
```

## Packages

My package lists:

```text
packages/pacman-native.txt   explicit packages from official repositories
packages/aur.txt             explicit AUR/foreign packages
packages/explicit-all.txt    all explicit packages, for reference
```

The installer does not use `packages/explicit-all.txt` directly; I keep it only as a reference.

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
