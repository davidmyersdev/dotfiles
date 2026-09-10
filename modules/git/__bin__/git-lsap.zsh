#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

echo "$(git diff --name-only HEAD && git ls-files --others --exclude-standard)" | grep -E "($1)"
