

##
# Discover conda base dir and shell name 
if [[ "$OSTYPE" == "darwin"* ]]; then
    export CONDA_PATH=$(find -E $HOME -maxdepth 1 -type d -regex '[^.]*(miniforge|conda).*' 2>/dev/null | head -n 1)
else #if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Assume linux if not macos
    export CONDA_PATH=$(find $HOME -maxdepth 1 -type d -regex '[^.]*\(miniforge\|conda\).*' 2>/dev/null | head -n 1)
fi

__shellname=$(basename $0)

##
# Contents below are based on the output of 'mamba init' 

__conda_setup="$("$CONDA_PATH/bin/conda" "shell.$__shellname" 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
        . "$CONDA_PATH/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_PATH/bin:$PATH"
    fi
fi
unset __conda_setup
unset __shellname

if [ -f "$CONDA_PATH/etc/profile.d/mamba.sh" ]; then
    . "$CONDA_PATH/etc/profile.d/mamba.sh"
fi
