export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export INPUT_METHOD=fcitx5
export DefaultIMModule=fcitx5
if [ $SHLVL = 1 ]; then
    (fcitx5 --disable=wayland -d --verbose '*'=0 &)
    xset -r 49 > /dev/null 2>&1
fi
