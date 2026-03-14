#!/usr/bin/env bash
# install.sh -- Clone dotfiles bare repo and check out files

set -e

DOTFILES_REPO="https://github.com/daesorin/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

echo "-> Cloning dotfiles..."

if [ -d "$DOTFILES_DIR" ]; then
  echo "!! $DOTFILES_DIR already exists. Aborting."
  exit 1
fi

git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"

dot() {
  git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

echo "-> Checking out files..."

if ! dot checkout 2>/dev/null; then
  echo "!! Conflicts found. Backing up to ~/.dotfiles-backup/"
  mkdir -p "$HOME/.dotfiles-backup"
  dot checkout 2>&1 |
    grep "^\s" |
    awk '{print $1}' |
    xargs -I{} sh -c \
      'mkdir -p ~/.dotfiles-backup/$(dirname {}) && mv ~/{} ~/.dotfiles-backup/{}'
  dot checkout
fi

dot config --local status.showUntrackedFiles no

echo "-> Adding dot alias to .zshenv..."

ALIAS_LINE="alias dot='git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'"

if ! grep -q "alias dot=" "$HOME/.zshenv" 2>/dev/null; then
  echo "$ALIAS_LINE" >>"$HOME/.zshenv"
fi

echo ""
echo "Done. Restart your shell or run: source ~/.zshenv"
echo "To install packages on Arch: bash ~/.dotfiles/bootstrap.sh"
