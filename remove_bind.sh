#!/bin/bash

NAMES_TO_REMOVE=("Abrir GNOME Terminal" "Abrir menu")

EXISTENTES=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)


EXISTENTES_CLEAN=$(echo "$EXISTENTES" | sed -e "s/'//g" -e "s/\[//" -e "s/\]//" -e "s/ //g")
IFS=',' read -ra BINDINGS <<< "$EXISTENTES_CLEAN"

NOVOS_BINDINGS=()

for b in "${BINDINGS[@]}"; do

  NAME=$(gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$b name 2>/dev/null)

  REMOVE=false
  for rm_name in "${NAMES_TO_REMOVE[@]}"; do
    if [[ "$NAME" == "'$rm_name'" ]]; then
      REMOVE=true
      break
    fi
  done

  if ! $REMOVE ; then
    NOVOS_BINDINGS+=("$b")
  else

    gsettings reset org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$b name
    gsettings reset org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$b command
    gsettings reset org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$b binding
  fi
done

NOVOS_BINDINGS_STRING=$(printf "'%s'," "${NOVOS_BINDINGS[@]}")
NOVOS_BINDINGS_STRING="[${NOVOS_BINDINGS_STRING%,}]"


gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NOVOS_BINDINGS_STRING"
