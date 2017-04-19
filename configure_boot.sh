#!/bin/bash

mount_point=${1:-"/Volumes/boot"}
if ! ls "${mount_point}" &>/dev/null; then
	echo "SD card with Raspbian not mounted at ${mount_point}." >&2
	exit 1
fi

ipaddr=${2:-"192.168.1.200"}
hostname=${3:-"rpi0"}
ethconf="ip=${ipaddr}::192.168.1.1:255.255.255.0:${hostname}:eth0:off"
echo "Configuring Ethernet..."
sed "s/$/ ${ethconf}/" "${mount_point}/cmdline.txt" > tmpfile
mv tmpfile "${mount_point}/cmdline.txt"

echo "Configuring SSH..."
touch "${mount_point}/ssh"

if [ -e wpa_supplicant.conf ]; then
	echo "Configuring Wi-Fi..."
	cp wpa_supplicant.conf "${mount_point}/"
fi
