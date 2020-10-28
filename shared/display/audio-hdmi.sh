output_input=$(pactl list | grep hdmi | grep "Digital Stereo (HDMI 2) Output + Analog Stereo Input" | sed "s/\(.*\):\ Digital.*/\1/" | xargs) 
pactl set-card-profile 0 $output_input
# Disable any other plugged in devices
pactl set-card-profile 1 off