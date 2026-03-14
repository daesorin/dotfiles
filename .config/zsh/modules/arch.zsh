# ==============================================================================
#  ARCH LINUX & PACMAN WRAPPERS
#  Includes: Pacman, Paru, System Maintenance
# ==============================================================================

# --- PACMAN ALIASES ---
alias pac='sudo pacman'
alias pacs='sudo pacman -S'
alias pacr='sudo pacman -R'
alias pacrns='sudo pacman -Rns'
alias pacu='sudo pacman -Syu'

# Search & Info
alias pacss='pacman -Ss'
alias pacsi='pacman -Si'
alias pacqs='pacman -Qs'
alias pacqi='pacman -Qi'
alias pacql='pacman -Ql'
alias pacqo='pacman -Qo'
alias paclist='pacman -Qe'
alias paccount='pacman -Q | wc -l'

# PARU ALIASES ---
alias parus='paru -S'
alias paruu='paru -Syu'
alias paruss='paru -Ss'
alias parur='paru -R'
alias parurns='paru -Rns'
alias paruc='paru -Sc'

# ==============================================================================
#  MAINTENANCE FUNCTIONS
# ==============================================================================

cleanup() {
    echo "\033[36m🧹 Running Arch Linux system cleanup...\033[0m"
    
    # 1. Pacman Cache
    echo "📦 Cleaning Pacman cache..."
    yes | sudo pacman -Sc > /dev/null 2>&1 || echo "   (Pacman cache already clean or locked)"

    # 2. Orphans
    echo "👻 Checking for orphans..."
    if [[ -n $(pacman -Qtdq) ]]; then
        sudo pacman -Rns $(pacman -Qtdq) --noconfirm
        echo "   ✅ Orphans removed."
    else
        echo "   ✅ No orphans found."
    fi
    
    # 3. User Caches
    echo "🗑️  Clearing user cache..."
    rm -rf "$HOME/.cache/"*(N)
    rm -rf "$HOME/.thumbnails/"*(N)
    
    # 4. Logs
    echo "📔 Vacuuming journals..."
    sudo journalctl --vacuum-time=7d > /dev/null 2>&1
    
    # 5. Paru/AUR
    if command -v paru &> /dev/null; then
        echo "🐻 Cleaning AUR cache..."
        yes | paru -Sc > /dev/null 2>&1
        rm -rf "$HOME/.cache/paru/clone"
        rm -rf "$HOME/.cache/paru/diff"
    fi
    
    # 6. Trash (if using trash-cli)
    if command -v trash-empty &> /dev/null; then
        echo "🚮 Emptying trash..."
        trash-empty
    fi
    
    echo "\033[32m✨ Cleanup completed!\033[0m"
    echo "Disk space freed:"
    df -h / | tail -1
}

# Check for security updates without installing
securityupdates() {
    echo "\033[36m🔒 Checking for security updates...\033[0m"
    if command -v arch-audit &> /dev/null; then
        arch-audit
    else
        echo "Install arch-audit: sudo pacman -S arch-audit"
    fi
}

# Reflector... The dedicated package for this annoys me,
reflector() {
    curl "https://archlinux.org/mirrorlist/?country=DE&country=NL&country=ZA&protocol=https&use_mirror_status=on" | sed 's/^#Server/Server/' | sudo tee /etc/pacman.d/mirrorlist
}
