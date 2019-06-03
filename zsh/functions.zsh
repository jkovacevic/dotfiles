# Functions used as commands
bg() { nohup $@ > /dev/null 2>&1 & disown }
cpcat() { cat $1 | xclip -selection clipboard; }
cppsh() { xclip -selection clipboard -o > $1; }
cpth() { readlink -f $1 | xargs echo -n | xclip -selection clipboard; }
evince () { bg evince "$@" }
fd() { eval subl --command \'sbs_compare_files {\"A\":\"$(realpath $1)\", \"B\":\"$(realpath $2)\"}\'; }
fs() {find -iname \*$1\*; }
fss() {sudo find -iname \*$1\*; }
libreoffice () { bg libreoffice "$@" }
pinta () { bg pinta "$@" }
sxiv () { if [[ $# -eq '0' ]]; then bg /usr/bin/sxiv -t -a .; elif [[ -d $1 ]]; then bg /usr/bin/sxiv -t -a $1; else bg /usr/bin/sxiv -a $@; fi; }
vlc() { bg vlc "$@" }
ws() {grep -rn $1; }
wss() {sudo grep -rn $1; }
ymp3() { youtube-dl --extract-audio --audio-format mp3 $1; }
yvid() { youtube-dl $1; }

# Git shortcuts
gg () {git add .; git commit -m "automated commit message"; git push;}
ga () {	if [[ $1 == "" ]]; then git add .;	else git add $@; fi }
gp () {git push}
gf () {git pull}
gs () {git status}
gc () {git commit -m "$1"}
gr () {git reset $@}
gh () {smerge log $1}
gd () { if [ "$#" -eq 1 ]; then git diff $1; return 1; 
		elif [ "$#" -eq 3 ]; then f=$(cut -d "/" -f 2 <<< "$1"); b1=$2; b2=$3;
		else echo "Expected arguments: file name, first branch name, second branch name,"; return 1; fi;
		git cat-file blob origin/$b1:$f > /tmp/$b1-$f; 
		git cat-file blob origin/$b2:$f > /tmp/$b2-$f; 
		fd /tmp/$b1-$f /tmp/$b2-$f
}

copy_cmd() { 
	zle kill-buffer; 
	print -rn -- $CUTBUFFER | xclip -selection clipboard; 
}; zle -N copy_cmd

template() {
	choices=("awk\nsed")
	selected=$(echo -e "$choices" | rofi -dmenu)
	if [[ "$selected" == "awk" ]]; then
		zle -U " | awk '{ print }'";
	elif [[ "$selected" == "sed" ]]; then
		zle -U " | sed 's/word/replacement/g'";
	fi;
}; zle -N template