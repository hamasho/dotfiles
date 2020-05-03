#
# ~/.profile
#
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox

[[ -f ~/.extend.profile ]] && . ~/.extend.profile
