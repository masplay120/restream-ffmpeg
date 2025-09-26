#!/bin/bash
set -e

# Variables (se pueden sobrescribir en Render -> Environment Variables)
INPUT_URL=${INPUT_URL:-"https://live20.bozztv.com/giatvplayout7/giatv-208566/tracks-v1a1/mono.ts.m3u8"}
OUTPUT_URL=${OUTPUT_URL:-"rtmp://streamlive8.hearthis.at/live/10778826?secret=b45494c4g584"}

while true; do
  echo "▶️ [$(date)] Iniciando restream (COPIA DIRECTA) desde $INPUT_URL a $OUTPUT_URL..."

  ffmpeg \
    -reconnect 1 \
    -reconnect_streamed 1 \
    -reconnect_delay_max 30 \
    -i "$INPUT_URL" \
    -c copy \
    -f flv "$OUTPUT_URL" \
    -hide_banner -loglevel warning

  echo "⚠️ [$(date)] FFmpeg terminó. Reintentando en 5 segundos..."
  sleep 5
done
