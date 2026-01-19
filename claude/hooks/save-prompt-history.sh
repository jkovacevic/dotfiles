#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract the prompt from JSON
prompt=$(echo "$input" | jq -r '.prompt // empty')

# Exit if no prompt
if [ -z "$prompt" ]; then
    exit 0
fi

# Get tmux window name (tab name)
tmux_name=$(tmux display-message -p '#W' 2>/dev/null)

# Fallback if not in tmux
if [ -z "$tmux_name" ]; then
    tmux_name="no-tmux"
fi

# Use PPID (Claude Code's process ID) to track session
session_marker="/tmp/claude-session-${PPID}"

# Get or create session start timestamp
if [ -f "$session_marker" ]; then
    session_timestamp=$(cat "$session_marker")
else
    session_timestamp=$(date '+%Y-%m-%d@%H:%M:%S')
    echo "$session_timestamp" > "$session_marker"
fi

# Current timestamp for the entry
entry_timestamp=$(date '+%H:%M:%S')

# Define the output directory and file
output_dir="/home/jk/notes/model/history/${tmux_name}"
output_file="${output_dir}/${session_timestamp}.txt"

# Create directory if it doesn't exist
mkdir -p "$output_dir"

# Append the prompt to the file with timestamp
echo "[$entry_timestamp] $prompt" >> "$output_file"
echo "" >> "$output_file"

exit 0
