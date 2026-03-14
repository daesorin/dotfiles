#!/usr/bin/env bash
# bootstrap.sh -- Arch Linux setup from dotfiles

set -e

if ! command -v pacman &>/dev/null; then
  echo "!! Arch Linux only."
  exit 1
fi

echo "-> Installing native packages..."

PACKAGES=(
  # Shell
  zsh
  starship
  zoxide
  eza

  # Terminal & multiplexer
  kitty
  tmux

  # Compositor & desktop
  hyprland
  hyprlock
  hypridle
  hyprpaper
  waybar
  rofi
  mako

  # Editor
  neovim

  # Media
  mpd
  ncmpcpp
  mpv

  # Utilities
  btop
  zathura
  zathura-pdf-mupdf

  # Base
  git
  go
  base-devel
)

sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

echo "-> Installing AUR packages..."

AUR_PACKAGES=(
  paru
)

if command -v paru &>/dev/null; then
  echo "paru already installed."
elif command -v yay &>/dev/null; then
  echo "yay found. Installing AUR packages..."
  yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"
else
  echo "!! No AUR helper found. Install paru manually:"
  echo "   https://github.com/morganamilo/paru"
fi

echo "-> Installing gitmux via go..."

if ! command -v gitmux &>/dev/null; then
  go install github.com/arl/gitmux@latest
  echo "gitmux installed to ~/go/bin/"
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
