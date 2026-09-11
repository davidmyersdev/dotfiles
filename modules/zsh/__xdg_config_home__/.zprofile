#!/usr/bin/env zsh

# -U: vars have unique values
# -a: vars are arrays
# -g: vars are global
typeset -U -a -g cdpath fpath path prepath

export DOTFILES_HOME=${DOTFILES_HOME:-${HOME}/.dotfiles}

# Disable macOS shell snapshots (can help performance in native Terminal.app).
export SHELL_SESSIONS_DISABLE=1

# Configure SSH to use 1password.
export SSH_AUTH_SOCK="${XDG_DATA_HOME}/apps/1password/container/t/agent.sock"

# A custom XDG env var to represent my local bin dir.
export XDG_BIN_HOME=${XDG_BIN_HOME:-${HOME}/.local/bin}

# Homebrew
if test -z "$HOMEBREW_PREFIX"
then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

prepath=(
  $XDG_BIN_HOME(N/)
)

path=(
  $prepath
  $path
)
