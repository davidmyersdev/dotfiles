#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

git diff-tree --no-commit-id --name-only -r $@
