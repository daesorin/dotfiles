#!/usr/bin/env bash
# bootstrap.sh -- Arch Linux setup from dotfiles

set -e

if ! command -v pacman &>/dev/null; then
  echo "!! Arch Linux only."
  exit 1
fi

META_DIR="$(dirname "$(realpath "$0")")"

echo "-> Installing native packages..."

if [ -f "$META_DIR/native-packages.txt" ]; then
  PACKAGES=$(awk '{print $1}' "$META_DIR/native-packages.txt")
  sudo pacman -S --needed --noconfirm $PACKAGES
else
  echo "!! native-packages.txt not found in $META_DIR"
  exit 1
fi

echo "-> Installing AUR packages..."

if [ -f "$META_DIR/aur-packages.txt" ]; then
  AUR_PACKAGES=$(awk '{print $1}' "$META_DIR/aur-packages.txt")
  if command -v paru &>/dev/null; then
    paru -S --needed --noconfirm $AUR_PACKAGES
  elif command -v yay &>/dev/null; then
    yay -S --needed --noconfirm $AUR_PACKAGES
  else
    echo "!! No AUR helper found. Install the following manually:"
    echo "$AUR_PACKAGES"
  fi
else
  echo "!! aur-packages.txt not found in $META_DIR"
  exit 1
fi

echo "-> Installing gitmux via go..."

if ! command -v gitmux &>/dev/null; then
  go install github.com/arl/gitmux@latest
  echo "gitmux installed to ~/go/bin/"
  echo "Make sure ~/go/bin is in your PATH."
else
  echo "gitmux already installed."
fi

echo "-> Cloning TPM..."

TPM_DIR="$HOME/.config/tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "TPM already present."
fi

echo ""
echo "Done."
echo "- Start tmux and press prefix + I to install plugins."
echo "- Set zsh as default shell: chsh -s \$(which zsh)"
