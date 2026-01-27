#!/bin/bash

sudo  rm -rf ~/.config/polybar

sudo rm -f ~/.config/autostart/polybar.desktop

pkill polybar 2>/dev/null || true

DEFAULT_WALLPAPER="/usr/share/backgrounds/gnome/adwaita-d.webp"

if [ -f "$DEFAULT_WALLPAPER" ]; then
    gsettings set org.gnome.desktop.background picture-uri "file://$DEFAULT_WALLPAPER"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$DEFAULT_WALLPAPER"
    echo "Papel de parede padrão restaurado."
else
    echo "Imagem padrão não encontrada: $DEFAULT_WALLPAPER"
fi

./remove_bind.sh

sudo apt remove --purge -y polybar rofi dbus-x11

echo "Rice desinstalado com sucesso!"
