#!/bin/bash

DEVICE_NAME="HP 350/355 Series Keyboard"
DEVICE_ID=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name == "'"$DEVICE_NAME"'") | .name')

if [ -n "$DEVICE_ID" ]; then
    hyprctl keyword "input:kb_options:device:$DEVICE_ID" "altwin:swap_alt_win"
fi
