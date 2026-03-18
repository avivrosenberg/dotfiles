#!/usr/bin/env python3

import argparse
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
    src_name: str | Path  # can be a glob pattern
    dst_dir: str | Path = DESTDIR
    prepend_dot: bool = True


# List of files and directories which will be symlinked as dotfiles in the home folder.
SRC_FILES = [
    Symlink("bash/bash_profile"),
    Symlink("bash/bashrc"),
    Symlink("bash/profile"),
    Symlink("bin"),
    Symlink("Brewfile"),
    Symlink("claude/*", dst_dir=DESTDIR / ".claude", prepend_dot=False),
    Symlink("conda/condarc"),
    Symlink("fzf/fzfrc"),
    Symlink("ghostty", DESTDIR / ".config", prepend_dot=False),
    Symlink("git/gitconfig"),
    Symlink("git/gitk"),
    Symlink("intellij/ideavimrc"),
    Symlink("ipython"),
    Symlink("lazygit", DESTDIR / ".config", prepend_dot=False),
    Symlink("nvim", DESTDIR / ".config", prepend_dot=False),
    Symlink("pandoc"),
    Symlink("ripgrep/ripgreprc"),
    Symlink("tmux/tmux.conf"),
    Symlink("tmuxinator"),
    Symlink("vim"),
    Symlink("vim/gvimrc"),
    Symlink("vim/vimrc"),
    Symlink("zed", DESTDIR / ".config", prepend_dot=False),
    Symlink("zsh/zshenv"),
    Symlink("zsh/zshrc"),
]


def make_symlinks(dry_run: bool = True):
    print(f"{GREEN}DOTFILESDIR: {DOTFILESDIR}{RESTORE}")
    print(f"{GREEN}DESTDIR: {DESTDIR}{RESTORE}\n")

    total_links = 0
    for sym_spec in SRC_FILES:
        # Get the full path to the source file

        src_filepath_glob = DOTFILESDIR.glob(str(sym_spec.src_name))
        for src_filepath in src_filepath_glob:
            make_symlink_file(
                src_filepath,
                dst_dir=Path(sym_spec.dst_dir),
                prepend_dot=sym_spec.prepend_dot,
                dry_run=dry_run,
            )
            total_links += 1

    print(f"\n{GREEN}Done, {total_links} links created.{RESTORE}")


def make_symlink_file(
    src_filepath: Path, dst_dir: Path, prepend_dot: bool, dry_run: bool
):

    # Make sure it exists
    if not src_filepath.exists():
        print(f"{RED}ERROR: source file {src_filepath!s} does not exist{RESTORE}")
        exit(1)

    # Take the file name and prepend the DESTDIR with a dot
    dst_filename = src_filepath.name
    if prepend_dot:
        dst_filename = f".{dst_filename}"

    dst_filepath = Path(dst_dir) / dst_filename

    # Remove target if it exists
    if dst_filepath.is_symlink():
        if not dry_run:
            print(f"{YELLOW}Removing existing symlink {dst_filepath!s}{RESTORE}")
            dst_filepath.unlink()
        else:
            print(f"{YELLOW}Would remove existing symlink {dst_filepath!s}{RESTORE}")

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


def main():
    parser = argparse.ArgumentParser(
        description="Create symlinks for dotfiles in the home directory."
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print what would be done without making any changes.",
    )
    args = parser.parse_args()
    make_symlinks(dry_run=args.dry_run)


if __name__ == "__main__":
    main()
