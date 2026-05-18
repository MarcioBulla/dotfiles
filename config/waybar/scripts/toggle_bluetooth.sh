#!/bin/bash

# Verifica o status do Bluetooth
bluetooth_status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

if [ "$bluetooth_status" == "yes" ]; then
    bluetoothctl power off
else
    bluetoothctl power on
fi
