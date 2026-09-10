#!/usr/bin/env zsh

function run() {
  local name=${1:-$(gdate +%s%3N)}

  git update-ref refs/checkpoints/${name} HEAD

  echo "refs/checkpoints/${name}"
}

run "$@"
