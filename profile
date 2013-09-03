
####
## Git prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=auto

####
## Android development
ANDROIDSDK=/Applications/Android\ Studio.app/sdk
PATH=$PATH:$ANDROIDSDK/tools
PATH=$PATH:$ANDROIDSDK/platform-tools
export ANDROIDSDK

####
## Homebrew
PATH=/usr/local/bin:$PATH #prepend so that brew binaries are found first
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export GTK_PATH=/usr/local/lib/gtk-2.0
export LC_ALL='en_US'

####
## Environment
export EDITOR='mvim -p'
export PATH
