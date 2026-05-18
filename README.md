# dotfiles

Dotfiles for my current CachyOS/Arch system.

## Default Location

This repo is expected to live at:

```sh
~/.dotfiles
```

Clone it directly there with:

```sh
git clone https://github.com/<your-github-user>/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## Restore Packages

```sh
sudo pacman -S --needed - < packages/pacman-native.txt
paru -S --needed - < packages/aur.txt
```

## Apply Dotfiles

No Dotbot on `main`. The installer creates symlinks for `~/.zshrc`, `~/.gitconfig`, and `~/.config/*`.
`~/.zshrc` points to `config/zshrc`.
The repo is expected to be in `~/.dotfiles`, so the links look like this:

```text
~/.zshrc             -> ~/.dotfiles/config/zshrc
~/.gitconfig         -> ~/.dotfiles/gitconfig
~/.config/nvim       -> ~/.dotfiles/config/nvim
~/.config/kitty      -> ~/.dotfiles/config/kitty
~/.config/niri       -> ~/.dotfiles/config/niri
~/.local/share/...   -> ~/.dotfiles/local/share/...
```

Existing files are moved to `~/.dotfiles-backup/` before links are created.
The installer also unblocks Bluetooth with `rfkill` when available and enables `bluetooth.service`.
It also opens the default LocalSend port, `53317/tcp` and `53317/udp`, with `ufw` or `firewall-cmd` when available.

```sh
./install.sh
```

`install.sh` is only an orchestrator. The actual steps live in:

```text
scripts/ensure-standard-location.sh
scripts/install-symlinks.sh
scripts/setup-bluetooth.sh
scripts/setup-localsend-firewall.sh
scripts/install-sddm-theme.sh
```

The SDDM step installs the `where_is_my_sddm_theme` theme automatically, cloning it from:

```sh
https://github.com/stepanzubkov/where-is-my-sddm-theme.git
```

It applies `sddm.conf` and `sddm-theme.conf`, keeping a black background without copying any wallpaper.
To skip the SDDM step:

```sh
SKIP_SDDM=1 ./install.sh
```

## Notes

- `packages/pacman-native.txt`: only explicitly installed packages from official repositories, without automatic dependencies.
- `packages/aur.txt`: only explicitly installed AUR/external packages, without automatic dependencies.
- `packages/explicit-all.txt`: full explicit package list, also without automatic dependencies.
- `local/share/kio/servicemenus/localsend.desktop`: Dolphin/KDE context menu for LocalSend.
- API keys, cookies, local databases, and logs should not be versioned.
