#!/bin/bash
timestamp=$(date +"%Y-%m-%d@%H:%M:%S")
temp_dir="/home/jk/notes/tmp"
temp_file="$temp_dir/$timestamp.txt"
touch "$temp_file"
vscodium -add "$temp_file"