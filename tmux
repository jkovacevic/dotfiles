set -g default-terminal "screen-256color"

unbind C-b
set -g prefix F12

set -g base-index 1
setw -g pane-base-index 1

setw -g window-status-current-format ' #I.#W '
setw -g window-status-format ' #I.#W '

# default statusbar colors
set -g status-fg white
set -g status-bg black
set-window-option -g window-status-style fg=default,bg=default,dim
set-window-option -g window-status-current-style fg=cyan,bg=default,bright

bind k confirm kill-window
bind K confirm kill-server