set -g default-terminal "rxvt-unicode-256color"

unbind C-b
unbind s
set -g prefix F1

# Start window index from 1
set -g base-index 1
set -g pane-base-index 1

# Set active and default tab name format
set -g window-status-format ' #I.#W '
set -g window-status-current-format ' #I.#W '
# Session indicator
set -g status-left-style fg=cyan,bg=colour16,bright
set -g status-left ' #[fg=white][#[fg=cyan]#S#[fg=white]] '
# Remove right status
set -g status-right ''

# Set active and default tab styles
set -g status-style fg=white,bg=colour16
setw -g window-status-style fg=white,bg=colour16,dim
setw -g window-status-current-style fg=cyan,bg=colour16,bright

# Add padding above tmux status and color it black
setw -g pane-border-status bottom
setw -g pane-border-format ''
setw -g pane-active-border-style fg=cyan,bg=colour16,dim

# Keybindings
bind -n C-n new-window
bind -n C-w kill-window
bind -n C-x confirm kill-server
bind -n F2 command-prompt
bind -n F4 command-prompt -I "#W" "rename-window -- '%%'"
bind -n F5 source-file ~/.tmux.conf \; display-message "Config ~/.tmux.conf reloaded."

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