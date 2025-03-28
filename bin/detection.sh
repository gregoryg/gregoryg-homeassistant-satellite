#!/usr/bin/env sh

name="$(cat)"
# echo "Wake word detected: ${name}"

DISPLAY=:0 xscreensaver-command -deactivate
# killall -v xscreensaver
