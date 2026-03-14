# dotfiles

Personal configuration files for Arch Linux + Hyprland.

Managed with a bare git repository.

---

## What Is In Here

- Shell -- Zsh with modular config
- Prompt -- Starship
- Terminal -- Kitty
- Multiplexer -- tmux + TPM
- Compositor -- Hyprland
- Bar -- Waybar
- Launcher -- Rofi
- Editor -- Neovim (LazyVim)
- Notifications -- Mako
- Media -- mpd, ncmpcpp, mpv
- Utilities -- btop, zathura, gitmux

---

## Install

Clone and set up the bare repo:

```bash
curl -fsSL https://raw.githubusercontent.com/daesorin/dotfiles/main/install.sh | bash
```

Then restart your shell. If you are on Arch and want to install packages:

```bash
bash ~/.dotfiles/bootstrap.sh
```

---

## Structure

All files live in their original locations under `$HOME`. No symlinks.

---

## Notes

- Arch Linux only. No guarantees on other distros.
- Neovim config is LazyVim-based.
- tmux plugins managed by TPM. Run `prefix + I` after first launch to install.
- gitmux is installed via `go install` -- see `bootstrap.sh`.
