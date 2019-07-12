# Functions used as commands
bg() { nohup $@ > /dev/null 2>&1 & disown }
evince () { bg evince "$@" }
libreoffice () { bg libreoffice "$@" }
pinta () { bg pinta "$@" }
vlc() { bg vlc "$@" }
thunar() { bg thunar "$@" }
sxiv () { if [[ $# -eq '0' ]]; then bg /usr/bin/sxiv -t -a .; elif [[ -d $1 ]]; then bg /usr/bin/sxiv -t -a $1; else bg /usr/bin/sxiv -a $@; fi; }
fd() { eval subl --command \'sbs_compare_files {\"A\":\"$(realpath $1)\", \"B\":\"$(realpath $2)\"}\'; }
cpcat() { cat $1 | xclip -selection clipboard; }
cppsh() { xclip -selection clipboard -o > $1; }
cpth() { readlink -f $1 | xargs echo -n | xclip -selection clipboard; }
ws() { rgrep -rn $1 --color=auto; }
wss() { sudo rgrep -rn $1 --color=auto; }
ymp3() { youtube-dl --extract-audio --audio-format mp3 $1; }
yvid() { youtube-dl $1; }

# Git functions
gg () { git add .; git commit -m "automated commit message"; git push; }
ga () {	if [[ $1 == "" ]]; then git add .;	else git add $@; fi }
gp () { git push }
gf () { git pull }
gs () { git status }
gd () { git diff $1; }
gr () { git checkout $1 }
gh () { smerge log $1 }
gc () { git commit -m "$1" }
gb () { git pull; git branch -a }
gbl () { git branch | fzf --prompt='local-branch > ' | xargs git checkout }
gbr () { git branch -r | grep -v HEAD | fzf --prompt='origin-branch > ' | xargs git checkout -t }

gdb() {
	if [ "$#" -ne 1 ]; then echo "Expected arguments: file_name"; return 1; fi;
	remote_branch=$(git branch -r | grep -v HEAD | fzf --prompt='origin-branch > ' | xargs)
	local_path=/tmp/$(basename $remote_branch)-$(basename $1)
	git cat-file blob $remote_branch:$1 > $local_path;
	fd $1 $local_path;
}

gptb() {
	if [ "$#" -ne 1 ]; then echo "Expected arguments: file_name"; return 1; fi;
	file_name=$1;
	local_branch=$(git branch | awk '{print $NF}' | fzf --prompt='local-branch > ');
	current_branch=$(git symbolic-ref --short HEAD)
	cpcat $file_name;
	git checkout $local_branch;
	cppsh $file_name;
	git add $file_name;
	git commit -m "automated commit message";
	git push;
	git checkout $current_branch;
}

# Python 
pipi() {
	echo "Using $(pip --version)"
	pip install --user $(python $HOME/dotfiles/python/list_pypi.py | fzf --prompt 'install-package > ')
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

manfind() {
	man -k . | fzf --prompt='man-pages > ' | awk '{print $1}' | xargs -r man
}

pkill() {
  	local pid 
	if [ "$UID" != "0" ]; then
	    pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
	    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi;
	if [ "x$pid" != "x" ]; then echo $pid | xargs kill -${1:-9}; fi
}