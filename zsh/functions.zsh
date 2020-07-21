# Aliases
alias l='ls -lh --color=auto --group-directories-first'
alias ls='ls --color=auto --group-directories-first'
alias lt='ls -lhrt --color=auto --group-directories-first'
alias ldot='ls -ld .*'
alias grep='grep --color=auto'
alias mocp='mocp -T rhowaldt'
alias clip='xclip -selection clipboard'
alias edit='cat > /tmp/_.txt; subl /tmp/_.txt'
alias cat='bat --style=plain'
alias tw='$HOME/dotshared/tmux/tmux.startup.shell'
alias th='$HOME/dotshared/tmux/tmux.startup.home'
alias lpython='$HOME/local-tmp/ipython/venv/bin/python'
alias lpip='$HOME/local-tmp/ipython/venv/bin/pip'

# Functions used as commands
sz() { source ~/.zshrc; echo "Sourced ~/.zshrc"; }
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
ws() { rg -n $@ --ignore-case --color=auto; }
wss() { sudo rg -n $@ --ignore-case --color=auto; }
ymp3() { youtube-dl --extract-audio --audio-format mp3 $1; }
yvid() { youtube-dl $1; }
venv() { if [[ "$VIRTUAL_ENV" == "" ]]; then source venv/bin/activate; else deactivate; fi; }
log() { echo "$1" && notify-send "$1"; }
ts() { ct=$(date +"%Y%m%d_%H%M%S"); mv $1 $1.$ct }

short-url() {
    urlencode() {
      python -c 'import urllib, sys; print(urllib.quote(sys.argv[1], sys.argv[2]))' "$1" "$urlencode_safe"
    }

    encoded=$(urlencode "$1")
    local url=$(curl --silent "https://is.gd/create.php?format=simple&url=$encoded")
    xclip -selection clipboard <<< $url
    echo $url
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

port-list() {
    local v=$(sudo lsof -i -P -n)
    echo $v | fzf
}

pid-list() {
    local v=$(sudo ps -aux)
    echo $v | fzf
}

# Git functions
gg () { git add .; git commit -m "automated commit message"; git push; }
ga () { if [[ $1 == "" ]]; then git add .;  else git add $@; fi }
gp () { git push }
gf () { git pull }
gs () { git status }
gss () { git status --short }
gr () { git checkout $1 }
grh () { git reset --hard origin/$(git branch | awk '{print $NF}') }
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
    (cd $HOME/notes; if gs | grep -q -E "Changes not staged for commit|Untracked files"; then gg; fi;)
    echo "- Pushing dotfiles"
    (cd $HOME/dotfiles; if gs | grep -q -E "Changes not staged for commit|Untracked files"; then gg; fi;)
    echo "- Pushing dotshared"
    (cd $HOME/dotshared; if gs | grep -q -E "Changes not staged for commit|Untracked files"; then gg; fi;)
}

gfa() {
    echo "- Syncing notes"
    (cd $HOME/notes; gf;)
    echo "- Syncing dotfiles"
    (cd $HOME/dotfiles; gf;)
    echo "- Syncing dotshared"
    (cd $HOME/dotshared; gf;)
}

docker-rmi() {
    docker rmi $(docker images -q) --force
}

docker-rmc() {
    docker rm $(docker ps -a -q) --force
}

docker-rma() {
    docker-rmc;
    docker-rmi;
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
        fi;
        if [ -f $f ]; then 
            xdotool type --delay 6 ${f} > /dev/null 2>&1
        fi;
    fi
    zle reset-prompt;
}; zle -N go

go_back() {
    cd ..; echo "";
    zle reset-prompt;
}; zle -N go_back

list_dir() {
    echo ""; ls -lFh --color=auto --group-directories-first;
    zle reset-prompt;
}; zle -N list_dir

start_wifi() {
    # wlp3s0 enp0s31f6 - home
    # wlp58s0 enp0s31f6 - work
    rm /tmp/create_ap.all.lock; sudo create_ap $1 $2 Pi jankowifi7
}

start_btooth() {
    systemctl start bluetooth.service && blueman-applet
}