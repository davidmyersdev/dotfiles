#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

git for-each-ref --sort=-committerdate --count=10 --format='%(refname:short)' refs/heads/
