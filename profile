PATH=/opt/local/bin:/opt/local/sbin:$PATH
PATH=$PATH:~/dev/eclipse/android-sdk-macosx/tools:~/dev/eclipse/android-sdk-macosx/platform-tools
export PATH

# export for python2.7 (used my meld)
export PYTHONPATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/

# exports for meld via MacPorts
export LC_ALL='en_US'

# Variables for git bash
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=auto

function crc32 { cksum -o3 "$@"|ruby -e 'STDIN.each{|a|a=a.split;printf "%08X\t%s\n",a[0],a[2..-1].join(" ")}'; }

