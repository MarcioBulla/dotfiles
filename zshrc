# Print fastfetch
(fastfetch -c ~/.config/fastfetch/startup.jsonc --ds-force-drm &) 

# Source Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh
source /usr/bin/virtualenvwrapper.sh

# Enable AutoCompletion
autoload -U compinit && compinit

# Shell Integrations
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(register-python-argcomplete pipx)"
eval "$(zoxide init --cmd cd zsh)"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^?' backward-delete-char
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
bindkey '^[[3~' delete-char

#History
HISTSIZE=5000
SAVEHIST=HISTSIZE
HISTFILE=~/.HISTORY
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

# Paths
export PATH=$PATH:"$HOME/.local/bin"
export KICAD=$HOME/.local/share/kicad/8.0/
export SUDO_EDITOR=/usr/bin/nvim
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab/
export HYPRSHOT_DIR=$HOME/Pictures/Screenshots
export EDITOR=/usr/bin/nvim
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export IDF_PATH=$HOME/esp/esp-idf
export DOTFILES=$HOME/.dotfiles
export WORKON_HOME=~/.virtualenvs

# Aliases
alias ls="eza --icons=auto"
alias tree="eza --icons=auto -T"
alias get_idf='. $IDF_PATH/export.sh'

