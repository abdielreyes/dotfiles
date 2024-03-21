if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/abdiel/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    sudo
	vi-mode
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#tilix  configuration
# if [[ $TILIX_ID ]]; then
#         source /etc/profile.d/vte.sh
# fi
# function custom_prompt() {
#   __git_ps1 "\[\033[0;31m\]\u \[\033[0;36m\]\h:\w\[\033[00m\]" " \n\[\033[0;31m\]>\[\033[00m\] " " %s"
#   VTE_PWD_THING="\[$(__vte_osc7)\]"
#   PS1="$PS1$VTE_PWD_THING"
# }
# PROMPT_COMMAND=custom_prompt


alias vim="nvim"
alias vi="nvim"

#export PATH="$PATH:/home/abdiel/scripts"
#PATH="$HOME/.local/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
