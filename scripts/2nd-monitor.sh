#!/bin/sh
xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --mode 1440x900 --pos 1920x47 --rotate normal --output HDMI1 --off --output HDMI2 --off --output VIRTUAL1 --off
bspc wm -r