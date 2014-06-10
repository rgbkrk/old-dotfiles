# don't put duplicate lines or lines starting with a space in the history.
HISTCONTROL=ignoreboth

# Pump it up!
case "$OSTYPE" in
  linux*)
    export HISTSIZE=50000
    export SAVEHIST=50000
    shopt -s histappend
    shopt -s checkwinsize
    shopt -u direxpand
esac

export EDITOR=vim

export CLICOLOR=1
