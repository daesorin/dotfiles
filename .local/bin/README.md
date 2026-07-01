# UTILS

a collection of personal utility scripts for arch linux system management, automation, and infrastructure reconnaissance. 

## DEPENDENCIES

most scripts rely on the following packages available in the arch repositories or aur:

`bash`, `python3`, `jq`, `curl`, `bc`, `awk`, `bind`, `whois`, `openssl`, `aria2`, `yt-dlp`, `ffmpeg`, `fzf`, `lm_sensors`, `pacman-contrib`, `rsync`, `python-watchdog`, `waybar`

## UTILITIES ARCHITECTURE

the repository is structured around singular, verb-oriented tools designed for autonomous infrastructure management:

* `archive`: handles universal file compression and extraction routing.
* `fetch`: executes autonomous media liberation via aria2c and yt-dlp.
* `rate`: provides terminal-native fiat and crypto currency evaluation.
* `recon`: executes domain reconnaissance and infrastructure security auditing.
* `status`: audits arch linux system telemetry and environment health.
* `pick`: provides modular element selection functionality.
* `power`: handles system state and operational power management.
* `scratch`: controls the window manager scratchpad buffer.
* `audit-pkg`: scans local package environments for vulnerabilities.
* `audit-users`: maps system permissions and active user accounts.
* `backup-obsd`: automates synchronisation for local knowledge vaults.
* `obsd`: launches the local knowledge base environment.
* `adbx`: wraps android debug bridge operations.
* `fuzzel-run`: configures the autonomous application launcher.
* `waybar-net`: feeds network state data to the status bar.
