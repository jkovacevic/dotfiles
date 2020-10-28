#!/usr/bin/bash
# Install translate-shell
translation=$(trans -b "$(xsel)")
notify-send "$translation"
