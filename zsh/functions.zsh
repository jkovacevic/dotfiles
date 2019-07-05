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
ws() { rgrep -rn $1 --color=auto; }
wss() { sudo rgrep -rn $1 --color=auto; }
ymp3() { youtube-dl --extract-audio --audio-format mp3 $1; }
yvid() { youtube-dl $1; }

# Git shortcuts
gg () { git add .; git commit -m "automated commit message"; git push; }
ga () {	if [[ $1 == "" ]]; then git add .;	else git add $@; fi }
gp () { git push }
gf () { git pull }
gs () { git status }
gc () { git commit -m "$1" }
gb () { git pull; git branch -a }
gbl () { git branch | fzf | xargs git checkout }
gbr () { git branch -r | grep -v HEAD | fzf | xargs git checkout -t }
gr () { git checkout $1 }
gh () { smerge log $1 }
gd () { if [ "$#" -eq 1 ]; then git diff $1; return 1; 
		elif [ "$#" -eq 2 ]; then f=$(cut -d "/" -f 2 <<< "$1"); b=$2;
		else echo "Expected arguments: file name, branch name"; return 1; fi;
		git cat-file blob origin/$b:$1 > /tmp/$b-$f; 
		fd $1 /tmp/$b-$f;
}

gptb() {
	if [ "$#" -ne 1 ]; then echo "Expected arguments: file_name"; return 1; fi;
	file_name=$1;
	remote_branch=$(git branch | fzf);
	local_branch=$(git status | head -1 | awk '{ print $NF }')
	cpcat $file_name;
	git checkout $remote_branch;
	cppsh $file_name;
	git add $file_name;
	git commit -m "automated commit message";
	git push;
	git checkout $local_branch;
}

aws() {	if [[ "$*" == *tree* ]]; then aws_s3_tree $@; else command aws $@; fi; }
aws_s3_tree() {
	KEY=$_
	BUCKET=$(grep -oP "(?<=s3://).*?(?=/)" <<< "$KEY")
	PREFIX=$(sed "s/.*$BUCKET\///" <<< "$KEY")
	aws s3api list-objects --bucket $BUCKET --prefix $PREFIX | jq ".Contents[] .Key" | sed s/\"//g | sed -e s#$PREFIX##
}

copy_cmd() { 
	zle kill-buffer; 
	print -rn -- $CUTBUFFER | xclip -selection clipboard; 
}; zle -N copy_cmd

template() {
	choices=("awk\nsed\ncut")
	selected=$(echo -e "$choices" | rofi -dmenu)
	if [[ "$selected" == "awk" ]]; then
		zle -U "awk '{ print }'";
	elif [[ "$selected" == "sed" ]]; then
		zle -U "sed 's/word/replacement/g'";
	elif [[ "$selected" == "cut" ]]; then
		zle -U "cut -d / -f 1";
	fi;
}; zle -N template