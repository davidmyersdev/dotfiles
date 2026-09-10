#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

# Show a diff of changes since the merge base of HEAD and origin/HEAD.
git diff $(git mb)
