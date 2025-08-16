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
set -x # print the subsequent expanded command(s)

# https://git-scm.com/docs/pretty-formats
git log --color=always --pretty=format:'%C(10)%h%Creset %s %C(246)~%cr%Creset%C(13)%(decorate:prefix= ,suffix=)%Creset' --date=relative --max-count=${count:-20} ${ref:-HEAD}
