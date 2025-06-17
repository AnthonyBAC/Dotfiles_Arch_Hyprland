#!/usr/bin/env bash

eth_iface=$(ip link | awk -F: '/: e/{print $2}' | tr -d ' ')
eth_status=$(cat /sys/class/net/$eth_iface/operstate 2>/dev/null)

if [[ "$eth_status" == "up" ]]; then
    echo "{\"text\": \"\", \"tooltip\": \"$eth_iface connected\"}"
else
    echo "{}"
fi
