#!/usr/bin/env zsh

PS4='' # clear prompt for the set -x call
set -x # print the subsequent expanded command(s)

git log --color=always --pretty=format:'%C(10)%h%Creset %s %C(246)~%cr%Creset%C(13)%(decorate:prefix= ,suffix=)%Creset' --date=relative $(git mb)..HEAD
