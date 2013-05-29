#
# ~/.bashrc
#

hgrep (){ find ~/.dir_bash_history/ -type f|xargs grep -h $*;}

# Usage: mycd
# Replacement for builtin 'cd', wh ich keeps a separate bash-history
# for every directory.
shopt -s histappend
alias cd="mycd"
export HISTFILE="$HOME/.dir_bash_history$PWD/bash_history.txt"
export HISTCONTROL=ignoredups
history -r

function mycd()
{
    history -w # write current history file
    builtin cd "$@" && ls --color=auto # do actual c d and list teh new contents
    local HISTDIR="$HOME/.dir_bash_history$PWD" # use& nbsp;nested folders for history
    if [ ! -d "$HISTDIR" ]; then # create folder if neede d
        mkdir -p "$HISTDIR"
    fi
    export HISTFILE="$HISTDIR/bash_history.txt" # set& nbsp;new history file
    history -c # clear memory
    history -r #read from current histfile
}

export PATH=$PATH:/home/adam/scripts
export _JAVA_AWT_WM_NONREPARENTING=1

alias emacs='emacs -r'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

complete -cf sudo

alias ls='ls --color=auto'
alias l='ls'
alias la='ls -lah'
alias emacs='emacs -nw'
alias du='du -h --max-depth=1'
alias psf='ps aux |grep '
#PS1='\[\033[G\]\[\e[1;34m\]<\w> \[\e[0m\]'
PS1='\[\e[1;34m\]<\w> \[\e[0m\]'
