#!/bin/bash
set -e

# Variables de entorno (se pueden setear en Render)
INPUT_URL=${INPUT_URL:-"https://live20.bozztv.com/giatvplayout7/giatv-208566/playlist.m3u8"}
OUTPUT_URL=${OUTPUT_URL:-"rtmp://streamlive8.hearthis.at/live/10778826?secret=b45494c4g584"}
VIDEO_SIZE=${VIDEO_SIZE:-1280x720}
VIDEO_BITRATE=${VIDEO_BITRATE:-3000k}
AUDIO_BITRATE=${AUDIO_BITRATE:-64k}

echo "▶️ Iniciando restream..."
echo "   Origen: $INPUT_URL"
echo "   Destino: $OUTPUT_URL"
echo "   Resolución: $VIDEO_SIZE"
echo "   Bitrate: $VIDEO_BITRATE / Audio: $AUDIO_BITRATE"

ffmpeg -re -i "$INPUT_URL" \
-c:v libx264 -preset veryfast -b:v $VIDEO_BITRATE -maxrate $VIDEO_BITRATE -bufsize 2M -s $VIDEO_SIZE -r 30 -pix_fmt yuv420p \
-c:a aac -b:a $AUDIO_BITRATE -ar 48000 -ac 2 \
-f flv "$OUTPUT_URL"
