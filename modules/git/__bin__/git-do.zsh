#!/usr/bin/env zsh

set -x # print the subsequent expanded command(s)

git diff "origin/$(git head)"
