# MAIN BASH CONFIGURATION
# entry point for shell initialisation

# avoid running in non-interactive shells
[[ $- != *i* ]] && return

# BASH COMPLETION
# arch linux requires the bash-completion package
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
fi

# MODULE LOADER
# sources all scripts in the modules directory
BASH_MOD_DIR="$HOME/.config/bash/modules"
if [[ -d "$BASH_MOD_DIR" ]]; then
  for config in "$BASH_MOD_DIR"/*.sh; do
    [[ -f "$config" ]] && source "$config"
  done
fi

# PROMPT AND TOOLS
# initialising external binaries
eval "$(starship init bash)"
eval "$(zoxide init bash)"

# PLUGINS
# syntax highlighting for bash (available via aur/bash-syntax-highlighting)
[[ -f /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh ]] &&
  source /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh
