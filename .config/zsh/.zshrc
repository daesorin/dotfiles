# ZSH MAIN CONFIGURATION
[[ -o interactive ]] || return

# Enable auto-completion
autoload -Uz compinit
compinit

# Source modular configs
# We use ZDOTDIR (defined in .zshenv) to find our neighbors
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
# If:
# 1. We are interactive (not a script)
# 2. We are NOT already inside Tmux
# 3. We are NOT logged in via SSH
# 4. We are NOT in a VSCode terminal (optional, but good safety)
# -----------------------------------------------------------------------------
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -z "$SSH_CONNECTION" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
    # Attempt to attach to a session named "main", or create it if it doesn't exist.
    # 'exec' replaces the Zsh process, so closing Tmux closes the window.
    exec tmux new-session -A -s main
fi

# KEYBINDINGS
bindkey '^B' clear-screen
