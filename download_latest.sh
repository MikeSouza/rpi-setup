#!/bin/bash

out_file=raspbian_lite_latest.zip

echo "Download latest Raspbian Lite release..."
curl -L https://downloads.raspberrypi.org/raspbian_lite_latest -o "${out_file}"

echo "Unzip latest Raspbian Lite release..."
unzip -o "${out_file}"

echo "Delete ${out_file}..."
rm -f "${out_file}"
