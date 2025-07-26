#!/bin/bash
set -e

OUT_JSON="output/all_links.json"
TMP_JSON="output/tmp_links.json"
mkdir -p output
echo "[]" > "$OUT_JSON"

extract_timestamp() {
    local filename="$1"
    if [[ "$filename" =~ ([0-9]{8}T[0-9]{6})([+-][0-9]{4}) ]]; then
        local ts="${BASH_REMATCH[1]}"
        local tz="${BASH_REMATCH[2]}"
        echo "${ts:0:4}-${ts:4:2}-${ts:6:2}T${ts:9:2}:${ts:11:2}:${ts:13:2}${tz:0:3}:${tz:3:2}"
    else
        echo ""
    fi
}

for file in data/*ExportTabsURLs*.txt; do
    [ -f "$file" ] || continue
    echo "📄 Processando: $file"
    timestamp=$(extract_timestamp "$(basename "$file")")

    paste - - < "$file" | while IFS=$'\t' read -r title url; do
        [ -n "$url" ] || continue
        case "$url" in
            *youtube.com/watch*) type="youtube" ;;
            *github.com*) type="github" ;;
            *notebooklm.google.com*|*ai.google.dev*) type="notebooklm" ;;
            *reddit.com*) type="reddit" ;;
            *) type="other" ;;
        esac

        jq -n \
            --arg title "${title//\"/\\\"}" \
            --arg url "$url" \
            --arg source_file "$file" \
            --arg timestamp "$timestamp" \
            --arg type "$type" \
            '{
                title: $title,
                url: $url,
                source_file: $source_file,
                timestamp: $timestamp,
                type: $type
            }' >> "$TMP_JSON"
    done
done

jq -s '.' "$TMP_JSON" > "$OUT_JSON"
rm -f "$TMP_JSON"
echo "✅ JSON creato in: $OUT_JSON"