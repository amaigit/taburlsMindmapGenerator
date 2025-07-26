#!/bin/bash
set -e

INPUT_JSON="output/all_links.json"
OUT_MD="output/markmap_links.md"
mkdir -p output
echo "# 🧠 Link Esportati (da JSON)" > "$OUT_MD"

types=$(jq -r '.[].type' "$INPUT_JSON" | sort | uniq)

for type in $types; do
    case "$type" in
        youtube) emoji="🎥 Video YouTube" ;;
        github) emoji="🐙 GitHub" ;;
        notebooklm) emoji="📘 NotebookLM / Google AI" ;;
        reddit) emoji="🌐 Reddit" ;;
        other) emoji="🧪 Altro" ;;
        *) emoji="🔗 Altro" ;;
    esac

    echo -e "\n## $emoji" >> "$OUT_MD"

    jq -r --arg type "$type" '
        map(select(.type == $type)) | sort_by(.timestamp)[] |
        "* [\(.title)](\(.url))\n  * 🗓️ \(.timestamp)\n  * 📁 \(.source_file)"
    ' "$INPUT_JSON" >> "$OUT_MD"
done

echo "✅ Markmap creato in: $OUT_MD"