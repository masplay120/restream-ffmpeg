#!/bin/bash
set -e

INPUT_URL=${INPUT_URL:-"https://live20.bozztv.com/giatvplayout7/giatv-208566/tracks-v1a1/mono.ts.m3u8"}
OUTPUT_URL=${OUTPUT_URL:-"rtmp://ssh101.bozztv.com:1935/ssh101/estacionmixtv"}


while true; do
  echo "▶️ [$(date)] Iniciando restream desde $INPUT_URL a $OUTPUT_URL..."

  ffmpeg \
    -fflags +genpts \
    -timeout 10000000 \
    -i "$INPUT_URL" \
    -c:v libx264 -preset veryfast -b:v "$VIDEO_BITRATE" -maxrate 800k -bufsize 3000k -s "$VIDEO_SIZE" -r 30 -pix_fmt yuv420p \
    -c:a aac -b:a "$AUDIO_BITRATE" -ar 44100 -ac 2 \
    -f flv "$OUTPUT_URL" \
    -hide_banner -loglevel error

  echo "⚠️ [$(date)] FFmpeg terminó. Reintentando en 5 segundos..."
  sleep 5
done
