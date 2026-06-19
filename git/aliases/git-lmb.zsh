#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call

if ! git rev-parse --verify --quiet HEAD >/dev/null
then
  printf 'No commits yet.\n' >&2
  exit 1
fi

base=$(git mb "$@") || exit $?

set -x # print the subsequent expanded command(s)

git log --color=always --pretty=format:'%C(10)%h%Creset %s %C(246)~%cr%Creset%C(13)%(decorate:prefix= ,suffix=)%Creset' --date=relative "$base"..HEAD
