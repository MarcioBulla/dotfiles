# dotfiles

Dotfiles for my CachyOS/Arch setup.

The purpose of this repository is to apply this dotfile set to a system. It installs the saved package list, applies system helpers, installs the SDDM theme, and then links the tracked config files into their target locations.

`gitconfig` is intentionally not managed here.

## Location

The installer expects this repository at:

```sh
~/.dotfiles
```

Clone it there:

```sh
git clone https://github.com/<your-github-user>/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

To run from another path:

```sh
ALLOW_NONSTANDARD_DOTFILES=1 ./install.sh
```

## Apply

Run:

```sh
./install.sh
```

The installer runs these steps in order:

1. `scripts/ensure-standard-location.sh`
   Checks that the repo is located at `~/.dotfiles`, unless `ALLOW_NONSTANDARD_DOTFILES=1` is set.
2. `scripts/install-packages.sh`
   Installs packages from `packages/pacman-native.txt` with `pacman`, then installs AUR/foreign packages from `packages/aur.txt` with `paru` or `yay`.
3. `scripts/setup-bluetooth.sh`
   Unblocks Bluetooth when `rfkill` is available and enables `bluetooth.service`.
4. `scripts/setup-localsend-firewall.sh`
   Opens LocalSend port `53317/tcp` and `53317/udp` with `ufw` or `firewall-cmd`, when available.
5. `scripts/install-sddm-theme.sh`
   Installs the SDDM theme and applies the SDDM config files.
6. `scripts/install-symlinks.sh`
   Backs up existing target configs and creates symlinks from the system config locations to this repo.

## Symlinks

The original files live in this repository. The system paths become symlinks to them:

```text
~/.zshrc             -> ~/.dotfiles/config/zshrc
~/.config/nvim       -> ~/.dotfiles/config/nvim
~/.config/kitty      -> ~/.dotfiles/config/kitty
~/.config/niri       -> ~/.dotfiles/config/niri
~/.local/share/kio   -> ~/.dotfiles/local/share/kio
```

In this section, `->` means the system path is a symlink pointing to the repo path. This applies to both `~/.config` entries and `~/.local/share` entries.

Before replacing existing target files, `scripts/install-symlinks.sh` creates:

```text
~/.dotfiles-backup/<timestamp>/old-configs.zip
~/.dotfiles-backup/<timestamp>/<original-path>
```

## Packages

Package lists:

```text
packages/pacman-native.txt   explicit packages from official repositories
packages/aur.txt             explicit AUR/foreign packages
packages/explicit-all.txt    all explicit packages, for reference
```

`packages/explicit-all.txt` is not installed directly by the installer.

## SDDM

The SDDM step installs `where_is_my_sddm_theme` from:

```sh
https://github.com/stepanzubkov/where-is-my-sddm-theme.git
```

It copies these repo files into system locations. These are regular file copies, not symlinks:

```text
sddm.conf       -> copy to -> /etc/sddm.conf
sddm-theme.conf -> copy to -> /usr/share/sddm/themes/where_is_my_sddm_theme/theme.conf
```

## Options

Skip package installation:

```sh
SKIP_PACKAGES=1 ./install.sh
```

Skip SDDM setup:

```sh
SKIP_SDDM=1 ./install.sh
```

Use both when needed:

```sh
SKIP_PACKAGES=1 SKIP_SDDM=1 ./install.sh
```
