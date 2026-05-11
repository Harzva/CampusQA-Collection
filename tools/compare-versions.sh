#!/usr/bin/env bash
set -euo pipefail

FROM="${1:-}"
TO="${2:-}"

if [[ -z "$FROM" || -z "$TO" ]]; then
  echo "Usage: ./tools/compare-versions.sh <from> <to>"
  echo "Example: ./tools/compare-versions.sh rag_qa hyper_memory"
  exit 1
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Comparing $FROM -> $TO"
git diff --no-index --stat "$ROOT/$FROM" "$ROOT/$TO" || true
echo
echo "Detailed diff:"
git diff --no-index "$ROOT/$FROM" "$ROOT/$TO" || true

