# dotfiles

My personal system configuration files. Built for Arch Linux, running on Wayland.

## The Stack

* **WM:** Hyprland
* **Terminal:** Kitty
* **Shell:** Zsh
* **Editor:** Neovim
* **Bar:** Waybar
* **Launcher:** Rofi
* **Multiplexer:** Tmux

## Structure

* `hypr/` - Window rules, keybindings ...
* `kitty/` - Terminal font rendering and colour schemes.
* `nvim/` - Lua-based config. LSP, completion, and telescope setup.
* `rofi/` - App launcher and menu scripts.
* `tmux/` - Session management and status line.
* `waybar/` - Status bar modules.
* `zsh/` - Aliases, functions, prompt, and environment variables.

```sh
git clone [https://github.com/daesorin/dotfiles.git](https://github.com/daesorin/dotfiles.git) ~/dotfiles
cd ~/dotfiles
stow .
