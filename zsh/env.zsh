# Enable colors
autoload -Uz colors && colors

# History configuration (Stored in .config/zsh now)
HISTFILE="$ZDOTDIR/.zhistory"
HISTSIZE=1000000
SAVEHIST=1000000
setopt appendhistory
setopt sharehistory

# LANGUAGE ENVIRONMENT  
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# EDITOR
export EDITOR=nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Zsh options
setopt AUTO_CD
export LEDGER_FILE="$HOME/Documents/finance/2026.journal"

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt NO_BEEP
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt GLOBAL_RCS
setopt APPEND_HISTORY
setopt PUSHD_IGNORE_DUPS
setopt HIST_VERIFY

# Completion Styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# PATHS
path=(
  /usr/local/sbin
  /usr/local/bin
  /usr/sbin
  /usr/bin
  /sbin
  /bin
)

[[ -d "$HOME/scripts" ]] && path=("$HOME/scripts" $path)
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

export PATH

# GPG
export GPG_TTY=$(tty)
