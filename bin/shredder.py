#!/usr/bin/env python3
import os
from pathlib import Path
import random

# ---------- Core Utilities ----------
def secure_delete(file_path, passes=3, dry_run=False):
    file_path = Path(file_path)
    if not file_path.exists():
        print(f"File not found: {file_path}")
        return
    size = file_path.stat().st_size
    if dry_run:
        print(f"[DRY-RUN] Would overwrite and delete: {file_path} ({size} bytes)")
        return
    with open(file_path, "r+b") as f:
        for p in range(passes):
            f.seek(0)
            f.write(os.urandom(size))
            f.flush()
            print(f"Pass {p+1}/{passes} completed for {file_path}")
    file_path.unlink()
    print(f"Deleted: {file_path}")

def shred_directory(directory, passes=3, dry_run=False):
    directory = Path(directory)
    if not directory.is_dir():
        print(f"Not a directory: {directory}")
        return
    for item in directory.rglob('*'):
        if item.is_file():
            secure_delete(item, passes=passes, dry_run=dry_run)

# ---------- Interactive file selector ----------
def select_files():
    cwd = Path.cwd()
    items = [i for i in cwd.iterdir()]
    if not items:
        print("No files or directories in current folder.")
        return []
    print("Select files/directories to shred:")
    for idx, item in enumerate(items, 1):
        print(f"{idx:03d}. {item.name} ({'Dir' if item.is_dir() else 'File'})")
    sel = input("Enter numbers (comma separated) or leave blank to cancel: ").strip()
    if not sel:
        return []
    try:
        indices = [int(i)-1 for i in sel.split(",")]
        return [items[i] for i in indices]
    except ValueError:
        print("Invalid input.")
        return []

# ---------- CLI ----------
def main():
    import argparse
    parser = argparse.ArgumentParser(description="Secure File Shredder")
    parser.add_argument("paths", nargs="*", help="Files or directories to shred")
    parser.add_argument("--passes", type=int, default=3, help="Overwrite passes (default=3)")
    parser.add_argument("--recursive", action="store_true", help="Recursively shred directories")
    parser.add_argument("--dry-run", action="store_true", help="Preview actions without deleting")
    args = parser.parse_args()

    paths = args.paths or select_files()
    if not paths:
        print("No paths to shred. Exiting.")
        return

    for path in paths:
        p = Path(path)
        if p.is_file():
            secure_delete(p, passes=args.passes, dry_run=args.dry_run)
        elif p.is_dir():
            if args.recursive:
                shred_directory(p, passes=args.passes, dry_run=args.dry_run)
            else:
                print(f"Skipping directory {p}. Use --recursive to shred directories.")
        else:
            print(f"Invalid path: {p}")

if __name__ == "__main__":
    main()

