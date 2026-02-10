#!/usr/bin/env python3
import subprocess
import json
import os
import re
import datetime

# CONFIGURATION
LEDGER_FILE = os.path.expanduser("~/Documents/finance/2026.journal")
CURRENCY = "₦"


def get_monthly_data():
    # Get expenses for the current month
    cmd = [
        "hledger",
        "-f",
        LEDGER_FILE,
        "bal",
        "expenses",
        "-p",
        "this month",
        "--depth",
        "2",
        "--no-total",
        "-O",
        "csv",
    ]
    try:
        output = subprocess.check_output(cmd).decode("utf-8").strip().split("\n")
        return output
    except:
        return []


def parse(data):
    expenses = []
    total = 0.0

    for line in data:
        if not line or "account" in line:
            continue
        parts = line.replace('"', "").split(",")
        if len(parts) < 2:
            continue

        account = parts[0].replace("expenses:", "").replace(":", " > ")
        # Clean the amount string
        raw_amt = re.sub(r"[^\d.-]", "", parts[1])
        try:
            amt = float(raw_amt)
            if amt > 0:
                expenses.append((account, amt))
                total += amt
        except:
            continue

    # Sort top 5 for tooltip
    expenses.sort(key=lambda x: x[1], reverse=True)
    return total, expenses[:6]


def main():
    if not os.path.exists(LEDGER_FILE):
        print(json.dumps({"text": "No Journal", "class": "error"}))
        return

    data = get_monthly_data()
    total, top_expenses = parse(data)

    # Tooltip construction
    tooltip = f"<b>{datetime.datetime.now().strftime('%B')} Spending</b>\n"
    tooltip += "----------------\n"
    for cat, amt in top_expenses:
        tooltip += f"{cat}: {CURRENCY} {amt:,.2f}\n"

    # JSON Output for Waybar
    output = {
        "text": f"{CURRENCY} {total:,.0f}",
        "tooltip": tooltip.strip(),
        "class": "finance",
        "alt": "expenses",
    }

    print(json.dumps(output))


if __name__ == "__main__":
    main()
