#!/usr/bin/env python3
import os
import tarfile
import zipfile
from pathlib import Path
from Crypto.Cipher import AES
from Crypto.Protocol.KDF import PBKDF2
from Crypto.Random import get_random_bytes
import getpass

try:
    import py7zr
    HAS_7ZR = True
except ImportError:
    HAS_7ZR = False

BLOCK_SIZE = 16

def pad(data):
    pad_len = BLOCK_SIZE - len(data) % BLOCK_SIZE
    return data + bytes([pad_len] * pad_len)

def unpad(data):
    return data[:-data[-1]]

def aes_encrypt_file(infile, outfile, password, dry_run=False):
    if dry_run:
        print(f"[DRY-RUN] Would encrypt {infile} -> {outfile}")
        return
    salt = get_random_bytes(16)
    key = PBKDF2(password, salt, dkLen=32)
    cipher = AES.new(key, AES.MODE_CBC)
    with open(infile, 'rb') as f:
        plaintext = pad(f.read())
    ciphertext = cipher.encrypt(plaintext)
    with open(outfile, 'wb') as f:
        f.write(salt + cipher.iv + ciphertext)
    print(f"Encrypted {infile} -> {outfile}")

def aes_decrypt_file(infile, outfile, password, dry_run=False):
    if dry_run:
        print(f"[DRY-RUN] Would decrypt {infile} -> {outfile}")
        return
    with open(infile, 'rb') as f:
        salt = f.read(16)
        iv = f.read(16)
        ciphertext = f.read()
    key = PBKDF2(password, salt, dkLen=32)
    cipher = AES.new(key, AES.MODE_CBC, iv)
    plaintext = unpad(cipher.decrypt(ciphertext))
    with open(outfile, 'wb') as f:
        f.write(plaintext)
    print(f"Decrypted {infile} -> {outfile}")

def compress(path, dry_run=False):
    path = Path(path)
    archive_name = path.name + ".tar.gz"
    if dry_run:
        print(f"[DRY-RUN] Would compress {path} -> {archive_name}")
        return archive_name
    with tarfile.open(archive_name, "w:gz") as tar:
        tar.add(path, arcname=path.name)
    print(f"Compressed {path} -> {archive_name}")
    return archive_name

def extract(path, dry_run=False):
    path = Path(path)
    if dry_run:
        print(f"[DRY-RUN] Would extract {path}")
        return
    if path.suffix == ".zip":
        with zipfile.ZipFile(path, 'r') as zipf:
            zipf.extractall()
    elif path.suffix in ['.tar', '.gz', '.bz2', '.tgz', '.tbz2']:
        with tarfile.open(path, 'r:*') as tar:
            tar.extractall()
    elif path.suffix == ".7z" and HAS_7ZR:
        with py7zr.SevenZipFile(path, mode='r') as archive:
            archive.extractall()
    else:
        print(f"Unknown or unsupported format: {path}")
        return
    print(f"Extracted {path}")

def list_current_dir():
    items = [p for p in Path(".").iterdir()]
    print("\nCurrent directory:")
    for idx, item in enumerate(items, 1):
        print(f"{idx:02d}. {item.name}")
    while True:
        choice = input("Enter number(s) separated by comma: ")
        try:
            selected = [items[int(i.strip())-1] for i in choice.split(",")]
            return selected
        except (ValueError, IndexError):
            print("Invalid selection, try again.")

def interactive_select_operation():
    print("\nOperation:")
    print("1. compress")
    print("2. extract")
    print("3. secure compress")
    print("4. secure extract")
    op = input("Choose operation: ").strip()
    return op

def ask_dry_run():
    ans = input("Dry-run mode? (preview only, no changes) [y/N]: ").strip().lower()
    return ans == "y"

def process_item(path, operation, dry_run=False):
    if operation == "1":
        compress(path, dry_run=dry_run)
    elif operation == "2":
        extract(path, dry_run=dry_run)
    elif operation == "3":
        password = getpass.getpass("Password: ")
        outfile = input(f"Output encrypted file for {path} (e.g., secure.tar.gz.enc): ").strip()
        archive = compress(path, dry_run=dry_run)
        aes_encrypt_file(archive, outfile, password, dry_run=dry_run)
        if not dry_run:
            os.remove(archive)
    elif operation == "4":
        password = getpass.getpass("Password: ")
        outfile = input(f"Output decrypted archive for {path} (e.g., file.tar.gz): ").strip()
        aes_decrypt_file(path, outfile, password, dry_run=dry_run)
        extract(outfile, dry_run=dry_run)
    else:
        print("Invalid operation")

def main():
    print("Options:\n1. compress\n2. extract\n3. secure compress\n4. secure extract\n5. select from current directory")
    choice = input("Choose option: ").strip()
    dry_run = ask_dry_run()

    if choice in ["1", "2", "3", "4"]:
        path = input("Path to file/folder: ").strip()
        process_item(Path(path), choice, dry_run=dry_run)
    elif choice == "5":
        selected_items = list_current_dir()
        operation = interactive_select_operation()
        for item in selected_items:
            process_item(item, operation, dry_run=dry_run)
    else:
        print("Invalid choice")

if __name__ == "__main__":
    main()

