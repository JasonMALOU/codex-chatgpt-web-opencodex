#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
HERE="$(cd "$(dirname "$0")" && pwd)"
BUNDLE="$HERE/overlay.tar.xz"

if [ ! -f "$ROOT/package.json" ] || [ ! -d "$ROOT/src" ]; then
  echo "Target does not look like a codex-chatgpt-web checkout: $ROOT" >&2
  exit 1
fi

if [ ! -f "$BUNDLE" ]; then
  echo "Missing compatibility bundle: $BUNDLE" >&2
  exit 1
fi

tar -xJf "$BUNDLE" -C "$ROOT" --strip-components=1

echo "OpenCodex compatibility overlay applied to: $ROOT"
