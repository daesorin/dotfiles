# dotfiles

Personal configuration files for macOS.
Managed with a bare git repository.

---

## What Is In Here

* Shell: zsh with modular config
* Prompt: Starship
* Terminal: Kitty
* Multiplexer: tmux + TPM
* Editor: Neovim (LazyVim)
* Media: mpv
* Utilities: btop

---

## Install

Clone and set up the bare repository:

```bash
curl -fsSL https://code.sgbvmr.xyz/daesorin/dotfiles/raw/branch/mac/.dotfiles-meta/install.sh | bash

```

Then restart your shell. To install the required macOS packages via Homebrew:

```bash
bash ~/.dotfiles-meta/bootstrap.sh

```

---

## Structure

All files live directly in their standard locations under `$HOME`.

---

## Notes

* Designed and tested specifically for macOS.
* Neovim configuration is LazyVim-based.
* tmux plugins are managed by TPM. Run `prefix + I` after the first launch to install them.
* gitmux is installed via `go install`; see `bootstrap.sh` for the exact command.

