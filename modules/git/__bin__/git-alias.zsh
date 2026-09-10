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

this_dir="${0:A:h}"

# Create the new script.
cat << 'TEMPLATE' > "${this_dir}/git-${git_alias}.zsh"
  #!/usr/bin/env zsh

  PS4='' # clear prompt for the set -x call
  set -x # print the subsequent expanded command(s)

  echo $@
TEMPLATE

# Make it executable.
chmod +x "${this_dir}/git-${git_alias}.zsh"

# Create the alias (with shell completion).
# if [[ -z "$git_command" ]]
# then
#   git config --global alias.${git_alias} "!~/.dotfiles/git/aliases/git-${git_alias}.zsh"
# else
#   git config --global alias.${git_alias} "!: git ${git_command} && ~/.dotfiles/git/aliases/git-${git_alias}.zsh"
# fi

# Git uses tabs for new configuration entries by default, but I prefer 2-space
# indentation.
# sed -i '' 's/\t/  /g' $(realpath ~/.gitconfig)

# Edit the script.
$EDITOR "${this_dir}/git-${git_alias}.zsh"
