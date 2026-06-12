# Navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CDABLE_VARS
setopt NO_CASE_GLOB
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt GLOB_DOTS

# ZSTYLE
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' group-name ''
zstyle ':completion:*' smart-case yes
zstyle ':completion:*' completer _expand _complete _correct _approximate

# Globbing
setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT

# History
HISTFILE="$HOME/.config/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_FIND_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY


# SAFETY AND CONTROL
setopt NO_CLOBBER

# Vi Mode
bindkey -e

# PATH
typeset -U path PATH

path=(
"$HOME/.local/bin"
"$HOME/.cargo/bin"
"$HOME/go/bin"
"$HOME/.npm-global/bin"
/usr/local/bin
$path
)

export PATH

# Environment
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="bat"
export MANPAGER="nvim +Man!"
export BAT_THEME="base16"

# Less Colours
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'

