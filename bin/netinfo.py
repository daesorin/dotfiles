#!/usr/bin/env python3
import socket
import subprocess
from pathlib import Path
from tqdm import tqdm
import urllib.request
import argparse

def public_ip():
    """Fetch and print public IP using urllib (no external modules)."""
    try:
        with urllib.request.urlopen("https://ifconfig.me") as response:
            ip = response.read().decode().strip()
            print(f"Public IP: {ip}")
    except Exception as e:
        print(f"Cannot get public IP: {e}")

def local_ip():
    """Detect local IP on Wi-Fi / network interfaces."""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))  # dummy connect to detect interface
        ip = s.getsockname()[0]
        s.close()
        print(f"Local IP: {ip}")
    except Exception:
        print("Cannot determine local IP")

def port_scan(host, start=1, end=1024):
    """Scan a range of ports on a host with progress bar."""
    print(f"Scanning {host} ports {start}-{end} ...")
    open_ports = []
    for port in tqdm(range(start, end+1), desc="Scanning", unit="port"):
        try:
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.settimeout(0.5)
            result = sock.connect_ex((host, port))
            sock.close()
            if result == 0:
                open_ports.append(port)
        except Exception:
            continue
    if open_ports:
        print(f"Open ports on {host}: {open_ports}")
    else:
        print(f"No open ports found on {host}.")

def batch_scan(hosts, start=1, end=1024):
    """Scan multiple hosts in sequence."""
    for host in hosts:
        print(f"\n=== Scanning host: {host} ===")
        port_scan(host, start=start, end=end)

def main():
    parser = argparse.ArgumentParser(description="Network Info & Scanner")
    parser.add_argument("--host", help="Host to scan")
    parser.add_argument("--batch", nargs="+", help="Batch hosts to scan")
    parser.add_argument("--start", type=int, default=1, help="Start port")
    parser.add_argument("--end", type=int, default=1024, help="End port")
    args = parser.parse_args()

    print("\n=== Network Info ===")
    public_ip()
    local_ip()

    if args.host:
        port_scan(args.host, start=args.start, end=args.end)
    elif args.batch:
        batch_scan(args.batch, start=args.start, end=args.end)
    else:
        host = input("Enter host to scan: ").strip()
        port_scan(host, start=args.start, end=args.end)

if __name__ == "__main__":
    main()

