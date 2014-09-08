####
## Environment
export EDITOR='vim'
export DOTFILES='~/.dotfiles'

if [[ "$OSTYPE" == "darwin"* ]]; then
    ####
    ## Android development
    export ANDROIDSDK=/Applications/Android\ Studio.app/sdk
    PATH=$PATH:$ANDROIDSDK/tools
    PATH=$PATH:$ANDROIDSDK/platform-tools

    ####
    ## Postgres
    export PGDATA=/usr/local/var/postgres

    ####
    ## Homebrew
    PATH=$(brew --prefix)/bin:$PATH #prepend so that brew binaries are found first
    PATH=$PATH:~/.dotfiles/brew/extensions
else
    # Other OSes...
fi

export PATH
