# ==============================================================================
#  INCUS (LXD Fork)
# ==============================================================================

# --- CORE ---
alias ic='incus'
alias icl='incus list'         # List instances
alias ici='incus info'         # Show instance info
alias icimg='incus image list' # List available images

# --- LIFECYCLE ---
alias icstart='incus start'
alias icstop='incus stop'
alias icres='incus restart'
alias icdel='incus delete'     # Delete instance

# --- INTERACTIVE ---
# usage: icsh <container_name>
alias icsh='incus exec'        # Base exec command

# --- FUNCTIONS ---

# Quick Shell Access
# Usage: ish <container_name> [shell]
# Defaults to bash, falls back to sh if you specify it.
ish() {
    local name=$1
    local shell=${2:-bash}
    
    if [[ -z "$name" ]]; then
        echo "Usage: ish <container_name> [bash|sh|zsh]"
        return 1
    fi

    echo "🚀 Entering $name via $shell..."
    incus exec "$name" -- "$shell"
}

# Quick Launch (Arch Linux default)
# Usage: iclaunch <container_name>
iclaunch() {
    if [[ -z "$1" ]]; then
        echo "Usage: iclaunch <name>"
        return 1
    fi
    incus launch images:archlinux "$1"
}

# IP Address Grabber
# Usage: icip <container_name>
icip() {
    incus list "$1" -c 4 --format csv | cut -d' ' -f1
}

# Add to modules/incus.zsh
alias torbrowser='incus exec librewolf-tor -- su - user -c "XDG_RUNTIME_DIR=/run/user/1000 WAYLAND_DISPLAY=wayland-1 MOZ_ENABLE_WAYLAND=1 librewolf"'
