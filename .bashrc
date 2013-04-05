#
# ~/.bashrc
#

export PATH=$PATH:/home/adam/scripts
export _JAVA_AWT_WM_NONREPARENTING=1
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'




alias emacs='emacs -r'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


complete -cf sudo

alias ls='ls --color=auto'
alias l='ls'
alias la='ls -lah'
alias emacs='emacs -nw'
alias du='du -h --max-depth=1'
alias google='google -C'
PS1='\[\033[G\]\[\e[1;34m\]<\w> \[\e[0m\]'
