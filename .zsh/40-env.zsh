# SYSTEM DEFAULTS
# define default editors and pagers
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="bat"
export MANPAGER="nvim +Man!"
export BAT_THEME="base16"
export NODE_OPTIONS=--no-deprecation

# PAGER COLOURS
# define terminal capability codes for less
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'

# VIDEODRIVER
export SDL_VIDEODRIVER=wayland
