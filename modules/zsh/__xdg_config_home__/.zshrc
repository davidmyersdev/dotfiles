#!/usr/bin/env zsh

export EDITOR=vim
export PAGER=less
export VISUAL=vim

# Worktrunk
eval "$(wt config shell init zsh)"

# Initialize shell completions.
#
# -U: ignore compinit aliases
# -z: ensure proper (non-emulated) shell environment
autoload -Uz compinit && compinit

# An `ls` wrapper for listing directory contents in a human-readable format.
#
# -1: List one item per line.
# -A: Include hidden files (excluding `.` and `..`).
# -F: Show file-type indicators.
# -G: Enable colorized output.
alias ll='ls -1AFG '

# Return a successful status code.
true
