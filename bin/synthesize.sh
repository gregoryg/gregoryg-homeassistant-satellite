#!/usr/bin/env sh

text="$(cat)"
echo "Text to speech text: ${text}"
dunstify --appname=GLADOS \
         --icon=/data/homeassistant/img/glados-robot-modern-ai-glados-portal-video-game-512.png \
         --timeout=20000 \
         "GladOS" \
         "${text}"
