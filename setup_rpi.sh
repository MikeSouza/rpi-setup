#!/bin/bash

usage="Usage: $0 image_file [ip_address] [gateway] [netmask] [hostname] [interface]"
if [ "$#" == "0" ]; then
	echo "${usage}"
	exit 1
fi

./create_sdcard.sh $1
shift

./configure_boot.sh '' $@


