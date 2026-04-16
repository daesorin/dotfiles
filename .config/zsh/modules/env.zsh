# ~/.config/zsh/module/env.zsh
# Environment variables and path configuration

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Path configuration
typeset -U path
path=(
    "$HOME/.local/bin"
    /usr/local/bin
    /usr/bin
    /bin
    /usr/local/sbin
    /usr/sbin
    /sbin
    $path
)
export PATH
