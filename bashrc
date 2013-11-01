#!/bin/sh

####
## Prompt
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
PS1='\u@\h: \W$(__git_ps1 "(%s)")$ '

####
## Aliases
# bash aliases
alias l='ls -FG'
alias ll='ls -lFG'
alias la='ls -laFG'
#common typos
alias gti='git'
alias mvmi='mvim'
alias pgstart='pg_ctl -l $PGDATA/server.log start'
alias pgstop='pg_ctl stop -s -m fast'

####
## RVM
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

####
## Completions
source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
source $(brew --prefix)/Library/Contributions/brew_bash_completion.sh
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
