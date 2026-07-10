# PACKAGE MANAGEMENT
alias pm='sudo pacman'
alias pr='paru'

# EZA
alias ls='ls --color=always'
alias lz='eza --group-directories-first'
alias l='eza -l --group-directories-first --git'
alias li='eza -laai --group-directories-first --git'
alias la='eza -la --group-directories-first --git'
alias lt='eza -l --tree --group-directories-first --git'
alias lta='eza -la --tree --group-directories-first --git'
alias lt2='eza --tree --level=2'
alias lt3='eza --tree --level=3'

# BAT
alias cat='bat --paging=never'
alias bap='bat --paging=always'
alias b='bat'

# SAFER DEFAULTS
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'

alias rmr='rm -Irv'
alias rmf='rm -frv'
alias mkdir='mkdir -pv'

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
alias chmod='chmod -v'
alias suchmod='sudo chmod -v'

alias cls='clear'
alias path='echo $PATH | tr ":" "\n"'
alias reload='exec bash'

# global
alias -g L='| less'
alias -g G='| grep -i'
alias -g WC='| wc -l'
alias -g NUL='>/dev/null 2>&1'
alias -g E='2>&1'
alias -g COPY='| wl-copy'

alias fullcharge='sudo tlp fullcharge'
alias paste='wl-paste'
alias ic='incus'

# GIT
alias gs='git status'
alias gst='git status -sb'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -am'
alias gco='git checkout'
alias gb='git branch'
alias gm='git merge'
alias gp='git push'
alias gpl='git pull'
alias gun='git reset HEAD --'

alias dot='git dot'

alias netlist='ip link show'
alias netip='ip addr show'
alias ports='sudo ss -tulpn'
alias myip='curl -s https://ifconfig.me && echo'
alias iptor='torsocks curl -s https://ifconfig.me'


# FIREWALL (UFW)
alias fw='sudo ufw'
alias fws='sudo ufw status'
alias fwv='sudo ufw status verbose'
alias fwen='sudo ufw enable'
alias fwdis='sudo ufw disable'
alias fwallow='sudo ufw allow'
alias fwdeny='sudo ufw deny'

# BLUETOOTH
alias bt='bluetoothctl'
alias bton='bluetoothctl power on'
alias btoff='bluetoothctl power off'
alias btlist='bluetoothctl devices'
alias btscan='bluetoothctl scan on'
alias btconnect='bluetoothctl connect'
alias btdisconnect='bluetoothctl disconnect'

#  VPN & PRIVACY
alias vpnup='sudo wg-quick up proton'
alias vpndown='sudo wg-quick down proton'
alias torup='sudo systemctl start tor && echo "Tor Service Started [O n]"'
alias tordown='sudo systemctl stop tor && echo "Tor Service Stopped [ Off]"'
alias torstat='systemctl status tor'
alias torres='sudo systemctl restart tor'
alias trun='torsocks'
alias tormon='nyx'

# STATIC REASSIGNMENTS
alias git.last='git log -1 HEAD'
alias git.oops='git commit --amend --no-edit'
alias git.unstage='git reset HEAD --'
alias git.today="git log --since='24 hours ago' --oneline --graph --all"

# PYTHON
alias py='python3'
alias ipy='ipython'

# ZATHURA PDF Reader
alias zt='zathura'

# SYSTEMD
alias sys='systemctl'
alias susys='sudo systemctl'

# TMUX
alias tx='tmux'
alias txn='tmux new -s'
alias txnmain='tmux new -s main'
alias txa='tmux attach -t'
alias txkw='tmux kill-window -t'
alias txks='tmux kill-session -t'
alias txkp='tmux kill-pane -t'
