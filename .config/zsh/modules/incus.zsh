# ==============================================================================
#  INCUS (LXD Fork)
# ==============================================================================

# --- CORE ---
alias ic='incus'
alias icl='incus list'
alias ici='incus info'
alias icimg='incus image list'

# --- LIFECYCLE ---
alias icstart='incus start'
alias icstop='incus stop'
alias icres='incus restart'
alias icdel='incus delete'

alias icsh='incus exec'

iclaunch() {
    if [[ -z "$1" ]]; then
        echo "Usage: iclaunch <name>"
        return 1
    fi
    incus launch images:archlinux "$1"
}

icip() {
    incus list "$1" -c 4 --format csv | cut -d' ' -f1
}
