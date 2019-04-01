# i3 configuration file
set $mod Mod4

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:DejaVu Sans 10

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec i3-sensible-terminal

# kill focused window
bindsym $mod+Escape kill

# start dmenu (a program launcher)
bindsym $mod+space exec rofi -show drun -padding 16

bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+h split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
# bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

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
set $workspace11 "11:"
set $workspace12 "12:"
set $workspace13 "13:"
set $workspace14 "14:"

# switch to workspace
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
bindsym $mod+n          workspace $workspace11
bindsym $mod+m          workspace $workspace12
bindsym $mod+minus      workspace $workspace13
bindsym $mod+equal      workspace $workspace14

# move focused container to workspace
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
bindsym $mod+Shift+n            move container to workspace $workspace11
bindsym $mod+Shift+m            move container to workspace $workspace12
bindsym $mod+Shift+minus        move container to workspace $workspace13
bindsym $mod+Shift+equal        move container to workspace $workspace14

# In command line use xprop command
assign [class="jetbrains-pycharm-ce"]   	$workspace2
assign [class="jetbrains-idea-ce"]      	$workspace2
assign [class="Subl"]                   	$workspace3
assign [class="Sublime_merge"]          	$workspace3
assign [class="jetbrains-datagrip"]     	$workspace4
assign [class="Dragondisk"]     			$workspace4
assign [class="Pinta"]                  	$workspace5
assign [class="Sxiv"]                  		$workspace5
assign [class="vlc"]                  		$workspace5
assign [class="Soffice"] 					$workspace6
assign [class="libreoffice-startcenter"] 	$workspace6
assign [class="libreoffice-calc"] 			$workspace6
assign [class="TeXstudio"]              	$workspace6
assign [class="Evince"]                 	$workspace6
assign [class="Slack"]                  	$workspace9
assign [class="Sublime_merge"]          	$workspace10
assign [class="Thunderbird"]            	$workspace12

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
for_window [class="libreoffice-startcenter"] focus
for_window [class="libreoffice-calc"] focus
for_window [class="Dragondisk"] focus
for_window [class="jetbrains-idea-ce"] focus
for_window [class="jetbrains-pycharm-ce"] focus
for_window [class="jetbrains-datagrip"] focus

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

bindsym $mod+Control+Right resize shrink width 5 px
bindsym $mod+Control+Left resize grow width 5 px
bindsym $mod+Control+Up resize grow height 5 px
bindsym $mod+Control+Down resize shrink height 5 px

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
        status_command i3status
        font pango:DejaVu Sans 10, FontAwesome 12
        strip_workspace_numbers yes
        separator_symbol "|"
}

focus_follows_mouse no

exec $HOME/startup.sh
exec /usr/bin/google-chrome-stable
exec /usr/bin/subl
exec /usr/bin/nm-applet
exec /usr/bin/thunderbird
exec /usr/bin/slack

exec /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 

# Shortcuts
bindsym $mod+Tab move workspace to output left
bindsym $mod+Control+p exec pavucontrol
bindsym $mod+l exec i3lock --color "#000001"
bindsym $mod+F1 exec $HOME/dotfiles/bash/buffer.sh 1
bindsym $mod+F2 exec $HOME/dotfiles/bash/buffer.sh 2
bindsym $mod+c exec $HOME/dotfiles/bash/buffer-compare.sh
bindsym $mod+t exec $HOME/dotfiles/bash/translate.sh

# Video recording
bindsym $mod+F12 exec kill $(pgrep -f "ffmpeg -f x11grab")