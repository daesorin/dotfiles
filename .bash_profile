# SOURCE BASHRC FOR LOGIN SHELLS
if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi

# START SSH-AGENT IF NOT RUNNING
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
  ssh-agent -s >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
  source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi


# filen-cli
PATH=$PATH:~/.filen-cli/bin
