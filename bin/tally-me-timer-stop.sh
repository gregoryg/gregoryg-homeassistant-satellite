#!/usr/bin/env bash
set -euo pipefail
set +H

thing=$(cat)  # automation feeds stdin
timername=$(< "/tmp/${thing}.timer")
announcement="Hey everybody! The ${timername} timer has finished! I repeat: the ${timername} timer has come to its end!"

# notify-send may fail in headless/automation environments; don’t let that kill the script
notify-send \
  --app-name=Timer \
  --icon=/data/homeassistant/img/timer-going-off.png \
  --expire-time=20000 \
  "${timername} timer" \
  "${timername} timer is done done done!" || true

# Try to fetch voices; if curl fails, fall back to espeak
if curl -sS --connect-timeout 0.5 --max-time 2 \
     http://aziriphale.magichome:8004/get_predefined_voices \
     -o /tmp/chatterbox-predefined-voices.json
then
  # Validate JSON; if invalid, fall back to espeak
  if jq -e type /tmp/chatterbox-predefined-voices.json >/dev/null 2>&1; then
    num_voices=$(jq 'length' /tmp/chatterbox-predefined-voices.json)
    # echo "I am desperately attempting to voice using ${num_voices} voices!" > /tmp/timer-desperation.txt
    random_index=$(shuf -i 0-$(($num_voices - 1)) -n 1)
    random_voice=$(jq ".[$random_index]" /tmp/chatterbox-predefined-voices.json)
    voicename=$(jq -r '.filename' <<<"$random_voice")
    echo "Voicing announcement as ${voicename}"

    body=$(jq -n \
              --arg text "$announcement" \
              --arg voice_mode "predefined" \
              --arg predefined_voice_id "$voicename" \
              --arg reference_audio_filename "" \
              --arg output_format "wav" \
              --argjson exaggeration 0.6 \
              --argjson temperature 1.0 \
              --arg language "en_US" \
              '{
                 text: $text,
                 voice_mode: $voice_mode,
                 predefined_voice_id: $predefined_voice_id,
                 reference_audio_filename: $reference_audio_filename,
                 output_format: $output_format,
                 exaggeration: $exaggeration,
                 temperature: $temperature,
                 language: $language
               }')

    # POST may also fail; let it fail fast but don’t abort on player failing
    if curl -sS -X POST \
         http://aziriphale.magichome:8004/tts \
         -H "Content-Type: application/json" \
         -d "$body" \
         --fail-with-body \
         -o /tmp/voice.wav
    then
      mplayer -af volume=4 /tmp/voice.wav || true
    else
      espeak "$announcement" || true
    fi
  else
    espeak "$announcement" || true
  fi
else
  # Server not reachable in time; fall back
  espeak "$announcement" || true
fi
