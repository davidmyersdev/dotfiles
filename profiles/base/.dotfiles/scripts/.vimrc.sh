#!/bin/sh

# download nerdtree if it doesn't exist
if [ ! -d ${HOME}/.vim/bundle/scrooloose/nerdtree ]
then
    git clone https://github.com/scrooloose/nerdtree ${HOME}/.vim/bundle/scrooloose/nerdtree
fi
