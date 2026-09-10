#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

echo "https://github.com/$(gh repo view --json nameWithOwner --jq '.nameWithOwner')/compare/$(git main)...$(git head)"
