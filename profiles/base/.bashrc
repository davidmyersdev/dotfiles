# global
export EDITOR=vim

# golang
export GOPATH=/usr/local/Go
export PATH=${PATH}:${GOPATH}/bin

# dotfiles
export DOTFILES_PATH=${HOME}/.dotfiles
export PATH=${PATH}:${DOTFILES_PATH}/bin

# aliases
alias ls="ls -GFlash"

# helper functions
ptree () {
    tree -a -F -L $([ ! -z ${1} ] && echo ${1} || echo 3) -I .git
}
