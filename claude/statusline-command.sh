#!/bin/sh
# Claude Code status line — styled after kphoen zsh theme

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten home directory to ~
home="$HOME"
short_cwd="${cwd/#$home/~}"

user=$(whoami)
host=$(hostname -s)

# Git branch (skip optional locks)
git_branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# Context usage progress bar (20 chars wide)
ctx_bar=""
if [ -n "$used_pct" ]; then
  filled=$(echo "$used_pct" | awk '{printf "%d", int($1 / 100 * 20 + 0.5)}')
  empty=$((20 - filled))
  bar=""
  i=0
  while [ $i -lt $filled ]; do bar="${bar}█"; i=$((i + 1)); done
  i=0
  while [ $i -lt $empty ]; do bar="${bar}░"; i=$((i + 1)); done
  ctx_bar=" | [${bar}] ${used_pct}%"
fi

ESC=$(printf '\033')

# Git part: " on <branch>" in green, matching kphoen style
git_part=""
if [ -n "$git_branch" ]; then
  git_part=" on ${ESC}[32m${git_branch}${ESC}[0m"
fi

# Format: [user@host:path on git-branch] | model | ctx_bar
# Colors: red=user, magenta=host, blue=path — mirroring kphoen
printf "[${ESC}[31m%s${ESC}[0m@${ESC}[35m%s${ESC}[0m:${ESC}[34m%s${ESC}[0m%s] | %s%s" \
  "$user" "$host" "$short_cwd" "$git_part" "$model" "$ctx_bar"
