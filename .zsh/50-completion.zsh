# COMPLETION INITIALISATION
# load and start the completion system
autoload -Uz compinit
fpath=(
    /usr/share/zsh/site-functions
    $fpath
)
compinit

# STYLING OPTIONS
# apply cache and interface rules to completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' group-name ''
zstyle ':completion:*' smart-case yes
zstyle ':completion:*' completer _expand _complete _correct _approximate
