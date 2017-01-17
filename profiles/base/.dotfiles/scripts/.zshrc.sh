#!/bin/sh

# make sure oh-my-zsh is installed
if [ ! -d ${HOME}/.oh-my-zsh/package ]
then
    git clone git://github.com/robbyrussell/oh-my-zsh ${HOME}/.oh-my-zsh/package
fi

# make sure pastel theme is installed
if [ ! -f ${HOME}/.oh-my-zsh/package/themes/pastel.zsh-theme ]
then
    tee ${HOME}/.oh-my-zsh/package/themes/pastel.zsh-theme <<- 'EOF'

    # if superuser, make the username green
    if [ $UID -eq 0 ]; then NCOLOR="green"; else NCOLOR="white"; fi

    # prompt
    PROMPT=$'%{$fg_bold[$NCOLOR]%}%B%n%b%{$reset_color%} in %{$fg_bold[red]%}%~%{$reset_color%}$(git_prompt_info) \n%(!.#.$) '
    RPROMPT=''

    # git theming
    ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%} on branch %{$fg[yellow]%}%B"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
    ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%} with %{$fg_bold[red]%}uncommitted%{$reset_color%} changes"

    export LSCOLORS='BxGxcxdxCxegedabagacad'
    export LS_COLORS='di=1;31:ln=1;36:so=32:pi=33:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

EOF
# heredoc terminators can't be indented
fi
