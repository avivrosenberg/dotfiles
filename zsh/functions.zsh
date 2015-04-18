if [[ "$OSTYPE" = darwin* ]] ; then

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
