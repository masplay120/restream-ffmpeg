#!/bin/bash
set -e

INPUT_URL=${INPUT_URL:-"https://live20.bozztv.com/giatvplayout7/giatv-208566/playlist.m3u8"}
OUTPUT_URL=${OUTPUT_URL:-"rtmp://streamlive8.hearthis.at/live/10778826?secret=b45494c4g584"}

while true; do
  echo "▶️ [$(date)] Restream en vivo (copiando fluido) desde $INPUT_URL a $OUTPUT_URL..."

  ffmpeg \
    -fflags +genpts+discardcorrupt \
    -use_wallclock_as_timestamps 1 \
    -protocol_whitelist "file,http,https,tcp,tls" \
    -reconnect 1 \
    -reconnect_streamed 1 \
    -reconnect_delay_max 30 \
    -rtbufsize 256M \
    -i "$INPUT_URL" \
    -c copy \
    -f flv "$OUTPUT_URL" \
    -hide_banner -loglevel warning

  echo "⚠️ [$(date)] FFmpeg terminó. Reintentando en 5 segundos..."
  sleep 5
done
