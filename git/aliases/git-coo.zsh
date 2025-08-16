#!/usr/bin/env zsh

set -x # print the subsequent expanded command(s)

git checkout "origin/$(git head)"
