#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
if [[ $(xrandr -q | grep -w 'HDMI1 connected') ]]; then
    echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
    polybar 2ndbar  >>/tmp/polybar1.log 2>&1 &
    polybar main >>/tmp/polybar2.log &
else
    echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
    polybar main  >>/tmp/polybar1.log 2>&1 &
fi

echo "Bars launched..."
