#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
HERE="$(cd "$(dirname "$0")" && pwd)"
PARTS_DIR="$HERE/overlay.parts"

if [ ! -f "$ROOT/package.json" ] || [ ! -d "$ROOT/src" ]; then
  echo "Target does not look like a codex-chatgpt-web checkout: $ROOT" >&2
  exit 1
fi

if [ ! -d "$PARTS_DIR" ]; then
  echo "Missing compatibility parts: $PARTS_DIR" >&2
  exit 1
fi

TMP_B64="$(mktemp)"
TMP_XZ="$(mktemp)"
trap 'rm -f "$TMP_B64" "$TMP_XZ"' EXIT

cat "$PARTS_DIR"/part-* > "$TMP_B64"

if base64 --decode < "$TMP_B64" > "$TMP_XZ" 2>/dev/null; then
  :
else
  base64 -D < "$TMP_B64" > "$TMP_XZ"
fi

EXPECTED_SHA256="ae1a2cc0daf03efe4c9a80ad9c292555dae2a416a242f29b302b7cc3c9f4368a"
ACTUAL_SHA256="$( (sha256sum "$TMP_XZ" 2>/dev/null || shasum -a 256 "$TMP_XZ") | awk '{print $1}' )"
if [ "$ACTUAL_SHA256" != "$EXPECTED_SHA256" ]; then
  echo "Overlay checksum mismatch: $ACTUAL_SHA256" >&2
  exit 1
fi

tar -xJf "$TMP_XZ" -C "$ROOT" --strip-components=1

echo "OpenCodex compatibility overlay applied to: $ROOT"
