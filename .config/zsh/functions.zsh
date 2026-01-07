#!/usr/bin/env bash

# ==============================================================================
#  SYSTEM ESSENTIALS (Functions)
# ==============================================================================
src() { 
    source "$ZDOTDIR/.zshrc"
    echo "✅ Config reloaded from $ZDOTDIR"
}
c()     { clear; }
q()     { exit; }

# Navigation Shortcuts
..()    { cd ..; }
...()   { cd ../..; }
....()  { cd ../../..; }

# ==============================================================================
#  LISTING MASTER (Eza + Fallbacks)
# ==============================================================================

# Check if 'eza' is installed
if command -v eza &> /dev/null; then

    # --- Configuration ---
    # We use simple strings, but we must expand them with ${=VAR} in Zsh
    _EZA_BASE="eza --group-directories-first --icons --color=always"
    _EZA_LIST="${_EZA_BASE} --git -lh"
    _EZA_TREE="${_EZA_BASE} --tree"

    # --- 1. Standard Listing ---
    l()     { ${=_EZA_BASE} "$@"; }
    la()    { ${=_EZA_BASE} -a "$@"; }
    
    # --- 2. Long Listing ---
    ll()    { ${=_EZA_LIST} "$@"; }
    lla()   { ${=_EZA_LIST} -a "$@"; }

    # --- 3. Tree Views ---
    lt()    { ${=_EZA_TREE} "$@"; }
    lta()   { ${=_EZA_TREE} -a "$@"; }
    ltl()   { ${=_EZA_TREE} --git -lh "$@"; }
    ltla()  { ${=_EZA_TREE} --git -lha "$@"; }

    # --- 4. Sorting ---
    ltn()   { ${=_EZA_LIST} --sort=modified "$@"; }
    ltna()  { ${=_EZA_LIST} -a --sort=modified "$@"; }
    lsz()   { ${=_EZA_LIST} --sort=size "$@"; }
    lsza()  { ${=_EZA_LIST} -a --sort=size "$@"; }

    # --- 5. Special Views ---
    ld()    { ${=_EZA_LIST} -D "$@"; }
    lda()   { ${=_EZA_LIST} -Da "$@"; }
    
    # [LZ] Recursive Size
    lz()    { ${=_EZA_LIST} --total-size "$@"; }
    lza()   { ${=_EZA_LIST} -a --total-size "$@"; }

    # [LO] Octal Permissions
    lo()    { ${=_EZA_LIST} --octal-permissions "$@"; }
    loa()   { ${=_EZA_LIST} -a --octal-permissions "$@"; }

    # [LX] Extended Summary
    lx() { 
        echo -e "\033[1;34mDisk Usage:\033[0m $(du -sh "${1:-.}" 2>/dev/null | cut -f1)"
        ${=_EZA_LIST} "$@"
    }
    lxa() { 
        echo -e "\033[1;34mDisk Usage:\033[0m $(du -sh "${1:-.}" 2>/dev/null | cut -f1)"
        ${=_EZA_LIST} -a "$@"
    }

else
    # --- FALLBACKS ---
    echo "⚠️  Eza not found. Using standard ls."
    l()     { ls --color=auto --group-directories-first "$@"; }
    la()    { ls -A --color=auto --group-directories-first "$@"; }
    ll()    { ls -lh --color=auto --group-directories-first "$@"; }
    lla()   { ls -lhA --color=auto --group-directories-first "$@"; }
    lt()    { tree -C "$@"; }
    lta()   { tree -Ca "$@"; }
fi

mkdirp() {
    mkdir -p "$@" && echo "Created: $@"
}

mkcd() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: mkcd <directory>"
        return 1
    fi
    mkdir -p "$1" && cd "$1"
}

tmpd() {
    local tmpdir=$(mktemp -d)
    cd "$tmpdir"
    echo "Created and entered temporary directory: $tmpdir"
}

grepf() {
    grep -r "$1" "${2:-.}"
}

ncat() {
    cat -n "$@"
}

