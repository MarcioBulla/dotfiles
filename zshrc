# Created by newuser for 5.9


export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# Lines configured
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify


# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)EZA_COLORS}"


autoload -Uz compinit
compinit

# PATHs

export PATH=$PATH:"$HOME/.local/bin"
export KICAD=$HOME/.local/share/kicad/8.0/
export SUDO_EDITOR=/usr/bin/nvim
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab


# alias
alias ls="eza --icons=auto"
alias tree="eza --icons=auto -T"

alias get_idf='. $HOME/esp/esp-idf/export.sh'

fastfetch -c ~/.config/fastfetch/startup.jsonc 
