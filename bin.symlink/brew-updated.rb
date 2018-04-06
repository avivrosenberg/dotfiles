# require the Homebrew commands needed
require 'cmd/update'
require 'cmd/outdated'

###
# Just a helper to print bold output
def bold(str)
  console_bold="\e[1m"
  console_reset="\e[0m"
  "#{console_bold}#{str}#{console_reset}"
end

###
# Main function
def brew_updated
  # Update homebrew
  puts bold "==> Updating homebrew"
  Homebrew.update

  # Call homebrew internal function to get number of outdated brews
  num_outdated = Homebrew.outdated_brews(Formula.installed).length

  # Print outdated brews
  if num_outdated > 0
    puts bold "==> Outdated brews"
    Homebrew.outdated 
  end
end

# do it...
brew_updated
