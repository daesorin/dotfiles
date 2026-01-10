# ==============================================================================
#  FILE OPERATIONS
#  Includes: Creation, Backup, Search, Hashing, Compression
# ==============================================================================

# --- DIRECTORY OPERATIONS ---

# Make directory and cd into it
mkcd() {
    if [[ -z "$1" ]]; then
        echo "Usage: mkcd <directory>"
        return 1
    fi
    mkdir -p "$1" && cd "$1"
}

# Create a temporary directory and enter it
tmpd() {
    local tmpdir=$(mktemp -d)
    cd "$tmpdir" && echo "🧪 Entered temporary lab: $tmpdir"
}

# Count files/dirs in current location
count() {
    echo "Files: $(find . -maxdepth 1 -type f | wc -l)"
    echo "Dirs:  $(find . -maxdepth 1 -type d | wc -l)"
}

# --- FILE MANIPULATION ---

# Quick Timestamp Backup
# Usage: backup file.txt -> file.txt.backup.20260110_120000
backup() {
    if [[ -f "$1" ]]; then
        local timestamp=$(date +"%Y%m%d_%H%M%S")
        cp "$1" "$1.backup.$timestamp" && echo "📦 Backed up to: $1.backup.$timestamp"
    else
        echo "❌ File not found: $1"
    fi
}

# --- SEARCH & ANALYSIS ---

# Find files larger than X (default 100M)
bigfiles() {
    local size=${1:-100M}
    echo "📊 Searching for files larger than $size..."
    find . -type f -size +"$size" -exec ls -lh {} \; | awk '{print $9 ": " $5}'
}

# Find duplicate files (MD5 hash based)
finddupes() {
    echo "🔍 Finding duplicate files in current directory..."
    find . -type f -exec md5sum {} + | sort | uniq -w32 -dD
}

# Recursive Grep Shortcut
grepf() {
    grep -r "$1" "${2:-.}"
}

# --- HASHING ---
md5() { echo -n "$1" | md5sum | awk '{print $1}'; }
sha1() { echo -n "$1" | sha1sum | awk '{print $1}'; }
sha256() { echo -n "$1" | sha256sum | awk '{print $1}'; }

# --- ARCHIVES ---

# Universal Extract
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
