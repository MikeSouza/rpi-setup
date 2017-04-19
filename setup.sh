#!/bin/bash

usage="Usage: $0 image_file ip_addr hostname"
if [ "$#" == "0" ]; then
	echo "${usage}"
	exit 1
fi

./create_sdcard.sh $1

./configure_boot.sh '' $2 $3
