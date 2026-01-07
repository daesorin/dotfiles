#!/usr/bin/env python3
import os
import hashlib
from pathlib import Path
import shutil
from tqdm import tqdm

def sha256(file_path, chunk_size=65536):
    h = hashlib.sha256()
    with open(file_path, 'rb') as f:
        while chunk := f.read(chunk_size):
            h.update(chunk)
    return h.hexdigest()

def find_duplicates(directory, min_size=1, extensions=None):
    files_by_hash = {}
    directory = Path(directory)
    all_files = [f for f in directory.rglob('*') if f.is_file()]
    if extensions:
        all_files = [f for f in all_files if f.suffix.lower() in extensions]
    all_files = [f for f in all_files if f.stat().st_size >= min_size]

    for file in tqdm(all_files, desc="Scanning files", unit="file"):
        h = sha256(file)
        files_by_hash.setdefault(h, []).append(file)

    duplicates = {h: files for h, files in files_by_hash.items() if len(files) > 1}
    return duplicates

def resolve_conflict(dest_folder, filename):
    dest = dest_folder / filename
    counter = 1
    while dest.exists():
        dest = dest_folder / f"{filename.stem}_{counter}{filename.suffix}"
        counter += 1
    return dest

def interactive_action(duplicates, dry_run=False):
    for hash_val, files in duplicates.items():
        print("\nDuplicate group:")
        for idx, file in enumerate(files, 1):
            print(f"{idx:02d}. {file}")
        print("Options:")
        print(" d = delete selected")
        print(" m = move selected")
        print(" s = skip group")
        choice = input("Choose action [d/m/s]: ").strip().lower()
        if choice == 's':
            continue
        selection = input("Enter number(s) separated by comma (or leave blank for all but first): ").strip()
        if not selection:
            to_act = files[1:]  # default: keep first
        else:
            try:
                to_act = [files[int(i)-1] for i in selection.split(',')]
            except (ValueError, IndexError):
                print("Invalid selection, skipping group.")
                continue
        if choice == 'd':
            for f in to_act:
                if dry_run:
                    print(f"[DRY-RUN] Would delete {f}")
                else:
                    f.unlink()
                    print(f"Deleted {f}")
        elif choice == 'm':
            dest_folder = Path(input("Destination folder to move duplicates: ").strip())
            if not dry_run:
                dest_folder.mkdir(parents=True, exist_ok=True)
            for f in to_act:
                dest_path = resolve_conflict(dest_folder, f.name)
                if dry_run:
                    print(f"[DRY-RUN] Would move {f} -> {dest_path}")
                else:
                    shutil.move(str(f), dest_path)
                    print(f"Moved {f} -> {dest_path}")

def auto_batch(duplicates, keep="newest", action="delete", dest_folder=None, dry_run=False):
    for files in duplicates.values():
        sorted_files = sorted(files, key=lambda f: f.stat().st_mtime, reverse=(keep=="newest"))
        to_act = sorted_files[1:]  # keep first based on sorting
        for f in to_act:
            if action == "delete":
                if dry_run:
                    print(f"[DRY-RUN] Would delete {f}")
                else:
                    f.unlink()
                    print(f"Deleted {f}")
            elif action == "move" and dest_folder:
                dest_folder = Path(dest_folder)
                if not dry_run:
                    dest_folder.mkdir(parents=True, exist_ok=True)
                dest_path = resolve_conflict(dest_folder, f.name)
                if dry_run:
                    print(f"[DRY-RUN] Would move {f} -> {dest_path}")
                else:
                    shutil.move(str(f), dest_path)
                    print(f"Moved {f} -> {dest_path}")

def export_report(duplicates, report_file="duplicates_report.txt"):
    with open(report_file, 'w') as f:
        for hash_val, files in duplicates.items():
            f.write(f"Duplicate group (hash: {hash_val}):\n")
            for file in files:
                f.write(f"  {file}\n")
            f.write("\n")
    print(f"Duplicate report saved to {report_file}")

def main():
    print("=== Dupesweep: Duplicate Finder & Cleaner ===")
    directory = input("Directory to scan for duplicates: ").strip()
    dry_run = input("Dry-run only? [y/N]: ").strip().lower() == 'y'
    export = input("Export report? [y/N]: ").strip().lower() == 'y'
    min_size = int(input("Minimum file size in bytes (default 1): ") or 1)
    exts = input("Filter by extensions (comma separated, e.g., .mp4,.mkv) or leave blank: ").strip()
    extensions = [e.strip().lower() for e in exts.split(",")] if exts else None

    duplicates = find_duplicates(directory, min_size=min_size, extensions=extensions)
    if not duplicates:
        print("No duplicates found.")
        return

    print(f"\nFound {len(duplicates)} duplicate groups.")

    print("\nChoose mode:")
    print(" 1 = Interactive delete/move")
    print(" 2 = Auto-batch keep newest, delete/move others")
    print(" 3 = Auto-batch keep oldest, delete/move others")
    mode = input("Select mode [1/2/3]: ").strip()

    if mode == "1":
        interactive_action(duplicates, dry_run=dry_run)
    elif mode in ["2", "3"]:
        keep = "newest" if mode=="2" else "oldest"
        action = input("Action for duplicates? delete/move [delete]: ").strip().lower() or "delete"
        dest_folder = None
        if action == "move":
            dest_folder = input("Destination folder to move duplicates: ").strip()
        auto_batch(duplicates, keep=keep, action=action, dest_folder=dest_folder, dry_run=dry_run)
    else:
        print("Invalid mode selected.")

    if export:
        export_report(duplicates)

if __name__ == "__main__":
    main()

