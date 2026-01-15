# -----------------------------------------------------------------------------
# SYSTEMD / SERVICE MANAGEMENT
# -----------------------------------------------------------------------------

# --- Read Operations (No Sudo) ---
alias sc='systemctl'
alias scs='systemctl status'
alias scl='systemctl list-units --type=service --state=running'
alias scf='systemctl list-units --all --type=service'

# --- Write Operations (Sudo Implicit) ---
alias scstart='sudo systemctl start'
alias scstop='sudo systemctl stop'
alias screstart='sudo systemctl restart'
alias scenable='sudo systemctl enable --now'
alias scdisable='sudo systemctl disable --now'
alias screload='sudo systemctl daemon-reload'

# --- Logging (Journalctl) ---
logs() {
    journalctl -n 50 -f -u "$1"
}

sys() {
    local service=$(systemctl list-units --all --type=service --no-legend | cut -d' ' -f1 | fzf --preview 'systemctl status {}')
    
    if [[ -n $service ]]; then
        echo "Selected: $service"
        echo "1) Start  2) Stop  3) Restart  4) Status  5) Logs"
        read -k 1 "opt?Action: "
        echo ""
        case $opt in
            1) sudo systemctl start $service ;;
            2) sudo systemctl stop $service ;;
            3) sudo systemctl restart $service ;;
            4) systemctl status $service ;;
            5) journalctl -n 50 -f -u $service ;;
            *) echo "Aborted." ;;
        esac
    fi
}
