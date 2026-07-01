# dotfiles  

Personal configuration files for Arch Linux.
Managed with a bare git repository.

---

## Install

Clone and set up the bare repo:

```bash
curl -fsSL https://code.sgbvmr.xyz/daesorin/dotfiles/raw/branch/main/.dotfiles-meta/install.sh | bash
```

Then restart your shell. If you are on Arch and want to install packages:

```bash
bash ~/.dotfiles-meta/bootstrap.sh
```

---

## Notes

- Arch Linux only. No guarantees on other distros.
- Neovim config is LazyVim-based.
- tmux plugins managed by TPM. Run `prefix + I` after first launch to install.
- gitmux is installed via `go install` -- see `bootstrap.sh`.

 
