#!/bin/bash
date=$(date +"%Y-%m-%d")
tasks_dir="/home/jk/notes/tasks"
task_file="$tasks_dir/$date.todo"

if [ -f "$task_file" ]; then
    notify-send "Task file already exists" "$task_file"
else
    printf 'TODO list:\n\t☐ item1\n\t☐ item2\n' > "$task_file"
fi

code -r "$task_file"
