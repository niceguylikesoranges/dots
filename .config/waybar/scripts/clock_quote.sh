#!/usr/bin/env bash

# One source only: DummyJSON, then local fallbacks.
QUOTE=$(curl -s --max-time 4 -H 'Cache-Control: no-cache' \
  "https://dummyjson.com/quotes/random" |
  jq -r 'select(.quote != null) | "\"\(.quote)\"\n— \(.author)"' 2>/dev/null)

if [ -z "$QUOTE" ]; then
  FALLBACKS=(
    "\"The only way to do great work is to love what you do.\"\n— Steve Jobs"
    "\"Well done is better than well said.\"\n— Benjamin Franklin"
  )
  QUOTE=$(printf '%b' "${FALLBACKS[RANDOM % ${#FALLBACKS[@]}]}")
fi

TEXT=$(date '+%H:%M  •  %b %d')

jq -nc --arg text "$TEXT" --arg tooltip "$QUOTE" '{text: $text, tooltip: $tooltip}'
