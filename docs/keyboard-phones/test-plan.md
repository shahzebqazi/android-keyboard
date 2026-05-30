# Keyboard phones — test plan

Build: `./gradlew assembleUnstableDebug`  
Install: `adb install -r java/build/outputs/apk/unstable/debug/*.apk` (path may vary; confirm after build)

## Device matrix

| Device | Model (`getprop ro.product.model`) | Android | Keyboard type | Date | Tester |
|--------|-----------------------------------|---------|---------------|------|--------|
| Zinwa Q25 | _pending_ | _pending_ | Built-in | — | shahzebqazi |

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
| `./gradlew assembleUnstableDebug` | _not run_ | |
| `./gradlew test` | _not run_ | |

## User approval (upstream gate)

- [ ] On-device results reviewed
- [ ] Explicit **“approved for upstream”** before opening PR to `futo-org/android-keyboard`
