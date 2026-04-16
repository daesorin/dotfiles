# ~/.config/zsh/module/incus.zsh
# Incus container aliases

alias ic='incus'
alias icl='incus list'
alias ics='incus start'
alias icx='incus stop'
alias icr='incus restart'
alias ice='incus exec'
alias icc='incus console'
alias ici='incus info'
alias icimg='incus image list'

# Quick shell access into a container
alias ish='incus exec \!* -- sh -c "zsh || bash || sh"'
