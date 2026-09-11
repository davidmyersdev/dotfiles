#!/usr/bin/env zsh

export EDITOR=vim
export PAGER=less
export VISUAL=vim

# Initialize shell completions.
#
# -U: ignore compinit aliases
# -z: ensure proper (non-emulated) shell environment
autoload -Uz compinit && compinit

alias ll='ls -alGF'

# Return a successful status code.
true
