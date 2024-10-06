#!/bin/bash

pulseaudio --check
pulseaudio --kill
pulseaudio --start
