#!/usr/bin/env zsh
#
# Based on the script from this gist:
# https://gist.github.com/erdincay/4f1d2e092c50e78ae1ffa39d13fa404e

target=$1 # user or org
destination=${2:-`pwd`} # folder to clone into

current_page=1
max_page_count=1
page_size=75
sort_by=updated
sort_direction=asc

echo "Cloning all repos from https://github.com/$target into $destination..."

until [[ $current_page > $max_page_count ]]
do
  curl -s "https://api.github.com/users/$target/repos?page=$current_page&per_page=$page_size&sort=$sort_by&direction=$sort_direction" | grep -e 'clone_url*' | cut -d \" -f 4 | xargs -L 1 git -C "$destination" clone

  current_page=$(($current_page + 1))
done
