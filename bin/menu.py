#!/usr/bin/env python3
import json
import subprocess
from pathlib import Path

# Config mapping categories to scripts
CONFIG = {
    "File Utilities": {
        "Mass Rename": "massrename.py",
        "Compress / Extract": "compress_extract.py",
        "Duplicate Sweeper": "dupesweep.py",
        "Disk Cleaner": "diskclean.py",
        "Backup Manager": "backup.py",
        "Secure File Shredder": "shredder.py",
        "File Search & Preview": "fsearch.py"
    },
    "Network & Download": {
        "Port Killer / Process Manager": "prockill.py",
        "Network Info & Scanner": "netinfo.py",
        "Auto Download Manager": "adownload.py"
    },
    "Security & Crypto": {
        "Password Manager": "pwmanager.py",
        "AES / PGP File Encryption Suite": "encrptor.py",
        "Hash Calculator & Verifier": "hashcheck.py"
    }
}

SCRIPTS_DIR = Path.home() / "pyscripts"

def run_script(script_file):
    path = SCRIPTS_DIR / script_file
    if not path.exists():
        print(f"Script not found: {script_file}")
        return
    subprocess.run(["python3", str(path)])

def select_from_dict(d):
    keys = list(d.keys())
    while True:
        for idx, key in enumerate(keys, 1):
            print(f"{idx}. {key}")
        print("0. Back / Exit")
        choice = input("Select: ").strip()
        if choice == "0":
            return None
        if choice.isdigit() and 1 <= int(choice) <= len(keys):
            return keys[int(choice) - 1]
        print("Invalid selection.")

def main():
    while True:
        print("\n=== Launcher Main Menu ===")
        category = select_from_dict(CONFIG)
        if category is None:
            break
        while True:
            print(f"\n--- {category} ---")
            script_name = select_from_dict(CONFIG[category])
            if script_name is None:
                break
            script_file = CONFIG[category][script_name]
            print(f"\nRunning: {script_name}")
            run_script(script_file)
            input("\nPress Enter to continue...")

if __name__ == "__main__":
    main()

