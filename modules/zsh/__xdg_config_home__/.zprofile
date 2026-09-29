#!/usr/bin/env zsh

# -U: vars have unique values
# -a: vars are arrays
# -g: vars are global
typeset -U -a -g cdpath fpath path prepath

export DOTFILES_HOME=${DOTFILES_HOME:-${HOME}/.dotfiles}

# Disable macOS shell snapshots (can help performance in native Terminal.app).
export SHELL_SESSIONS_DISABLE=1

# A custom XDG env var to represent my local bin dir.
export XDG_BIN_HOME=${XDG_BIN_HOME:-${HOME}/.local/bin}

prepath=(
  $XDG_BIN_HOME(N/)
)

path=(
  $prepath
  $path
)
