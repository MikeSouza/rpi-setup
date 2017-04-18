#!/bin/bash

img_file="$(ls *-raspbian-*-lite.img)"
if [ ! -s "${img_file}" ]; then
	echo "Image '${img_file}' not found." >&2
	exit 1
fi

diskutil list

read -p "Enter the disk #: "  disk_num
if [[ $((disk_num)) != ${disk_num} ]]; then
	echo "Disk number '${disk_num}' invalid" >&2
	exit 1
fi

disk_id="disk${disk_num}"
disk_dev="/dev/${disk_id}"
echo "Formatting SD card (${disk_dev})..."
sudo diskutil eraseDisk FAT32 "JESSIE_LITE" MBRFormat "${disk_dev}"

part_id="${disk_id}s1"
part_dev="/dev/${part_id}"
echo "Unmounting formatted SD card partition (${part_dev})..."
sudo diskutil umount "${part_id}"

rdisk_dev="/dev/rdisk${disk_num}"
echo "Writing image to SD card (${rdisk_dev})..."
sudo dd bs=1m if="${img_file}" of="${rdisk_dev}"

