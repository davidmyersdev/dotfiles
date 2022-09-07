#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

git fetch origin pull/$1/head:pr/$1 && git checkout pr/$1
