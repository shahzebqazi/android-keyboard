# Keyboard phones — requirements

Fork: [shahzebqazi/android-keyboard](https://github.com/shahzebqazi/android-keyboard)  
Upstream: [futo-org/android-keyboard](https://github.com/futo-org/android-keyboard)  
Prior art (not the integration target): [shahzebqazi/zinwa-q25-keyboard](https://github.com/shahzebqazi/zinwa-q25-keyboard) — Q25 sizing, separate `applicationId`, branding.

## Mission

Improve FUTO Keyboard for **keyboard / communicator phones** (built-in QWERTY, small square displays, USB/BT physical keyboards)—not a single OEM fork. All changes must be **upstreamable**: no second app ID, fork-only branding, or custom URL schemes.

**Upstream PR:** Draft only until on-device testing and explicit user approval (“approved for upstream”). **No upstream PR in this phase.**

## Branch model

| Branch | Role |
|--------|------|
| `main` | Tracks `upstream/master` only (sync; no feature work) |
| `dev` | Integration branch for merged `feature/*`, `bugfix/*`, `test/*` |
| `feature/*`, `bugfix/*`, `test/*` | One concern per branch → merge to `dev` |

## Primary upstream issue

| Issue | Title | Status | Role in this fork |
|-------|--------|--------|-------------------|
| [#1755](https://github.com/futo-org/android-keyboard/issues/1755) | Feature request: Compatibility with built in physical keyboard | OPEN | **Primary feature request** — built-in / communicator physical keyboard behavior |

## Related issues (cite in upstream PR draft)

| Issue | Title | Notes |
|-------|--------|--------|
| [#1153](https://github.com/futo-org/android-keyboard/issues/1153) | Physical Keyboard Utility and Fix | Suggestion strip + physical keyboard |
| [#1318](https://github.com/futo-org/android-keyboard/issues/1318) | The "Minimal" phone ships with a qwerty keyboard | Hide keys / layout fit on minimal devices |
| [#27](https://github.com/futo-org/android-keyboard/issues/27) | Auto-Hide On-Screen Keyboard When Physical Keyboard Is Detected | Overlaps hide-when-hard-keyboard setting |
| [#1900](https://github.com/futo-org/android-keyboard/issues/1900) | Option to show on-screen keyboard with physical keyboard connected | User control when soft keys visible |
| [#2000](https://github.com/futo-org/android-keyboard/issues/2000) | Keyboard pops up when using physical keyboard | Regression / unwanted IME show |
| [#1810](https://github.com/futo-org/android-keyboard/issues/1810) | Can't search for emojis when using a physical keyboard | Secondary; after core MVP |
| [#1278](https://github.com/futo-org/android-keyboard/issues/1278) | Keyboard disappears with no way to manually show when physical keyboard connected | Manual show / strip access |

### Already in upstream (baseline)

- **`HideKeyboardWhenHardKeyboardConnected`** — setting (`SettingsKey` in `LatinIME.kt`, UI in `Typing.kt`). When enabled, IME can keep input view available while hard keyboard is connected (`onEvaluateInputViewShown()`). Default: `false`.

## Out of scope (initial MVP)

- **Sym-specific keymaps** and other heavy OEM key tables unless trivial.
- Fork-only packaging from `zinwa-q25-keyboard` (`applicationId`, app name strings, branding assets).

## Approved MVP (user sign-off 2026-05-30)

**Order: A + B in one MVP**, defer Sym/OEM tables unless trivial.

### A — Square / small display (soft keyboard usable)

- General **device override** mechanism (`ResourceUtils.getDeviceOverrideValue()`, `MODEL=…` entries in height XML).
- Port **only** upstream-suitable deltas from `zinwa-q25-keyboard` (e.g. `MODEL=Q25` in `keyboard-heights.xml`, `keyboard-height-overrides.xml`) — not fork branding.
- Target class: 720×720 and similar communicator layouts; extensible to other models via override tables.

### B — Physical-keyboard UX (built-in + USB/BT)

- Align with [#1755](https://github.com/futo-org/android-keyboard/issues/1755): built-in keyboard on Titan-class / Sym-class / **Zinwa Q25** communicators.
- Keep **suggestion / action bar** useful when soft key rows are hidden or suppressed ([#1153](https://github.com/futo-org/android-keyboard/issues/1153)).
- Sensible interaction with **`HideKeyboardWhenHardKeyboardConnected`** and related issues ([#27](https://github.com/futo-org/android-keyboard/issues/27), [#1900](https://github.com/futo-org/android-keyboard/issues/1900), [#1278](https://github.com/futo-org/android-keyboard/issues/1278), [#2000](https://github.com/futo-org/android-keyboard/issues/2000)).
- Optional follow-up in same release if small: settings for soft key row visibility ([#1318](https://github.com/futo-org/android-keyboard/issues/1318) class devices).

## Test devices

| Device | `ro.product.model` | Android | Built-in / USB / BT | Status |
|--------|-------------------|---------|---------------------|--------|
| Zinwa Q25 | _(pending adb)_ | _(pending)_ | Built-in QWERTY (primary) | **adb not connected** — plug USB or pair wireless debugging |

Other keyboard phones: add rows as hardware becomes available; do not block Q25-first validation.

## Contributing / license (upstream)

- Issues & PRs: GitHub [futo-org/android-keyboard](https://github.com/futo-org/android-keyboard/)
- [CLA](https://cla.futo.org/) — sign **after** upstream PR is opened, not before
- License: [FUTO Source First License 1.1](../../LICENSE.md)
- Issue templates: `.github/ISSUE_TEMPLATE/`

## Implementation touchpoints (Phase 1+)

| Area | Location |
|------|----------|
| Hard keyboard / input view | `LatinIME.kt` — `onEvaluateInputViewShown()`, `HideKeyboardWhenHardKeyboardConnected` |
| Legacy IME behavior | `LatinIMELegacy.java` |
| Height / device overrides | `ResourceUtils.java`, `res/values/keyboard-heights.xml`, `keyboard-height-overrides.xml` |
| Hardware keys | `HardwareKeyboardEventDecoder.java`, `EmojiAltPhysicalKeyDetector.java` |
| Settings UI | `latin/uix/settings/` (`Typing.kt`, `SettingsKey`) |

## Prior art porting checklist (`zinwa-q25-keyboard`)

| Delta | Upstream? |
|-------|-----------|
| `MODEL=Q25` height overrides | Yes |
| `ResourceUtils` / override patterns | Yes, if already matches upstream API |
| Separate `applicationId` | **No** |
| `strings-appname.xml` branding | **No** |

## Git identity (fork commits)

- `user.name`: `shahzebqazi`
- `user.email`: `16868330+shahzebqazi@users.noreply.github.com` (GitHub blocks private `code@sqazi.sh` on push)
