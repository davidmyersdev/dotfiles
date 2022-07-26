#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

git for-each-ref --sort='-committerdate:iso8601' --format=' %(committerdate:iso8601)%09%(refname) $@
