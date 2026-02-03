#!/usr/bin/env zsh
# ZSH MAIN CONFIGURATION
[[ -o interactive ]] || return

# 1. Initialize Completion & History
autoload -Uz compinit
compinit

# 2. Load Environment Variables (Always first)
# We keep env.zsh separate because plugins might rely on $PATH or $EDITOR
[[ -f "$ZDOTDIR/env.zsh" ]] && source "$ZDOTDIR/env.zsh"

# 3. The Module Loader
# This loop sources every .zsh file in the modules directory automatically.
if [[ -d "$ZDOTDIR/modules" ]]; then
    for config in "$ZDOTDIR/modules/"*.zsh; do
        source "$config"
    done
fi

# 4. Plugins (Standard Arch Paths)
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 5. Prompt
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# 6.
bindkey -v
