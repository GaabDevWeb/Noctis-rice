#!/bin/bash

# Polybar usa JetBrains Mono (texto) e FontAwesome (ícones) — ver polybar/config/config.ini
sudo apt install -y polybar rofi dbus-x11 fonts-jetbrains-mono fonts-font-awesome

fc-cache -f 2>/dev/null || true

if ! fc-list | grep -qi 'fontawesome'; then
    echo "Aviso: FontAwesome não foi detectada. Os ícones da barra podem não aparecer."
fi
if ! fc-list | grep -qi 'jetbrains mono'; then
    echo "Aviso: JetBrains Mono não foi detectada. O texto da barra pode usar fonte substituta."
fi

if [ -e "$HOME/.config/polybar" ]; then
    rm -rf "$HOME/.config/polybar"
fi



mkdir -p ~/.config
cp -r polybar ~/.config/

WALLPAPER_DIR="$HOME/.config/polybar/wallpapers"
DEFAULT_THEME="purpleEva"
IMAGE_DIR="$HOME/.config/polybar/images"

get_wallpaper_path() {
    local base="$WALLPAPER_DIR/$1"
    if [ -f "${base}.jpg" ]; then
        echo "${base}.jpg"
    elif [ -f "${base}.jpeg" ]; then
        echo "${base}.jpeg"
    fi
}

get_image_path() {
    local base="$IMAGE_DIR/$1"
    if [ -f "${base}.jpg" ]; then
        echo "${base}.jpg"
    elif [ -f "${base}.jpeg" ]; then
        echo "${base}.jpeg"
    fi
}

mkdir -p ~/.config/autostart
cp polybar.desktop ~/.config/autostart/

chmod a+r ~/.config/polybar/scripts/theme/menu.rasi
chmod a+r ~/.config/polybar/scripts/theme/powermenu.rasi
chmod a+r ~/.config/polybar/scripts/theme/choose_theme.rasi

# Substituir ~ pelo caminho absoluto no config.ini para evitar problemas de expansão
sed -i "s|~/.config/polybar|$HOME/.config/polybar|g" "$HOME/.config/polybar/config/config.ini"

# Dar permissão de execução aos scripts
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/scripts/*.sh

NOME1="Abrir GNOME Terminal"
COMANDO1="gnome-terminal"
ATALHO1="<Super>Return"

NOME2="Abrir menu"
COMANDO2="$HOME/.config/polybar/scripts/menu.sh"
ATALHO2="<Super>q"

EXISTENTES=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

if [[ $EXISTENTES == "[]" ]]; then
    BINDINGS=()
else
    BINDINGS=()
    EXISTENTES_CLEAN=$(echo $EXISTENTES | sed -e "s/^\[//" -e "s/\]$//" -e "s/'//g" -e "s/ //g")
    IFS=',' read -ra BINDINGS <<< "$EXISTENTES_CLEAN"
fi

IDX1=${#BINDINGS[@]}
IDX2=$((IDX1 + 1))

PATH1="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$IDX1/"
PATH2="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$IDX2/"

NOVOS_BINDINGS=("${BINDINGS[@]}" "$PATH1" "$PATH2")


NOVOS_BINDINGS_STRING=$(printf "'%s'," "${NOVOS_BINDINGS[@]}")
NOVOS_BINDINGS_STRING="[${NOVOS_BINDINGS_STRING%,}]" 

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NOVOS_BINDINGS_STRING"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH1 name "$NOME1"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH1 command "$COMANDO1"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH1 binding "$ATALHO1"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH2 name "$NOME2"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH2 command "$COMANDO2"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH2 binding "$ATALHO2"

wallpaper_path="$(get_wallpaper_path "$DEFAULT_THEME")"
if [ -n "$wallpaper_path" ]; then
    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_path"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$wallpaper_path"
else
    echo "Aviso: wallpaper do tema \"$DEFAULT_THEME\" não encontrado em $WALLPAPER_DIR"
fi

image_path="$(get_image_path "$DEFAULT_THEME")"
if [ -n "$image_path" ]; then
    sed -i "s|background-image:.*|    background-image:            url(\"$image_path\", height);|" "$HOME/.config/polybar/scripts/theme/menu.rasi"
else
    echo "Aviso: imagem do tema \"$DEFAULT_THEME\" não encontrada em $IMAGE_DIR"
fi

~/.config/polybar/launch.sh

echo "Rice instalado com sucesso!"
