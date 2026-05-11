# BAT
alias cat='bat --paging=never'
alias bap='bat --paging=always'
alias b='bat'

# EZA
alias ls='eza --group-directories-first'
alias l='eza -lh --group-directories-first --git'
alias la='eza -lah --group-directories-first --git'
alias lt='eza -lh --tree --group-directories-first --git'
alias lta='eza -lah --tree --group-directories-first --git'
alias lt2='eza --tree --level=2'
alias lt3='eza --tree --level=3'

# ZOXIDE
alias cd='z'
alias cdi='zi' # interactive picker

# SAFER DEFAULTS
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv' # prompt once for 3+ files; -i is less annoying than -i
alias mkdir='mkdir -pv'

# NAVIGATION
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# NVIM
alias ,='nvim'
alias ,,='sudo nvim'

# MISC
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'

alias cls='clear'
alias path='echo $PATH | tr ":" "\n"'
alias reload='exec bash'

# CLIPBOARD
if command -v wl-copy &>/dev/null; then
  alias copy='wl-copy'
  alias paste='wl-paste'
elif command -v xclip &>/dev/null; then
  alias copy='xclip -selection clipboard'
  alias paste='xclip -selection clipboard -o'
fi

# DOCKER
alias dck='docker'
alias dc='docker compose'

# INCUS
alias ic='incus'

# TMUX
alias tx='tmux'

# FIND HELPERS
# find files by name
ff() { find "${2:-.}" -type f -iname "*$1*" 2>/dev/null; }

# prefer fd-find binary name on some distros
command -v fdfind &>/dev/null && alias fd='fdfind'

# PYTHON
alias py='python3'
alias ipy='ipython'

# QUICK HTTP SERVER
serve() { python3 -m http.server "${1:-8000}"; }

# MKCD
mkcd() { mkdir -p "$1" && cd "$1"; }

# FORGEJO
alias fgj='fj -H https://git.osaigbovo.xyz'

# Power
alias sus='systemctl suspend'
alias fullcharge='sudo tlp fullcharge'
