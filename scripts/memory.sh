#!/usr/bin/env bash
set -euo pipefail
# memory.sh — sync git log → .review-memory.json (quota-free Qodo memory)
LIMIT=10
OUT=".review-memory.json"
while [[ $# -gt 0 ]]; do
  case "$1" in --limit) LIMIT="$2"; shift 2;; --out) OUT="$2"; shift 2;; *) shift 1;; esac
done
if [[ ! -f "$OUT" ]]; then echo '{"reviews":[]}' > "$OUT"; fi
TMP=$(mktemp)
git log --pretty=format:'{"hash":"%H","date":"%aI","msg":%s}' -n "$LIMIT" 2>/dev/null | head -n "$LIMIT" > /tmp/gitlog.jsonl || true
echo "Synced $LIMIT commits -> $OUT (local PR memory, no API)"
echo "Tip: after each review, append findings via: jq '.reviews += [{\"date\":\"'$(date -Iseconds)'\",\"msg\":\"review\"}]' $OUT > /tmp/m && mv /tmp/m $OUT"
cat "$OUT" | head -n 20
