speak() {
    # Default to the best quality voice you have
    local VOICE="libri"
    local TEXT=""
    local MODEL_DIR="$HOME/piper-voices"

    # Flag processing: Check if the user typed -v name
    if [[ "$1" == "-v" ]]; then
        if [[ -n "$2" ]]; then
            VOICE="$2"
            shift 2
        else
            echo "Error: -v requires a voice name (alan, libri, ryan)."
            return 1
        fi
    fi

    local MODEL="${MODEL_DIR}/${VOICE}.onnx"

    if [ ! -f "$MODEL" ]; then
        echo "Error: Voice file not found at $MODEL"
        echo "Available voices: alan, libri, ryan"
        return 1
    fi

    # LOGIC: Run explicitly without a variable to satisfy Zsh
    if [ -t 0 ]; then
        # Argument mode
        echo "$*" | piper-tts --model "$MODEL" --output-raw | \
        aplay -r 22050 -f S16_LE -t raw -q -B 500000
    else
        # Pipe mode
        cat | piper-tts --model "$MODEL" --output-raw | \
        aplay -r 22050 -f S16_LE -t raw -q -B 500000
    fi
}
