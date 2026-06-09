alias py='python3'
alias ipy='ipython'
serve() { python3 -m http.server "${1:-8000}"; }
