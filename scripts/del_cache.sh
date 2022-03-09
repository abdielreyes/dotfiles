#! /bin/bash
du -sh /var/cache/pacman/pkg/
du -sh ~/.cache/yay
sudo pacman -Scc
yay -Scc
sudo pacman -Rns $(pacman -Qdtq)
du -sh ~/.cache
