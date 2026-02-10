# --- CORE ---
alias g='git'
alias gi='git init'
alias gst='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gr='git remote -v'

# --- STAGING ---
alias ga='git add'
alias gaa='git add --all'
alias gap='git add -p'
alias gau='git add -u'

# --- COMMITTING ---
alias gc='git commit -m'
alias gca='git commit --amend --no-edit'

# --- BRANCHING ---
alias gb='git branch'
alias gba='git branch -a'
alias gsw='git switch'
alias gswc='git switch -c'
alias grs='git restore'
alias grss='git restore --staged'

# --- PUSH & PULL ---
alias gl='git pull'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpsup='git push --set-upstream origin $(git branch --show-current)'

# --- LOGGING ---
alias glg='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)" --all'
alias glo='git log --oneline --decorate'
alias glS='git log --show-signature'

# --- UTILS ---
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
