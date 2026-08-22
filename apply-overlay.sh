#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
HERE="$(cd "$(dirname "$0")" && pwd)"
OVERLAY="$HERE/overlay"

if [ ! -f "$ROOT/package.json" ] || [ ! -d "$ROOT/src" ]; then
  echo "Target does not look like a codex-chatgpt-web checkout: $ROOT" >&2
  exit 1
fi

if [ ! -d "$OVERLAY" ]; then
  echo "Missing overlay directory: $OVERLAY" >&2
  exit 1
fi

cp -R "$OVERLAY"/. "$ROOT"/
echo "OpenCodex compatibility overlay applied to: $ROOT"
