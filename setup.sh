#!/bin/bash

mount_point=/Volumes/boot

for i in {0..2}
do
	read -p "Insert SD card for Raspberry Pi, press ENTER when ready... "

	./setup_rpi.sh '' "192.168.227.10${i}" 192.168.227.1 255.255.0.0 "rpi${i}" eth0

  read -p "\nPress ENTER to continue or CTRL+C to exit... \n"
	sudo umount "${mount_point}"
done


