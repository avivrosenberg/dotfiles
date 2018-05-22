# OSX Specific
if [[ "$OSTYPE" == darwin* ]] ; then

  # These functions rely on the 'iterm2' zsh plugin
  if [[ "$plugins" =~ "iterm2" ]]; then

    function bg_dark() {
      iterm2_profile "Solarized Dark"
      update_tmux_colors
    }

    function bg_light() {
      iterm2_profile "Solarized Light"
      update_tmux_colors
    }

    function update_tmux_colors() {
      if [[ -n $TMUX ]]; then
        local tmux_file=''

        if [[ "$ITERM_PROFILE" =~ "[Ll]ight" ]]; then
          tmux_file="$DOTFILES/tmux/airline-colors-light.conf"
        else
          tmux_file="$DOTFILES/tmux/airline-colors-dark.conf"
        fi

        tmux source-file "$tmux_file" > /dev/null
      fi
    }

  fi
fi

###
# Echos the full (absolute) path of a given input file
function fullpath() {
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}

# Appends/prepends to PATH, removing duplicates
function pathmunge () {
  if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
    if [ "$2" = "after" ] ; then
      PATH=$PATH:$1
    else
      PATH=$1:$PATH
    fi
  fi
}
