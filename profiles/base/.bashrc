# global
export EDITOR=vim

# golang
export GOPATH=/usr/local/Go
export PATH=${PATH}:${GOPATH}/bin

# dotfiles
export DOTFILES_PATH=${HOME}/.dotfiles
export PATH=${PATH}:${DOTFILES_PATH}/bin

# rbenv
export PATH=${PATH}:${HOME}/.rbenv/bin
eval "$(rbenv init -)"

# aliases
alias ls="ls -GFlash"

# helper functions
ptree () {
    tree -a -F -L $([ ! -z ${1} ] && echo ${1} || echo 3) -I .git
}

prdiff () {
    git fetch $(git config --get remote.origin.url) "+refs/pull/${1}/*:refs/remotes/origin/pr/${1}/*"
    git diff origin/pr/${1}/merge
}
