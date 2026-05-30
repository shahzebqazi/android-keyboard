#!/usr/bin/env bash
# Capture a device screenshot into docs/keyboard-phones/screenshots/
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="${ROOT}/docs/keyboard-phones/screenshots"
mkdir -p "$OUT"
label="${1:-screenshot}"
stamp="$(date +%Y%m%d-%H%M%S)"
file="${OUT}/${stamp}-${label}.png"
serial="$(adb devices | awk 'NR>1 && $2=="device" {print $1; exit}')"
if [[ -z "$serial" ]]; then
  echo "No authorized adb device. Accept USB debugging on the phone." >&2
  exit 1
fi
adb -s "$serial" exec-out screencap -p > "$file"
echo "$file"
