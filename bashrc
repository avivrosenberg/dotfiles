#!/bin/sh

# set default editor
export EDITOR='vim -p'

# set prompt
source ~/.git-completion.bash
source ~/.git-prompt.sh
PS1='\u@\h: \W$(__git_ps1 "(%s)")$ '

# add bash aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
