#!/usr/bin/env python3
import os
from pathlib import Path
import subprocess
from rapidfuzz import fuzz, process
import shutil

def list_files(path=".", file_types=None, min_size=0):
    path = Path(path).expanduser()
    if not path.exists() or not path.is_dir():
        print(f"Directory not found: {path}")
        return []
    files = [f for f in path.iterdir() if f.is_file() or f.is_dir()]
    if file_types:
        files = [f for f in files if f.suffix.lower() in file_types]
    if min_size > 0:
        files = [f for f in files if f.is_dir() or f.stat().st_size >= min_size]
    return files

def preview_file(file_path):
    file_path = Path(file_path)
    if not file_path.exists():
        print("File not found.")
        return
    print(f"\n=== Preview: {file_path.name} ===")
    if file_path.is_dir():
        print("Directory contents:")
        for f in file_path.iterdir():
            print(f"- {f.name}")
    else:
        try:
            subprocess.run(["head", "-n", "20", str(file_path)])
        except Exception as e:
            print(f"Cannot preview file: {e}")

def fuzzy_search(files, query, limit=20):
    names = [f.name for f in files]
    matches = process.extract(query, names, scorer=fuzz.partial_ratio, limit=limit)
    return [(files[names.index(m[0])], m[1]) for m in matches]

def interactive_search():
    path = input("Directory to search (default .): ").strip() or "."
    file_types_input = input("Filter by file extensions (comma separated, blank = all): ").strip()
    min_size_input = input("Minimum file size in bytes (0 = all): ").strip()
    
    file_types = [ft.lower().strip() for ft in file_types_input.split(",")] if file_types_input else None
    min_size = int(min_size_input) if min_size_input.isdigit() else 0
    
    files = list_files(path, file_types=file_types, min_size=min_size)
    if not files:
        print("No files found.")
        return
    
    while True:
        query = input("\nEnter search query (or 0 to exit): ").strip()
        if query == "0":
            break
        matches = fuzzy_search(files, query)
        if not matches:
            print("No matches found.")
            continue
        
        for idx, (f, score) in enumerate(matches, 1):
            print(f"{idx}. {f.name} (score {score})")
        
        sel = input("\nEnter number to preview, 'a' for action menu, 0 to search again: ").strip()
        if sel == "0":
            continue
        if sel.lower() == 'a':
            # Action menu for multiple selections
            selected_nums = input("Enter numbers separated by comma: ").strip().split(",")
            selected_files = [matches[int(n)-1][0] for n in selected_nums if n.isdigit() and 1 <= int(n) <= len(matches)]
            action = input("Action (c=copy, m=move, d=delete): ").strip().lower()
            for sf in selected_files:
                if action == 'c':
                    dest = input(f"Copy {sf.name} to: ").strip()
                    shutil.copy2(sf, Path(dest).expanduser())
                elif action == 'm':
                    dest = input(f"Move {sf.name} to: ").strip()
                    shutil.move(sf, Path(dest).expanduser())
                elif action == 'd':
                    if sf.is_dir():
                        shutil.rmtree(sf)
                    else:
                        sf.unlink()
            print("Action completed.")
        elif sel.isdigit() and 1 <= int(sel) <= len(matches):
            preview_file(matches[int(sel)-1][0])
        else:
            print("Invalid selection.")

if __name__ == "__main__":
    interactive_search()

