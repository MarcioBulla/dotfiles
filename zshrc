# Created by newuser for 5.9

export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# autoload -Uz compinit promptinit

# compinit
# promptinit
#
# # This will set the default prompt to the walters theme
# prompt walters
#
# ESP_IDF
alias get_idf='. $HOME/esp/esp-idf/export.sh'
export PATH=$PATH:"$HOME/.espressif/tools/esp-clang/15.0.0-23786128ae/esp-clang/bin"
export PATH=$PATH:"$HOME/.local/bin"

# PATHs

export KICAD=$HOME/.local/share/kicad/7.0/
export SUDO_EDITOR=/usr/bin/nvim



# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were read by zsh-newuser-install.
# They were moved here as they could not be understood.
# Tue Dec 12 04:49:36 AM UTC 2023
# setopt autocd beep extendedglob
# bindkey -e
# End of lines moved by zsh-newuser-install.
# The following lines were added by compinstall
zstyle :compinstall filename '/home/coldjr/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# alias
alias ls="eza --icons=auto"
alias tree="eza --icons=auto -T"
