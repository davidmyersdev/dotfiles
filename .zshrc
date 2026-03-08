setopt emacs
setopt prompt_subst
autoload -Uz vcs_info # enable vcs_info
zstyle ':vcs_info:git*' formats '%b' # format $vcs_info_msg_0_

DISABLE_AUTO_TITLE="true"
NEWLINE=$'\n'
PS1='$(prompt-directory)$(prompt-git-branch)$(prompt-git-status)${NEWLINE}$(prompt-user)$(prompt-cursor) '

mkdir -p ~/.zsh_histories

# split history files based on session
HISTFILE="$HOME/.zsh_histories/.zsh_history.$(date +%s)_$(basename `tty`)"
HISTSIZE=99999
SAVEHIST=99999

export EDITOR=vim

# Homebrew global bundle file
export HOMEBREW_BUNDLE_FILE=~/Brewfile

# utilities
source ~/pub/dots/profiles/dotfiles/utils.sh

# j (autojump alternative)
source ~/pub/j/j.sh

# local binaries
export PATH="$HOME/.local/bin:$PATH"

# Init Homebrew
source ~/.zshrc.d/brew.zsh

alias de='docker exec -it -e COLUMNS="$(tput cols)" -e LINES="$(tput lines)"'
alias dps='docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Status}}" | sort'
alias g='git'
alias ls='ls -alGF'
alias pbsquish='pbpaste | tr "\n" " " | pbcopy'

# Java / Android
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/openjdk/include"

export JAVA_HOME="$(dirname "$(dirname "$(asdf which java)")")"
export JDK_HOME="$JAVA_HOME"
export ANDROID_HOME="/opt/homebrew/share/android-commandlinetools"
export NDK_HOME="$ANDROID_HOME/ndk/26.1.10909125"

export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"

# MySQL
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

# Necessary for `ruby-build` to use the correct dependencies.
export LDFLAGS=-L/opt/homebrew/opt/ncurses/lib
export CPPFLAGS=-I/opt/homebrew/opt/ncurses/include
export PKG_CONFIG_PATH=/opt/homebrew/opt/ncurses/lib/pkgconfig

# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Alias the original Homebrew path for internal use.
alias pathtobrew="$(which brew)"

