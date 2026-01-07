#!/usr/bin/env python3
import subprocess
from datetime import datetime
from pathlib import Path

LOG_FILE = "prockill.log"

# ---------- Logging ----------
def log_action(action):
    with open(LOG_FILE, "a") as f:
        f.write(f"{datetime.now()} - {action}\n")

# ---------- Process Listing ----------
def list_processes_by_port(port):
    try:
        result = subprocess.run(["lsof", "-i", f":{port}"], capture_output=True, text=True)
        lines = result.stdout.strip().split("\n")
        if len(lines) < 2:
            return []
        processes = [(line.split()[1], line.split()[0]) for line in lines[1:]]
        return processes
    except FileNotFoundError:
        # fallback to netstat/grep if lsof is unavailable
        try:
            result = subprocess.run(
                f"netstat -tulpn | grep ':{port}'",
                shell=True, capture_output=True, text=True
            )
            lines = result.stdout.strip().split("\n")
            processes = []
            for line in lines:
                parts = line.split()
                pid_info = parts[-1] if len(parts) >= 7 else ""
                if "/" in pid_info:
                    pid, name = pid_info.split("/", 1)
                    processes.append((pid, name))
            return processes
        except Exception:
            return []
    except Exception as e:
        print(f"Error listing processes: {e}")
        return []

def list_processes_by_name(name):
    try:
        result = subprocess.run(["pgrep", "-fl", name], capture_output=True, text=True)
        lines = result.stdout.strip().split("\n")
        processes = []
        for line in lines:
            if not line: continue
            pid, *cmd = line.split()
            processes.append((pid, " ".join(cmd)))
        return processes
    except Exception as e:
        print(f"Error searching processes: {e}")
        return []

# ---------- Interactive Kill ----------
def interactive_kill(processes, dry_run=False):
    if not processes:
        print("No processes found.")
        return

    while True:
        print("\nProcesses found:")
        for idx, (pid, name) in enumerate(processes, 1):
            print(f"{idx:03d}. PID: {pid}, Name: {name}")

        sel = input("Enter numbers to kill (comma separated), 'a' to kill all, 'f' to filter, or 'q' to quit: ").strip().lower()
        if sel == 'q':
            break
        if sel == 'a':
            indices = range(len(processes))
        elif sel == 'f':
            substr = input("Filter by substring in name: ").strip()
            processes = [p for p in processes if substr in p[1]]
            continue
        else:
            try:
                indices = [int(s)-1 for s in sel.split(",")]
            except ValueError:
                print("Invalid input.")
                continue

        for i in indices:
            if 0 <= i < len(processes):
                pid, name = processes[i]
                if dry_run:
                    print(f"[DRY-RUN] Would kill PID {pid} ({name})")
                    log_action(f"[DRY-RUN] Kill PID {pid} ({name})")
                else:
                    subprocess.run(["kill", "-9", pid])
                    print(f"Killed PID {pid} ({name})")
                    log_action(f"Killed PID {pid} ({name})")

        # Refresh process list after kills
        print("Refreshing process list...")
        refreshed = []
        for pid, name in processes:
            try:
                # check if process still exists
                subprocess.run(["kill", "-0", pid], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                refreshed.append((pid, name))
            except subprocess.CalledProcessError:
                continue
        processes = refreshed
        if not processes:
            print("No remaining processes.")
            break

# ---------- CLI ----------
def main():
    import argparse
    parser = argparse.ArgumentParser(description="Port Killer / Process Manager")
    parser.add_argument("--port", type=int, help="Port number to search processes")
    parser.add_argument("--name", help="Process name to search")
    parser.add_argument("--dry-run", action="store_true", help="Dry-run mode")
    args = parser.parse_args()

    processes = []
    if args.port:
        processes = list_processes_by_port(args.port)
    elif args.name:
        processes = list_processes_by_name(args.name)
    else:
        mode = input("Search by [port/name]: ").strip().lower()
        if mode == "port":
            port = int(input("Port number: ").strip())
            processes = list_processes_by_port(port)
        elif mode == "name":
            name = input("Process name: ").strip()
            processes = list_processes_by_name(name)

    interactive_kill(processes, dry_run=args.dry_run)

if __name__ == "__main__":
    main()

