#!/usr/bin/env python3
import os
from pathlib import Path
import shutil
from tqdm import tqdm

def get_size(path):
    """Return total size of file or folder."""
    if path.is_file():
        return path.stat().st_size
    total = 0
    for f in path.rglob('*'):
        if f.is_file():
            total += f.stat().st_size
    return total

def scan_directory(directory, min_size=1, extensions=None):
    directory = Path(directory)
    items = [p for p in directory.rglob('*')]
    filtered = []
    for p in tqdm(items, desc="Scanning", unit="item"):
        if not p.exists(): continue
        if not p.is_file() and not p.is_dir(): continue
        if extensions and p.is_file() and p.suffix.lower() not in extensions:
            continue
        if get_size(p) >= min_size:
            filtered.append(p)
    filtered.sort(key=lambda x: get_size(x), reverse=True)
    return filtered

def interactive_action(items, dry_run=False):
    for idx, item in enumerate(items, 1):
        size = get_size(item)
        size_mb = size / (1024*1024)
        print(f"{idx:03d}. {item} ({size_mb:.2f} MB)")
    while True:
        sel = input("Enter number(s) to delete/move, comma separated (or 'q' to quit): ").strip()
        if sel.lower() == 'q':
            break
        indices = []
        try:
            indices = [int(s)-1 for s in sel.split(',')]
        except ValueError:
            print("Invalid input, try again.")
            continue
        action = input("Delete or move [d/m]? ").strip().lower()
        dest_folder = None
        if action == 'm':
            dest_folder = Path(input("Destination folder: ").strip())
            if not dry_run:
                dest_folder.mkdir(parents=True, exist_ok=True)
        for i in indices:
            if 0 <= i < len(items):
                item = items[i]
                if action == 'd':
                    if dry_run:
                        print(f"[DRY-RUN] Would delete {item}")
                    else:
                        if item.is_file():
                            item.unlink()
                        else:
                            shutil.rmtree(item)
                        print(f"Deleted {item}")
                elif action == 'm':
                    dest_path = dest_folder / item.name
                    counter = 1
                    while dest_path.exists():
                        dest_path = dest_folder / f"{item.stem}_{counter}{item.suffix}"
                        counter += 1
                    if dry_run:
                        print(f"[DRY-RUN] Would move {item} -> {dest_path}")
                    else:
                        shutil.move(str(item), dest_path)
                        print(f"Moved {item} -> {dest_path}")
        print("Done with selection.")

def main():
    print("=== DiskClean: Disk Usage & Cleanup Tool ===")
    directory = input("Directory to scan: ").strip()
    dry_run = input("Dry-run only? [y/N]: ").strip().lower() == 'y'
    top_n = int(input("Show top N largest items (default 20): ") or 20)
    min_size = int(input("Minimum size in bytes to include (default 1): ") or 1)
    exts = input("Filter by extensions (comma separated, e.g., .mp4,.mkv) or leave blank: ").strip()
    extensions = [e.strip().lower() for e in exts.split(",")] if exts else None

    items = scan_directory(directory, min_size=min_size, extensions=extensions)
    items = items[:top_n]
    if not items:
        print("No items found matching criteria.")
        return
    interactive_action(items, dry_run=dry_run)

if __name__ == "__main__":
    main()

