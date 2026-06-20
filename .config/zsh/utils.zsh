# BAT
alias cat='bat --paging=never'
alias bap='bat --paging=always'
alias b='bat'

# EZA
alias ls='ls --color=always'
alias lz='eza --group-directories-first'
alias l='eza -lh --group-directories-first --git'
alias la='eza -lah --group-directories-first --git'
alias lt='eza -lh --tree --group-directories-first --git'
alias lta='eza -lah --tree --group-directories-first --git'
alias lt2='eza --tree --level=2'
alias lt3='eza --tree --level=3'

# SAFER DEFAULTS
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv' # prompt once for 3+ files; -i is less annoying than -i
alias rmr='rm -Irv'
alias rmf='rm -frv'
alias mkdir='mkdir -pv'

# NAVIGATION
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

cdc() {
	cd "$1" ; clear
}

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
alias paste='wl-paste'

copy() {
	cat $1 | wl-copy;
}

# FIND HELPERS
#ff() { find "${2:-.}" -type f -iname "*$1*" 2>/dev/null; }
#command -v fdfind &>/dev/null && alias fd='fdfind'

# MKCD
mkcd() { mkdir -p "$1" && cd "$1"; }

alias fullcharge='sudo tlp fullcharge'
