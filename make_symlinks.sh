#!/usr/bin/env bash

DOTFILESDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DESTDIR="$HOME"

EXT=".symlink"
FILES=($(find $DOTFILESDIR -regex "$DOTFILESDIR/.*$EXT" -not -regex ".*\.git.*"))

source "$DOTFILESDIR/bin$EXT/colorcodes.sh"

echo -e "${GREEN}DOTFILESDIR: $DOTFILESDIR${RESTORE}"
echo -e "${GREEN}DESTDIR: $DESTDIR${RESTORE}"

for filepath in "${FILES[@]}"; do

    # Take only the file name, remove EXT and prepend the DESTDIR
    filename=$(basename $filepath)
    target_filename="$DESTDIR/.${filename%${EXT}}"

    # Create the symlink (override previous ones)
    echo -e "${BLUE}$filepath${RESTORE} --> ${GREEN}$target_filename${RESTORE}"
    $(
    set -x;
    ln -snFf $filepath $target_filename
    )
done

