# Dotfiles

My personal configuration files for **Arch Linux** and **macOS**. Managed using a **Git Bare Repository** to keep the home directory clean without symlinks or external tools.

## The Stack

- **OS:** Arch Linux (ThinkPad T490s), macOS (MacBook Air), Android (Termux)
- **Shell:** Zsh (with a custom, lightweight config)
- **WM:** Hyprland
- **Editor:** Neovim
- **Terminal:** Kitty
- **Multiplexer:** Tmux
- **Scripts:** Python & Bash (`.local/bin`)

## Installation (Bootstrap)

These dotfiles are managed as a bare repository. To replicate this setup on a fresh machine, do not run a standard `git clone`. Instead, follow these steps:

1.  **Create the alias** to avoid conflicts:

    ```bash
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    ```

2.  **Clone the repository** into a hidden directory:

    ```bash
    git clone --bare git@github.com:daesorin/dotfiles.git $HOME/.cfg
    ```

3.  **Checkout the content** into your Home directory:

    ```bash
    config checkout
    ```

    _Note: If existing config files conflict, Git will warn you. Move or delete the default files (e.g., `.bashrc`) and run checkout again._

4.  **Hide untracked files** (Crucial step):
    ```bash
    config config --local status.showUntrackedFiles no
    ```

## Repository Structure

- **`main` branch:** The public showcase. Contains refined configurations for my core development tools (Nvim, Zsh, Hyprland, scripts).
- **`.config/zsh`:** XDG-compliant shell configuration. Keeping `$HOME` clean.
- **`.local/bin`:** Custom automation scripts.

## Philosophy

- **Hard Dependencies:** None. No `stow`, no ansible. Just Git.
- **Separation of Concerns:** Plugins are not tracked. Configurations include the manifests (e.g., `packer`, `tpm`) to auto-bootstrap plugins on first launch.
- **Hygiene:** Heavy cache folders (Electron apps, browser history) are strictly ignored via `.gitignore` to prevent repository bloat.

---

**Author:** daesorin
