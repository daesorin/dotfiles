# SHELL OPTIONS
shopt -s autocd
shopt -s cdable_vars
shopt -s checkwinsize
shopt -s histappend
shopt -s globstar
shopt -s dirspell
shopt -s cdspell

# HISTORY MANAGEMENT
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth:erasedups
export HISTFILE="$HOME/.config/bash/history"

# PATH HANDLING
# Bash does not have typeset -U; use a manual export.
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.go/bin:$HOME/.npm-global/bin:/usr/local/bin:$PATH"

# DEDUPLICATE PATH (OPTIONAL HELPER)
export PATH=$(echo -n "$PATH" | awk -v RS=: '!($0 in a) {a[$0]; printf "%s%s", (i++ ? ":" : ""), $0}')

# ENVIRONMENT
export EDITOR=nvim
export VISUAL=nvim
export PAGER=bat
export MANPAGER="nvim +Man!"
export BAT_THEME="base16"

# LESS COLOURS
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'
