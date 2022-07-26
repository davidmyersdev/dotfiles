#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

for file in `git diff $1 ${2:-HEAD} --name-only`
do
  echo "$(git rev-list --abbrev-commit $1..${2:-HEAD} -- "$file") $file"
done
