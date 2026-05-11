#!/bin/bash

interface=$(iw dev | awk '$1=="Interface"{print $2}')
echo Interface: $interface

sudo airmon-ng start $interface
