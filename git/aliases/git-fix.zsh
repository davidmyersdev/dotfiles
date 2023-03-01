#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

git l 20 | fzf --ansi --multi --no-sort --reverse | gsed --expression='s/^[^a-z0-9]*//;/^$/d' | awk '{print $1}' | xargs git commit --fixup
