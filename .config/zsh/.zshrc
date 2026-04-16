#!/usr/bin/env zsh
[[ -o interactive ]] || return

unset HISTFILE
export HISTSIZE=0
export SAVEHIST=0
setopt NO_HISTSAVE

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
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^[[3~' delete-char
bindkey -M viins '^[[A' history-search-backward
bindkey -M viins '^[[B' history-search-forward
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line

export PATH="$HOME/.npm-global/bin:$PATH"

#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
