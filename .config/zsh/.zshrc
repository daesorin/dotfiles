# ZSH MAIN CONFIGURATION
[[ -o interactive ]] || return

# Enable auto-completion
autoload -Uz compinit
compinit

# Source modular configs
[[ -f "$ZDOTDIR/env.zsh" ]]       && source "$ZDOTDIR/env.zsh"
[[ -f "$ZDOTDIR/aliases.zsh" ]]   && source "$ZDOTDIR/aliases.zsh"
[[ -f "$ZDOTDIR/functions.zsh" ]] && source "$ZDOTDIR/functions.zsh"

# Arch Linux System Plugins (Standard Paths)
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Prompt
eval "$(starship init zsh)"

# -----------------------------------------------------------------------------
# AUTO-START TMUX (Local Only)
# -----------------------------------------------------------------------------
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -z "$SSH_CONNECTION" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
    exec tmux new-session -A -s main
fi

# KEYBINDINGS
bindkey '^B' clear-screen
