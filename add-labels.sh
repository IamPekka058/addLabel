#!/bin/bash
set -e

LABELS_RAW="$1"
NUMBER="$2"

if [[ -z "$LABELS_RAW" || -z "$NUMBER" || -z "$REPO" ]]; then
  echo "Usage: $0 '<YAML label list>' <issue_number> <owner/repo>"
  exit 1
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "GITHUB_TOKEN environment variable is not set."
  exit 1
fi

# Reject JSON array, only accept YAML list
if [[ "$LABELS_RAW" =~ ^\[.*\]$ ]]; then
  echo "Error: Only a YAML list is accepted, not a JSON array."
  exit 1
fi

# Convert YAML list to JSON array
LABELS_JSON="["
FIRST=1
while IFS= read -r label; do
  label_trimmed="$(echo "$label" | sed 's/^- *//' | xargs)"
  if [[ -n "$label_trimmed" ]]; then
    if [[ $FIRST -eq 1 ]]; then
      LABELS_JSON+="\"$label_trimmed\""
      FIRST=0
    else
      LABELS_JSON+=", \"$label_trimmed\""
    fi
  fi
done <<< "$LABELS_RAW"
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
