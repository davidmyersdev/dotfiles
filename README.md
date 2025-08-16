# dotfiles

My dotfiles

## How to use

Clone the repo.

```sh
git clone git@github.com:davidmyersdev/dotfiles.git ~/.dotfiles
```

Move into the project folder.

```sh
cd ~/.dotfiles
```

Run the setup script.

```sh
# ~/.dotfiles (or wherever you cloned to)
bin/setup
```

Note: The setup script uses `stow` to create symlinks in your `$HOME` directory for each package under the `./packages` directory.
