#!/usr/bin/env bash
# Install unstable debug APK on authorized Q25 and capture baseline screenshots.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
APK="${ROOT}/build/outputs/apk/unstable/debug/android-keyboard-unstable-debug.apk"
PKG="org.futo.inputmethod.latin.unstable"
CAP="${ROOT}/docs/keyboard-phones/capture-screenshot.sh"

serial() {
  adb devices | awk 'NR>1 && $2=="device" {print $1; exit}'
}

wait_device() {
  echo "Waiting for authorized adb device (accept USB debugging on phone)..."
  for _ in $(seq 1 60); do
    if [[ -n "$(serial)" ]]; then
      return 0
    fi
    sleep 2
  done
  echo "No authorized device after 120s." >&2
  adb devices -l >&2
  exit 1
}

wait_device
S="$(serial)"
echo "Using device $S"

adb -s "$S" shell getprop ro.product.model | tee /dev/stderr
adb -s "$S" shell getprop ro.build.version.release | tee /dev/stderr

[[ -f "$APK" ]] || { echo "Missing APK: $APK — run ./gradlew assembleUnstableDebug" >&2; exit 1; }

adb -s "$S" install -r "$APK"
sleep 2

# Open system input settings (IME list / enable)
adb -s "$S" shell am start -a android.settings.INPUT_METHOD_SETTINGS
sleep 2
"$CAP" 00-after-install

# Quick note field via Android UI (search app with editable field)
adb -s "$S" shell am start -a android.intent.action.MAIN -c android.intent.category.LAUNCHER -n com.android.documentsui/.LauncherActivity 2>/dev/null \
  || adb -s "$S" shell am start -a android.intent.action.VIEW -d "https://example.com" -n com.android.chrome/com.google.android.apps.chrome.Main 2>/dev/null \
  || true

# Fallback: open any app that accepts text — Dialer search is unreliable; use `cmd input` after focus
adb -s "$S" shell am start -n com.android.settings/.Settings
sleep 1
adb -s "$S" shell input tap 360 400 2>/dev/null || true
sleep 1
adb -s "$S" shell input text "keyboard%20phones%20smoke" 2>/dev/null || true
sleep 1
"$CAP" 01-soft-keyboard || true

echo "Done. Review screenshots in docs/keyboard-phones/screenshots/"
