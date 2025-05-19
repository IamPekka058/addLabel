#!/bin/bash
set -e

LABELS_RAW="$1"
NUMBER="$2"

if [[ -z "$LABELS_RAW" || -z "$NUMBER" || -z "$REPO" ]]; then
  echo "Usage: $0 '[\"label1\", \"label2\"]' <issue_number> <owner/repo>"
  exit 1
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "GITHUB_TOKEN environment variable is not set."
  exit 1
fi

# Only accept LABELS_RAW as a JSON array
if [[ "$LABELS_RAW" =~ ^\[.*\]$ ]]; then
  LABELS_JSON="$LABELS_RAW"
else
  echo "Labels must be provided as a JSON array, e.g. ['label1', 'label2']."
  exit 1
fi

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
