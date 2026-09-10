#!/usr/bin/env zsh

function get-main() {
  local main="$(git main)"
  local remote_main="origin/$main"

  if git rev-parse --verify --quiet "$remote_main" > /dev/null
  then
    echo "$remote_main"
  else
    echo "$main"
  fi
}

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

git checkout $(get-main) $@
