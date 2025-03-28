#!/usr/bin/env sh

text="$(cat)"
echo "Speech to text transcript: ${text}"
# dunstify --appname=GLADOS \
notify-send \
         --icon=/data/homeassistant/img/chell-fed-up.png \
         --expire-time=20000 \
         "Chell" \
         "${text}"

         # --timeout=20000 \
