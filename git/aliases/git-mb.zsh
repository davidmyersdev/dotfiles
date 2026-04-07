#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call

default_target=$(git rev-parse --abbrev-ref origin/HEAD)
target=${1:-$default_target}

if [ ! -z "$1" ]
then
  shift
fi

set -x # print the subsequent expanded command(s)

git merge-base HEAD $target $@
