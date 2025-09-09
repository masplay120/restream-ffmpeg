#!/bin/bash
set -e

INPUT_URL=${INPUT_URL:-"https://live20.bozztv.com/giatvplayout7/giatv-208566/tracks-v1a1/mono.ts.m3u8"}
OUTPUT_URL=${OUTPUT_URL:-"rtmp://estacionmixtv:159357456@36bay2.tulix.tv/giatv-estacionmixtv/estacionmixtv"}
VIDEO_SIZE=${VIDEO_SIZE:-1280x720}
VIDEO_BITRATE=${VIDEO_BITRATE:-2000k}
AUDIO_BITRATE=${AUDIO_BITRATE:-64k}

echo "▶️ Restream iniciando..."
echo "   Origen: $INPUT_URL"
echo "   Destino: $OUTPUT_URL"
echo "   Resolución: $VIDEO_SIZE"
echo "   Video bitrate: $VIDEO_BITRATE"
echo "   Audio bitrate: $AUDIO_BITRATE"

exec ffmpeg -re -i "$INPUT_URL" \
-c:v libx264 -preset veryfast -b:v $VIDEO_BITRATE -maxrate $VIDEO_BITRATE -bufsize 2M -s $VIDEO_SIZE -r 30 -pix_fmt yuv420p \
-c:a aac -b:a $AUDIO_BITRATE -ar 48000 -ac 2 \
-f flv "$OUTPUT_URL" \
-hide_banner -loglevel warning \
-reconnect 1 -reconnect_streamed 1 -reconnect_delay_max 30
