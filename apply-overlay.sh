#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
HERE="$(cd "$(dirname "$0")" && pwd)"
BUNDLE="$HERE/overlay.tar.gz.b64"

if [ ! -f "$ROOT/package.json" ] || [ ! -d "$ROOT/src" ]; then
  echo "Target does not look like a codex-chatgpt-web checkout: $ROOT" >&2
  exit 1
fi

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

if base64 --decode < "$BUNDLE" > "$TMP" 2>/dev/null; then
  :
else
  base64 -D < "$BUNDLE" > "$TMP"
fi

tar -xzf "$TMP" -C "$ROOT" --strip-components=1

echo "OpenCodex compatibility overlay applied to: $ROOT"
