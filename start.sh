#!/bin/bash
set -e

# Variables (se pueden sobrescribir desde Render -> Environment Variables)
INPUT_URL=${INPUT_URL:-"https://live20.bozztv.com/giatvplayout7/giatv-208566/tracks-v1a1/mono.ts.m3u8"}
OUTPUT_URL=${OUTPUT_URL:-"rtmp://streamlive8.hearthis.at/live/10778826?secret=b45494c4g584"}
VIDEO_SIZE=${VIDEO_SIZE:-1280x720}
VIDEO_BITRATE=${VIDEO_BITRATE:-2000k}
AUDIO_BITRATE=${AUDIO_BITRATE:-128k}

while true; do
  echo "▶️ [$(date)] Iniciando restream desde $INPUT_URL a $OUTPUT_URL..."

  ffmpeg \
    -reconnect 1 \
    -reconnect_streamed 1 \
    -reconnect_delay_max 30 \
    -i "$INPUT_URL" \
    -c:v libx264 -preset veryfast -b:v "$VIDEO_BITRATE" -maxrate "$VIDEO_BITRATE" -bufsize 3000k -s "$VIDEO_SIZE" -r 30 -pix_fmt yuv420p \
    -c:a aac -b:a "$AUDIO_BITRATE" -ar 44100 -ac 2 \
    -f flv "$OUTPUT_URL" \
    -hide_banner -loglevel warning

  echo "⚠️ [$(date)] FFmpeg terminó. Reintentando en 5 segundos..."
  sleep 5
done
