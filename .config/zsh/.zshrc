#!/usr/bin/env zsh
[[ -o interactive ]] || return

autoload -Uz compinit
compinit

if [[ -d "$ZDOTDIR/modules" ]]; then
    for config in "$ZDOTDIR/modules/"*.zsh; do
        source "$config"
    done
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

bindkey -v
export PATH="$HOME/.npm-global/bin:$PATH"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
