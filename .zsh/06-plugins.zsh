# STARSHIP INITIALISATION
# start the prompt
eval "$(starship init zsh)"

# ZOXIDE INITIALISATION
# start the smart directory jumper
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --cmd cd)"
fi

# TMUX CHECK
# verify active multiplexer sessions
if [ -n "$TMUX" ] && ! tmux info >/dev/null 2>&1; then
    unset TMUX
    unset TMUX_PANE
fi

# ZSH PLUGINS
# source external extension scripts
if [[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then 
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
