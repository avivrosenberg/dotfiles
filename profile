# Variables for git bash
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=auto

function crc32 { cksum -o3 "$@"|ruby -e 'STDIN.each{|a|a=a.split;printf "%08X\t%s\n",a[0],a[2..-1].join(" ")}'; }

export ANDROIDSDK=/Applications/Android\ Studio.app/sdk

PATH=$PATH:$ANDROIDSDK/tools:$ANDROIDSDK/platform-tools
export PATH

### EXPORTS FOR HOMEBREW PACKAGES ###
# export for python2.7 (used my meld)
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
#export for gtk2 from homewbrew
export GTK_PATH=/usr/local/lib/gtk-2.0
# exports for meld via MacPorts
export LC_ALL='en_US'

