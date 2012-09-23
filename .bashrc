#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


complete -cf sudo

alias ls='ls --color=auto'
alias l='ls'
alias la='ls -lah'
PS1='\[\e[1;34m\]<\w> \[\e[0m\]'


export PATH=$PATH:/home/adam/scripts/
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
