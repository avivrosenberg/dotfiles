####
## Aliases

# General
alias w=which

# ls
if [[ -x "$(which lsd)" ]]; then
    LS="$(which lsd)"
else
    LS='ls'
fi
alias l="$LS -hFG"
alias ll="$LS -lhFG"
alias la="$LS -lhaFG"

# vim
alias v='nvim'
alias vmi='nvim'
alias nv='nvim'

# git
alias g='git'
alias gti='git'

# python
alias py='python3'
alias ipy='ipython'
alias pyt='pytest'
alias wpy='which python'

# tmux
alias tmux='tmux -u2'

# zmv
alias mmv='noglob zmv -W'

# docker
alias d='docker'
alias dc='docker compose'

# conda/mamba
alias m='mamba'
alias ma='mamba activate'
alias md='mamba deactivate'
alias mr='mamba run -a ""'
alias m64='CONDA_SUBDIR=osx-64 mamba'

# bat
alias cat='bat'

# time: don't use zsh builtin
if [[ -x '/usr/bin/time' ]]; then
  alias time='/usr/bin/time'
fi
