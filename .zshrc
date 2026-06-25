# ONLY RUN FOR INTERACTIVE SHELLS
[[ -o interactive ]] || return

# COMPLETION SYSTEM
autoload -Uz compinit

# zsh-completions
fpath=(
    /usr/share/zsh/site-functions
    $fpath
)

compinit

# MODULE LOADER
ZSH_MOD_DIR="$HOME/.zsh"

if [[ -d "$ZSH_MOD_DIR" ]]; then
    for config in "$ZSH_MOD_DIR"/*.zsh(N); do
        source "$config"
    done
fi

# STARSHIP
eval "$(starship init zsh)"

# ZOXIDE
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --cmd cd)"
fi

# TMUX
if [ -n "$TMUX" ] && ! tmux info >/dev/null 2>&1; then
  unset TMUX
  unset TMUX_PANE
fi

# SEARCH
if [[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then 
	source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

# AUTOSUGGESTIONS
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# SYNTAX HIGHLIGHTING
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

export NODE_OPTIONS=--no-deprecation
