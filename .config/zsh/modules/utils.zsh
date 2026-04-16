# ~/.config/zsh/module/util.zsh

# eza aliases
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --group-directories-first --icons'
    alias ll='eza -lh --group-directories-first --icons'
    alias la='eza -lah --group-directories-first --icons'
    alias lt='eza --tree --level=2 --icons'
fi

# Neovim aliases
alias ,='nvim'
alias ,,='sudo nvim'

# Standard utilities with rational defaults
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias grep='grep --color=auto'
alias df='df -h'
alias free='free -m'
alias mkdir='mkdir -p'

# Fetch and update Arch mirrorlist via curl
reflector() {
    local target_file="/etc/pacman.d/mirrorlist"
    local backup_file="/etc/pacman.d/mirrorlist.backup.$(date +%Y%m%d%H%M%S)"
    local url="https://archlinux.org/mirrorlist/?country=all&protocol=https&ip_version=4&use_mirror_status=on"

    echo "Backing up current mirrorlist to ${backup_file}..."
    sudo cp "${target_file}" "${backup_file}"

    echo "Fetching new mirrorlist..."
    curl -s "$url" | sed -e 's/^#Server/Server/' -e '/^#/d' | sudo tee "${target_file}" > /dev/null

    echo "Mirrorlist updated. Synchronising package databases..."
    sudo pacman -Syy
}