# Network interface management
netspeed() {
    echo "\033[36m📊 Network Interface Speeds:\033[0m"
    for iface in $(ip link show | grep "^[0-9]" | awk '{print $2}' | tr -d ':' | grep -v "lo"); do
        speed=$(cat /sys/class/net/$iface/speed 2>/dev/null)
        if [[ -n "$speed" && "$speed" != "-1" ]]; then
            echo "├── $iface: ${speed} Mb/s"
        fi
    done
}

# List failed services
sysdfailed() {
    echo "\033[36m❌ Failed Services:\033[0m"
    systemctl --failed
}

# List enabled services
sysdenabled() {
    echo "\033[36m✅ Enabled Services:\033[0m"
    systemctl list-unit-files --state=enabled
}

jctlf() {
    sudo journalctl -f "$@"
}

jctlb() {
    sudo journalctl -b "$@"
}

jctlu() {
    sudo journalctl -u "$@"
}

# SSH FUNCTIONS
sshkeygen() {
    local email=$1
    local keytype=${2:-ed25519}
    local keyname=${3:-id_$keytype}
    
    if [[ -z "$email" ]]; then
        echo "Usage: sshkeygen <email> [keytype=ed25519] [keyname=id_<keytype>]"
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
    
    if command -v xclip &> /dev/null; then
        cat "$keypath.pub" | xclip -selection clipboard
        echo "\033[36m📋 Public key copied to clipboard!\033[0m"
    elif command -v wl-copy &> /dev/null; then
        cat "$keypath.pub" | wl-copy
        echo "\033[36m📋 Public key copied to clipboard!\033[0m"
    else
        echo "\033[33m⚠️  Install xclip or wl-clipboard to auto-copy\033[0m"
        cat "$keypath.pub"
    fi
}

sshkeylist() {
    echo "\033[36m📂 Existing SSH keys in ~/.ssh:\033[0m"
    ls -lh "$HOME/.ssh/"*.pub 2>/dev/null || echo "No SSH keys found."
}

# UTILITY FUNCTIONS
path() {
    echo $PATH | tr ':' '\n'
}

# Date and time utilities
current_time() { date +"%H:%M:%S"; } # Keep this function as it provides time without date

weather() {
    curl -s "https://wttr.in/${1}" || echo "Unable to fetch weather data"
}

ports() {
    sudo ss -tulpn
}

flush() {
    sudo systemd-resolve --flush-caches 2>/dev/null || sudo resolvectl flush-caches
    echo "DNS cache flushed"
}

# FILE AND DIRECTORY UTILITIES
ff() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: ff <filename_pattern>"
        return 1
    fi
    find . -type f -iname "*$1*" 2>/dev/null
}

fd() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: fd <dirname_pattern>"
        return 1
    fi
    find . -type d -iname "*$1*" 2>/dev/null
}

dus() {
    du -sh * 2>/dev/null | sort -hr
}

# PROCESS UTILITIES
psg() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: psg <process_name>"
        return 1
    fi
    ps aux | grep -i "$1" | grep -v grep
}

killp() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: killp <process_name>"
        return 1
    fi
    pkill -9 -i "$1" && echo "Killed processes matching: $1" || echo "No matching processes found"
}

pinfo() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: pinfo <PID>"
        return 1
    fi
    ps -p "$1" -o pid,ppid,user,%cpu,%mem,vsz,rss,tty,stat,started,time,command
}

# BACKUP UTILITY
backup() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: backup <file>"
        return 1
    fi
    if [[ ! -f "$1" ]]; then
        echo "File not found: $1"
        return 1
    fi
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    cp "$1" "$1.backup.$timestamp"
    echo "Backed up to: $1.backup.$timestamp"
}

# TEXT ENCODING/DECODING
base64encode() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: base64encode <text>"
        return 1
    fi
    echo -n "$1" | base64
}

base64decode() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: base64decode <encoded_text>"
        return 1
    fi
    echo "$1" | base64 -d
}

urlencode() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: urlencode <text>"
        return 1
    fi
    python -c "import urllib.parse; print(urllib.parse.quote('$1'))"
}

urldecode() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: urldecode <encoded_text>"
        return 1
    fi
    python -c "import urllib.parse; print(urllib.parse.unquote('$1'))"
}

