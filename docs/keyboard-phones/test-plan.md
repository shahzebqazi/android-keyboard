# Keyboard phones — test plan

Build: `./gradlew assembleUnstableDebug`  
Install: `adb install -r build/outputs/apk/unstable/debug/*-unstable-debug.apk` (confirm path after build)

## Screenshots (required after install + each scenario)

Captured with `docs/keyboard-phones/capture-screenshot.sh <label>` into `docs/keyboard-phones/screenshots/`. Commit PNGs on `dev` with test-plan updates.

| Label | File | Scenario |
|-------|------|----------|
| `00-after-install` | | APK installed, FUTO set as default IME |
| `01-soft-keyboard` | | S1 — soft keyboard on Q25 |
| `02-physical-keyboard` | | S2 — built-in keys |
| `03-suggestion-strip` | | S4 — strip with soft keys hidden |
| _(add as tested)_ | | |

## Device matrix

| Device | Model (`getprop ro.product.model`) | Android | Keyboard type | Date | Tester |
|--------|-----------------------------------|---------|---------------|------|--------|
| Zinwa Q25 | _pending adb authorize_ | _pending_ | Built-in | 2026-05-30 | shahzebqazi |

Record when connected:

```bash
adb devices -l
adb shell getprop ro.product.model
adb shell getprop ro.build.version.release
```

## Scenarios

| ID | Scenario | Pass | Notes |
|----|----------|------|-------|
| S1 | Soft keyboard on square / small display (Q25) | | Height overrides (MVP A) |
| S2 | Built-in physical keyboard: type in field | | MVP B / #1755 |
| S3 | USB or BT keyboard connect / disconnect | | MVP B |
| S4 | Suggestion / action strip visible when soft keys hidden | | #1153 |
| S5 | `Hide keyboard when hard keyboard connected` on/off | | #27, setting default |
| S6 | Can show IME manually when hard keyboard connected | | #1278, #1900 |
| S7 | IME does not pop up unexpectedly with hard keyboard | | #2000 |
| S8 | Emoji search with physical keyboard | | #1810 — post-MVP if deferred |
| S9 | Regression: normal touchscreen phone (if available) | | |

## Build / automated tests

| Command | Result | Date |
|---------|--------|------|
| `./gradlew assembleUnstableDebug` | **PASS** — `build/outputs/apk/unstable/debug/android-keyboard-unstable-debug.apk` | 2026-05-30 |
| `./gradlew test` | _not run_ | |

## User approval (upstream gate)

- [ ] On-device results reviewed
- [ ] Explicit **“approved for upstream”** before opening PR to `futo-org/android-keyboard`
