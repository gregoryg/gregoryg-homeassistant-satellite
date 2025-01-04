#!/usr/bin/env sh

text="$(cat)"
echo "Speech to text transcript: ${text}"
dunstify --appname=GLADOS \
         --icon=/data/homeassistant/img/chell-fed-up.png \
         --timeout=5000 \
         "Chell" \
         "${text}"
