# ==============================================================================
#  CORE UTILITIES & INTERFACE
# ==============================================================================

# --- SAFETY NETS ---
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

# --- TEXT EDITORS ---
alias v='$EDITOR'
alias sv='sudo $EDITOR'
alias ,='$EDITOR'
alias ,,='sudo $EDITOR'
alias nano='nano -l' # Show line numbers

# Config Shortcuts
alias zshrc='$EDITOR $ZDOTDIR/.zshrc'
alias zreload='source $ZDOTDIR/.zshrc && echo "✅ ZSH config reloaded"'

# --- MODERN REPLACEMENTS ---

# Bat (Cat replacement with syntax highlighting)
if command -v bat &> /dev/null; then
    alias cat='bat --style=plain'
    alias preview='bat --style=numbers,changes'
fi

# Ripgrep (Grep replacement)
if command -v rg &> /dev/null; then
    alias grep='rg'
    alias rgg='rg -S'
else
    # Fallback coloring
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
fi

# --- YAZI (Navigation) ---
function ya() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# ==============================================================================
#  LISTING MASTER (Eza Configuration)
# ==============================================================================

if command -v eza &> /dev/null; then

    # Base options: Icons, group dirs first, git status
    _EZA_BASE="eza --group-directories-first --icons --color=always --git --no-quotes"
    _EZA_LIST="${_EZA_BASE} -lh"
    _EZA_TREE="${_EZA_BASE} --tree"

    # 1. Standard Listing
    alias l="${_EZA_BASE}"           # Basic list
    alias la="${_EZA_BASE} -a"       # All files (inc hidden)
    alias ld="${_EZA_BASE} -D"       # Directories only
    alias lda="${_EZA_BASE} -Da"     # Directories only (inc hidden)
    
    # 2. Detailed List View (Long)
    alias ll="${_EZA_LIST}"          # Long list
    alias lla="${_EZA_LIST} -a"      # Long list all
    alias lld="${_EZA_LIST} -D"      # Long list dirs only
    
    # 3. Tree View
    alias lt="${_EZA_TREE}"          # Tree view
    alias lta="${_EZA_TREE} -a"      # Tree view all
    alias ltl="${_EZA_TREE} -lh"     # Tree with long details
    alias ltla="${_EZA_TREE} -lha"   # Tree all with long details
    
    # 4. Sorting & Metrics
    alias ltn="${_EZA_LIST} --sort=modified" # Sort by Modified
    alias lsz="${_EZA_LIST} --sort=size"     # Sort by Size
    alias lo="${_EZA_LIST} --octal-permissions" # Show octal perms (755)
    
    # 5. Disk Usage (Recursive)
    alias lz="${_EZA_LIST} --total-size"    # Recursive size of current dir
    alias lza="${_EZA_LIST} -a --total-size"

else
    # Fallback to standard LS if eza is missing
    echo "⚠️  Eza not found. Using standard ls."
    alias l='ls --color=auto --group-directories-first'
    alias la='ls -A --color=auto --group-directories-first'
    alias ll='ls -lh --color=auto --group-directories-first'
    alias lla='ls -lhA --color=auto --group-directories-first'
    alias lt='tree -C'
fi

# --- SYSTEM & HARDWARE INFO ---
alias hw='hwinfo --short'
alias audio='lspci | grep -i audio'
alias usb='lsusb'
alias pci='lspci'
alias mycpu='grep MHz /proc/cpuinfo'

# --- POWER MANAGEMENT ---
alias sus='systemctl suspend'
alias rb='sudo systemctl reboot'
alias off='sudo systemctl poweroff'
alias lock='loginctl lock-session'

# --- ... --- 
alias find='fd'
alias ps='procs'
alias cd='z'
alias bltspeak='echo "connect 41:42:9E:F5:1C:C9" | bluetoothctl'
alias bltmouse='echo "connect 30:24:78:A0:00:BD" | bluetoothctl'
