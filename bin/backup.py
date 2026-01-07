#!/usr/bin/env python3
import os
from pathlib import Path
import shutil
import tarfile
from datetime import datetime
import subprocess
import getpass

# ---------- Core Utilities ----------
def compress(src, dest):
    with tarfile.open(dest, "w:gz") as tar:
        tar.add(src, arcname=Path(src).name)

def extract_compressed(src, dest):
    with tarfile.open(src, "r:gz") as tar:
        tar.extractall(dest)

def encrypt_file(input_file, output_file, password):
    cmd = [
        "openssl", "enc", "-aes-256-cbc", "-salt", "-pbkdf2",
        "-in", str(input_file),
        "-out", str(output_file),
        "-k", password
    ]
    subprocess.run(cmd, check=True)

def decrypt_file(input_file, output_file, password):
    cmd = [
        "openssl", "enc", "-d", "-aes-256-cbc", "-pbkdf2",
        "-in", str(input_file),
        "-out", str(output_file),
        "-k", password
    ]
    subprocess.run(cmd, check=True)

# ---------- Backup ----------
def backup(src_paths, dest_dir, compress_backup=False, encrypt=False, password=None, dry_run=False):
    dest_dir = Path(dest_dir).expanduser()
    if not dest_dir.exists() and not dry_run:
        dest_dir.mkdir(parents=True)
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    for src in src_paths:
        src = Path(src).expanduser()
        if not src.exists():
            print(f"Skipping {src}, does not exist.")
            continue

        backup_name = f"{src.name}_{timestamp}"
        dest_path = dest_dir / backup_name
        if compress_backup:
            dest_path = dest_path.with_suffix(".tar.gz")

        if dry_run:
            print(f"[DRY-RUN] Would backup {src} -> {dest_path}")
            if encrypt:
                print(f"[DRY-RUN] Would encrypt {dest_path} with AES-256")
            continue

        if compress_backup:
            compress(src, dest_path)
            print(f"Compressed backup: {dest_path}")
        else:
            if src.is_dir():
                shutil.copytree(src, dest_path)
            else:
                shutil.copy2(src, dest_path)
            print(f"Copied backup: {dest_path}")

        if encrypt:
            encrypted_path = dest_path.with_suffix(dest_path.suffix + ".enc")
            encrypt_file(dest_path, encrypted_path, password)
            print(f"Encrypted backup: {encrypted_path}")
            dest_path.unlink()  # remove unencrypted

# ---------- Restore ----------
def restore(dest_dir, restore_path=None, decrypt=False, password=None, dry_run=False):
    dest_dir = Path(dest_dir).expanduser()
    if not dest_dir.exists():
        print(f"Backup folder {dest_dir} does not exist.")
        return

    backups = sorted(dest_dir.glob("*"), key=lambda f: f.stat().st_mtime, reverse=True)
    if not backups:
        print("No backups found.")
        return

    print("Available backups:")
    for idx, b in enumerate(backups, 1):
        print(f"{idx:03d}. {b}")
    sel = input("Enter number(s) to restore (comma separated): ").strip()
    try:
        indices = [int(i)-1 for i in sel.split(",")]
    except ValueError:
        print("Invalid input.")
        return

    for i in indices:
        b = backups[i]
        target_path = Path(restore_path).expanduser() if restore_path else Path.cwd()
        target_file = target_path / b.name

        if decrypt and b.suffix.endswith(".enc"):
            decrypted_file = target_file.with_suffix(''.join(target_file.suffixes[:-1]))
            if dry_run:
                print(f"[DRY-RUN] Would decrypt {b} -> {decrypted_file}")
            else:
                decrypt_file(b, decrypted_file, password)
                print(f"Decrypted backup: {decrypted_file}")
        elif b.suffix == ".tar.gz":
            if dry_run:
                print(f"[DRY-RUN] Would extract {b} -> {target_path}")
            else:
                extract_compressed(b, target_path)
                print(f"Extracted backup: {b} -> {target_path}")
        else:
            if dry_run:
                print(f"[DRY-RUN] Would copy {b} -> {target_path}")
            else:
                if b.is_dir():
                    shutil.copytree(b, target_file)
                else:
                    shutil.copy2(b, target_file)
                print(f"Copied backup: {b} -> {target_file}")

# ---------- CLI ----------
def main():
    import argparse
    parser = argparse.ArgumentParser(description="Backup Manager with restore and scheduling")
    parser.add_argument("--backup", nargs="+", help="Paths to backup")
    parser.add_argument("--dest", help="Destination folder")
    parser.add_argument("--compress", action="store_true")
    parser.add_argument("--encrypt", action="store_true")
    parser.add_argument("--password", help="Password for encryption")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--restore", action="store_true")
    parser.add_argument("--restore-path", help="Path to restore to")
    parser.add_argument("--decrypt", action="store_true")
    args = parser.parse_args()

    if args.backup and args.dest:
        backup(args.backup, args.dest, compress_backup=args.compress,
               encrypt=args.encrypt, password=args.password, dry_run=args.dry_run)
    elif args.restore and args.dest:
        restore(args.dest, restore_path=args.restore_path, decrypt=args.decrypt,
                password=args.password, dry_run=args.dry_run)
    else:
        # Interactive mode
        print("=== Backup Manager Interactive Mode ===")
        mode = input("Select mode: backup / restore: ").strip().lower()
        if mode == "backup":
            src_input = input("Paths to backup (comma separated): ").strip()
            src_paths = [p.strip() for p in src_input.split(",") if p.strip()]
            dest_dir = input("Destination backup folder: ").strip()
            compress_backup = input("Compress backups? [y/N]: ").strip().lower() == 'y'
            encrypt = input("Encrypt backups? [y/N]: ").strip().lower() == 'y'
            password = None
            if encrypt:
                password = getpass.getpass("Enter encryption password: ").strip()
            dry_run = input("Dry-run only? [y/N]: ").strip().lower() == 'y'
            backup(src_paths, dest_dir, compress_backup=compress_backup, encrypt=encrypt,
                   password=password, dry_run=dry_run)
        elif mode == "restore":
            dest_dir = input("Backup folder to restore from: ").strip()
            restore_path = input("Restore destination (leave blank = current dir): ").strip() or None
            decrypt = input("Decrypt backups? [y/N]: ").strip().lower() == 'y'
            password = None
            if decrypt:
                password = getpass.getpass("Enter decryption password: ").strip()
            dry_run = input("Dry-run only? [y/N]: ").strip().lower() == 'y'
            restore(dest_dir, restore_path=restore_path, decrypt=decrypt, password=password, dry_run=dry_run)
        else:
            print("Invalid mode selected.")

if __name__ == "__main__":
    main()

