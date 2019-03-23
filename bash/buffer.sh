f=/tmp/_$1.txt
xsel > $f
notify-send "Copied selected text to: $f"