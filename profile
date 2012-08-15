PATH=$PATH:~/bin
export PATH

# Variables for git bash
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=auto

function crc32 { cksum -o3 "$@"|ruby -e 'STDIN.each{|a|a=a.split;printf "%08X\t%s\n",a[0],a[2..-1].join(" ")}'; }

