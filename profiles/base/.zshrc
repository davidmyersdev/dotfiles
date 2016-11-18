# set ZSH home path
export ZSH=${HOME}/.oh-my-zsh/package

# load my custom theme
ZSH_THEME="pastel"

# load necessary plugins
plugins=(git)

# load up oh-my-zsh
source $ZSH/oh-my-zsh.sh

# include custom overrides
source ${HOME}/.bashrc
