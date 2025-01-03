#!/usr/bin/zsh
# Aliases
alias l='ls -lh --color=auto --group-directories-first'
alias ls='ls --color=auto --group-directories-first'
alias lt='ls -lhrt --color=auto --group-directories-first'
alias ldot='ls -ld .*'
alias grep='grep --color=auto'
alias mocp='mocp -T nightly_theme'
alias clip='sed -z "$ s/\n$//" | xclip -selection clipboard'
alias edit='cat > /tmp/_shell.txt; subl /tmp/_shell.txt'
alias cat='bat --theme=Nord --style=plain'
alias ipy='$HOME/ipython/venv/bin/python'
alias ipip='$HOME/ipython/venv/bin/pip'
alias mi='TERM=xterm-256color micro'
alias vs='cursor -add'
alias pacman='sudo pacman' 

export FZF_DEFAULT_OPTS="--prompt='search > ' --height 60% --layout=reverse --border --exact --sort"
export FZF_CTRL_T_COMMAND="command fd --hidden --no-ignore --ignore-case . /"
export FZF_ALT_C_COMMAND="command fd --hidden --no-ignore --ignore-case -t d . /"

# Functions used as commands
bg() { nohup $@ > /dev/null 2>&1 & disown }
f() { bg mimeo "$@" }
sxiv() { if [[ $# -eq '0' ]]; then bg /usr/bin/sxiv -t -a .; elif [[ -d $1 ]]; then bg /usr/bin/sxiv -t -a $1; else bg /usr/bin/sxiv -a $@; fi; }
fd() { eval subl --command \'sbs_compare_files {\"A\":\"$(realpath $1)\", \"B\":\"$(realpath $2)\"}\'; }
cpcat() { cat $1 | xclip -selection clipboard; }
cppsh() { xclip -selection clipboard -o > $1; }
cpth() { readlink -f $1 | xargs echo -n | xclip -selection clipboard; }
cpthlt() { cpth $(ls -r | head -n 1) }
ws() { rg -n $@ --ignore-case --color=auto; }
wss() { sudo rg -n $@ --ignore-case --color=auto; }
ymp3() { $HOME/ipython/venv/bin/yt-dlp -o "%(title).150B [%(id)s].%(ext)s" --extract-audio --audio-format mp3 $1; }
yvid() { $HOME/ipython/venv/bin/yt-dlp -o "%(title).150B [%(id)s].%(ext)s" $1; }
venv() { if [[ "$VIRTUAL_ENV" == "" ]]; then source venv/bin/activate; else deactivate; fi; }
log() { echo "$1" && notify-send "$1"; }
ts() { ct=$(date +"%Y%m%d_%H%M%S"); mv $1 $1.$ct }
notes() {  find "$HOME/notes/tmp/" -type f -empty -delete && EDITOR=vscodium ranger "$HOME/notes/tmp/" }
pass-push() { pass git add . && pass git commit -m "automated commit message" && pass git push origin master }
dotfiles-push() { cd $HOME/dotfiles && git add . && git commit -m "automated commit message" && git push origin master }

# Other functions
tm() {
    if [ -z "$TMUX" ] && [ ! -z "$DISPLAY" ];
    then
        echo "---- TMUX Startup ----\n[w]orkshell\n[h]omeshell"
        vared -p '' -c shell
        tmux source-file ~/.tmux.conf
        if [[ ${shell:l} == "w" ]]; then
            $HOME/dotfiles/tmux/tmux.startup.shell;
        elif [[ ${shell:l} == "h" ]]; then
            $HOME/dotfiles/tmux/tmux.startup.home;
        else
            tmux new-session -d -s $shell;
            tmux attach -t $shell;
        fi;
    fi;
}

setup-capslock() {
    xmodmap -e 'clear Lock'
    xmodmap -e "keycode 66 = F13"
}

di() {
    find_latest_name() {
        dir_name=$1
        file_name=$2
        file_ext=$3
        n="1"
        FILE_NAME="${dir_name}/${file_name}${n}${file_ext}"
        while [ -f $FILE_NAME ]
        do
            n=$((n + 1))
            FILE_NAME="${dir_name}/${file_name}${n}${file_ext}"
        done
    }

    if [ ! "$#" -eq 1 ]; then echo "Expecting Document ticket number as CLI argument"; exit 1; fi;
    ticket_num=$1
    ticket_num=${ticket_num:l}

    project_home="$HOME/documents"
    file_name="item"
    file_ext=".md"
    dir_name="$project_home/$ticket_num"

    if [ ! -d $dir_name ]; then
        echo "Creating directory $dir_name"
        mkdir -p $dir_name
    fi;

    find_latest_name $dir_name $file_name $file_ext

    if [ ! -f $FILE_NAME ]; then
        echo "Creating file: $FILE_NAME"
        echo "<Insert ticket title>" > $FILE_NAME
        echo "https://jira.smaato.net/browse/${ticket_num}" >> $FILE_NAME
        subl $FILE_NAME
    fi;
}

dl() {
    file_path=$(doc-list_ | sort | fzf --no-sort | awk '{print $1}')
    subl $file_path
}

doc-list_() {
    project_home="$HOME/documents"
    file_name="item1.md"
    dir_name="$project_home/$ticket_num"

    for f in $(ls $project_home); do
        file_path="$project_home/$f/$file_name";
        echo $file_path;
    done;
}

# Docker functions
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
    fd $1 $local_path;
    subl $1;
}

gsa() {
    echo "- Status notes"
    (cd $HOME/notes; gss;)
    echo "- Status dotfiles"
    (cd $HOME/dotfiles; gss;)
}

gpa() {
    echo "- Pushing notes"
    (cd $HOME/notes; if [[ $(git status --short) ]]; then gg; fi;)
    echo "- Pushing dotfiles"
    (cd $HOME/dotfiles; if [[ $(git status --short) ]]; then gg; fi;)
}

gfa() {
    echo "- Syncing notes"
    (cd $HOME/notes; gf;)
    echo "- Syncing dotfiles"
    (cd $HOME/dotfiles; gf;)
}

# ZLE functions
go-back() {
    cd ..; echo "";
    zle reset-prompt;
}; zle -N go-back

list-dir() {
    text="$BUFFER"
    dir=$(awk '{print $NF}' <<< $text)
    if [ -d "$dir" ]; then
        (cd $dir && echo "" && ls -lFh --color=auto --group-directories-first;)
    else
        echo ""; ls -lFh --color=auto --group-directories-first;
    fi;
    zle reset-prompt;
}; zle -N list-dir

home-dir() {
    LBUFFER="$LBUFFER~/"
    zle reset-prompt;
}; zle -N home-dir

copy-text() {
    text="$BUFFER"
    BUFFER=""
    zle reset-prompt
    echo -n $text | xclip -selection clipboard
    notify-send "ZSH copy:" $text
}; zle -N copy-text

fzf-pass() {
    # https://github.com/ficoos/pass-fzf
    echo "" && PASSWORD_STORE_ENABLE_EXTENSIONS=true pass fzf;
    zle reset-prompt;
}; zle -N fzf-pass

reset-term() {
    source ~/dotfiles/$PLATFORM/zsh/zshrc.zsh
    /usr/bin/tmux source ~/dotfiles/shared/tmux/tmux.conf
    zle reset-prompt
    /usr/bin/notify-send "Reset prompt"
}; zle -N reset-term

# Utility functions
start-wifi() {
    # wlp3s0 enp0s31f6 - home
    # wlp58s0 enp0s31f6 - work
    rm /tmp/create_ap.all.lock; sudo create_ap $1 $2 Pi jankowifi7
}

weather() {
    curl wttr.in/$1
}

rtfm() {
    tldr $@ || man $@ || $BROWSER "http://www.google.com/search?q=$@"; 
}

upload() {
    RESPONSE=$(curl -s https://apiv2.gofile.io/getServer)
    SERVER_STATUS=$(jq -r .status <<< $RESPONSE)
    if [ $SERVER_STATUS = "ok" ]; then
        SERVER=$(jq -r .data.server <<< $RESPONSE)
        FILE_ID=$(jq -r .data.code <<< $(curl -s -F file=@"$1" https://$SERVER.gofile.io/uploadFile))
        URL="https://gofile.io/d/$FILE_ID"
        xclip -selection clipboard <<< $URL
        notify-send "Uploaded file $1 to $URL"
    else
        echo "Failed to find server in $RESPONSE. See https://gofile.io/api"
    fi
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

short-url() {
    urlencode() {
      python -c 'import urllib, sys; print(urllib.quote(sys.argv[1], sys.argv[2]))' "$1" "$urlencode_safe"
    }

    encoded=$(urlencode "$1")
    local url=$(curl --silent "https://is.gd/create.php?format=simple&url=$encoded")
    xclip -selection clipboard <<< $url
    echo $url
}

port-list() {
    local v=$(sudo lsof -i -P -n)
    echo $v | fzf
}

pid-list() {
    local v=$(sudo ps -aux)
    echo $v | fzf
}

path-list() {
    echo $PATH | sed s/:/\\n/g | sort
}

str-format() {
    x=$(awk '{print tolower($0)}' <<< $1)
    x=$(sed s#/##g <<< $x)
    x=$(sed s/-/\ /g <<< $x)
    x=$(sed s/\ /-/g <<< $x)
    x=$(sed s/,//g <<< $x)
    echo $x
}

polget() {
    (cd $HOME/hard-disk/threads/pol && changet $1)
}

bizget() {
    (cd $HOME/hard-disk/threads/biz && changet $1)
}

mic-volume() {
    while sleep 0.1; do pacmd set-source-volume alsa_input.pci-0000_00_1f.3.analog-stereo 40000; done
}
