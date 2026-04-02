# -----------------------------------------------------------------------------
# SYSTEMD / SERVICE MANAGEMENT
# -----------------------------------------------------------------------------

# Read Operations (Normie)
alias sc='systemctl'
alias scs='systemctl status'
alias scl='systemctl list-units --type=service --state=running'
alias scf='systemctl list-units --all --type=service'

# Write Operations (Supie)
alias scstart='sudo systemctl start'
alias scstop='sudo systemctl stop'
alias screstart='sudo systemctl restart'
alias scenable='sudo systemctl enable --now'
alias scdisable='sudo systemctl disable --now'
alias screload='sudo systemctl daemon-reload'

# Logging
logs() {
    journalctl -n 50 -f -u "$1"
}
