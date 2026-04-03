#!/usr/bin/env python3
"""Send Telegram notifications from your desktop."""

import requests

# Replace these with your actual values
BOT_TOKEN = "8288093061:AAGlqCcQILt8hKRap0I5F82cz2pydY3CuPQ"
CHAT_ID = "1634521643"


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
