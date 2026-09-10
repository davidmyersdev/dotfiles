#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call

function default_target() {
  local remote_head

  remote_head=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null) && {
    printf '%s\n' "$remote_head"
    return 0
  }

  git show-ref --verify --quiet refs/heads/main && {
    printf 'main\n'
    return 0
  }

  git show-ref --verify --quiet refs/heads/master && {
    printf 'master\n'
    return 0
  }

  return 1
}

default_target=$(default_target)
target=${1:-$default_target}

if [ ! -z "$1" ]
then
  shift
fi

if [ -z "$target" ]
then
  printf 'No default branch found; pass a target ref.\n' >&2
  exit 1
fi

if ! git rev-parse --verify --quiet HEAD >/dev/null
then
  printf 'No commits yet.\n' >&2
  exit 1
fi

set -x # print the subsequent expanded command(s)

git merge-base HEAD "$target" "$@"
