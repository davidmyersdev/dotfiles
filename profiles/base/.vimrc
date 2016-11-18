" set some vim defaults
set nocompatible
filetype off

set number
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set foldcolumn=1

" set the runtime path to include plugins
set runtimepath^=$HOME/.vim/bundle/scrooloose/nerdtree

" enable syntax highlighting and set theme
syntax on
set t_Co=256
colorscheme wombat256i

" custom commands
command NT NERDTreeToggle " toggle NerdTree on or off

" set some defaults for NerdTree
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 45
let g:NERDTreeShowHidden = 1
let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "~"
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeWinPos = "right"

" override some syntax highlighting defaults
:hi Directory guifg=#FF0000 ctermfg=red
:hi cursorLine cterm=NONE gui=NONE
:hi NonText gui=NONE ctermfg=NONE ctermbg=NONE
:hi FoldColumn ctermfg=NONE ctermbg=NONE
:hi StatusLineNC ctermfg=NONE ctermbg=NONE
:hi VertSplit ctermfg=NONE ctermbg=NONE
:hi LineNr ctermfg=NONE ctermbg=NONE

" override some syntax highlighting for NerdTree
:hi NERDTreeExecFile guifg=#00ff00 ctermfg=green
:hi NERDTreeDirSlash guifg=#ffffff ctermfg=white
:hi NERDTreeLinkTarget guifg=#ffffff ctermfg=white
:hi NERDTreeLinkDir ctermfg=lightblue
:hi NERDTreeLinkFile ctermfg=lightblue
