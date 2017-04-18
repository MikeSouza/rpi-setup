#!/bin/bash

./create_sdcard.sh

sleep 3s

if ! ls /Volumes/boot &>/dev/null; then
	echo "SD card with Raspbian not mounted." >&2
	exit 1
fi

echo "Configuring SSH..."
touch /Volumes/boot/ssh

if [ -e wpa_supplicant.conf ]; then
	echo "Configuring Wi-Fi..."
	cp wpa_supplicant.conf /Volumes/boot/
fi

