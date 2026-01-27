
killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

CONFIG=~/.config/polybar/config/config.ini

polybar purple --config="$CONFIG" &
