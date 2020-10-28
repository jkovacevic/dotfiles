# Activate Laptop audio input/output
pactl set-card-profile 0 output:analog-stereo+input:analog-stereo
# Disable any other plugged in devices
pactl set-card-profile 1 off