set -g default-terminal "screen-256color"

unbind C-b
set -g prefix F12

set -g base-index 1
set -g pane-base-index 1
set -g window-status-current-format ' #I.#W '
set -g window-status-format ' #I.#W '
set -g status-right ''

set -g status-style fg=white,bg=colour16
set-window-option -g window-status-style fg=default,bg=default,dim
set-window-option -g window-status-current-style fg=cyan,bg=default,bright

bind -n C-PageDown next-window
bind -n C-PageUp previous-window
bind -n C-S-PageDown swap-window -t +1
bind -n C-S-PageUp swap-window -t -1

bind -n M-0 select-window -t :0
bind -n M-1 select-window -t :1
bind -n M-2 select-window -t :2
bind -n M-3 select-window -t :3
bind -n M-4 select-window -t :4
bind -n M-5 select-window -t :5
bind -n M-6 select-window -t :6
bind -n M-7 select-window -t :7
bind -n M-8 select-window -t :8
bind -n M-9 select-window -t :9

bind n new-window
bind r kill-window
bind d confirm detach-client
bind k confirm kill-server