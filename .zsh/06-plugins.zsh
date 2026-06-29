# STARSHIP INITIALISATION
eval "$(starship init zsh)"

# ZOXIDE INITIALISATION
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --cmd cd)"
fi

# TMUX CHECK
if [ -n "$TMUX" ] && ! tmux info >/dev/null 2>&1; then
    unset TMUX
    unset TMUX_PANE
fi

# ZSH PLUGINS
if [[ -f /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

if [[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
