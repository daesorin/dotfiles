# INPUT MODES
# enforce vi keybindings
bindkey -e

# SEARCH BINDINGS
# map arrows to history search functions
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# HELP MANUAL
# map keyboard shortcut to local runbook
unalias run-help 2>/dev/null
autoload -Uz run-help
bindkey '^[h' run-help
