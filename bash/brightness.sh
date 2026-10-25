#!/bin/bash
# Usage: ./brightness.sh <percent>   e.g. ./brightness.sh 10

percent="$1"

if [[ -z "$percent" || ! "$percent" =~ ^[0-9]+$ || "$percent" -lt 1 || "$percent" -gt 100 ]]; then
    echo "Usage: $0 <percent 1-100>"
    exit 1
fi

level=$(awk -v p="$percent" 'BEGIN { printf "%.2f", p / 100 }')

for output in $(xrandr --listmonitors | awk '/^ [0-9]+:/ {print $NF}'); do
    xrandr --output "$output" --brightness "$level"
done
