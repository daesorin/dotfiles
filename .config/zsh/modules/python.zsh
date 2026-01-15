# ==============================================================================
#  PYTHON & VIRTUAL ENVIRONMENTS
# ==============================================================================

# --- CORE ALIASES ---
alias python="python3"
alias py="python3"
alias pip="pip3"

# --- VIRTUAL ENVIRONMENTS ---
alias venv='python3 -m venv venv && echo "🐍 Created venv/ in current directory."'

activate() {
    if [[ -f "venv/bin/activate" ]]; then
        source venv/bin/activate
        echo "✅ Activated venv"
    elif [[ -f ".venv/bin/activate" ]]; then
        source .venv/bin/activate
        echo "✅ Activated .venv"
    else
        echo "❌ No virtual environment found in ./venv or ./.venv"
    fi
}

# --- UTILITIES ---

pyserve() {
    local port="${1:-8000}"
    echo "🌐 Serving $(pwd) on http://localhost:$port"
    python3 -m http.server "$port"
}

pyclean() {
    echo "🧹 Cleaning .pyc, .pyo, and __pycache__..."
    find . -type f -name "*.py[co]" -delete -o -type d -name "__pycache__" -delete
    echo "Done."
}

# --- ENCODING (Moved from functions.zsh) ---

urlencode() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: urlencode <text>"
        return 1
    fi
    python3 -c "import urllib.parse; print(urllib.parse.quote('$1'))"
}

urldecode() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: urldecode <encoded_text>"
        return 1
    fi
    python3 -c "import urllib.parse; print(urllib.parse.unquote('$1'))"
}
