# Navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CDABLE_VARS

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

# Vi Mode
bindkey -v

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

