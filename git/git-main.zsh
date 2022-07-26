#!/usr/bin/env zsh

git rev-parse --abbrev-ref origin/HEAD | xargs -L 1 basename
