# i3 configuration file
set $mod Mod4
font pango:DejaVu Sans Bold 10
floating_modifier $mod
focus_follows_mouse no
focus_wrapping no

## Shortcuts and scripts
bindsym $mod+Escape             kill
bindsym $mod+Shift+Escape       exec systemctl poweroff
bindsym $mod+Shift+r            restart
bindsym $mod+Shift+x            exec "i3-nagbar -t warning -m 'Do you really want to exit i3?' -b 'Yes, exit i3' 'i3-msg exit'"

bindsym $mod+Return             exec i3-sensible-terminal
bindsym $mod+space              exec rofi -show drun -padding 20 -yoffset -100
bindsym F1                      exec $HOME/dotshared/bash/google-search.sh

bindsym $mod+l                  exec betterlockscreen -l
bindsym $mod+t                  exec $HOME/dotshared/bash/translate.sh
bindsym $mod+x                  exec $HOME/dotshared/bash/kill-proc.sh
bindsym $mod+Ctrl+F5            exec pavucontrol
bindsym $mod+Ctrl+F6            exec arandr

bindsym $mod+Left               focus left
bindsym $mod+Down               focus down
bindsym $mod+Up                 focus up
bindsym $mod+Right              focus right
bindsym $mod+Shift+Left         move left
bindsym $mod+Shift+Down         move down
bindsym $mod+Shift+Up           move up
bindsym $mod+Shift+Right        move right
bindsym $mod+Tab                move workspace to output left

bindsym $mod+Shift+f            fullscreen toggle
bindsym $mod+Shift+q            layout stacking
bindsym $mod+Shift+w            layout tabbed
bindsym $mod+Shift+e            layout toggle split
bindsym $mod+Shift+t            floating toggle
bindsym $mod+Ctrl+Left          resize shrink width 20 px
bindsym $mod+Ctrl+Right         resize grow width 20 px
bindsym $mod+Ctrl+Down          resize grow height 20 px
bindsym $mod+Ctrl+Up            resize shrink height 20 px

bindsym XF86AudioMute           exec pactl set-sink-mute 0 toggle
bindsym XF86AudioLowerVolume    exec pactl set-sink-volume 0 -10%
bindsym XF86AudioRaiseVolume    exec pactl set-sink-volume 0 +10%

# Startup
exec_always --no-startup-id $HOME/dotshared/bash/polybar_launch.sh
exec /usr/bin/urxvt -title urxvt_
exec /usr/bin/thunderbird
exec /usr/bin/slack
exec /usr/bin/dunst
exec /usr/bin/nm-applet
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# Workspaces
set $workspace0 "0:"
set $workspace1 "1:"
set $workspace2 "2:"
set $workspace3 "3:"
set $workspace4 "4:"
set $workspace5 "5:"
set $workspace6 "6:"
set $workspace7 "7:"
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
assign [title="urxvt_"]                     $workspace0
assign [class="Brave-browser"]              $workspace1
assign [class="Google-chrome"]              $workspace1
assign [class="jetbrains-idea-ce"]          $workspace2
assign [class="jetbrains-pycharm-ce"]       $workspace2
assign [class="Subl"]                       $workspace3
assign [class="Sublime_merge"]              $workspace3
assign [class="Evince"]                     $workspace4
assign [class="Soffice"]                    $workspace4
assign [class="(?i)libreoffice.*"]          $workspace4
assign [class="jetbrains-datagrip"]         $workspace4
assign [class="TeXstudio"]                  $workspace4
assign [class="Pinta"]                      $workspace5
assign [class="Sxiv"]                       $workspace5
assign [class="vlc"]                        $workspace5
assign [class="Slack"]                      $workspace9
assign [class="Sublime_merge"]              $workspace10
assign [class="Thunderbird"]                $workspace11

for_window [class="urxvt_"] focus
for_window [class="Subl"] focus
for_window [class="Sublime_merged"] focus
for_window [class="Evince"] focus
for_window [class="Soffice"] focus
for_window [class="(?i)libreoffice.*"] focus
for_window [class="Sxiv"] focus
for_window [class="Pinta"] focus
for_window [class="vlc"] focus
for_window [class="TeXstudio"] focus
for_window [title="Authy"] focus
for_window [title="Authy"] floating enable

# Intellij and PyCharm settings for popup refresh
for_window [class="^jetbrains-.+"] focus

for_window [workspace=$workspace3] layout split
for_window [workspace=$workspace4] layout stacked
for_window [workspace=$workspace5] layout stacked

# class                 border  backgr. text    indicator child_border
client.focused          #1e2128 #1e2128 #00ffff #2F343F   #2F343F
client.focused_inactive #333333 #5f676a #00ffff #2F343F   #2F343F
client.unfocused        #333333 #222222 #888888 #292d2e   #2F343F
client.urgent           #2f343a #900000 #00ffff #900000   #900000
client.placeholder      #000000 #0c0c0c #00ffff #000000   #2F343F

client.background       #00ffff