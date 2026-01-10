# ==============================================================================
#  ARCH LINUX & PACMAN WRAPPERS
#  Includes: Pacman, Paru, System Maintenance
# ==============================================================================

# --- SYSTEM MONITORING ---
alias syscheck="echo -e '\n肌 System: ' \$(uname -r); \
                 echo -e '\n朕 Disk: ' \$(df -h / | tail -1); \
                 echo -e '\nｧ Memory: ' \$(free -h | grep Mem); \
                 echo -e '\n藤 Network: ' \$(ip addr show | grep 'inet ' | grep -v 127.0.0.1 | head -1)"

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
alias pacqo='pacman -Qo'  # Who owns this file?
alias paclist='pacman -Qe'
alias paccount='pacman -Q | wc -l'

# --- PARU ALIASES ---
if command -v paru &> /dev/null; then
    alias parus='paru -S'
    alias paruu='paru -Syu'
    alias paruss='paru -Ss'
    alias parur='paru -R'
    alias parurns='paru -Rns'
    alias paruc='paru -Sc'
fi

# ==============================================================================
#  MAINTENANCE FUNCTIONS
# ==============================================================================

cleanup() {
    echo "\033[36m🧹 Running Arch Linux system cleanup...\033[0m"
    
    # 1. Pacman Cache
    # We use 'yes' to pipe 'y' into the command because -Sc can still be interactive
    echo "📦 Cleaning Pacman cache..."
    yes | sudo pacman -Sc > /dev/null 2>&1 || echo "   (Pacman cache already clean or locked)"

    # 2. Orphans
    # We check if orphans exist first to avoid the "target not found" error
    echo "👻 Checking for orphans..."
    if [[ -n $(pacman -Qtdq) ]]; then
        sudo pacman -Rns $(pacman -Qtdq) --noconfirm
        echo "   ✅ Orphans removed."
    else
        echo "   ✅ No orphans found."
    fi
    
    # 3. User Caches
    # We use (N) glob qualifier: It tells Zsh "null glob" (don't error if empty)
    # This also bypasses the "rm *" interactive safety check
    echo "🗑️  Clearing user cache..."
    rm -rf "$HOME/.cache/"*(N)
    rm -rf "$HOME/.thumbnails/"*(N)
    
    # 4. Logs
    echo "📔 Vacuuming journals..."
    sudo journalctl --vacuum-time=7d > /dev/null 2>&1
    
    # 5. Paru/AUR
    if command -v paru &> /dev/null; then
        echo "🐻 Cleaning AUR cache..."
        # Clean package cache
        yes | paru -Sc > /dev/null 2>&1
        # Clean the clone directory (where the source code lives)
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
