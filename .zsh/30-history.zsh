# HISTORY FILE CONFIGURATION
# define history location and limits
HISTFILE="$ZDOTDIR/.history"
HISTSIZE=1000000
SAVEHIST=2000000

# HISTORY OPTIONS
# set recording and retrieval parameters
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

# HISTORY ALIASES
# define output format for history review
alias hist='fc -l -t "%Y-%m-%d %H:%M:%S"'
