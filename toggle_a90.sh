#!/bin/bash
MAC="9E:4A:F8:E8:EE:E8"

# Check if bluetooth is on, turn it on if not
if ! bluetoothctl show | grep -q "Powered: yes"; then
    rfkill unblock bluetooth
    sleep 1
    bluetoothctl power on
    sleep 2
    notify-send -t 2000 -u low "Bluetooth" "Bluetooth turned on"
fi

if bluetoothctl info "$MAC" | grep -q "Connected: yes"; then
    bluetoothctl disconnect "$MAC"
    notify-send -t 2000 -u low "Bluetooth" "A90 Pro: Off"
else
    if bluetoothctl connect "$MAC" | grep -q "Connection successful"; then
        notify-send -t 2000 -u low "Bluetooth" "A90 Pro: On"
    else
        notify-send -u normal "Bluetooth" "A90 Pro: Failed"
    fi
fi
