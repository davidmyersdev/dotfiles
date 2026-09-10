#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

# https://stackoverflow.com/a/31776247/6189752
git branch --format "%(refname:short) %(upstream)" | awk '{if (!$2) print $1;}'
