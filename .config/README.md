# .config

This directory contains user-specific configuration files conforming to the XDG Base Directory Specification. The configurations map out a modular, Wayland-centric desktop environment alongside core terminal and system utilities.

## COMPOSITORS AND SESSION MANAGEMENT
* **niri:** Scrollable-tiling Wayland compositor.
* **sway:** Tiling Wayland compositor and X11/i3 replacement.
* **swaylock:** Screen locking utility for Wayland sessions.
* **nwg-displays:** Output and display management.

## TERMINALS AND SHELL ENVIRONMENT
* **kitty:** GPU-accelerated terminal emulator.
* **foot:** Lightweight Wayland terminal emulator.
* **fish:** Interactive shell configuration.
* **tmux:** Terminal multiplexer for persistent workspace sessions.
* **starship.toml:** Cross-shell prompt configuration.

## SYSTEM UI AND THEMING
* **waybar:** Customisable Wayland status bar.
* **fuzzel:** Application launcher for wlroots-based compositors.
* **mako:** Lightweight notification daemon.
* **nwg-look:** GTK settings editor for maintaining visual consistency.
* **qt5ct / qt6ct:** Qt configuration utilities for uniform theming across toolkits.

## MEDIA AND DOCUMENTS
* **mpd:** Music Player Daemon for backend audio management.
* **ncmpcpp:** Feature-rich ncurses client for MPD.
* **mpv:** Hardware-accelerated command-line media player.
* **zathura:** Keyboard-driven document and PDF viewer.

## SYSTEM UTILITIES AND DEVELOPMENT
* **nvim:** Neovim configuration for development and text editing.
* **git:** Global version control parameters.
* **btop:** Resource monitor for system usage and hardware polling.
* **incus:** Local configuration for the container and virtual machine daemon.
