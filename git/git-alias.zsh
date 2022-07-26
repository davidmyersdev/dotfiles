#!/usr/bin/env zsh
#
# Create a new git alias.

git_alias="$1"
git_command="$2"

if [[ -z "$git_alias" ]]
then
  echo "usage: git alias co [checkout]"
  exit 1
fi

# Create the new script.
cp ~/.dotfiles/git/example.zsh ~/.dotfiles/git/git-${git_alias}.zsh

# Make it executable.
chmod +x ~/.dotfiles/git/git-${git_alias}.zsh

# Create the alias.
if [[ -z "$git_command" ]]
then
  git config --global alias.${git_alias} "!~/.dotfiles/git/git-${git_alias}.zsh"
else
  git config --global alias.${git_alias} "!: git ${git_command} && ~/.dotfiles/git/git-${git_alias}.zsh"
fi

# Edit the script.
$EDITOR ~/.dotfiles/git/git-${git_alias}.zsh
