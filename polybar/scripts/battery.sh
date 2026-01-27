#!/bin/bash

# Ícones da bateria (animação)
icons=( "" "" "" "" "" )
icon_count=${#icons[@]}
index=0

# Caminhos padrão
BATTERY_PATH="/sys/class/power_supply/BAT0"
STATUS=$(cat "$BATTERY_PATH/status")
CAPACITY=$(cat "$BATTERY_PATH/capacity")

# Mostra animação se estiver carregando
if [[ "$STATUS" == "Charging" ]]; then
    # Loop contínuo com troca de ícones
    while true; do
	if [[ $1 == "icon" ]]; then
	    echo " ${icons[$index]}"
	elif [[ $1 == "level" ]]; then
	    echo "$CAPACITY%"
	else
	    echo "$icon $CAPACITY%"
	fi
        index=$(( (index + 1) % icon_count ))
        sleep 1
	STATUS=$(cat "$BATTERY_PATH/status")
	CAPACITY=$(cat "$BATTERY_PATH/capacity")
	if [[ "$STATUS" != "Charging" ]]; then
		break
	fi
    done
else
    # Modo normal, só mostra o ícone correspondente
    if [[ $CAPACITY -ge 90 ]]; then
        icon=""
    elif [[ $CAPACITY -ge 70 ]]; then
        icon=""
    elif [[ $CAPACITY -ge 50 ]]; then
        icon=""
    elif [[ $CAPACITY -ge 30 ]]; then
        icon=""
    else
        icon=""
    fi
    if [[ $1 == "icon" ]]; then
	    echo "$icon"
    elif [[ $1 == "level" ]]; then
	    echo "$CAPACITY%"
    else
	    echo "$icon $CAPACITY%"
	fi
fi
