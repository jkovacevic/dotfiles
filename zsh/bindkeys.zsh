bindkey -r "^[c"
bindkey -r "^T"

bindkey "^[[3~"     delete-char
bindkey "^[3;5~"    delete-char
bindkey "^[d"       delete-word
bindkey ";5D"       vi-backward-blank-word
bindkey ";5C"       .vi-forward-blank-word
bindkey "^Z"        undo
bindkey "^[[20~"    list-dir
bindkey "^H"        go-back
bindkey "^Y"        copy-text
bindkey "^P"        fzf-pass
bindkey "^[h"       home-dir
bindkey "^F"        fzf-file-home
bindkey "^[[102;6u" fzf-file-system
bindkey "^D"        fzf-cd-home
