# IP
alias netlist='ip link show'
alias netip='ip addr show'
alias ports='sudo ss -tulpn'
alias myip='curl -s https://ifconfig.me && echo'
alias iptor='torsocks curl -s https://ifconfig.me'

# FIREWALL (UFW)
alias fw='sudo ufw'
alias fws='sudo ufw status'
alias fwv='sudo ufw status verbose'
alias fwen='sudo ufw enable'
alias fwdis='sudo ufw disable'
alias fwallow='sudo ufw allow'
alias fwdeny='sudo ufw deny'

# BLUETOOTH
alias bt='bluetoothctl'
alias bton='bluetoothctl power on'
alias btoff='bluetoothctl power off'
alias btlist='bluetoothctl devices'
alias btscan='bluetoothctl scan on'
alias btconnect='bluetoothctl connect'
alias btdisconnect='bluetoothctl disconnect'

#  VPN & PRIVACY
alias vpnup='sudo wg-quick up proton'
alias vpndown='sudo wg-quick down proton'
alias torup='sudo systemctl start tor && echo "Tor Service Started [O n]"'
alias tordown='sudo systemctl stop tor && echo "Tor Service Stopped [ Off]"'
alias torstat='systemctl status tor'
alias torres='sudo systemctl restart tor'
alias trun='torsocks'
alias tormon='nyx'

# REFLECTOR
alias mirror='sudo reflector -c FR,DE,NL,GB,PT,ZA,MA --protocol https --latest 20 --sort rate --save /etc/pacman.d/mirrorlist'
#alias mirror='sudo reflector -c FR,DE,NL,GB --protocol https --latest 15 --sort rate --save /etc/pacman.d/mirrorlist'
