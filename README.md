# My dotfiles

this directory contains the dotfiles for my system

## Requirements

Ensure you have the following packages installed

- git
    - lazygit
- stow
- nvim ^0.8.0
    - npm
    - pip3
- tmux 
- tpm
- zsh
- oh-my-zsh
    - powerlevel10k theme
    - zsh-autosuggestions
    - zsh-syntax-highlighting

Also, dont forget:
- a nerd font

## Installation
first, check out the repo into $home directory using git
```bash
git clone git@github.com:abdielreyes/dotfiles.git
cd dotfiles/
```
run GNU stow to create symlinks
```bash
stow . 
```
