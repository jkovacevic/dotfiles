set -g default-terminal "screen-256color"

unbind C-b
set -g prefix F12

set -g base-index 1
setw -g pane-base-index 1

setw -g window-status-current-format ' #I.#W '
setw -g window-status-format ' #I.#W '

set -g status-style fg=white,bg=black
set-window-option -g window-status-style fg=default,bg=default,dim
set-window-option -g window-status-current-style fg=cyan,bg=default,bright

bind -n C-PageDown next-window
bind -n C-PageUp previous-window
bind -n C-S-PageDown swap-window -t +1
bind -n C-S-PageUp swap-window -t -1

bind n new-window
bind r kill-window
bind k confirm kill-server