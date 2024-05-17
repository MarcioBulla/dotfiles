# START Terminal
fastfetch -c ~/.config/fastfetch/startup.jsonc 

# Source Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh

# Enable AutoCompletion
autoload -U compinit && compinit

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

#History
HISTSIZE=5000
SAVEHIST=HISTSIZE
HISTFILE=~/.zsh_history
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Completion Stuling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $ realpath'

# Aliases
alias ls="eza --icons=auto"
# alias cd=z
alias tree="eza --icons=auto -T"
alias get_idf='. $HOME/esp/esp-idf/export.sh'

# Paths
export PATH=$PATH:"$HOME/.local/bin"
export KICAD=$HOME/.local/share/kicad/8.0/
export SUDO_EDITOR=/usr/bin/nvim
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab


# Shell Integrations
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
