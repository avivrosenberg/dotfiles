####
## Aliases

# ls
alias l='ls -hFG'
alias ll='ls -lhFG'
alias la='ls -lhaFG'

# vim
alias v='vim'
alias vmi='vim'

# git
alias g='git'
alias gti='git'

# postgres
alias pgstart='pg_ctl -l $PGDATA/server.log start'
alias pgstop='pg_ctl stop -s -m fast'

# tmux
alias tmux='tmux -u2'

# zmv
alias mmv='noglob zmv -W'

# gradle
alias gw='./gradlew --daemon'
alias gwo='./gradlew --daemon --offline'

# docker
alias d='docker'
alias dc='docker-compose'
