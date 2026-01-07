#!/usr/bin/env python3
import requests
from tqdm import tqdm
import os
from pathlib import Path
from datetime import datetime

LOG_FILE = "downloads.log"

def log_action(msg):
    with open(LOG_FILE, "a") as f:
        f.write(f"{datetime.now()} - {msg}\n")

def download_file(url, dest=None, retries=3, dry_run=False):
    dest = Path(dest or url.split("/")[-1])
    for attempt in range(1, retries+1):
        try:
            headers = {}
            mode = "wb"
            if dest.exists():
                headers['Range'] = f"bytes={dest.stat().st_size}-"
                mode = "ab"
            if dry_run:
                print(f"[DRY-RUN] Would download {url} -> {dest} (attempt {attempt})")
                break
            with requests.get(url, stream=True, headers=headers) as r:
                r.raise_for_status()
                total = int(r.headers.get("content-length", 0)) + dest.stat().st_size if dest.exists() else int(r.headers.get("content-length", 0))
                with open(dest, mode) as f, tqdm(total=total, unit='B', unit_scale=True, desc=dest.name, initial=dest.stat().st_size if dest.exists() else 0) as pbar:
                    for chunk in r.iter_content(chunk_size=8192):
                        if chunk:
                            f.write(chunk)
                            pbar.update(len(chunk))
            log_action(f"Downloaded {url} -> {dest}")
            print(f"Downloaded {url} -> {dest}")
            break
        except Exception as e:
            print(f"Attempt {attempt} failed: {e}")
            if attempt == retries:
                log_action(f"Failed to download {url}: {e}")

def main():
    urls_input = input("Enter URLs to download (comma separated): ").strip()
    urls = [u.strip() for u in urls_input.split(",") if u.strip()]
    dest_folder = input("Destination folder (default current dir): ").strip() or "."
    Path(dest_folder).mkdir(parents=True, exist_ok=True)
    dry_run = input("Dry-run only? [y/N]: ").strip().lower() == 'y'

    for url in urls:
        download_file(url, dest=Path(dest_folder) / url.split("/")[-1], dry_run=dry_run)

if __name__ == "__main__":
    main()

