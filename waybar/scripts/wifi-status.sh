#!/usr/bin/env bash

interface=$(iwctl device list | sed -r "s/\x1B\[[0-9;]*[mK]//g" | grep -E '^  \w' | grep -v 'Name' | awk '{print $1}' | head -n1)

if [[ -z "$interface" ]]; then
    echo '{"text": "󰤫", "tooltip": "No Wi-Fi device found"}'
    exit 1
fi

station_info=$(iwctl station "$interface" show | sed -r "s/\x1B\[[0-9;]*[mK]//g")

ssid=$(echo "$station_info" | grep -i 'Connected network' | awk '{$1=$2=""; sub(/^  */, ""); print}')

signal=$(echo "$station_info" | grep "^ *RSSI" | awk '{print $2}' | tr -d 'dBm ')

signal_value=$(( -1 * signal ))

ipaddr=$(echo "$station_info" | grep "IPv4 address" | awk '{$1=$2=""; sub(/^  */, ""); print}')

channel=$(echo "$station_info" | grep "Channel" | awk '{$1=""; sub(/^  */, ""); print}')

security=$(echo "$station_info" | grep "Security" | awk '{$1=""; sub(/^  */, ""); print}')

txrate=$(echo "$station_info" | grep "TxBitrate" | awk '{$1=""; sub(/^  */, ""); print}' | sed 's/ Kbit\/s//')

rxrate=$(echo "$station_info" | grep "RxBitrate" | awk '{$1=""; sub(/^  */, ""); print}' | sed 's/ Kbit\/s//')

if [[ -z "$ssid" ]]; then
    echo '{"text": "󰤯", "tooltip": "Not connected to any network"}'
    exit 0
fi

icon="󰤯"

if (( signal_value >= 80 )); then
    icon="󰤨"
elif (( signal_value >= 60 )); then
    icon="󰤥"
elif (( signal_value >= 40 )); then
    icon="󰤢"
elif (( signal_value >= 20 )); then
    icon="󰤟"
fi

tooltip="SSID: $ssid"
tooltip+="\nSignal: ${signal} dBm"
tooltip+="\nIP: $ipaddr"
tooltip+="\nChannel: $channel"
tooltip+="\nSecurity: $security"
tooltip+="\nTx: ${txrate} Kbit/s"
tooltip+="\nRx: ${rxrate} Kbit/s"

echo "{\"text\": \"$icon\", \"tooltip\": \"$tooltip\"}"
