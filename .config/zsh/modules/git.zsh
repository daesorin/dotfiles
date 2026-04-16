# ~/.config/zsh/module/git.zsh
# Version control aliases

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gs='git status -s'
alias gst='git status'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias glo='git log --oneline --graph --decorate'
alias gco='git checkout'
alias gb='git branch'

# Repository management for dotfiles
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
