#!/bin/bash

status=$(playerctl status 2>/dev/null)

case "$status" in
  "Playing") icon="" ;;  # Pause
  "Paused")  icon="" ;;  # Play
  *) exit 0 ;;
esac

title=$(playerctl metadata title 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)

if [ -z "$title" ] && [ -z "$artist" ]; then
  exit 0
fi

text="$title"
if [ -n "$artist" ]; then
  text="$title - $artist"
fi

# Truncar para manter compacto
max_len=35
if [ ${#text} -gt $max_len ]; then
  text="${text:0:$((max_len - 1))}…"
fi

# Ícone + título curto + controles
echo " $text %{A1:playerctl previous:}%{A} %{A1:playerctl play-pause:}$icon%{A} %{A1:playerctl next:}%{A}"

