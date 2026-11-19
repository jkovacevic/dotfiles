#!/usr/bin/env python3
"""Send Telegram notifications from your desktop."""

import os
import sys

import requests

BOT_TOKEN = os.environ.get("TELEGRAM_BOT_TOKEN")
CHAT_ID = os.environ.get("TELEGRAM_CHAT_ID")

if not BOT_TOKEN or not CHAT_ID:
    sys.exit("Missing TELEGRAM_BOT_TOKEN or TELEGRAM_CHAT_ID environment variable")


def send_telegram_message(message: str) -> bool:
    """Send a message via Telegram bot."""
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
    payload = {
        "chat_id": CHAT_ID,
        "text": message,
    }

    response = requests.post(url, json=payload)

    if response.ok:
        print("Message sent successfully!")
        return True
    else:
        print(f"Failed to send message: {response.text}")
        return False


if __name__ == "__main__":
    send_telegram_message("Hello World!")
