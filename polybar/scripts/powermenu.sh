#!/bin/sh

# Caminhos
ROFI_THEME="$HOME/.config/polybar/scripts/theme"
THEME_DIR="$HOME/.config/polybar/themes"
POLYBAR_CONFIG="$HOME/.config/polybar/config/config.ini"
WALLPAPER_DIR="$HOME/.config/polybar/wallpapers"
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

# Opções
shutdown="⏻ Power Off"
reboot=" Reboot"
logout=" Logout"
suspend="⏾ Suspend"
change_theme=" Theme"

# Menu via rofi + X11 backend
chosen=$(printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n" \
  "$shutdown" "$reboot" "$logout" "$suspend" "$change_theme" \
  | GDK_BACKEND=x11 rofi -dmenu -filter "" -p "$(whoami)@$(hostname)" -theme "$ROFI_THEME/powermenu.rasi")

confirm_action() {
  local action="$1"
  local confirm
  confirm=$(printf "Não\nSim\n" | GDK_BACKEND=x11 rofi -dmenu -p "Confirmar $action?" -theme "$ROFI_THEME/powermenu.rasi")
  [ "$confirm" = "Sim" ]
}

case "$chosen" in
  "$shutdown")
    confirm_action "desligar" && systemctl poweroff
    ;;
  "$reboot")
    confirm_action "reiniciar" && systemctl reboot
    ;;
  "$logout")
    confirm_action "sair" || exit 0
    gdbus call --session \
      --dest org.gnome.SessionManager \
      --object-path /org/gnome/SessionManager \
      --method org.gnome.SessionManager.Logout 1
    ;;
  "$suspend")
    confirm_action "suspender" && systemctl suspend
    ;;
  "$change_theme")
    current_theme=$(grep include-file "$POLYBAR_CONFIG" | awk -F '/' '{print $NF}' | sed 's/.ini//')
    themes=$(ls "$THEME_DIR" | sed 's/.ini//')
    new_theme=$(printf "%s" "$themes" | GDK_BACKEND=x11 rofi -dmenu -p "Tema atual: $current_theme" -theme "$ROFI_THEME/choose_theme.rasi")

    if [ -n "$new_theme" ]; then
	sed -i "s|include-file = .*|include-file = $THEME_DIR/$new_theme.ini|" "$POLYBAR_CONFIG"
	sed -i "s|@import \"colors/$current_theme\.rasi\"|@import \"colors/$new_theme.rasi\"|" "$ROFI_THEME/powermenu.rasi"
	sed -i "s|@import \"colors/$current_theme\.rasi\"|@import \"colors/$new_theme.rasi\"|" "$ROFI_THEME/choose_theme.rasi"
	sed -i "s/$current_theme/$new_theme/g" "$ROFI_THEME/choose_theme.rasi"
	sed -i "s/$current_theme/$new_theme/g" "$ROFI_THEME/menu.rasi"
	sed -i "s|@import \"colors/$current_theme\.rasi\"|@import \"colors/$new_theme.rasi\"|" "$ROFI_THEME/menu.rasi"


      wallpaper_path="$(get_wallpaper_path "$new_theme")"
      image_path="$(get_image_path "$new_theme")"
      if [ -n "$wallpaper_path" ]; then
        sed -i "s|background-image:.*|    background-image:            url(\"$wallpaper_path\", BOTH);|" "$ROFI_THEME/choose_theme.rasi"
        gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
        gsettings set org.gnome.shell.extensions.user-theme name "Adwaita-dark"
        gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
        gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_path"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$wallpaper_path"
      else
        notify-send "Erro" "Wallpaper do tema não encontrado: $WALLPAPER_DIR/$new_theme.(jpg|jpeg)"
      fi

      if [ -n "$image_path" ]; then
        sed -i "s|background-image:.*|    background-image:            url(\"$image_path\", height);|" "$ROFI_THEME/menu.rasi"
      else
        notify-send "Aviso" "Imagem do menu não encontrada: $IMAGE_DIR/$new_theme.(jpg|jpeg)"
      fi

      ~/.config/polybar/launch.sh
    fi
    ;;
  *) exit 0 ;;
esac
