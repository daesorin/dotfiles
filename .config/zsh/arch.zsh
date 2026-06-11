# PACMAN
alias pm='sudo pacman'
alias pmS='sudo pacman -S'     # install
alias pmR='sudo pacman -Rns'   # remove + deps + config
alias pmSyu='sudo pacman -Syu' # full upgrade
alias pmSs='pacman -Ss'        # search repos
alias pmQs='pacman -Qs'        # search installed
alias pmQi='pacman -Qi'        # local package info
alias pmSi='pacman -Si'        # remote package info
alias pmQl='pacman -Ql'        # list files in package
alias pmQo='pacman -Qo'        # which package owns file
alias pmQdt='pacman -Qdt'      # orphans
alias pmSc='sudo pacman -Sc'   # clean package cache
alias pmScc='sudo pacman -Scc' # clean all cache

# remove orphans
pmorphans() {
  local orphans
  orphans=$(pacman -Qdtq)
  [[ -n "$orphans" ]] && sudo pacman -Rns $orphans || echo "no orphans"
}

# PACMAN
alias pa='paru'
alias paS='paru -S'
alias paR='paru -Rns'
alias paSyu='paru -Syu'
alias paSs='paru -Ss'
alias paQs='paru -Qs'

# REFLECTOR
# update mirrorlist via reflector (curl because egress may be restricted to curl on some setups)
mirrors() {
  local country="${1:-NG,ZA,DE,FR,GB}"
  echo "fetching mirrors for: $country"
  curl -s \
    "https://archlinux.org/mirrorlist/?country=${country//,/&country=}&protocol=https&use_mirror_status=on" |
    sed 's/^#Server/Server/' |
    sudo tee /etc/pacman.d/mirrorlist.tmp >/dev/null &&
    sudo mv /etc/pacman.d/mirrorlist.tmp /etc/pacman.d/mirrorlist &&
    echo "mirrorlist updated"
}

# rank top N fastest mirrors from current list: mirrors-rank [n]
mirrors-rank() {
  local n="${1:-10}"
  sudo rankmirrors -n "$n" /etc/pacman.d/mirrorlist |
    sudo tee /etc/pacman.d/mirrorlist.ranked &&
    sudo mv /etc/pacman.d/mirrorlist.ranked /etc/pacman.d/mirrorlist &&
    echo "ranked top $n mirrors"
}

# SYSTEM
alias pkgcount='pacman -Qq | wc -l'
alias pkgexp='pacman -Qqe' # explicitly installed
alias pkgall='pacman -Qq'  # all
