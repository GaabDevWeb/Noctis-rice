
killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

CONFIG=~/.config/polybar/config/config.ini
PID_DIR=~/.config/polybar

polybar purple --config="$CONFIG" &
echo $! >"$PID_DIR/pid_purple"

polybar peek --config="$CONFIG" &
echo $! >"$PID_DIR/pid_peek"

sleep 0.5
polybar-msg -p "$(cat "$PID_DIR/pid_peek")" cmd hide 2>/dev/null || true
echo visible >"$PID_DIR/.bar_state"
