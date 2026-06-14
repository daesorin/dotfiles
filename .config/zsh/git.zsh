# CORE HELPERS

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

# QUICK UTILITIES

git.last() {
    git log -1 HEAD
}

git.oops() {
    git commit --amend --no-edit
}

git.unstage() {
    git reset HEAD --
}

git.grab() {
    git checkout "$1" -- "$2"
}

git.fire() {
    local branch="fire-$(date +%Y%m%d-%H%M)"

    git checkout -b "$branch" &&
    git add -A &&
    git commit -m "FIRE EMERGENCY: $branch" --no-verify &&
    git push -u origin "$branch"
}

git.lazy() {
    if [ -z "$1" ]; then
        echo "Usage: git.lazy \"commit message\""
        return 1
    fi

    git add -A &&
    git commit -m "$1" &&
    git push
}

git.abort() {
    local branch
    branch=$(git branch --show-current)

    git fetch origin &&
    git reset --hard "origin/$branch"
}

git.nuke() {
    if [ -z "$1" ]; then
        echo "Usage: git.nuke <branch>"
        return 1
    fi

    git branch -D "$1"
    git push origin --delete "$1"
}

git.today() {
    git log --since='24 hours ago' --oneline --graph --all
}
