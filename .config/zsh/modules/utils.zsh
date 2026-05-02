# ── bat ───────────────────────────────────────────────────────────────────────
alias cat='bat --paging=never'
alias bap='bat --paging=always'
alias b='bat'

# ── eza ───────────────────────────────────────────────────────────────────────
alias ls='eza --group-directories-first'
alias l='eza -lh --group-directories-first --git'
alias la='eza -lah --group-directories-first --git'
alias lt='eza -lh --tree --group-directories-first --git'
alias lta='eza -lah --tree --group-directories-first --git'
alias lt2='eza --tree --level=2'
alias lt3='eza --tree --level=3'

# ── zoxide ────────────────────────────────────────────────────────────────────
alias cd='z'
alias cdi='zi'       # interactive picker

# ── safer defaults ────────────────────────────────────────────────────────────
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'    # prompt once for 3+ files; -I is less annoying than -i
alias mkdir='mkdir -pv'

# ── navigation ────────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# nvim
alias ,='nvim'
alias ,,='sudo nvim'

# misc
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'

alias cls='clear'
alias path='echo $PATH | tr ":" "\n"'
alias reload='exec zsh'

# ── clipboard (wayland / x11 fallback) ───────────────────────────────────────
if command -v wl-copy &>/dev/null; then
    alias copy='wl-copy'
    alias paste='wl-paste'
elif command -v xclip &>/dev/null; then
    alias copy='xclip -selection clipboard'
    alias paste='xclip -selection clipboard -o'
fi

# ── find helpers ──────────────────────────────────────────────────────────────
# ff <pattern>  — find files by name
ff() { find "${2:-.}" -type f -iname "*$1*" 2>/dev/null }

# fd alias (prefer fd-find binary name on some distros)
command -v fdfind &>/dev/null && alias fd='fdfind'

# ── quick http server ─────────────────────────────────────────────────────────
serve() { python3 -m http.server "${1:-8000}" }

# ── mkcd ──────────────────────────────────────────────────────────────────────
mkcd() { mkdir -p "$1" && cd "$1" }
