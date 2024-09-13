# Zinit's storage plugins directory
ZINIT_HOME="${XDF_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi


# Source/Load zinit
source "$ZINIT_HOME/zinit.zsh"

# Add in StarShip
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# add fast-syntax-highlighting
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# Add zsh-completions
zinit light zsh-users/zsh-completions 

# Add zsh-autosuggestions
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Add fzf-tab
zinit light Aloxaf/fzf-tab
zinit light lincheney/fzf-tab-completion

# Add eza
zinit ice wait lucid for \
  has'eza' atinit'AUTOCD=1' 
zinit light z-shell/zsh-eza

# Add virtualenvwrapper
zinit light python-virtualenvwrapper/virtualenvwrapper

# Add Poetry
zinit light darvid/zsh-poetry

# Add pipx
zinit wait lucid light-mode as"null" nocompile \
  atclone"pipx install nox; register-python-argcomplete nox > zhook.zsh" \
  atpull"pipx update nox; rm -f zhook.zsh; register-python-argcomplete nox > zhook.zsh" \
  atdelete"pipx uninstall nox" \
  atload"autoload bashcompinit && bashcompinit && source zhook.zsh" \
for theacodes/nox

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Shel integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(register-python-argcomplete pipx)"

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

# History
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
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':completion:*:*:cp:*' file-sort size
zstyle ':completion:*' file-sort modification

# Aliases
alias get_idf=". $IDF_PATH/export.sh"
alias to_clipboard="xclip -selection clipboard"

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
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/python # virtualenvwrapper project home

# Print fastfetch
fastfetch -c ~/.config/fastfetch/startup.jsonc --ds-force-drm 

# Created by `pipx` on 2024-09-13 20:10:02
export PATH="$PATH:/home/marcio/.local/bin"