function args_or_stdin() {
  local input

  if [ $# -gt 0 ]
  then
    input="$@"
  else
    read -r input
  fi

  echo -n "$input"
}

# Automatically add installed brew dependencies to ~/Brewfile.
function brew() {
  pathtobrew "$@"

  if [[ "$1" == "install" || "$1" == "uninstall" || "$1" == "upgrade" ]]
  then
    # Update ~/Brewfile with the latest dependencies.
    pathtobrew bundle dump --describe -f
  fi
}

function copy-branch() {
  git head | tr -d '\n' | pbcopy
}

function deprecate-npm() {
  npm deprecate "$1" "Please install \`$2\` instead"
}

function docker-local-socket() {
  echo 'export DOCKER_HOST=unix:///var/run/docker.sock'
}

function gif() {
  input="$1"
  output="$2"

  gifski --fps 10 --width 720 -o "$output" "$input"
}

function is-clean() {
  if [[ -z "$(git status --porcelain)" ]]
  then
    true
  else
    false
  fi
}

function is-dirty() {
  if is-clean
  then
    false
  else
    true
  fi
}

function is-me() {
  [ "`whoami`" = "david" ] && true || false
}

function launch() {
  open -a "$1"
}

function ls-processes() {
  local pattern="${1:-.}"

  # List all processes and filter by the given pattern without removing the header.
  ps ax -o user,pid,ppid,%cpu,%mem,command | sed "1p;/${pattern}/!d"
}

function ls-scripts() {
  cat ./package.json | jq '.scripts'
}

function now() {
  gdate +%s%3N
}

function pw() {
  # Could also use -base64 maybe?
  openssl rand -hex $((${1:-8} / 2))
}

function password-add() {
  local password=''

  echo 'Password:'
  read -s password
  echo ''

  security add-generic-password -a "$USER" -s "$1" -w "$password"
}

function password-get() {
  security find-generic-password -a "$USER" -s "$1" -w
}

function password-remove() {
  security delete-generic-password -a "$USER" -s "$1"
}

function password-replace() {
  password-remove "$1"
  password-add "$1"
}

# always loaded before displaying the prompt
function precmd() {
  vcs_info
  title "$(relative-pwd)"
}

function prompt-cursor() {
  echo -n "%F{12}➜%f"
}

function prompt-directory() {
  echo -n "%F{12}$(relative-pwd)%f"
}

function prompt-git-branch() {
  ! is-git && return

  local branch="$vcs_info_msg_0_"

  branch="${branch#heads/}"
  branch="${branch/.../}"

  echo -n " @ %F{13}$branch%f"
}

function prompt-git-status() {
  ! is-git && return

  local prompt=""
  local output="$(git status --porcelain -b 2> /dev/null)"

  grep -Eq '^\?\? ' <(<<<$output) && prompt+="?" # untracked
  grep -Eq '^(A[ MDAU]|M[ MD]|UA) ' <(<<<$output) && prompt+="+" # added
  grep -Eq '^([ MARC]M|^R[ MD]) ' <(<<<$output) && prompt+="!" # modified
  grep -Eq '^([MARCDU ]D|D[ UM]) ' <(<<<$output) && prompt+="-" # deleted

  [ -z "$prompt" ] && return

  echo -n " $prompt"
}

function prompt-user() {
  ! is-me && echo -n "as %F{#ba6ecf}%n%f "
}

function quit() {
  osascript -e "quit app \"$1\""
}

function relative-pwd() {
  print -P "%~"
}

function reload() {
  clear
  exec zsh
}

function set_env() {
  if [ -z "$1" ]
  then
    echo "Missing environment variable name" && return 1
  fi

  printf "Enter secret: "
  eval "read -s $1 && export $1"
}

function simulator() {
  open /System/Volumes/Data/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app
}

function sync_icons() {
  local ghostty="/Applications/Ghostty.app"
  local google_chrome="~/Applications/Chrome Apps.localized/Google Calendar.app"
  local spotify="/Applications/Spotify.app"
  local youtube="~/Applications/Chrome Apps.localized/YouTube.app"

  if [ -d "$ghostty" ]
  then
    # Overwrite the Ghostty default app icon
    cp ~/pub/dots/profiles/dotfiles/.config/dotfiles/icons/ghostty.icns "$ghostty/Contents/Resources/Ghostty.icns"

    # Touch the app folder to force the icon to refresh.
    touch "$ghostty"
  fi

  if [ -d "$google_chrome" ]
  then
    # Overwrite the Google Chrome default app icon
    cp ~/.config/dotfiles/icons/google-calendar.icns "$google_chrome/Contents/Resources/app.icns"

    # Touch the app folder to force the icon to refresh.
    touch "$google_chrome"
  fi

  if [ -d "$spotify" ]
  then
    # Overwrite the Google Chrome default app icon
    cp ~/.config/dotfiles/icons/spotify.icns "$spotify/Contents/Resources/Icon.icns"

    # Touch the app folder to force the icon to refresh.
    touch "$spotify"
  fi

  if [ -d "$youtube" ]
  then
    # Overwrite the Google Chrome default app icon.
    cp ~/.config/dotfiles/icons/youtube.icns "$youtube/Contents/Resources/app.icns"

    # Touch the app folder to force the icon to refresh.
    touch "$youtube"
  fi
}

function timestamp() {
  date +%Y-%m-%dT%H:%M:%S%z
}

function timestamp-clip() {
  timestamp | xargs echo -n | pbcopy
}

function title() {
  echo -en "\033]0;${1:?zsh}\007"
}

function to_join() {
  args_or_stdin "$@" | tr '\n' ' '
}

function to_lower() {
  args_or_stdin "$@" | tr '[:upper:]' '[:lower:]'
}

function to_upper() {
  args_or_stdin "$@" | tr '[:lower:]' '[:upper:]'
}

function trim() {
  # Remove whitespace at beginning and end of string.
  args_or_stdin "$@" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}

function tts() {
  sed -i '' 's/\t/  /g' $@
}

function uuid() {
  uuidgen | tr '[:upper:]' '[:lower:]'
}

function weather() {
  # https://github.com/chubin/wttr.in
  curl https://wttr.in/
}

function when-clean() {
  if is-clean
  then
    $@
  fi
}

function when-dirty() {
  if is-dirty
  then
    $@
  fi
}

# Init asdf
. $(brew --prefix asdf)/libexec/asdf.sh

# must be after function definitions
export BUNDLE_ARTIFACTS__DOX__SUPPORT="$(password-get bundler_dox_support_creds)"
export GITHUB_TOKEN="$(password-get github_token)"
export NEXUS_PULL_PASS="$(password-get nexus_pull_pass)"
export NEXUS_PULL_USER="$(password-get nexus_pull_user)"
export SEGMENT_KEY="$(password-get dox_vue_segment_key)"
export YARN_NPM_AUTH_IDENT="$(password-get yarn_npm_auth_ident)"

# include doximity config
source ~/.doxrc



# Make sure the dox-cli shell completion script stays up-to-date
dox completion zsh > ~/.zsh/functions/_dox

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add custom bin scripts to path
export PATH="$HOME/.bin:$PATH"

# bun completions
[ -s "/Users/david/.bun/_bun" ] && source "/Users/david/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/david/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# NPM
export PATH="$HOME/node_modules/.bin:$PATH"

function setup() {
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/pub/dots/profiles/dotfiles/"
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
}

# Anthropic / Claude Code
# Note: This env is exposed to Claude Code via `~/.claude/bin/auth.sh`.
export DOX_ANTHROPIC_API_KEY="$(password-get dox_anthropic_api_key)"

# Note: The global `ANTHROPIC_API_KEY` env var is intentionally not set, because
# Claude Code displays a warning if it is. Instead, the `~/.claude/bin/auth.sh`
# script is used to provide the API key directly to Claude Code via its special
# `apiKeyHelper` option in `~/.claude/settings.json`.
# export ANTHROPIC_API_KEY="$DOX_ANTHROPIC_API_KEY"
