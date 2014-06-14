####
## Aliases

# shell aliases
alias l='ls -FG'
alias ll='ls -lFG'
alias la='ls -laFG'

# common typos
alias gti='git'
alias vmi='vim'
alias mvmi='mvim'

# postgres
alias pgstart='pg_ctl -l $PGDATA/server.log start'
alias pgstop='pg_ctl stop -s -m fast'
