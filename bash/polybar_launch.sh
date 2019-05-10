killall polybar;
if xrandr | grep "DP-2-1 connected"; then
	(/usr/local/bin/polybar bottom-monitor) &
else
	(/usr/local/bin/polybar bottom-laptop) &
fi