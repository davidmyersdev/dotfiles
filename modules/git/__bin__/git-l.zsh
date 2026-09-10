#!/usr/bin/env zsh
# List the last X commits for Y ref (can be passed in any order).
#
# git l 2
# git l main
# git l main 2
# git l 2 main

if [[ $1 =~ ^[0-9]+$ ]]
then
  count=${1}
  ref=${2}
else
  count=${2}
  ref=${1}
fi

PS4='' # clear prompt for the set -x call

function default_branch_target() {
  local remote_head

  remote_head=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null) && {
    printf '%s\n' "$remote_head"
    return 0
  }

  git show-ref --verify --quiet refs/heads/main && {
    printf 'main\n'
    return 0
  }

  git show-ref --verify --quiet refs/heads/master && {
    printf 'master\n'
    return 0
  }

  return 1
}

if [[ -z "$ref" ]] && ! git rev-parse --verify --quiet HEAD >/dev/null
then
  printf 'No commits yet.\n' >&2
  exit 0
fi

main_target=$(default_branch_target)
main_branch=${main_target#origin/}
current_branch=$(git branch --show-current)

if [[ -z "$count" && -z "$ref" && -n "$main_branch" && -n "$current_branch" && "$current_branch" != "$main_branch" ]]
then
  # Fall-back to `git lmb` when on a feature branch (by default).
  git lmb "$main_target" || git l 20
  exit $?
fi

set -x # print the subsequent expanded command(s)

# https://git-scm.com/docs/pretty-formats
git log --color=always --pretty=format:'%C(10)%h%Creset %s %C(246)~%cr%Creset%C(13)%(decorate:prefix= ,suffix=)%Creset' --date=relative --max-count=${count:-20} "${ref:-HEAD}"
