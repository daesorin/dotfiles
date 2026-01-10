# --- SYSTEM INFO ---
alias syscheck="echo -e '\n肌 System: ' \$(uname -r); \
                 echo -e '\n朕 Disk: ' \$(df -h / | tail -1); \
                 echo -e '\nｧ Memory: ' \$(free -h | grep Mem); \
                 echo -e '\n藤 Network: ' \$(ip addr show | grep 'inet ' | grep -v 127.0.0.1 | head -1)"

# --- PACMAN ---
alias pac='sudo pacman'
alias pacs='sudo pacman -S'
alias pacr='sudo pacman -R'
alias pacrns='sudo pacman -Rns'
alias pacu='sudo pacman -Syu'
alias pacss='pacman -Ss'
alias pacsi='pacman -Si'
alias pacqs='pacman -Qs'
alias pacqi='pacman -Qi'
alias pacql='pacman -Ql'
alias pacqo='pacman -Qo'
alias pacclean='sudo pacman -Sc'
alias pacorphan='sudo pacman -Rns $(pacman -Qtdq)'
alias paclist='pacman -Qe'
alias paccount='pacman -Q | wc -l'

# --- PARU ---
alias parus='paru -S'
alias paruu='paru -Syu'
alias paruss='paru -Ss'
alias parur='paru -R'
alias parurns='paru -Rns'
alias paruc='paru -Sc'

# --- MAINTENANCE FUNCTIONS ---
cleanup() {
    echo "\033[36m🧹 Running Arch Linux system cleanup...\033[0m"
    sudo pacman -Sc --noconfirm
    
    echo "Removing orphaned packages..."
    local orphans=$(pacman -Qtdq 2>/dev/null)
    if [[ -n "$orphans" ]]; then
        sudo pacman -Rns $orphans --noconfirm
    fi
    
    echo "Clearing caches..."
    rm -rf ~/.cache/* 2>/dev/null
    sudo journalctl --vacuum-time=7d
    
    if command -v paru &> /dev/null; then
        echo "Cleaning paru cache..."
        paru -Sc --noconfirm
    fi
    echo "\033[32m✅ Cleanup completed!\033[0m"
}

securityupdates() {
    echo "\033[36m🔒 Checking for security updates...\033[0m"
    if command -v arch-audit &> /dev/null; then
        arch-audit
    else
        echo "Install arch-audit: sudo pacman -S arch-audit"
    fi
}
