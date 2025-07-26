#!/bin/bash
set -e

echo "🧪 Test: rilevamento tipo di link"
types=("youtube.com/watch" "github.com" "reddit.com" "notebooklm.google.com")

for t in "${types[@]}"; do
    result=$(./scripts/extract_links_to_json.sh data/example_${t}.txt | grep "$t")
    if [[ -n "$result" ]]; then
        echo "✅ $t rilevato correttamente"
    else
        echo "❌ Errore: $t non rilevato"
        exit 1