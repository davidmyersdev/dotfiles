#!/usr/bin/env bash

# Find apps by fuzzy-matching their names.
#
# $ find-app ze
# /Applications/Zed.app
# /Applications/Zen.app
function find-app() {
  local name="$1"

  list-apps | fzf --delimiter / --filter "$name" --with-nth -1
}

# Find icons in a given directory.
#
# $ find-icons $(find-app ghostty)
# /Applications/Ghostty.app/Contents/Resources/AppIcon.icns
function find-icons() {
  local dir="$1"

  if [ ! -d "$dir" ]
  then
    return 1
  fi

  find "$dir" -name "*.icns" -type f
}

# Check whether the current directory is a git repo.
#
# ~/project (main) $ is-git && echo 'yes!' || echo 'no!'
# yes!
function is-git() {
  git rev-parse 2> /dev/null
}

# List apps in all known locations.
#
# $ list-apps
# /Applications/Ghostty.app
# /Applications/Hammerspoon.app
# /Applications/Kiro.app
# /Applications/Ollama.app
# /Applications/Zed.app
# /Applications/Zen.app
function list-apps() {
  ls -1ad /Applications/*.app
}
