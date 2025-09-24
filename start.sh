#!/bin/bash
set -e

INPUT_URL=${INPUT_URL:-"https://live20.bozztv.com/giatvplayout7/giatv-208566/tracks-v1a1/mono.ts.m3u8"}
OUTPUT_URL=${OUTPUT_URL:-"rtmp://streamlive8.hearthis.at/live/10778826?secret=b45494c4g584"}
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
-c:v libx264 -preset veryfast -b:v 1500k -maxrate 2000k -bufsize 4M -s 1280x720 -r 30 -pix_fmt yuv420p \
-c:a aac -b:a 64k -ar 48000 -ac 2 \
-f flv -flvflags no_duration_filesize "$OUTPUT_URL" \
-hide_banner -loglevel warning \
-reconnect 1 -reconnect_streamed 1 -reconnect_delay_max 30

