#!/bin/bash
set -e

LABELS_RAW="$1"
NUMBER="$2"
REPO="$3"

if [[ -z "$LABELS_RAW" || -z "$NUMBER" || -z "$REPO" ]]; then
  echo "Usage: $0 '<label1 | label2 | ...>' <issue_number> <owner/repo>"
  exit 1
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "GITHUB_TOKEN environment variable is not set."
  exit 1
fi

# Convert labels to JSON array (comma separated)
LABELS_JSON="["
FIRST=1
IFS='|' read -ra LABELS_ARR <<< "$LABELS_RAW"
for label in "${LABELS_ARR[@]}"; do
  label_trimmed="$(echo "$label" | xargs)"
  if [[ -n "$label_trimmed" ]]; then
    if [[ $FIRST -eq 1 ]]; then
      LABELS_JSON+="\"$label_trimmed\""
      FIRST=0
    else
      LABELS_JSON+=", \"$label_trimmed\""
    fi
  fi

done
LABELS_JSON+="]"

API_URL="https://api.github.com/repos/$REPO/issues/$NUMBER/labels"

RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$API_URL" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -d "{\"labels\":$LABELS_JSON}")

if [[ "$RESPONSE" == "200" || "$RESPONSE" == "201" ]]; then
  echo "Added labels: $LABELS_JSON to Issue/PR #$NUMBER in $REPO"
  exit 0
else
  echo "Error adding labels ($LABELS_JSON) to Issue/PR #$NUMBER in $REPO. HTTP Status: $RESPONSE" >&2
  exit 1
fi
