#!/bin/bash

usage="Usage: $0 mount_point ip_address gateway netmask hostname interface"
if [ "$#" == "0" ]; then
	echo "${usage}"
	exit 1
fi

mount_point=${1:-"/Volumes/boot"}
if ! ls "${mount_point}" &>/dev/null; then
	echo "SD card with Raspbian not mounted at ${mount_point}." >&2
	exit 1
fi

ipaddr=${2:-"192.168.1.200"}
gateway=${3:-"192.168.1.1"}
subnet=${4:-"255.255.0.0"}
hostname=${5:-"rpi0"}
interface=${6:-"eth0"}

if [ "$#" == "6" ]; then
	autoconf=off
else
	autoconf=on
fi

netconf="ip=${ipaddr}::${gateway}:${subnet}:${hostname}:${interface}:${autoconf}"

echo "Configuring LAN..."
sed "s/$/ ${netconf}/" "${mount_point}/cmdline.txt" > tmpfile
mv tmpfile "${mount_point}/cmdline.txt"

echo "Configuring SSH..."
touch "${mount_point}/ssh"

if [ -e wpa_supplicant.conf ]; then
	echo "Configuring Wi-Fi..."
	cp wpa_supplicant.conf "${mount_point}/"
fi
