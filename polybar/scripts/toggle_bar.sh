#!/bin/bash

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/polybar"
STATE_FILE="$CONFIG_DIR/.bar_state"
PID_PURPLE="$CONFIG_DIR/pid_purple"
PID_PEEK="$CONFIG_DIR/pid_peek"

get_pid() {
    local file="$1"
    [ -f "$file" ] || return 1
    local pid
    pid=$(<"$file")
    kill -0 "$pid" 2>/dev/null || return 1
    echo "$pid"
}

msg() {
    local pid="$1"
    shift
    if [ -n "$pid" ]; then
        polybar-msg -p "$pid" "$@"
    else
        polybar-msg "$@"
    fi
}

expand_bar() {
    local pid_purple pid_peek
    pid_purple=$(get_pid "$PID_PURPLE")
    pid_peek=$(get_pid "$PID_PEEK")
    msg "$pid_purple" cmd show
    msg "$pid_peek" cmd hide
    echo visible >"$STATE_FILE"
}

collapse_bar() {
    local pid_purple pid_peek
    pid_purple=$(get_pid "$PID_PURPLE")
    pid_peek=$(get_pid "$PID_PEEK")
    msg "$pid_purple" cmd hide
    msg "$pid_peek" cmd show
    echo hidden >"$STATE_FILE"
}

case "${1:-toggle}" in
    collapse|hide) collapse_bar ;;
    expand|show) expand_bar ;;
    toggle)
        if [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "hidden" ]; then
            expand_bar
        else
            collapse_bar
        fi
        ;;
    *)
        echo "Uso: $0 [collapse|expand|toggle]" >&2
        exit 1
        ;;
esac
