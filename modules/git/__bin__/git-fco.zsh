#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

git checkout `git for-each-ref --sort=-committerdate --format='%(HEAD) %(refname:short)' refs/heads/ | fzf` $@
