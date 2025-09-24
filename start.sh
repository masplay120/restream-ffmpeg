#!/bin/bash
set -e

INPUT_URL=${INPUT_URL:-"https://live20.bozztv.com/giatvplayout7/giatv-208566/tracks-v1a1/mono.ts.m3u8"}
OUTPUT_URL=${OUTPUT_URL:-"rtmp://ssh101.bozztv.com:1935/ssh101/estacionmixtv"}
VIDEO_SIZE=${VIDEO_SIZE:-1280x720}
VIDEO_BITRATE=${VIDEO_BITRATE:-1000k}
AUDIO_BITRATE=${AUDIO_BITRATE:-64k}

echo "▶️ Restream iniciando..."
echo "   Origen: $INPUT_URL"
echo "   Destino: $OUTPUT_URL"

exec ffmpeg \
-i "$INPUT_URL" \
-c:v libx264 -preset veryfast -b:v "$VIDEO_BITRATE" -maxrate 1500k -bufsize 3000k -s "$VIDEO_SIZE" -r 30 -pix_fmt yuv420p \
-c:a aac -b:a "$AUDIO_BITRATE" -ar 44100 -ac 2 \
-f flv "$OUTPUT_URL" \
-hide_banner -loglevel warning
