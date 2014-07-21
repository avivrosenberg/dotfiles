# require the Homebrew commands needed
require 'cmd/update'
require 'cmd/outdated'

###
# Just a helper to colorize output don't want to depend on external gem
def colorize(str)
  console_white="\e[0;37m"
  console_reset="\e[0m"
  "#{console_white}#{str}#{console_reset}"
end

###
# Main function
def brew_updated
  # Update homebrew
  puts colorize "Updating homebrew..."
  Homebrew.update

  # Call homebrew internal function to get number of outdated brews
  num_outdated = Homebrew.outdated_brews.length

  # Print outdated brews
  if num_outdated > 0
    puts colorize "Outdated brews:"
    Homebrew.outdated 
  end
end

# do it...
brew_updated
