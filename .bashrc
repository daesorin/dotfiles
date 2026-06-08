# MAIN BASH CONFIGURATION
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh
[[ $- != *i* ]] && return

# BASH COMPLETION
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
fi

# MODULE LOADER
BASH_MOD_DIR="$HOME/.config/bash"
if [[ -d "$BASH_MOD_DIR" ]]; then
  for config in "$BASH_MOD_DIR"/*.bash; do
    [[ -f "$config" ]] && source "$config"
  done
fi

eval "$(starship init bash)"
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash --cmd cd)"
fi

# PLUGINS
[[ -f /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh ]] &&
  source /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh

# Testing


# filen-cli
PATH=$PATH:~/.filen-cli/bin
