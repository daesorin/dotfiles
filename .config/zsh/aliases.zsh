#!/usr/bin/env zsh
# Optimized ZSH Aliases for Arch Linux Desktop
# Source this file in your ~/.zshrc: source ~/.zsh_aliases

# PYTHON
alias python="python3"
alias py="python3"
alias pip="pip3"

# NETWORKING
# Network interfaces
alias netlist='ip link show'
alias netip='ip addr show'

# SYSTEM MONITORING (Arch Linux)
alias syscheck="echo -e '\n🔧 System: ' \$(uname -r); \
                 echo -e '\n💽 Disk: ' \$(df -h / | tail -1); \
                 echo -e '\n🧠 Memory: ' \$(free -h | grep Mem); \
                 echo -e '\n📡 Network: ' \$(ip addr show | grep 'inet ' | grep -v 127.0.0.1 | head -1)"



# Process monitoring
alias pscpu='ps aux --sort=-%cpu | head -n 11'
alias topcpu='ps aux --sort=-%cpu | head -n 20'
alias topmem='ps aux --sort=-%mem | head -n 20'

# Pacman
alias pac='sudo pacman' # General pacman
alias pacs='sudo pacman -S' # Install package
alias pacr='sudo pacman -R' # Remove package
alias pacrns='sudo pacman -Rns' # Remove package and unneeded dependencies
alias pacu='sudo pacman -Syu' # Update system
alias pacss='pacman -Ss' # Search repos
alias pacsi='pacman -Si' # Repo package info
alias pacqs='pacman -Qs' # Search installed
alias pacqi='pacman -Qi' # Installed package info
alias pacql='pacman -Ql' # List files installed by a package
alias pacqo='pacman -Qo' #  Find package owning a file
alias pacclean='sudo pacman -Sc'
alias pacorphan='sudo pacman -Rns $(pacman -Qtdq)'
alias paclist='pacman -Qe'
alias paccount='pacman -Q | wc -l'

# Paru
alias parus='paru -S'
alias paruu='paru -Syu'
alias paruss='paru -Ss'
alias parur='paru -R'
alias parurns='paru -Rns'
alias paruc='paru -Sc'

# SYSTEMD
alias sctl='systemctl'
alias sctls='systemctl status'
alias sctf='systemctl --failed'
alias sctlr='sudo systemctl restart'
alias sctlstart='sudo systemctl start'
alias sctlstop='sudo systemctl stop'
alias sctlen='sudo systemctl enable'
alias sctldis='sudo systemctl disable'
alias sctlre='sudo systemctl daemon-reload'

# User systemd
alias usctl='systemctl --user'
alias usctls='systemctl --user status'
alias usctlr='systemctl --user restart'
alias usctlstart='systemctl --user start'
alias usctlstop='systemctl --user stop'
alias usctlen='systemctl --user enable'
alias usctldis='systemctl --user disable'

# .NET TOOLS
alias dn='dotnet'
alias dnb='dotnet build'
alias dnr='dotnet run'
alias dnt='dotnet test'
alias dnp='dotnet publish'
alias dnc='dotnet clean'
alias dnw='dotnet watch'
alias dnwr='dotnet watch run'
alias dnnew='dotnet new'
alias dnadd='dotnet add'
alias dnrestore='dotnet restore'

# GIT
# --- CORE ---
alias g='git'
alias gi='git init'
alias gst='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gr='git remote -v'    # Verbose by default. Who would want it silent?
# --- STAGING ---
alias ga='git add'          # Basic add
alias gaa='git add --all'   # The real "Add All"
alias gap='git add -p'      # Surgical patch add
alias gau='git add -u'      # Only update tracked files (ignore new ones)
# --- COMMITTING ---
alias gc='git commit -v'    # Verbose: shows the diff in the editor
alias gca='git commit --amend --no-edit' # Fix the last mistake silently
# Moved gcm to functions.
# --- BRANCHING & SWITCHING ---
alias gb='git branch'
alias gba='git branch -a'
alias gsw='git switch'
alias gswc='git switch -c'  # Create and switch (replaces checkout -b)
alias grs='git restore'     # Discard changes in working directory
alias grss='git restore --staged' # Unstage files
# --- PUSH & PULL ---
alias gl='git pull'
alias gp='git push'
alias gpf='git push --force-with-lease' # Safe force push
alias gpsup='git push --set-upstream origin $(git branch --show-current)'
# --- LOGGING & HISTORY ---
# A clean graph view
alias glg='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)" --all'
alias glo='git log --oneline --decorate'
alias glS='git log --show-signature' # Verify GPG signatures
# --- REBASE & STASH ---
alias grb='git rebase'
alias grbi='git rebase -i'  # Interactive rebase (essential)
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias gsta='git stash push'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstc='git stash clear'
# --- UTILS ---
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'

