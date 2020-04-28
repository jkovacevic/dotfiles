# Functions used as commands
sz() { source ~/.zshrc; echo "Sourced ~/.zshrc"; }
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
ws() { rgrep -n $@ --ignore-case --color=auto; }
wss() { sudo rg -n $@ --ignore-case --color=auto; }
ymp3() { youtube-dl --extract-audio --audio-format mp3 $1; }
yvid() { youtube-dl $1; }
venv() { if [[ "$VIRTUAL_ENV" == "" ]]; then source venv/bin/activate; else deactivate; fi; }

# Git functions
gg () { git add .; git commit -m "automated commit message"; git push; }
ga () { if [[ $1 == "" ]]; then git add .;  else git add $@; fi }
gp () { git push }
gf () { git pull }
gs () { git status }
gss () { git status --short }
gr () { git checkout $1 }
gh () { smerge log $1 }
gc () { git commit -m "$1" }
gd () { git diff $1; }
gb () { 
    local branch=$(git branch -a | grep -v HEAD | fzf --prompt='checkout-branch > ' | awk '{print $NF}';)
    if [[ $branch == *"remotes/origin"* ]]; then git checkout -t $branch; else git checkout $branch; fi;  
}

gdr() {
    if [ "$#" -ne 1 ]; then echo "Usage: gdr file.txt"; return 1; fi;
    remote_branch=$(git branch -r | grep -v HEAD | fzf --prompt='origin-branch > ' | xargs)
    local_path=/tmp/$(basename $remote_branch)-$(basename $1)
    git cat-file blob $remote_branch:$(git ls-files --full-name $1) > $local_path;
    readlink -f $1 | xargs echo -n | xclip -selection clipboard;
    fd $1 $local_path && subl $1;
}

gpr() {
    if [ "$#" -ne 1 ]; then echo "Usage: gpr file.txt"; return 1; fi;
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

gsa() {
    echo "- Status notes"
    (cd $HOME/notes; gss;)
    echo "- Status dotfiles"
    (cd $HOME/dotfiles; gss;)
    echo "- Status dotshared"
    (cd $HOME/dotshared; gss;)
}

gpa() {
    echo "- Pushing notes"
    (cd $HOME/notes; gg;)
    echo "- Pushing dotfiles"
    (cd $HOME/dotfiles; gg;)
    echo "- Pushing dotshared"
    (cd $HOME/dotshared; gg;)
}

gfa() {
    echo "- Syncing notes"
    (cd $HOME/notes; gf;)
    echo "- Syncing dotfiles"
    (cd $HOME/dotfiles; gf;)
    echo "- Syncing dotshared"
    (cd $HOME/dotshared; gf;)
}

# Other functions
create_tmp() {
    file=$2
    if [ "$#" -ne 2 ]; then 
        tmp_file=$tmp_folder/$(head /dev/urandom | tr -dc a-z0-9 | head -c 13)
    else
        tmp_file=$tmp_folder/$file
    fi;
    if [[ $file =~ \.py$ ]]; then
        echo "#!/home/jk/local-tmp/ipython/venv/bin/python" > $tmp_file
    else
        touch $tmp_file
    fi;
    subl $tmp_file;
}

tmp() {
    if [ $# -eq 2 ] || [[ $1 == "local" ]]; then
        tmp_folder="$HOME/notes/tmp";
        if [ -z "$2" ]; then
            tmp_file=$tmp_folder/$(head /dev/urandom | tr -dc a-z0-9 | head -c 13);
        else
            tmp_file=$tmp_folder/$2;
        fi;
    else
        tmp_folder="/tmp";
        if [ -z "$1" ]; then
            tmp_file=$tmp_folder/$(head /dev/urandom | tr -dc a-z0-9 | head -c 13);
        else
            tmp_file=$tmp_folder/$1;
        fi;
    fi;
    touch $tmp_file && subl $tmp_file;
}

log() {
    echo "$1" && notify-send "$1";
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

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)        tar xjf $1        ;;
            *.tar.gz)         tar xzf $1        ;;
            *.bz2)            bunzip2 $1        ;;
            *.rar)            unrar x $1        ;;
            *.gz)             gunzip $1         ;;
            *.tar)            tar xf $1         ;;
            *.tbz2)           tar xjf $1        ;;
            *.tgz)            tar xzf $1        ;;
            *.zip)            unzip $1          ;;
            *.Z)              uncompress $1     ;;
            *.7z)             7zr e $1          ;;
            *)                echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

killport () {
    kill -9 `lsof -i tcp:$1 | tail -1 | awk '{ print $2;}'`
}

# ZLE commands
go_back() {
    cd ..; echo "";
    xdotool key "ctrl+l"
    zle reset-prompt;
}; zle -N go_back

list_dir() {
    echo ""; ls -lFh --color=auto --group-directories-first;
    zle reset-prompt;
}; zle -N list_dir

reset_compinit() {
    rm $HOME/.zcompdump && compinit
}

go() {
    line=$(ls --color=auto --group-directories-first)
    sel=$(ls --color=auto --group-directories-first | /bin/cat -n | sed 's/ //g' | awk '{printf ("%s. %s\n", $1, $NF)}'| fzf --prompt='select > ')
    files=($(echo "$line" | tr ' ' '\n'))
    n=$(echo $sel | awk '{print $1}')
    n=${n/./}
    re='^[0-9]+$'
    if [[ $n =~ $re ]] ; then
        f=${files[$n]}
        if [ -d $f ]; then
            cd $f
            xdotool key "ctrl+l"
        fi;
        if [ -f $f ]; then 
            xdotool type ${f} > /dev/null 2>&1
            xdotool key "ctrl+a"
        fi;
    fi
    zle reset-prompt;

}; zle -N go