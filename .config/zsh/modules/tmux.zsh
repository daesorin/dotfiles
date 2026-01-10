# --- TMUX ALIASES ---
alias tmrc='$EDITOR ~/.config/tmux/tmux.conf'
alias tmre='tmux source-file ~/.config/tmux/tmux.conf && echo "✅ Tmux config reloaded!"'

# --- TMUX AUTO-START (Local Only) ---
# Logic moved from your old .zshrc 
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -z "$SSH_CONNECTION" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
    # We use 'exec' to replace the shell, but only if you want it to act as a login shell wrapper
    # Based on your previous config, you preferred creating/attaching to 'main'
    exec tmux new-session -A -s main
fi

# --- TMUX FUNCTIONS ---

# 1. Smart Session Starter
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

# 2. Fuzzy Attach
tma() {
    if [[ $# -eq 1 ]]; then
        tmux attach -t "$1"
    else
        local session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height 40% --reverse --header="Select Session to Attach")
        [[ -n "$session" ]] && tmux attach -t "$session"
    fi
}

# 3. Fuzzy Kill
tmk() {
    local session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height 40% --reverse --header="💀 Kill Session" --prompt="Delete > ")
    if [[ -n "$session" ]]; then
        tmux kill-session -t "$session"
        echo "💥 Killed session: $session"
    fi
}
