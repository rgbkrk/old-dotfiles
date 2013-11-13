# don't put duplicate lines or lines starting with a space in the history.
HISTCONTROL=ignoreboth

# Pump it up!
shopt -s histappend
HISTSIZE=50000
SAVEHIST=50000

shopt -s checkwinsize
shopt -u direxpand

export EDITOR=vim

export CLICOLOR=1
