#!/usr/bin/bash
function between_strings {
	echo "$(sed -e "s/.*$2\(.*\)$3.*/\1/" <<< $1 | xargs)"
}

function disable_touchpad {
	in=$(xinput list | grep Synaptics)
	id=$(between_strings "$in" "id=" "\[")
	xinput --disable $id
}

function switch_home_end {
	xmodmap -e "keycode 112 = Home"
	xmodmap -e "keycode 117 = End"
	xmodmap -e "keycode 110 = Prior"
	xmodmap -e "keycode 115 = Next"
}

function revert_home_end {
	xmodmap -e "keycode 112 = Prior"
	xmodmap -e "keycode 117 = Next"
	xmodmap -e "keycode 110 = Home"
	xmodmap -e "keycode 115 = End"
}

function disable_capslock {
	xmodmap -e 'clear Lock'
	xmodmap -e "keycode 66 = F13"
}

function accelarate_touchpad {
	in=$(xinput list | grep TrackPoint)
	id=$(between_strings "$in" "id=" "\[")
	xinput --set-prop $id "libinput Accel Speed" 0.9
}

disable_capslock
case "$1" in
	-l)
		disable_touchpad
		accelarate_touchpad
		switch_home_end
		;;
	-k)	echo
		;;
esac

xset s off && xset -dpms