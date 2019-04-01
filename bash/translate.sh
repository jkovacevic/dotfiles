#!/bin/bash
translation=$(trans -b "$(xsel)")
notify-send "$translation"
