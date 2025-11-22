#!/bin/bash

name=$1
bssid=$2
channel=$3

interface=$(iw dev | awk '$1=="Interface"{print $2}')
echo Interface: $interface

sudo airodump-ng -w $name -c $channel --bssid $bssid $interface
