#!/bin/bash

sudo ip link set wlan0 down
sudo macchanger -r wlan0
sudo ip link set wlan0 up
