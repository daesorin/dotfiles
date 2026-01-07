#  .dotfiles

> **The Fortress**
> Personal configuration files for Arch Linux, Hyprland, and the developer workflow.
> _Managed via Git & custom tooling._

## 🛠 Tech Stack

| Component          | Choice           | Config Path      |
| :----------------- | :--------------- | :--------------- |
| **OS**             | Arch Linux       | N/A              |
| **Window Manager** | Hyprland         | `.config/hypr`   |
| **Bar**            | Waybar           | `.config/waybar` |
| **Shell**          | Zsh              | `.config/zsh`    |
| **Terminal**       | Kitty            | `.config/kitty`  |
| **Multiplexer**    | Tmux             | `.config/tmux`   |
| **Editor**         | Neovim (LazyVim) | `.config/nvim`   |
| **Launcher**       | Rofi             | `.config/rofi`   |
| **Notifications**  | Mako             | `.config/mako`   |
| **System Monitor** | Btop             | `.config/btop`   |

---

## 📂 Directory Structure

### `.config/`

The core configuration modules.

- **`hypr/`**: Tiling window manager logic. Split into modular configs (`conf/`) for keybinds, monitors, and rules. Includes `hyprlock` and `hypridle`.
- **`waybar/`**: JSONC modules and CSS styling. Includes custom modules for:
  - Finance tracking (`finance.jsonc`)
  - Hardware stats
  - Media controls
- **`nvim/`**: Lua-based configuration using Lazy.nvim.
- **`tmux/`**: Tmux with TPM (Plugin Manager) and Catppuccin theming.
- **`systemd/user/`**: User-level services (e.g., `filen-sync`, `mpd`).

### `bin/`

Custom executable scripts and utilities added to `$PATH`.

- **`tea`**: Custom wrapper for Gitea/Codeberg repository management.
- **`backup.py`**: Automated backup tool with encryption/decryption support.
- **`finance-*`**: Tools for syncing and reporting on ledger data.
- **System Utils**: `adbx`, `prockill`, `dupesweep`, `sysinfo`, `low-power`.

### `github/`

Workspace for public portfolio projects mirrored to GitHub.

- **`daily-python-projects`**: A collection of logic exercises and small apps.

---

## 🚀 Keybindings (Hyprland)

- `SUPER + Enter`: Open Kitty
- `SUPER + Q`: Kill active window
- `SUPER + E`: Open File Manager (Thunar/Ranger)
- `SUPER + Space`: App Launcher (Rofi)
- _See `.config/hypr/conf/binds.conf` for the full list._

## 📥 Installation

```bash
# 1. Clone the repository
git clone git@codeberg.org:osaigbovo/dotfiles.git ~/dotfiles

# 2. Link configurations (Using Stow or manual linking)
# The 'bin' folder is designed to be symlinked to ~/.local/bin
ln -s ~/dotfiles/bin ~/.local/bin

# 3. Install dependencies
# (Arch Linux)
sudo pacman -S hyprland waybar kitty tmux neovim zsh starship mako rofi
```

## ⚖️ License

MIT
