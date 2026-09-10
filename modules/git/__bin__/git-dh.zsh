#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

# Show a diff of unstaged changes.
git diff HEAD $@
