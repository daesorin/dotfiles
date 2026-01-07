#!/usr/bin/env python3
import os
from pathlib import Path
from getpass import getpass
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
import base64
import subprocess

def encrypt_file(file_path, password):
    file_path = Path(file_path)
    key = password.encode('utf-8')
    nonce = get_random_bytes(12)
    cipher = AES.new(key.ljust(32, b'\0'), AES.MODE_GCM, nonce=nonce)
    with open(file_path, "rb") as f:
        data = f.read()
    ciphertext, tag = cipher.encrypt_and_digest(data)
    enc_file = file_path.with_suffix(file_path.suffix + ".enc")
    with open(enc_file, "wb") as f:
        f.write(nonce + tag + ciphertext)
    print(f"Encrypted: {enc_file}")

def decrypt_file(file_path, password):
    file_path = Path(file_path)
    key = password.encode('utf-8')
    with open(file_path, "rb") as f:
        nonce, tag, ciphertext = f.read(12), f.read(16), f.read()
    cipher = AES.new(key.ljust(32, b'\0'), AES.MODE_GCM, nonce=nonce)
    try:
        data = cipher.decrypt_and_verify(ciphertext, tag)
        out_file = file_path.with_suffix('')
        with open(out_file, "wb") as f:
            f.write(data)
        print(f"Decrypted: {out_file}")
    except Exception as e:
        print(f"Decryption failed: {e}")

def pgp_encrypt(file_path):
    subprocess.run(["gpg", "--output", str(file_path) + ".gpg", "--encrypt", "--recipient", input("Recipient email: "), str(file_path)])

def pgp_decrypt(file_path):
    subprocess.run(["gpg", "--output", str(file_path).with_suffix(''), "--decrypt", str(file_path)])

def interactive_menu():
    while True:
        print("\n--- File Encryption Suite ---")
        print("1. AES encrypt file")
        print("2. AES decrypt file")
        print("3. PGP encrypt file")
        print("4. PGP decrypt file")
        print("5. Exit")
        choice = input("Choice: ").strip()
        if choice in ["1", "2"]:
            file_path = input("File path: ").strip()
            password = getpass("Password: ").strip()
            if choice == "1":
                encrypt_file(file_path, password)
            else:
                decrypt_file(file_path, password)
        elif choice == "3":
            file_path = input("File path: ").strip()
            pgp_encrypt(file_path)
        elif choice == "4":
            file_path = input("File path: ").strip()
            pgp_decrypt(file_path)
        elif choice == "5":
            break
        else:
            print("Invalid choice.")

if __name__ == "__main__":
    interactive_menu()

