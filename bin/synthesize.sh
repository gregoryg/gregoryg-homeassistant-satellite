#!/usr/bin/env sh

text="$(cat)"
echo "Text to speech text: ${text}"
# dunstify --appname=GLADOS \
notify-send \
     --icon=/data/homeassistant/img/glados-robot-modern-ai-glados-portal-video-game-512.png \
     --expire-time=20000 \
     "GladOS" \
     "${text}"

     # --timeout=20000 \
