#!/bin/bash
set -e

INPUT_JSON="output/all_links.json"
YT_LIST="output/youtube_links.txt"
YT_META="output/youtube_metadata.json"

jq -r '.[] | select(.type == "youtube") | .url' "$INPUT_JSON" > "$YT_LIST"
yt-dlp -j -a "$YT_LIST" > "$YT_META"

echo "✅ Metadati YouTube salvati in: $YT_META"