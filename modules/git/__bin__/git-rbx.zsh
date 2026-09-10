#!/usr/bin/env zsh

function merge-base() {
  local default_target="origin/HEAD"
  local target="${1:-${default_target}}"

  git merge-base HEAD "$target"
}

function touched-files() {
  local target="${1:-$(merge-base)}"

  git diff --name-only "$target"
}

# git diff --name-only $(git merge-base HEAD origin/HEAD)
#
# - create a checkpoint
# - for each commit between merge-base and head, run a the following steps:
#   - get list of changed files
#   - run find/replace on those files
#   - add the changes
#   - amend the commit

checkpoint=$(git checkpoint)

echo "Checkpoint: $checkpoint"

# Execute a command for each commit between HEAD and the target merge-base.
git rebase --exec "$(printf '%q ' "$@")" $(merge-base)
