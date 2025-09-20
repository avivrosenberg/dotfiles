

##
# Discover conda base dir and shell name
if [[ "$OSTYPE" == "darwin"* ]]; then
    export CONDA_BASE_PATH=$(find -E $HOME -maxdepth 1 -type d -regex '[^.]*(miniforge|conda).*' 2>/dev/null | head -n 1)
else #if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Assume linux if not macos
    export CONDA_BASE_PATH=$(find $HOME -maxdepth 1 -type d -regex '[^.]*\(miniforge\|conda\).*' 2>/dev/null | head -n 1)
fi

##
# Contents below are based on the output of 'mamba init'

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE="$CONDA_BASE_PATH/bin/mamba";
export MAMBA_ROOT_PREFIX="$CONDA_BASE_PATH";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$CONDA_BASE_PATH/bin/conda " 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$CONDA_BASE_PATH/etc/profile.d/conda.sh" ]; then
        . "$CONDA_BASE_PATH/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_BASE_PATH/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
