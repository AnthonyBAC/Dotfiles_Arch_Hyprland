#!/usr/bin/env bash

# Obtener la interfaz Wi-Fi activa
interface=$(nmcli device status | grep wifi | awk '{print $1}')
connection=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d':' -f2)

if [[ -z "$interface" || -z "$connection" ]]; then
    echo '{"text": "󰤯", "tooltip": "No conectado a ninguna red Wi-Fi"}'
    exit 0
fi

# Obtener detalles de la conexión
signal=$(nmcli -t -f active,signal dev wifi | grep '^yes' | cut -d':' -f2)
ipaddr=$(nmcli -t -f IP4.ADDRESS device show "$interface" | cut -d':' -f2 | cut -d'/' -f1)
txrate=$(iw dev "$interface" link | grep -i 'tx bitrate' | awk '{print $3, $4}')
rxrate="n/a"  # `iw` no entrega Rx fácilmente, puede omitirse o reemplazarse con otro método
channel=$(iw dev "$interface" info | grep channel | awk '{print $2}')
security=$(nmcli -t -f active,security dev wifi | grep '^yes' | cut -d':' -f2)

# Icono según la señal
icon="󰤯"
if (( signal >= 80 )); then
    icon="󰤨"
elif (( signal >= 60 )); then
    icon="󰤥"
elif (( signal >= 40 )); then
    icon="󰤢"
elif (( signal >= 20 )); then
    icon="󰤟"
else
    icon="󰤯"
fi

# Tooltip minimal
tooltip="SSID: $ssid"
tooltip+="\nIP: $ipaddr"
tooltip+="\nSeñal: ${signal}%"
tooltip+="\nSeguridad: $security"

# Output JSON para Waybar
echo "{\"text\": \"$icon\", \"tooltip\": \"$tooltip\"}"
