# SERVICE MANAGEMENT
alias toron='sudo systemctl start tor'
alias toroff='sudo systemctl stop tor'
alias torstat='systemctl status tor'
alias torres='sudo systemctl restart tor'

# NETWORK ROUTING
alias trun='torsocks'

# UTILITIES
alias ipclear='curl -s https://ifconfig.me'
alias iptor='torsocks curl -s https://ifconfig.me'

# MONITORING
alias tormon='nyx'
