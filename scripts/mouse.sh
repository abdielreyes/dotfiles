touchpad_id=$(xinput -list | sed '/Touchpad/s/.*id=\([0-9]*\).*/\1/;t;d')
echo $touchpad_id
xinput set-prop $touchpad_id 'libinput Tapping Enabled' 1
xinput set-prop $touchpad_id 'libinput Natural Scrolling Enabled' 1

