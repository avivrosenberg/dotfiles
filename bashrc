#!/bin/sh

####
## Prompt
source /usr/share/git-core/git-prompt.sh
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
## Shell functions
function crc32 { cksum -o3 "$@"|ruby -e 'STDIN.each{|a|a=a.split;printf "%08X\t%s\n",a[0],a[2..-1].join(" ")}'; }

####
## RVM
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

####
## Completions
source /usr/share/git-core/git-completion.bash
source /usr/local/Library/Contributions/brew_bash_completion.sh
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
