#!/usr/bin/env python3

import os
from dataclasses import dataclass
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


@dataclass
class Symlink:
    src_name: str | Path
    dst_dir: str | Path = DESTDIR
    prepend_dot: bool = True


# List of files and directories which will be symlinked as dotfiles in the home folder.
SRC_FILES = [
    Symlink("bash/bash_profile"),
    Symlink("bash/bashrc"),
    Symlink("bash/profile"),
    Symlink("bin"),
    Symlink("conda/condarc"),
    Symlink("git/gitconfig"),
    Symlink("git/gitk"),
    Symlink("intellij/ideavimrc"),
    Symlink("ipython"),
    Symlink("pandoc"),
    Symlink("ripgrep/ripgreprc"),
    Symlink("tmux/tmux.conf"),
    Symlink("tmuxinator"),
    Symlink("vim"),
    Symlink("vim/vimrc"),
    Symlink("vim/gvimrc"),
    Symlink("zsh/zshrc"),
    Symlink("zsh/zshenv"),
    Symlink("Brewfile"),
    Symlink("zed", DESTDIR / ".config", prepend_dot=False),
    Symlink("nvim", DESTDIR / ".config", prepend_dot=False),
    Symlink("ghostty", DESTDIR / ".config", prepend_dot=False),
]


def make_symlinks(dry_run: bool = True):
    print(f"{GREEN}DOTFILESDIR: {DOTFILESDIR}{RESTORE}")
    print(f"{GREEN}DESTDIR: {DESTDIR}{RESTORE}\n")

    for sym_spec in SRC_FILES:
        # Get the full path to the source file
        src_filepath = DOTFILESDIR / sym_spec.src_name

        # Make sure it exists
        if not src_filepath.exists():
            print(f"{RED}ERROR: source file {src_filepath!s} does not exist{RESTORE}")
            exit(1)

        # Take the file name and prepend the DESTDIR with a dot
        dst_filename = src_filepath.name
        if sym_spec.prepend_dot:
            dst_filename = f".{dst_filename}"

        dst_filepath = Path(sym_spec.dst_dir) / dst_filename

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
            dst_filepath.parent.mkdir(parents=True, exist_ok=True)
            dst_filepath.symlink_to(src_filepath)
        else:
            print(f"{YELLOW}Would link:{RESTORE} {src_tgt_str}")

    print(f"\n{GREEN}Done, {len(SRC_FILES)} links created.{RESTORE}")


if __name__ == "__main__":
    # Run the main function if this script is executed directly
    make_symlinks(dry_run=False)
