# Audio devices
_JABRA_CARD="alsa_card.usb-0b0e_Jabra_SPEAK_510_USB_70BF923FE2F2021900-00"
_JABRA_SINK="alsa_output.usb-0b0e_Jabra_SPEAK_510_USB_70BF923FE2F2021900-00.analog-stereo"
_JABRA_SOURCE="alsa_input.usb-0b0e_Jabra_SPEAK_510_USB_70BF923FE2F2021900-00.mono-fallback"

_BUILTIN_CARD="alsa_card.pci-0000_00_1f.3"
_BUILTIN_SINK="alsa_output.pci-0000_00_1f.3.analog-stereo"
_BUILTIN_SOURCE="alsa_input.pci-0000_00_1f.3.analog-stereo"


sound-jabra-on() {
    echo "Switching audio to Jabra..."

    # Turn off built-in audio
    pactl set-card-profile "$_BUILTIN_CARD" off

    # Enable Jabra playback + microphone
    pactl set-card-profile "$_JABRA_CARD" \
        output:analog-stereo+input:mono-fallback

    # Make Jabra the defaults
    pactl set-default-sink "$_JABRA_SINK"
    pactl set-default-source "$_JABRA_SOURCE"

    # Move existing playback streams to Jabra
    while read -r stream; do
        pactl move-sink-input "$stream" "$_JABRA_SINK"
    done < <(pactl list sink-inputs short | awk '{print $1}')

    echo "Jabra is now active."
}


sound-headphones-on() {
    echo "Switching audio to headphones..."

    # Turn off Jabra
    pactl set-card-profile "$_JABRA_CARD" off

    # Enable built-in audio + microphone
    pactl set-card-profile "$_BUILTIN_CARD" \
        output:analog-stereo+input:analog-stereo

    # Make built-in audio the defaults
    pactl set-default-sink "$_BUILTIN_SINK"
    pactl set-default-source "$_BUILTIN_SOURCE"

    # Move existing playback streams to headphones
    while read -r stream; do
        pactl move-sink-input "$stream" "$_BUILTIN_SINK"
    done < <(pactl list sink-inputs short | awk '{print $1}')

    echo "Headphones are now active."
}