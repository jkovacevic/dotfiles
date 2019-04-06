# i3 configuration file
set $mod Mod4
font pango:DejaVu Sans 12
floating_modifier $mod
focus_follows_mouse no

bindsym $mod+Return exec i3-sensible-terminal
bindsym $mod+Escape kill
bindsym $mod+space exec rofi -show drun -padding 16

bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

bindsym $mod+h split h
bindsym $mod+v split v
bindsym $mod+f fullscreen toggle
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

bindsym $mod+Shift+c reload
bindsym $mod+Shift+r restart
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# Startup
exec /usr/bin/urxvt
exec /usr/bin/google-chrome-stable
exec /usr/bin/subl
exec /usr/bin/thunderbird
exec /usr/bin/slack
exec /usr/bin/startup
exec /usr/bin/dunst
exec /usr/bin/nm-applet
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# Shortcuts
bindsym $mod+Tab move workspace to output left
bindsym $mod+l exec betterlockscreen -l
bindsym $mod+t exec $HOME/dotfiles/bash/translate.sh
bindsym $mod+c exec $HOME/dotfiles/bash/buffer-compare.sh
bindsym $mod+F1 exec $HOME/dotfiles/bash/buffer.sh 1
bindsym $mod+F2 exec $HOME/dotfiles/bash/buffer.sh 2
bindsym $mod+F12 exec kill $(pgrep -f "ffmpeg -f x11grab")
bindsym $mod+Control+p exec pavucontrol

# Workspaces
set $workspace0 "0:"
set $workspace1 "1:"
set $workspace2 "2:"
set $workspace3 "3:"
set $workspace4 "4:"
set $workspace5 "5:"
set $workspace6 "6:"
set $workspace7 "7:"
set $workspace8 "8:"
set $workspace9 "9:"
set $workspace10 "10:"
set $workspace11 "11:"
set $workspace12 "12:"
set $workspace13 "13:"

# Switch to workspace
bindsym $mod+grave      workspace $workspace0
bindsym $mod+1          workspace $workspace1
bindsym $mod+2          workspace $workspace2
bindsym $mod+3          workspace $workspace3
bindsym $mod+4          workspace $workspace4
bindsym $mod+5          workspace $workspace5
bindsym $mod+6          workspace $workspace6
bindsym $mod+7          workspace $workspace7
bindsym $mod+8          workspace $workspace8
bindsym $mod+9          workspace $workspace9
bindsym $mod+0          workspace $workspace10
bindsym $mod+m          workspace $workspace11
bindsym $mod+minus      workspace $workspace12
bindsym $mod+equal      workspace $workspace13

# Move focused container to workspace
bindsym $mod+Shift+grave        move container to workspace $workspace0
bindsym $mod+Shift+1            move container to workspace $workspace1
bindsym $mod+Shift+2            move container to workspace $workspace2
bindsym $mod+Shift+3            move container to workspace $workspace3
bindsym $mod+Shift+4            move container to workspace $workspace4
bindsym $mod+Shift+5            move container to workspace $workspace5
bindsym $mod+Shift+6            move container to workspace $workspace6
bindsym $mod+Shift+7            move container to workspace $workspace7
bindsym $mod+Shift+8            move container to workspace $workspace8
bindsym $mod+Shift+9            move container to workspace $workspace9
bindsym $mod+Shift+0            move container to workspace $workspace10
bindsym $mod+Shift+m            move container to workspace $workspace11
bindsym $mod+Shift+minus        move container to workspace $workspace12
bindsym $mod+Shift+equal        move container to workspace $workspace13

# Xprop assignation
assign [class="Google-chrome"]          $workspace1
assign [class="jetbrains-pycharm-ce"]   $workspace2
assign [class="jetbrains-idea-ce"]      $workspace2
assign [class="Subl"]                   $workspace3
assign [class="Sublime_merge"]          $workspace3
assign [class="jetbrains-datagrip"]     $workspace4
assign [class="Soffice"]                $workspace4
assign [class="Sxiv"]                  	$workspace5
assign [class="vlc"]                  	$workspace5
assign [class="Pinta"]                  $workspace5
assign [class="TeXstudio"]              $workspace6
assign [class="Evince"]                 $workspace7
assign [class="Slack"]                  $workspace9
assign [class="Thunderbird"]            $workspace12

for_window [workspace=$workspace3] layout stacked
for_window [workspace=$workspace5] layout stacked
for_window [workspace=$workspace7] layout stacked

for_window [class="Subl"] focus
for_window [class="Sublime_merged"] focus
for_window [class="Evince"] focus
for_window [class="Sxiv"] focus
for_window [class="Pinta"] focus
for_window [class="vlc"] focus
for_window [class="TeXstudio"] focus
for_window [class="Soffice"] focus
for_window [class="jetbrains-idea-ce"] focus
for_window [class="jetbrains-pycharm-ce"] focus
for_window [class="jetbrains-datagrip"] focus

bindsym $mod+Control+Right resize shrink width 5 px
bindsym $mod+Control+Left resize grow width 5 px
bindsym $mod+Control+Up resize grow height 5 px
bindsym $mod+Control+Down resize shrink height 5 px

bar {	
		tray_output eDP-1
		status_command i3status
        font pango: FontAwesome 14
        strip_workspace_numbers yes
        separator_symbol "|"
}