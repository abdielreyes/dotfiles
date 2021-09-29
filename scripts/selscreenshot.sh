#! /bin/bash 
scrot '/tmp/%F_%T_$wx$h.png' -s 'xclip -selection clipboard -target image/png -i $f'
