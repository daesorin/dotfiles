# SOURCE ZSHRC FOR LOGIN SHELLS
[[ -f ~/.zshrc ]] && source ~/.zshrc

# START SSH-AGENT IF NOT RUNNING
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    ssh-agent -s > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi

if [[ -z "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

eval $(/usr/bin/gnome-keyring-daemon --start --components=secrets)
export SSH_AUTH_SOCK

# filen-cli
typeset -U path
path+=("$HOME/.filen-cli/bin")

