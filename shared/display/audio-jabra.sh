# Deactivate Laptop / HDMI audio input/output
pactl set-card-profile 0 off
# Activate Jabra audio input/output
pactl set-card-profile 2 output:analog-stereo+input:mono-fallback