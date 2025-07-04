#!/usr/bin/env python3

import os
from pathlib import Path

# Get the directory containing this script
DOTFILESDIR = Path(os.path.dirname(os.path.abspath(__file__)))
DESTDIR = Path(os.path.expanduser("~"))

# ANSI color codes
GREEN = "\033[0;32m"
BLUE = "\033[0;34m"
YELLOW = "\033[0;33m"
RED = "\033[0;31m"
RESTORE = "\033[0m"

# Old extension to remove
SYMLINK_EXT = ".symlink"

# List of files and directories which will be symlinked as dotfiles in the home folder
# Some of these still have the old symlink extension, which is not easy to remove due to
# nested submodules
SRC_FILES = [
    "bash/bash_profile",
    "bash/bashrc",
    "bash/profile",
    "bin",
    "conda/condarc",
    "git/gitconfig",
    "git/gitk",
    "intellij/ideavimrc",
    "ipython",
    "pandoc.symlink",
    "ripgrep/ripgreprc",
    "tmux/tmux.conf",
    "tmuxinator",
    "vim.symlink",
    "vim.symlink/vimrc",
    "vim.symlink/gvimrc",
    "zsh/zshrc",
    "zsh/zshenv",
    "Brewfile",
]


def make_symlinks(dry_run: bool = True):
    print(f"{GREEN}DOTFILESDIR: {DOTFILESDIR}{RESTORE}")
    print(f"{GREEN}DESTDIR: {DESTDIR}{RESTORE}")

    for src_name in SRC_FILES:
        # Get the full path to the source file
        src_filepath = DOTFILESDIR / src_name

        # Make sure it exists
        if not src_filepath.exists():
            print(f"{RED}ERROR: source file {src_filepath!s} does not exist{RESTORE}")
            exit(1)

        # Take the file name and prepend the DESTDIR with a dot
        dst_filepath = DESTDIR / f".{src_filepath.name}"

        # Remove old symlink extension if it exists
        if dst_filepath.suffix == SYMLINK_EXT:
            dst_filepath = dst_filepath.with_suffix("")

        # Remove target if it exists
        if dst_filepath.is_symlink():
            if not dry_run:
                print(f"{YELLOW}Removing existing symlink {dst_filepath!s}{RESTORE}")
                dst_filepath.unlink()
            else:
                print(
                    f"{YELLOW}Would remove existing symlink {dst_filepath!s}{RESTORE}"
                )

        elif dst_filepath.exists():
            print(
                f"{RED}ERROR: target file {dst_filepath!s} exists but is not a symlink!{RESTORE}"
            )
            exit(1)

        # Create symlink
        src_tgt_str = (
            f"{BLUE}{src_filepath!s}{RESTORE} --> {GREEN}{dst_filepath!s}{RESTORE}"
        )
        if not dry_run:
            # Create the symlink (override previous ones)
            print(f"{GREEN}Linking:{RESTORE} {src_tgt_str}")
            dst_filepath.symlink_to(src_filepath)
        else:
            print(f"{YELLOW}Would link:{RESTORE} {src_tgt_str}")


if __name__ == "__main__":
    # Run the main function if this script is executed directly
    make_symlinks(dry_run=False)
