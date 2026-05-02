# ── core ──────────────────────────────────────────────────────────────────────
alias tx='tmux'

# ── sessions ──────────────────────────────────────────────────────────────────
alias txls='tmux ls'
alias txk='tmux kill-session -t'
alias txka='tmux kill-server'

# new named session: txn <name>
txn() { tmux new-session -s "${1:-main}" }

# attach to session (last if no arg, named if given): txa [name]
txa() {
    if [[ -n "$1" ]]; then
        tmux attach-session -t "$1"
    else
        tmux attach-session 2>/dev/null || tmux new-session -s main
    fi
}

# ── windows ───────────────────────────────────────────────────────────────────
alias txnw='tmux new-window'
alias txrw='tmux rename-window'

# ── panes ─────────────────────────────────────────────────────────────────────
alias txvs='tmux split-window -h'   # vertical split (side by side)
alias txhs='tmux split-window -v'   # horizontal split (stacked)

# ── config ────────────────────────────────────────────────────────────────────
alias txr='tmux source-file ~/.config/tmux/tmux.conf && echo "config reloaded"'
