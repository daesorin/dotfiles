# ==============================================================================
#  NETWORK UTILITIES
#  Includes: IP, VPN, Tor, SSH, DNS, Bluetooth, Firewall
# ==============================================================================

# --- INFO & INTERFACES ---
alias netlist='ip link show'
alias netip='ip addr show'
alias ports='sudo ss -tulpn'

# Get Public IP
alias myip='curl -s https://ifconfig.me && echo'

# --- DNS ---
# Smart DNS Flush
flush() {
    if systemctl is-active --quiet dnscrypt-proxy; then
        sudo systemctl restart dnscrypt-proxy
        echo "✅ DNSCrypt-proxy restarted (Cache Flushed)"
    elif systemctl is-active --quiet systemd-resolved; then
        sudo resolvectl flush-caches
        echo "✅ DNS cache flushed (systemd-resolved)"
    elif systemctl is-active --quiet NetworkManager; then
        sudo systemctl reload NetworkManager
        echo "✅ NetworkManager reloaded"
    else
        echo "⚠️  No known DNS cacher found (checked dnscrypt, resolved, NM)."
    fi
}

# --- VPN & PRIVACY ---

alias vpnup='sudo wg-quick up proton'
alias vpndown='sudo wg-quick down proton'

alias torup='sudo systemctl start tor && echo "🧅 Tor Service Started [On]"'
alias tordown='sudo systemctl stop tor && echo "🚫 Tor Service Stopped [Off]"'

# --- SSH MANAGEMENT ---

sshkeygen() {
    local email=$1
    local keytype="ed25519"
    local keyname=${2:-id_ed25519}
    
    if [[ -z "$email" ]]; then
        echo "Usage: sshkeygen <email> [keyname]"
        return 1
    fi
    
    local ssh_dir="$HOME/.ssh"
    mkdir -p "$ssh_dir"
    chmod 700 "$ssh_dir"
    
    local keypath="$ssh_dir/$keyname"
    if [[ -f "$keypath" ]]; then
        echo "\033[31m❌ Key already exists at $keypath\033[0m"
        return 1
    fi
    
    ssh-keygen -t "$keytype" -C "$email" -f "$keypath" -N ""
    echo "\033[32m✅ SSH key created at $keypath\033[0m"
    
    # Auto-copy to clipboard
    if command -v wl-copy &> /dev/null; then
        cat "$keypath.pub" | wl-copy
        echo "\033[36m📋 Public key copied to clipboard (Wayland)!\033[0m"
    elif command -v xclip &> /dev/null; then
        cat "$keypath.pub" | xclip -selection clipboard
        echo "\033[36m📋 Public key copied to clipboard (X11)!\033[0m"
    else
        cat "$keypath.pub"
    fi
}

# List Keys
sshkeylist() {
    echo "\033[36m📂 Existing SSH keys in ~/.ssh:\033[0m"
    ls -lh "$HOME/.ssh/"*.pub 2>/dev/null || echo "No SSH keys found."
}

# --- DIAGNOSTICS & SCANNERS ---

pingall() {
    local hosts=("8.8.8.8" "1.1.1.1" "codeberg.org" "archlinux.org")
    echo "\033[36m🌐 Testing connectivity...\033[0m"
    for host in "${hosts[@]}"; do
        if ping -c 1 -W 2 "$host" &>/dev/null; then
            echo "✅ $host: reachable"
        else
            echo "❌ $host: unreachable"
        fi
    done
}

netspeed() {
    echo "\033[36m📊 Network Interface Speeds:\033[0m"
    for iface in $(ip link show | grep "^[0-9]" | awk '{print $2}' | tr -d ':' | grep -v "lo"); do
        speed=$(cat /sys/class/net/$iface/speed 2>/dev/null)
        [[ -n "$speed" && "$speed" != "-1" ]] && echo "├── $iface: ${speed} Mb/s"
    done
}

lan-scan() {
    local iface_info=$(ip -o -f inet addr show | awk '/scope global/ {print $2, $4}' | head -1)
    local iface=$(echo $iface_info | awk '{print $1}')
    local subnet=$(echo $iface_info | awk '{print $2}')

    if [ -z "$subnet" ]; then
        echo "❌ No active network connection found."
        return 1
    fi

    echo "🔍 Scanning subnet \033[33m$subnet\033[0m on \033[33m$iface\033[0m..."
    sudo nmap -sn -n "$subnet" | grep -E "Nmap scan|MAC Address" | sed -e 's/Nmap scan report for /IP: /g' -e 's/MAC Address: /MAC: /g'
}

portscan() {
    [[ -z "$1" ]] && { echo "Usage: portscan <host>"; return 1; }
    nmap "$1"
}

speedtest() {
    if command -v speedtest-cli &> /dev/null; then
        speedtest-cli
    else
        echo "Install speedtest-cli: sudo pacman -S speedtest-cli"
    fi
}

# --- FIREWALL (UFW) ---
alias fw='sudo ufw'
alias fws='sudo ufw status'
alias fwv='sudo ufw status verbose'
alias fwen='sudo ufw enable'
alias fwdis='sudo ufw disable'
alias fwallow='sudo ufw allow'
alias fwdeny='sudo ufw deny'

# --- BLUETOOTH ---
alias bt='bluetoothctl'
alias bton='bluetoothctl power on'
alias btoff='bluetoothctl power off'
alias btlist='bluetoothctl devices'
alias btscan='bluetoothctl scan on'
alias btconnect='bluetoothctl connect'
alias btdisconnect='bluetoothctl disconnect'
