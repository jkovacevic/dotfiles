#!/bin/bash
# System-level setup (requires sudo)
# Run with: sudo ./setup-system.sh

if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo: sudo ./setup-system.sh"
    exit 1
fi

echo "# Setup Tailscale"
systemctl enable --now tailscaled
tailscale set --operator=$SUDO_USER

echo "=== MANUAL STEPS REQUIRED ==="
echo "1. Run 'tailscale up' to authenticate (first time only)"
echo "2. Run 'vncpasswd' to set VNC password (first time only)"
