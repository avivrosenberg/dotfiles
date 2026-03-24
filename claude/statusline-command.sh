#!/bin/sh
# Claude Code status line — styled after kphoen zsh theme

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name')
model_id=$(echo "$input" | jq -r '.model.id // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Determine context window label from model ID, falling back to raw token count
ctx_label=""
case "$model_id" in
  *1m*|*1M*|*million*)
    ctx_label="1M" ;;
  claude-opus-4-5|claude-sonnet-4-5|claude-haiku-4-5|\
  claude-opus-4-6|claude-sonnet-4-6|\
  claude-3-5-sonnet*|claude-3-5-haiku*|\
  claude-3-opus*|claude-3-sonnet*|claude-3-haiku*)
    ctx_label="200k" ;;
  *)
    if [ -n "$ctx_size" ]; then
      if [ "$ctx_size" -ge 1000000 ] 2>/dev/null; then
        ctx_label="$(echo "$ctx_size" | awk '{printf "%.0fM", $1/1000000}')"
      elif [ "$ctx_size" -ge 1000 ] 2>/dev/null; then
        ctx_label="$(echo "$ctx_size" | awk '{printf "%.0fk", $1/1000}')"
      else
        ctx_label="${ctx_size}"
      fi
    fi
    ;;
esac

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

# Helper: build a 10-char progress bar for a percentage
make_bar() {
  pct="$1"
  filled=$(echo "$pct" | awk '{printf "%d", int($1 / 100 * 10 + 0.5)}')
  empty=$((10 - filled))
  b=""
  i=0
  while [ $i -lt $filled ]; do b="${b}█"; i=$((i + 1)); done
  i=0
  while [ $i -lt $empty ]; do b="${b}░"; i=$((i + 1)); done
  echo "$b"
}

# 5-hour session usage bar
five_bar=""
if [ -n "$five_pct" ]; then
  b=$(make_bar "$five_pct")
  five_pct_rounded=$(printf '%.0f' "$five_pct")
  five_bar=" | 5h:[${b}] ${five_pct_rounded}%"
fi

# 7-day weekly usage bar
week_bar=""
if [ -n "$week_pct" ]; then
  b=$(make_bar "$week_pct")
  week_pct_rounded=$(printf '%.0f' "$week_pct")
  week_bar=" | 7d:[${b}] ${week_pct_rounded}%"
fi

# Context usage progress bar (10 chars wide, same as 5h/7d bars)
ctx_bar=""
if [ -n "$used_pct" ]; then
  b=$(make_bar "$used_pct")
  used_pct_rounded=$(printf '%.0f' "$used_pct")
  if [ -n "$ctx_label" ]; then
    ctx_bar=" | ctx (${ctx_label}):[${b}] ${used_pct_rounded}%"
  else
    ctx_bar=" | ctx:[${b}] ${used_pct_rounded}%"
  fi
fi

ESC=$(printf '\033')

# Git part: " on <branch>" in green, matching kphoen style
git_part=""
if [ -n "$git_branch" ]; then
  git_part=" on ${ESC}[32m${git_branch}${ESC}[0m"
fi

# Format: [user@host:path on git-branch] | model | 5h bar | 7d bar | ctx bar
# Colors: red=user, magenta=host, blue=path — mirroring kphoen
printf "[${ESC}[31m%s${ESC}[0m@${ESC}[35m%s${ESC}[0m:${ESC}[34m%s${ESC}[0m%s] | %s%s%s%s" \
  "$user" "$host" "$short_cwd" "$git_part" "$model" "$five_bar" "$week_bar" "$ctx_bar"
