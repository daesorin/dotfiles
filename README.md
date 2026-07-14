# dotfiles  

Personal configuration files for Arch Linux.
Managed with a bare git repository.

---

## What Is In Here

- Shell -- zsh with modular config
- Prompt -- Starship
- Terminal -- Alacritty
- Multiplexer -- tmux + TPM
- Compositor -- Niri
- Bar -- Waybar
- Launcher -- Rofi
- Editor -- Neovim (LazyVim)
- Notifications -- Mako
- Media -- mpc, mpd, ncmpcpp, mpv
- Utilities -- btop, zathura

---

## Install

Clone and set up the bare repo:

```bash
curl -fsSL https://git.daesorin.xyz/daesorin/dotfiles/raw/branch/main/.dotfiles-meta/install.sh | bash
```

Then restart your shell. If you are on Arch and want to install packages:

```bash
bash ~/.dotfiles-meta/bootstrap.sh
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

 
