#  PYTHON, IPYTHON & VIRTUAL ENVIRONMENTS

# --- CORE ALIASES ---
if command -v python3 &>/dev/null; then
    alias python="python3"
    alias pip="pip3"
else
    alias pip="pip"
fi

alias py="python"
alias ipy="ipython"

# --- VIRTUAL ENVIRONMENTS ---
alias venv='python3 -m venv venv && echo "🐍 Created venv/ in current directory."'

activate() {
    if [[ -f "venv/bin/activate" ]]; then
        source venv/bin/activate
        echo "✅ Activated venv (Type 'deactivate' to exit)"
    elif [[ -f ".venv/bin/activate" ]]; then
        source .venv/bin/activate
        echo "✅ Activated .venv (Type 'deactivate' to exit)"
    else
        echo "❌ No virtual environment found in ./venv or ./.venv"
    fi
}

# --- UTILITIES ---

calc() {
    local math_expression="$*"
    if command -v ipython &>/dev/null; then
        ipython -c "$math_expression"
    else
        python3 -c "print($math_expression)"
    fi
}

pyserve() {
    local port="${1:-8000}"
    local ip=$(hostname -I | cut -d' ' -f1) 
    echo "🌐 Serving $(pwd)"
    echo "   Local:   http://localhost:$port"
    echo "   Network: http://$ip:$port"
    python3 -m http.server "$port"
}

pyclean() {
    echo "🧹 Cleaning .pyc, .pyo, and __pycache__..."
    find . -type f -name "*.py[co]" -delete -o -type d -name "__pycache__" -delete
    echo "✨ Done."
}

# --- ENCODING ---

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
