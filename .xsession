#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

[[ -f ~/.extend.xsession ]] && . ~/.extend.xsession
[[ -f ~/.xmodmap ]] && xmodmap ~/.xmodmap

unclutter -idle 1 -root &

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx
