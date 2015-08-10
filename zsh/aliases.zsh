####
## Aliases

# shell aliases
alias l='ls -hFG'
alias ll='ls -lhFG'
alias la='ls -lhaFG'

# common typos
alias gti='git'
alias vmi='vim'
alias mvmi='mvim'

# postgres
alias pgstart='pg_ctl -l $PGDATA/server.log start'
alias pgstop='pg_ctl stop -s -m fast'

# tmux
alias tmux='tmux -u2'

# zmv
alias mmv='noglob zmv -W'
