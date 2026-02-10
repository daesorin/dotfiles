# --- TMUX ALIASES ---
alias tmrc='$EDITOR ~/.config/tmux/tmux.conf'
alias tmre='tmux source-file ~/.config/tmux/tmux.conf && echo "✅ Tmux config reloaded!"'

# --- TMUX AUTO-START (Local Only) ---
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -z "$SSH_CONNECTION" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
    exec tmux new-session -A -s main
fi

# --- TMUX FUNCTIONS ---

tms() {
    local name="${1:-main}"
    if tmux has-session -t "$name" 2>/dev/null; then
        echo "🔄 Session '$name' already exists. Attaching..."
        tmux attach -t "$name"
    else
        echo "✨ Creating new session: $name"
        tmux new-session -s "$name"
    fi
}

tma() {
    if [[ $# -eq 1 ]]; then
        tmux attach -t "$1"
    else
        local session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height 40% --reverse --header="Select Session to Attach")
        [[ -n "$session" ]] && tmux attach -t "$session"
    fi
}

tmk() {
    local session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height 40% --reverse --header="💀 Kill Session" --prompt="Delete > ")
    if [[ -n "$session" ]]; then
        tmux kill-session -t "$session"
        echo "💥 Killed session: $session"
    fi
}
