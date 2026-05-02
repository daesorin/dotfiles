# ── options ──────────────────────────────────────────────────────────────────
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="/home/dil/.config/zsh/history"

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ── paths ─────────────────────────────────────────────────────────────────────
typeset -U path  # deduplicate

path=(
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.go/bin"
    /usr/local/bin
    $path
)

export EDITOR=nvim
export VISUAL=nvim
export PAGER=bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="base16"

