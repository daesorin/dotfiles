#!/usr/bin/env python3
import os
import re
import sys
from pathlib import Path

def list_files(path="."):
    return sorted(Path(path).iterdir(), key=lambda p: p.stat().st_mtime)

def select_exclusions(files):
    print("\nFiles in directory:")
    for idx, f in enumerate(files, 1):
        print(f"{idx:02d}. {f.name}")
    excl_input = input("\nEnter numbers to exclude (comma-separated) or leave empty: ")
    if not excl_input.strip():
        return files
    try:
        exclude_idx = {int(x.strip())-1 for x in excl_input.split(",")}
    except ValueError:
        print("Invalid input, no exclusions applied.")
        return files
    return [f for i, f in enumerate(files) if i not in exclude_idx]

def preview(files, rename_fn):
    changes = []
    for i, f in enumerate(files, 1):
        new = rename_fn(f, i)
        if new != f.name:
            changes.append((f.name, new))
    return changes

def confirm_and_rename(changes, path="."):
    if not changes:
        print("No changes to apply.")
        return
    print("\nPlanned renames:")
    for old, new in changes:
        print(f"{old}  ->  {new}")
    choice = input("\nProceed? [y/N]: ").strip().lower()
    if choice == "y":
        for old, new in changes:
            os.rename(Path(path)/old, Path(path)/new)
        print("Renamed.")
    else:
        print("Aborted.")

def mode_prefix(files):
    text = input("Enter prefix: ")
    return preview(files, lambda f, i: text + f.name)

def mode_suffix(files):
    text = input("Enter suffix: ")
    return preview(files, lambda f, i: f.stem + text + f.suffix)

def mode_number(files):
    pad = int(input("Number padding (e.g. 2 for 01): ") or 2)
    return preview(files, lambda f, i: f"{i:0{pad}d} {f.stem}{f.suffix}")

def mode_regex(files):
    pattern = input("Regex pattern to search: ")
    repl = input("Replacement: ")
    regex = re.compile(pattern)
    return preview(files, lambda f, i: regex.sub(repl, f.name))

def main():
    path = sys.argv[1] if len(sys.argv) > 1 else "."
    files = [f for f in list_files(path) if f.is_file()]
    if not files:
        print("No files in directory.")
        return

    files = select_exclusions(files)

    print("\nModes:")
    print("1. Prefix")
    print("2. Suffix")
    print("3. Numbering")
    print("4. Regex replace")
    mode = input("Choose mode: ").strip()

    if mode == "1":
        changes = mode_prefix(files)
    elif mode == "2":
        changes = mode_suffix(files)
    elif mode == "3":
        changes = mode_number(files)
    elif mode == "4":
        changes = mode_regex(files)
    else:
        print("Invalid mode.")
        return

    confirm_and_rename(changes, path)

if __name__ == "__main__":
    main()
