# ==============================================================================
#  DOCKER & COMPOSE
# ==============================================================================

# --- DOCKER CORE ---
alias dk='docker'
alias dkc='docker container'
alias dki='docker image'
alias dkv='docker volume'
alias dkn='docker network'

# --- CONTAINERS & LIFECYCLE ---
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dstart='docker start'
alias dstop='docker stop'
alias drun='docker run'
alias dexec='docker exec -it' 

# --- IMAGES & BUILDING ---
alias dbuild='docker build'
alias dpull='docker pull'
alias dpush='docker push'

# --- LOGS ---
alias dlog='docker logs'
alias dlogf='docker logs -f'

# --- CLEANUP (Destructive) ---
alias drm='docker rm'
alias drmi='docker rmi'
alias dprune='docker system prune -af'

# --- DOCKER COMPOSE ---
alias dc='docker-compose'
alias dcup='docker-compose up -d'
alias dcdown='docker-compose down'
alias dcrestart='docker-compose restart'
alias dclogs='docker-compose logs -f'
alias dcps='docker-compose ps'

# --- FUNCTIONS ---
dstopall() {
    local containers=$(docker ps -q)
    if [[ -n "$containers" ]]; then
        echo "🛑 Stopping all containers..."
        docker stop $containers
    else
        echo "No running containers."
    fi
}

drmstopped() {
    echo "🧹 Removing stopped containers..."
    docker container prune -f
}