# Hash functions
md5() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: md5 <text>"
        return 1
    fi
    echo -n "$1" | md5sum | awk '{print $1}'
}

sha1() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: sha1 <text>"
        return 1
    fi
    echo -n "$1" | sha1sum | awk '{print $1}'
}

sha256() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: sha256 <text>"
        return 1
    fi
    echo -n "$1" | sha256sum | awk '{print $1}'
}

# FILE SYSTEM OPERATIONS
symlink() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: symlink <target> <link>"
        return 1
    fi
    ln -sv "$1" "$2"
}

hardlink() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: hardlink <target> <link>"
        return 1
    fi
    ln -v "$1" "$2"
}

sec2time() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: sec2time <seconds>"
        return 1
    fi
    local seconds=$1
    printf "%dd %dh %dm %ds\n" $((seconds/86400)) $((seconds%86400/3600)) $((seconds%3600/60)) $((seconds%60))
}

cleanup() {
    echo "\033[36m🧹 Running Arch Linux system cleanup...\033[0m"
    echo ""
    
    echo "Cleaning pacman cache..."
    sudo pacman -Sc --noconfirm
    
    echo "Removing orphaned packages..."
    local orphans=$(pacman -Qtdq 2>/dev/null)
    if [[ -n "$orphans" ]]; then
        sudo pacman -Rns $orphans --noconfirm
    fi
    
    echo "Clearing user caches..."
    rm -rf ~/.cache/* 2>/dev/null
    
    echo "Clearing systemd journal (keep last 7 days)..."
    sudo journalctl --vacuum-time=7d
    
    echo "Clearing thumbnail cache..."
    rm -rf ~/.thumbnails/* 2>/dev/null
    rm -rf ~/.cache/thumbnails/* 2>/dev/null
    
    if command -v yay &> /dev/null; then
        echo "Cleaning yay cache..."
        paru -Sc --noconfirm
    elif command -v paru &> /dev/null; then
        echo "Cleaning paru cache..."
        paru -Sc --noconfirm
    fi
    
    echo "\033[32m✅ Cleanup completed!\033[0m"
    echo ""
    echo "Disk space freed:"
    df -h / | tail -1
}

# PERFORMANCE MONITORING
# CPU frequency
cpufreq() {
    echo "\033[36m⚡ CPU Frequencies:\033[0m"
    grep MHz /proc/cpuinfo | awk '{print "├── Core " NR-1 ": " $4 " MHz"}'
}

# System temperatures
temps() {
    echo "\033[36m🌡️  System Temperatures:\033[0m"
    if command -v sensors &> /dev/null; then
        sensors
    else
        echo "Install lm_sensors package (sudo pacman -S lm_sensors)"
    fi
}

# Watch system resources
watchres() {
    watch -n 1 "echo '\033[36m=== SYSTEM RESOURCES ===\033[0m' && \
    echo '\nCPU:' && mpstat 1 1 | tail -1 && \
    echo '\nMemory:' && free -h | grep Mem && \
    echo '\nDisk I/O:' && iostat -d 1 1 | tail -3"
}

# SECURITY UTILITIES
# Check for security updates
securityupdates() {
    echo "\033[36m🔒 Checking for security updates...\033[0m"
    if command -v arch-audit &> /dev/null; then
        arch-audit
    else
        echo "Install arch-audit: sudo pacman -S arch-audit"
    fi
}

# Generate secure password
genpass() {
    local length=${1:-20}
    openssl rand -base64 32 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+' | head -c "$length"
    echo
}

# FILE PERMISSIONS
# Make file executable
chx() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: chx <file>"
        return 1
    fi
    chmod +x "$1"
    echo "Made executable: $1"
}

# Set directory permissions recursively
chownr() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: chownr <user:group> <directory>"
        return 1
    fi
    sudo chown -R "$1" "$2"
    echo "Changed ownership of $2 to $1"
}

# QUICK FILE OPERATIONS
# Count files in directory
countfiles() {
    local dir="${1:-.}"
    echo "\033[36m📁 File count in $dir:\033[0m"
    find "$dir" -maxdepth 1 -type f | wc -l
}

# Count directories
countdirs() {
    local dir="${1:-.}"
    echo "\033[36m📂 Directory count in $dir:\033[0m"
    find "$dir" -maxdepth 1 -type d | wc -l
}

# Find large files
bigfiles() {
    local size=${1:-100M}
    local dir="${2:-.}"
    echo "\033[36m📊 Files larger than $size in $dir:\033[0m"
    find "$dir" -type f -size +"$size" -exec ls -lh {} \; | awk '{print $9 ": " $5}'
}

# Find duplicate files
finddupes() {
    local dir="${1:-.}"
    echo "\033[36m🔍 Finding duplicate files in $dir...\033[0m"
    find "$dir" -type f -exec md5sum {} + | sort | uniq -w32 -dD
}

# NETWORK DIAGNOSTICS
# Ping multiple hosts
pingall() {
    local hosts=("8.8.8.8" "1.1.1.1" "codeberg.org" "cloudflare.com" "archlinux.org")
    echo "\033[36m🌐 Testing connectivity...\033[0m"
    for host in "${hosts[@]}"; do
        if ping -c 1 -W 2 "$host" &>/dev/null; then
            echo "✅ $host: reachable"
        else
            echo "❌ $host: unreachable"
        fi
    done
}

# Check open ports on host
portscan() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: portscan <host>"
        return 1
    fi
    if command -v nmap &> /dev/null; then
        nmap "$1"
    else
        echo "Install nmap: sudo pacman -S nmap"
    fi
}

# Network speed test
speedtest() {
    if command -v speedtest-cli &> /dev/null; then
        speedtest-cli
    else
        echo "Install speedtest-cli: sudo pacman -S speedtest-cli"
    fi
}

# Scan Local LAN for devices
lan-scan() {
    # 1. Detect the active interface and subnet (IPv4)
    # We look for 'scope global' to ignore localhost
    local iface_info=$(ip -o -f inet addr show | awk '/scope global/ {print $2, $4}' | head -1)
    local iface=$(echo $iface_info | awk '{print $1}')
    local subnet=$(echo $iface_info | awk '{print $2}')

    if [ -z "$subnet" ]; then
        echo -e "${RED}No active network connection found.${NC}"
        return 1
    fi

    echo -e "${BLUE}Scanning subnet ${YELLOW}$subnet${NC} on interface ${YELLOW}$iface${NC}..."
    
    # 2. Run Nmap with sudo for MAC address resolution
    # -sn: Ping scan (no ports)
    # -n: No DNS resolution (faster)
    sudo nmap -sn -n "$subnet" | grep -E "Nmap scan|MAC Address" | sed -e 's/Nmap scan report for /IP: /g' -e 's/MAC Address: /MAC: /g'
}

# Force remove any existing alias named 'ya'
unalias ya 2>/dev/null

function ya() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# ==============================================================================
#  TMUX SUPERPOWERS
# ==============================================================================

# 1. Smart Session Starter (tms)
# Usage: tms [name]
# Logic: If session exists, attach to it. If not, create it.
# If no name provided, defaults to "main".
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

# 2. Fuzzy Attach (tma)
# Usage: tma
# Logic: Lists all running sessions. Select one with FZF to attach.
tma() {
    if [[ $# -eq 1 ]]; then
        # If argument provided, try to attach directly
        tmux attach -t "$1"
    else
        # No argument? Show FZF menu
        local session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height 40% --reverse --header="Select Session to Attach")
        if [[ -n "$session" ]]; then
            tmux attach -t "$session"
        else
            echo "No session selected."
        fi
    fi
}

# 3. Fuzzy Kill (tmk)
# Usage: tmk
# Logic: Lists sessions. Select one to kill (delete).
tmk() {
    local session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height 40% --reverse --header="💀 Kill Session" --prompt="Delete > ")
    if [[ -n "$session" ]]; then
        tmux kill-session -t "$session"
        echo "💥 Killed session: $session"
    fi
}

# 4. Config Management (Corrected for XDG path)
tmrc() {
    $EDITOR ~/.config/tmux/tmux.conf
}

tmre() {
    tmux source-file ~/.config/tmux/tmux.conf && echo "✅ Tmux config reloaded!"
}
