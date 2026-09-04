#!/usr/bin/env bash
set -euo pipefail
# qodo-standard-review — quota-free diff review helper (no API calls)
# Usage: ./scripts/review.sh [--range main...HEAD] [--file path] [--staged]
# Output: markdown to stdout + .review-memory.json update hint
RANGE=""
FILE=""
STAGED=1
LIMIT=10

while [[ $# -gt 0 ]]; do
  case "$1" in
    --range) RANGE="$2"; STAGED=0; shift 2;;
    --file) FILE="$2"; shift 2;;
    --staged) STAGED=1; shift 1;;
    --limit) LIMIT="$2"; shift 2;;
    *) echo "Unknown arg: $1" >&2; exit 1;;
  esac
done

echo "## Qodo-Standard Review (quota-free) — context"
echo ""
echo "- Mode: $( [[ $STAGED -eq 1 ]] && echo "staged" || echo "range $RANGE")"
echo "- Date: $(date -Iseconds)"
echo "- Repo: $(git rev-parse --show-toplevel 2>/dev/null || echo "n/a")"
echo ""

if [[ -f AGENTS.md ]]; then echo "### AGENTS.md (project conventions)"; head -n 80 AGENTS.md; echo ""; fi
if [[ -f .review-memory.json ]]; then echo "### .review-memory.json (prior learnings)"; cat .review-memory.json | head -n 60; echo ""; fi

echo "### Recent PRs (local memory, last $LIMIT)"
git log --oneline -n "$LIMIT" 2>/dev/null || echo "(no git log)"
echo ""

echo "### Diff under review"
if [[ -n "$FILE" ]]; then
  git diff --unified=3 -- "$FILE" 2>/dev/null || cat "$FILE"
elif [[ -n "$RANGE" ]]; then
  git diff --unified=3 "$RANGE" 2>/dev/null || git diff "$RANGE"
else
  git diff --staged --unified=3 2>/dev/null; echo "--- unstaged ---"; git diff --unified=3 | head -n 400
fi

cat <<'INSTR'

---
### Next: run 4-lens review (local LLM, no API)
Paste this diff + AGENTS.md into your agent with:
  "review with qodo-standard-review, quality gate 8, use review-loop"
Lenses: correctness / security / quality / tests — see references/checklist.md
Verdict: ✅ Approve | 💬 Comment | 🔄 Request Changes
After fix: ./scripts/memory.sh to update .review-memory.json
INSTR
