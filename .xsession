#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

[[ -f ~/.extend.xsession ]] && . ~/.extend.xsession

# toggle Control <-> CapsLock
# but if CapsLock is pressed by alone, behave as Escape
[[ -f ~/.xmodmap ]] && xmodmap ~/.xmodmap
xcape -e 'Control_L=Escape'

# Hide mouse after 1 second idle
type unclutter 2>&1 >/dev/null && unclutter -idle 1 -root &

# Auto mount USB disks
type udiskie 2>&1 >/dev/null && udiskie &

# use fcitx as input method
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx
