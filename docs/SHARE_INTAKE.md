# Share intake — "share from any app into JARA"

How a share sheet on iOS or Android turns into a saved memory, what is
verified in this repo, and what can only be verified on a real machine.

---

## 1) The contract

One payload shape, spoken by three languages. Change it in one place and
all three must move together.

```
{ "type": "text" | "url" | "image", "value": String, "extras": [String] }
```

- `value` — the text, the URL, or the **first** image reference.
- `extras` — the remaining image references of a multi-image share.
  Empty for `text` and `url`.
- `url` vs `text` is decided **on the platform side**, never in Dart: a
  text/plain share whose whole payload parses as an `http(s)` URI with a
  host is `url`; anything else — including "read this https://x", where
  the sentence is the part worth keeping — stays `text`.
- Image references are passed through as strings and never read at intake
  (`content://…` on Android, a file path inside the App Group container on
  iOS). Decoding bytes belongs to the indexer.

| Name | Value | Where it is written |
|---|---|---|
| Method channel | `jara/share_intake` | `MainActivity.kt`, `share_intake.dart` |
| Cold-start method | `getInitialShare` (Dart → platform) | both |
| Warm method | `onShare` (platform → Dart) | both |
| iOS App Group | `group.com.jara.universalsearch` | `ShareViewController.swift`, both `.entitlements` |
| iOS URL scheme | `jara://share` | `ShareViewController.swift`, `ios/Runner/Info.plist` |
| iOS inbox file | `share_inbox.json` | `ShareViewController.swift` |

## 2) The flow

```
  Any app ── "Share" ─┐
                      │
   ANDROID            │            iOS
   ───────            │            ───
  ACTION_SEND         │      ShareViewController
  ACTION_SEND_MULTIPLE│      (own process, own sandbox)
        │             │             │
        ▼             │             ▼
   MainActivity       │      write share_inbox.json
   parses intent      │      into the App Group
        │             │             │
        │             │             ▼
        │             │      open "jara://share"
        │             │             │
        ▼             ▼             ▼
   ┌───────────────────────────────────────┐
   │  MethodChannel  jara/share_intake     │
   │  cold: getInitialShare  (Dart pulls)  │
   │  warm: onShare          (host pushes) │
   └───────────────────┬───────────────────┘
                       ▼
        lib/core/data/share_intake.dart
        ShareIntake → SharedPayload
                       │
                       ▼
        lib/app.dart   pendingShareProvider.value = payload
                       router.go('/share-capture')
                       │
                       ▼
        ShareCaptureScreen  takes + clears the payload,
        previews it, "Save instantly" → repo.add(MemoryItem)
```

### Cold vs warm

**Cold start** — the share intent exists before Dart does. Android parks
the parsed map in `MainActivity.pendingShare` (parsed *before*
`super.onCreate`, because that call attaches the engine and the engine can
answer immediately) and hands it over when Dart calls `getInitialShare`.
Exactly one delivery per launch: the buffer is nulled on read, so a hot
restart cannot re-open the capture screen for yesterday's share.

**Warm** — `launchMode="singleTop"` (already on MainActivity) sends a
second share to `onNewIntent` instead of stacking another copy of the app.
`onNewIntent` pushes `onShare` down the channel and Dart's broadcast
stream carries it to `app.dart`. If the engine is somehow not attached
yet, `onNewIntent` falls back to the cold buffer — no share is dropped.

### The route hand-off (why a notifier and not a route parameter)

`/share-capture` is built by the router as `const ShareCaptureScreen()`
and the router is not this feature's file to change. So the payload
travels through `pendingShareProvider` — a one-shot `ValueNotifier`
mailbox in `share_intake.dart`. `app.dart` fills it **before** navigating;
`ShareCaptureScreen` takes it in `initState` (not `build` — the success
card is a rebuild, and a read-in-build would lose the payload) and clears
it. Opening `/share-capture` later from the demo entry point therefore
finds an empty mailbox and shows the VoxBridge mock exactly as before.

A cold-start share lands while `SplashScreen` is on screen; navigating
away disposes it, and it cancels its own 1.2 s "go to /search" timer in
`dispose` — so the splash cannot steal the share back.

### What the screen does with each type

| Payload | Preview | Suggested title | Saved as |
|---|---|---|---|
| `url` | link row, full URL underneath | host + last path segment (`voxbridge.app/pricing`) | `MemoryType.link`, tags = host + first path segment, snippet = URL |
| `text` | note row, text over 2 lines | first non-empty line, capped at 60 | `MemoryType.note`, no tags, snippet = the text |
| `image` | photo row, count badge when > 1 | "Photo" / "3 Photos" from the copy deck | `MemoryType.photo`, snippet = "added just now" |
| *(none)* | the VoxBridge mock, unchanged | `VoxBridge pricing page` | `MemoryType.link`, mock tags, VoxBridge collection |

Saving reuses the screen's existing path — `repo.add` → bump
`memoryRevisionProvider` → `JaraHaptics.confirm()` → success card → back
to `/search`. There is only one save path; the payload only changes what
is put into the `MemoryItem`.

## 3) Verified here

- `flutter analyze` — clean, including the three Dart files of this
  feature (`share_intake.dart`, `app.dart`, `share_capture_screen.dart`).
- `flutter test` — the whole committed suite passes, the 8 goldens
  byte-compared and unchanged. `ShareCaptureScreen` is not in the golden
  set, but its
  no-payload path was kept structurally identical (same widgets, same
  constants, same order) so the signed-off layout cannot have moved.
- Payload plumbing, under an 11-check widget/unit suite run outside the
  committed `test/` directory (which is owned elsewhere): wire-map
  decoding and rejection of malformed maps, title/tag derivation,
  `getInitialShare` over a mock channel, the missing-host case, warm
  `onShare` over the broadcast stream, and five screen states (url /
  text / one image / several images / no payload) asserted down to the
  saved `MemoryItem`'s type, title, snippet, tags and collection.

## 4) Needs a real machine

Nothing below can be executed in this environment: there is no Android SDK
and no Xcode (`docs/PLATFORMS_AND_LOCALES.md` §4). The Kotlin and Swift
here have never been compiled — they were written to be reviewed by
reading.

**Android**
1. `flutter build apk` (or `appbundle`) — first compile of
   `MainActivity.kt` and the merged manifest.
2. Share text, a link, one image and several images from Chrome, Photos
   and a notes app; confirm JARA appears in the sheet and lands on the
   capture screen with the right preview.
3. Repeat with JARA already open (warm path via `onNewIntent`) and from
   cold.
4. Confirm the `wear` flavour still builds
   (`flutter build appbundle --flavor wear -t lib/main_watch.dart`). The
   watch inherits the share filters from the shared manifest; harmless,
   but worth an eye.

**iOS**
1. Create the extension target and enable the App Group on both targets —
   `ios/ShareExtension/README.md` has the exact click path. **A target
   cannot be created from files alone.**
2. Add the host-side channel in `AppDelegate.swift` (step 4 of that
   README). Until then the extension writes the inbox file and opens the
   app, and the app ignores it.
3. `flutter build ios` and share from Safari / Photos / Notes.

## 5) Known gaps (deliberate)

- **`EXTRA_SUBJECT` is dropped.** Many apps put the page title there while
  `EXTRA_TEXT` holds the URL — a good title suggestion we currently throw
  away. Adding it means extending the payload contract with a fourth key
  in all three languages; it was left out rather than smuggled into
  `extras`, which is typed as image references.
- **iOS read side is a TODO, not a stub.** See the block at the bottom of
  `lib/core/data/share_intake.dart`: it names the two files and the
  entitlement needed. Code that silently reads nothing would be worse than
  code that is honestly absent.
- **One iOS inbox file, last share wins** (see the extension README).
- **Android URI grants are session-scoped.** The read permission that
  arrives with a shared `content://` URI dies with the process, so the
  image must be copied during the session that received it. That belongs
  to the indexer, which does not exist yet — today the URI string is
  stored and nothing reads the bytes.
- **The extension's share-sheet label** (`Save to JARA`) is not in the
  20-language deck yet; it needs `InfoPlist.strings` per locale in the
  extension target.
