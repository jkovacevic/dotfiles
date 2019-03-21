f1=/tmp/_1.txt
f2=/tmp/_2.txt
xclip -selection clipboard -o > $f1
xsel > $f2
eval subl --command \'sbs_compare_files {\"A\":\"$f1\", \"B\":\"$f2\"}\'