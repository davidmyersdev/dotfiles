#!/usr/bin/env zsh

main=$(git main)

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

git branch --merged $main --format "%(refname:short)" | grep -v -e "^$main$"
