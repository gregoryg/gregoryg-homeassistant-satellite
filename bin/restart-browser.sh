#!/usr/bin/env bash

killall -v chromium
killall -v chromium-browser

DISPLAY=:0 chromium-browser \
	   --disable-gpu \
           --start-maximized \
           --start-fullscreen \
           http://homeassistant.magichome:8123 &
