# VNSTAT WIRELESS WRAPPER
vw() {
  local iface=$(ip -o link show | awk -F': ' '$2 ~ /^wlp/ {print $2; exit}')
  vnstat -i "$iface" "$@"
}

# PROTON VPN TOGGLES
vpnon() {
  sudo wg-quick up proton
}

vpnoff() {
  sudo wg-quick down proton
}
