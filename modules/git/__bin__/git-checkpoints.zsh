#!/usr/bin/env zsh

function run() {
  local name=${1:-$(gdate +%s%3N)}

  git for-each-ref refs/checkpoints \
    --color=always \
    --format='%(color:10)%(objectname:short)%(color:reset) %(subject) %(color:246)~%(authordate:relative)%(color:reset) %(color:13)%(refname)%(color:reset)'
}

run "$@"
