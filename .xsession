#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

[[ -f ~/.extend.xsession ]] && . ~/.extend.xsession
[[ -f ~/.xmodmap ]] && xmodmap ~/.xmodmap

unclutter -idle 1 -root &

# IMF
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS='@im=uim'
