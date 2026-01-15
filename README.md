# dotfiles

Minimal, opinionated Linux dotfiles for a Wayland-based workflow.

This repository contains a **curated subset** of my personal configuration, extracted intentionally for public use. It focuses on usability, readability, and composability rather than clever tricks or distro-specific hacks.

These files are meant to be _read_, _modified_, and _stolen from_.

---

## What this is

- Hyprland-based Wayland setup
- Terminal-centric workflow
- Modular Zsh configuration
- Tmux with sane defaults and theming
- Lightweight, scriptable status bars and notifications

No installers. No magic bootstrap scripts. No assumptions about your distro beyond “it’s Linux and you know what you’re doing.”

---

## Layout

.config/
├── hypr/ # Hyprland compositor + idle/lock/wallpaper
├── kitty/ # Terminal emulator
├── mako/ # Wayland notifications
├── mpv/ # Media player
├── tmux/ # Terminal multiplexer + plugins
├── waybar/ # Status bar for Wayland
└── zsh/ # Z Shell configuration

---

## Highlights

### Hyprland

- Split configuration by application (`binds`, `monitors`, `rules`, etc.)
- Clean separation between compositor config and supporting tools
- Designed to be readable before being clever

### Zsh

- Modular shell setup (`modules/*.zsh`)
- Explicit files for environment, aliases, utilities, and integrations

### Tmux

- TPM-based plugin management
- Catppuccin theme
- Sensible defaults with minimal custom glue

### Waybar

- JSONC configs with comments
- Styling separated cleanly into CSS

---

## What this is not

- A turnkey dotfiles installer
- A framework
- A promise of stability

This is a snapshot of my working system, not a universal solution.

---

## Usage

Clone and selectively symlink or copy what you need:

```sh
git clone https://github.com/daesorin/dotfiles.git
ln -s ~/dotfiles/.config/zsh ~/.config/zsh
ln -s ~/dotfiles/.config/hypr ~/.config/hypr
....
```

Do **not** blindly symlink everything unless you enjoy debugging your own machine.

---

## Assumptions

- You already use or understand:
  - Hyprland
  - Wayland
  - Zsh
  - Tmux

- You prefer explicit configuration over abstraction
- You read configs instead of asking Reddit why something broke

---

## License

MIT
