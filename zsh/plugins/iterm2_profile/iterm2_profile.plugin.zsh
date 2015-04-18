#####################################################
# iTerm2 Profile changer plugin for oh-my-zsh       #
# Version: 1.0                                      #
# Author: Aviv Rosenberg (github.com/avivrosenberg) #
#####################################################

###
# Call this function and pass in a name of an iTerm2 profile
# (name can contain spaces).
function iterm2_profile() {
  # Desired name of profile
  local profile="$1"

  # iTerm2 escape code for changing profile
  local iterm2_code="\x1b]50;SetProfile=$profile\x7"

  # If we're in tmux, a special ecape code must be prepended
  # so that the iTerm2 escape code is passed on into iTerm2.
  local prefix=''
  local suffix=''
  if [[ -n $TMUX ]]; then
    prefix='\033Ptmux;\033'
    suffix='\033\\'
  fi

  # send the sequence
  echo -n "$prefix""$iterm2_code""$suffix"

  # update shell variable
  ITERM_PROFILE="$profile"
}


