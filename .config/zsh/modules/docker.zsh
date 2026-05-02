# ── core ──────────────────────────────────────────────────────────────────────
alias dck='docker'
alias dc='docker compose'

# ── containers ────────────────────────────────────────────────────────────────
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dst='docker start'
alias dsp='docker stop'
alias drst='docker restart'
alias drm='docker rm'
alias drmf='docker rm -f'

# ── images ────────────────────────────────────────────────────────────────────
alias di='docker images'
alias drmi='docker rmi'
alias dpull='docker pull'
alias dbuild='docker build'
alias dtag='docker tag'
alias dpush='docker push'

# ── exec / logs ───────────────────────────────────────────────────────────────
alias dlog='docker logs'
alias dlogf='docker logs -f'

# shell into running container (bash fallback to sh)
dsh() { docker exec -it "$1" bash 2>/dev/null || docker exec -it "$1" sh }

# exec arbitrary command
dex() { docker exec -it "$1" "${@:2}" }

# ── inspect ───────────────────────────────────────────────────────────────────
alias dins='docker inspect'
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias dstats='docker stats --no-trunc'
alias dtop='docker top'

# ── networks / volumes ────────────────────────────────────────────────────────
alias dnet='docker network ls'
alias dvol='docker volume ls'

# ── compose ───────────────────────────────────────────────────────────────────
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcd='docker compose down'
alias dcr='docker compose restart'
alias dcp='docker compose pull'
alias dcb='docker compose build'
alias dcl='docker compose logs'
alias dclf='docker compose logs -f'
alias dcps='docker compose ps'

# ── cleanup ───────────────────────────────────────────────────────────────────
alias dprune='docker system prune -f'
alias dprunea='docker system prune -af --volumes'
alias drmstop='docker rm $(docker ps -aq -f status=exited) 2>/dev/null'

# ── functions ─────────────────────────────────────────────────────────────────

# run throwaway container with current dir mounted
drun() {
    docker run --rm -it \
        -v "$(pwd):/work" \
        -w /work \
        "$@"
}
