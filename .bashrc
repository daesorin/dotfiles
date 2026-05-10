# MAIN BASH CONFIGURATION
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh
[[ $- != *i* ]] && return

# BASH COMPLETION
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
fi

# MODULE LOADER
BASH_MOD_DIR="$HOME/.config/bash/modules"
if [[ -d "$BASH_MOD_DIR" ]]; then
  for config in "$BASH_MOD_DIR"/*.sh; do
    [[ -f "$config" ]] && source "$config"
  done
fi

eval "$(zoxide init bash)"

# PLUGINS
[[ -f /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh ]] &&
  source /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh

# Testing
