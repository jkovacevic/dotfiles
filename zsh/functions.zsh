# Functions used as commands
bg() { nohup $@ > /dev/null 2>&1 & disown }
evince () { bg evince "$@" }
libreoffice () { bg libreoffice "$@" }
pinta () { bg pinta "$@" }
vlc() { bg vlc "$@" }
thunar() { bg thunar "$@" }
sxiv () { if [[ $# -eq '0' ]]; then bg /usr/bin/sxiv -t -a *; elif [[ -d $1 ]]; then bg /usr/bin/sxiv -t -a $1; else bg /usr/bin/sxiv -a $@; fi; }
fd() { eval subl --command \'sbs_compare_files {\"A\":\"$(realpath $1)\", \"B\":\"$(realpath $2)\"}\'; }
cpcat() { cat $1 | xclip -selection clipboard; }
cppsh() { xclip -selection clipboard -o > $1; }
cpth() { readlink -f $1 | xargs echo -n | xclip -selection clipboard; }
ws() { rgrep -n $@ --color=auto; }
wss() { sudo rg -n $@ --color=auto; }
ymp3() { youtube-dl --extract-audio --audio-format mp3 $1; }
yvid() { youtube-dl $1; }
venv() { if [[ "$VIRTUAL_ENV" == "" ]]; then source venv/bin/activate; else deactivate; fi; }

# Git functions
gg () { git add .; git commit -m "automated commit message"; git push; }
ga () {	if [[ $1 == "" ]]; then git add .;	else git add $@; fi }
gp () { git push }
gf () { git pull }
gs () { git status }
gr () { git checkout $1 }
gh () { smerge log $1 }
gc () { git commit -m "$1" }
gd () { git diff $1; }
gdb() {
    if [ "$#" -ne 1 ]; then echo "Usage: gbd file.txt"; return 1; fi;
    remote_branch=$(git branch -r | grep -v HEAD | fzf --prompt='origin-branch > ' | xargs)
    local_path=/tmp/$(basename $remote_branch)-$(basename $1)
    git cat-file blob $remote_branch:$(git ls-files --full-name $1) > $local_path;
    fd $1 $local_path;
}
gb () { 
    local branch=$(git branch -a | grep -v HEAD | fzf --prompt='checkout-branch > ' | awk '{print $NF}';)
    if [[ $branch == *"remotes/origin"* ]]; then git checkout -t $branch; else git checkout $branch; fi;  
}
gptb() {
    if [ "$#" -ne 1 ]; then echo "Usage: gptb file.txt"; return 1; fi;
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

# Other functions
tmp() {
    tmp_folder=$HOME/notes/tmp
    if [ "$#" -ne 1 ]; then 
        tmp_file=$tmp_folder/$(head /dev/urandom | tr -dc a-z0-9 | head -c 13)
    else
        tmp_file=$tmp_folder/$1
    fi;
    touch $tmp_file
    subl $tmp_file
}

log() {
    echo "$1" && notify-send "$1"
}

short-url() {

    urlencode() {
      python -c 'import urllib, sys; print(urllib.quote(sys.argv[1], sys.argv[2]))' "$1" "$urlencode_safe"
    }

    encoded=$(urlencode "$1")
    local url=$(curl --silent "https://is.gd/create.php?format=simple&url=$encoded")
    xclip -selection clipboard <<< $url
    echo $url
}

ts() {
    ct=$(date +"%Y%m%d_%H%M%S")
    mv $1 $1.$ct
}

sync-all() {
    echo "Syncing notes"
    (cd $HOME/notes; gf;)
    echo "Syncing dotfiles"
    (cd $HOME/dotfiles; gf;)
}

push-all() {
    echo "Pushing notes"
    (cd $HOME/notes; gg;)
    echo "Pushing dotfiles"
    (cd $HOME/dotfiles; gg;)
}

# ZLE commands
copy_cmd() { 
    zle kill-buffer; 
    print -rn -- $CUTBUFFER | xclip -selection clipboard; 
}; zle -N copy_cmd

go_back() {
    cd ..; echo "";
    zle reset-prompt;
}; zle -N go_back