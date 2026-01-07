#!/usr/bin/env python3
import hashlib
from pathlib import Path

def compute_hash(file_path, algo="sha256"):
    file_path = Path(file_path)
    h = hashlib.sha256() if algo=="sha256" else hashlib.md5()
    with open(file_path, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b''):
            h.update(chunk)
    return h.hexdigest()

def verify_hash(file_path, expected_hash, algo="sha256"):
    computed = compute_hash(file_path, algo)
    return computed.lower() == expected_hash.lower()

def interactive_menu():
    while True:
        print("\n--- Hash Calculator & Verifier ---")
        print("1. Compute hash")
        print("2. Verify hash")
        print("3. Exit")
        choice = input("Choice: ").strip()
        if choice == "1":
            file_path = input("File path: ").strip()
            algo = input("Algorithm (sha256/md5, default sha256): ").strip().lower() or "sha256"
            print(f"{algo} hash: {compute_hash(file_path, algo)}")
        elif choice == "2":
            file_path = input("File path: ").strip()
            algo = input("Algorithm (sha256/md5, default sha256): ").strip().lower() or "sha256"
            expected = input("Expected hash: ").strip()
            if verify_hash(file_path, expected, algo):
                print("✅ Hash verified!")
            else:
                print("❌ Hash mismatch!")
        elif choice == "3":
            break
        else:
            print("Invalid choice.")

if __name__ == "__main__":
    interactive_menu()

