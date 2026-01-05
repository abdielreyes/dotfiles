
export ZSH="/Users/abdiel/.oh-my-zsh"

ZSH_THEME="alanpeabody"

plugins=(
    git
    sudo
    vi-mode
)

source $ZSH/oh-my-zsh.sh

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias vim="nvim"
alias vi="nvim"
alias ls="ls -alhSG"

#export PATH="$PATH:/home/abdiel/scripts"
#PATH="$HOME/.local/bin:$PATH"


eval "$(~/.local/bin/mise activate zsh)"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# bun completions
[ -s "/Users/abdiel/.bun/_bun" ] && source "/Users/abdiel/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

