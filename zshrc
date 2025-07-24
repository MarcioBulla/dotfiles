# Profiling (descomente para debug de performance)
# zmodload zsh/zprof

# Fastfetch primeiro - antes do prompt estar disponível
fastfetch -c ~/.config/fastfetch/startup.jsonc --ds-force-drm 2>/dev/null || true

# Zinit's storage plugins directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Instalação lazy do Zinit
if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
  command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

# Source/Load zinit
source "$ZINIT_HOME/zinit.zsh"

# Configurações de história otimizadas
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE=~/.HISTORY
HISTDUP=erase
setopt EXTENDED_HISTORY          # Record timestamp of command
setopt HIST_EXPIRE_DUPS_FIRST    # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS          # Ignore duplicated commands history list
setopt HIST_IGNORE_SPACE         # Ignore commands that start with space
setopt HIST_VERIFY               # Show command with history expansion to user before running it
setopt SHARE_HISTORY             # Share command history data
setopt HIST_SAVE_NO_DUPS         # Don't save duplicates
setopt HIST_FIND_NO_DUPS         # Don't display duplicates

# Outras opções úteis
setopt AUTO_CD                   # Change directory just by typing its name
setopt CORRECT                   # Auto correct mistakes
setopt MAGIC_EQUAL_SUBST         # Enable filename expansion for arguments of form 'anything=expression'
setopt NOTIFY                    # Report status of background jobs immediately
setopt NUMERICGLOBSORT          # Sort filenames numerically when it makes sense
setopt PROMPT_SUBST             # Enable command substitution in prompt

# Completion styling - configurado antes dos plugins
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion::complete:*' use-cache yes
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"
zstyle ':completion:*' menu no
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'

# FZF-tab specific
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' continuous-trigger '/'

# Keybindings otimizados
bindkey -e  # Emacs mode
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^r' history-incremental-search-backward
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[Z' undo
bindkey '^?' backward-delete-char
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
bindkey '^[[3~' delete-char

# Paths - definidos cedo para evitar problemas
export EDITOR="${EDITOR:-nvim}"
export SUDO_EDITOR="$EDITOR"
export JAVA_HOME="${JAVA_HOME:-/usr/lib/jvm/java-17-openjdk}"
export IDF_PATH="${HOME}/esp/esp-idf"
export DOTFILES="${HOME}/.dotfiles"
export WORKON_HOME="${HOME}/.virtualenvs"
export PROJECT_HOME="${HOME}/python"
export HYPRSHOT_DIR="${HOME}/Pictures/Screenshots"
export WALLPAPER="${HOME}/Pictures/Wallpaper"
export KICAD="${HOME}/.local/share/kicad/8.0/"

# PATH otimizado - evita duplicatas
typeset -U path PATH
path=(
    "$JAVA_HOME/bin"
    "$HOME/.local/bin"
    $path
)
export PATH

# Prompt - Starship carregado primeiro para melhor UX
zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Completions - carregamento primeiro
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    blockf \
        zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions

# Syntax highlighting - depois das completions
zinit wait"0a" lucid for \
        zdharma-continuum/fast-syntax-highlighting

# FZF tools - carregamento escalonado
zinit wait"0b" lucid for \
        Aloxaf/fzf-tab

# Tools condicionais - só carrega se necessário
zinit wait"1a" lucid has"eza" for \
    z-shell/zsh-eza

zinit wait"1b" lucid has"fzf" for \
    lincheney/fzf-tab-completion

# Python tools - carregamento tardio para não impactar startup
zinit wait"2a" lucid has"python3" for \
    darvid/zsh-poetry

zinit wait"2b" lucid has"virtualenvwrapper.sh" nocd for \
    python-virtualenvwrapper/virtualenvwrapper

# Integração de ferramentas externas - muito tardio
zinit wait"3" lucid nocd as"null" id-as"external-tools" \
    atload'
        # FZF integration
        [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
        command -v fzf >/dev/null && eval "$(fzf --zsh)" 2>/dev/null
        
        # Zoxide integration  
        command -v zoxide >/dev/null && eval "$(zoxide init --cmd cd zsh)" 2>/dev/null
        
        # UV integration
        command -v uv >/dev/null && eval "$(uv generate-shell-completion zsh)" 2>/dev/null
    ' \
for zdharma-continuum/null

get_idf() {
  source "$IDF_PATH/export.sh"
}

alias to_clipboard="xclip -selection clipboard"
alias freecad="env -u WAYLAND_DISPLAY freecad"
alias FreeCAD="env -u WAYLAND_DISPLAY freecad"
alias mmdc="npx -p @mermaid-js/mermaid-cli mmdc"


if command -v eza >/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -l --icons'
  alias la='eza -la --icons'
  alias lt='eza --tree --icons --level=2'
else
  alias ls='ls --color=auto'
fi



