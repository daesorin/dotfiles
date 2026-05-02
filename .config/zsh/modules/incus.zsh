# ── core ──────────────────────────────────────────────────────────────────────
alias ic='incus'

# ── instance lifecycle ────────────────────────────────────────────────────────
alias icls='incus list'
alias iclsv='incus list -c n,s,4,6,t,S --format=table'
alias icst='incus start'
alias icsp='incus stop'
alias icrst='incus restart'
alias icdel='incus delete'
alias icdsf='incus delete --force'

# ── shell / exec ──────────────────────────────────────────────────────────────
alias icsh='incus shell'

# exec a command in an instance: icex <name> <cmd...>
icex() { incus exec "$1" -- "${@:2}" }

# ── images ────────────────────────────────────────────────────────────────────
alias icimg='incus image list'
alias icimgr='incus image list images:'    # remote image browser

# ── info / logs ───────────────────────────────────────────────────────────────
alias icinfo='incus info'
alias iccfg='incus config show'
alias iclogs='incus info --show-log'

# ── snapshots ─────────────────────────────────────────────────────────────────
alias icsnap='incus snapshot create'
alias icsnapl='incus snapshot list'
alias icrestore='incus snapshot restore'

# === network / storage ────────────────────────────────────────────────────────
alias icnet='incus network list'
alias icvol='incus storage volume list'

# === console ===
alias iccon='incus console'
alias icconv='incus console --type=vga'

# ── functions ─────────────────────────────────────────────────────────────────

# launch and immediately shell in: icnew <image> <name>
icnew() {
    incus launch "$1" "$2" && incus shell "$2"
}

# copy a file into an instance: icpush <instance> <local> <remote>
icpush() { incus file push "$2" "$1/$3" }

# pull a file from an instance: icpull <instance> <remote> <local>
icpull() { incus file pull "$1/$2" "$3" }
