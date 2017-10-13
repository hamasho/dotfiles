#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

[[ -f ~/.extend.xsession ]] && . ~/.extend.xsession
[[ -f ~/.xmodmap ]] && xmodmap ~/.xmodmap

