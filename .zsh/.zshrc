[[ -o interactive ]] || return

if [[ -d "$ZDOTDIR" ]]; then
	for config in "$ZDOTDIR"/*.zsh(N); do
		source "$config"
	done
fi