# DOCKER
alias dk='docker' # Docker general
alias dkc='docker container' # Docker container
alias dki='docker image' # Docker image
alias dkv='docker volume' # Docker volume
alias dkn='docker network' # Docker network
alias dps='docker ps' # Docker ps
alias dpsa='docker ps -a' # Docker ps all
alias di='docker images' # Docker images
alias dstart='docker start' # Docker start
alias dstop='docker stop' # Docker stop
alias drm='docker rm' # Docker remove container
alias drmi='docker rmi' # Docker remove image
alias dlog='docker logs' # Docker logs
alias dlogf='docker logs -f' # Docker logs follow
alias dexec='docker exec -it' # Docker exec interactive
alias dbuild='docker build' # Docker build
alias dpull='docker pull' # Docker pull
alias dpush='docker push' # Docker push
alias drun='docker run' # Docker run
alias dprune='docker system prune -af' # Docker system prune    

# Docker Compose
alias dc='docker-compose' # Docker Compose general
alias dcup='docker-compose up -d' # Docker Compose up detached
alias dcdown='docker-compose down' # Docker Compose down
alias dcrestart='docker-compose restart' # Docker Compose restart
alias dclogs='docker-compose logs -f' # Docker Compose logs follow
alias dcps='docker-compose ps' # Docker Compose ps

# FILE OPERATIONS
# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

alias mkdir='mkdir -pv'

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Quick file operations
alias rd='rmdir'
alias rmf='rm -rf'

# TEXT EDITORS
alias v='$EDITOR'
alias vi='$EDITOR'
alias vim='$EDITOR'
alias nano='nano -l'  # Show line numbers
alias vimrc='$EDITOR ~/.vimrc'
alias zshrc='$EDITOR ~/.zshrc'

# DEVELOPMENT TOOLS
# Node.js/npm
alias npmg='npm install -g' # Global install
alias npmu='npm uninstall' # Uninstall
alias npmug='npm uninstall -g' # Uninstall global
alias npmi='npm install' # Install
alias npms='npm start' # Start
alias npmt='npm test' # Test
alias npmr='npm run' # Run
alias npml='npm list' # List
alias npmo='npm outdated' # Outdated

# Yarn
alias y='yarn' # General yarn
alias ya='yarn add' # Yarn add
alias yad='yarn add --dev' # Yarn add dev
alias yr='yarn remove' # Yarn remove
alias yi='yarn install' # Yarn install
alias ys='yarn start' # Yarn start
alias yt='yarn test' # Yarn test
alias yb='yarn build' # Yarn build

# Python virtual environments
alias venv='python -m venv venv' # Create venv in current dir
alias activate='source venv/bin/activate' # Activate venv
alias deactivate='deactivate' # Deactivate venv

# POWER MANAGEMENT
#alias hib='systemctl hibernate' # Hibernate the system
alias zzz='systemctl sleep'
#alias hyb='systemctl hybrid-sleep'
alias sus='systemctl suspend' # Suspend the system
alias rb='sudo systemctl reboot' # Reboot the system
alias off='sudo systemctl poweroff' # Shutdown the system
alias lock='loginctl lock-session' # Lock the session
alias startcharge='sudo tlp setcharge 0 100'

# BLUETOOTH
alias bt='bluetoothctl'
alias bton='bluetoothctl power on'
alias btoff='bluetoothctl power off'
alias btlist='bluetoothctl devices'
alias btscan='bluetoothctl scan on'
alias btconnect='bluetoothctl connect'
alias btdisconnect='bluetoothctl disconnect'

# FIREWALL (UFW)
alias fw='sudo ufw'
alias fws='sudo ufw status'
alias fwv='sudo ufw status verbose'
alias fwen='sudo ufw enable'
alias fwdis='sudo ufw disable'
alias fwallow='sudo ufw allow'
alias fwdeny='sudo ufw deny'

# HARDWARE INFO
alias hw='hwinfo --short'
alias audio='lspci | grep -i audio'
alias usb='lsusb'
alias pci='lspci'

# UTILITY ALIASES
# Date and time
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias today='date +"%Y-%m-%d"'
alias week='date +%V'
alias timestamp='date +%s'

# Color support
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# Quick shortcuts
alias e='$EDITOR'
alias o='xdg-open'

# FUN STUFF
alias hack='cmatrix'

# VPN & Network Aliases
alias vpnup='sudo wg-quick up proton'
alias vpndown='sudo wg-quick down proton'

# Tor Controls
alias torup='sudo systemctl start tor && echo "Tor Service Started [On]"'
alias tordown='sudo systemctl stop tor && echo "Tor Service Stopped [Off]"'

alias filen='filen-cli'

alias shame="python3 ~/scripts/mirror.py"

# Webcam (Mirror)
alias cam='mpv av://v4l2:/dev/video0 --profile=low-latency --title="Webcam"'

alias finance='cd /home/daesorin/Documents/finance/'

# --- VPN CONTROL (Proton Community CLI) ---
alias vpn='protonvpn'
alias vpn-on='protonvpn connect --fastest'    # Connect to the fastest available server
alias vpn-nl='protonvpn connect --cc NL'      # Connect to Netherlands
alias vpn-us='protonvpn connect --cc US'      # Connect to USA
alias vpn-off='protonvpn disconnect'          # Kill the connection
alias vpn-stat='protonvpn info'               # Check account/connection status
