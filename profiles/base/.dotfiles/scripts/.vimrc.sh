#!/bin/sh

# make sure nerdtree is installed
if [ ! -d ${HOME}/.vim/bundle/scrooloose/nerdtree ]
then
    git clone https://github.com/scrooloose/nerdtree ${HOME}/.vim/bundle/scrooloose/nerdtree
fi

# make sure vim-colorschemes is installed
if [ ! -d ${HOME}/.vim/bundle/flazz/vim-colorschemes ]
then
    git clone https://github.com/flazz/vim-colorschemes ${HOME}/.vim/bundle/flazz/vim-colorschemes

    cp -R ${HOME}/.vim/bundle/flazz/vim-colorschemes/colors ${HOME}/.vim/colors
fi
