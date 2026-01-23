#!/bin/bash

# Debug script to log notification hook data
# Writes to /tmp/claude-notification-debug.log

LOG="/tmp/claude-notification-debug.log"

echo "=== $(date) ===" >> "$LOG"
echo "Args: $@" >> "$LOG"

# Capture stdin (Claude may pass JSON data here)
STDIN_DATA=$(cat)
echo "STDIN: $STDIN_DATA" >> "$LOG"

# Log all CLAUDE_* env vars
echo "ENV vars:" >> "$LOG"
env | grep ^CLAUDE_ >> "$LOG"

echo "" >> "$LOG"
