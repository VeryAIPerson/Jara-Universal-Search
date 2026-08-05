# JARA share extension — Xcode wiring

These files are the complete source of the iOS share target. They are
**not yet a build target**: an app-extension target carries a product
type, an embed-into-app build phase, a signing identity and an
entitlement, and none of those live in files this directory can hold —
they live in `Runner.xcodeproj/project.pbxproj`, which only Xcode should
write. Nothing here has been compiled: this repo's environment has no
Xcode (see `docs/PLATFORMS_AND_LOCALES.md` §4).

Do the following once, on a machine with Xcode, and the extension is live.

## 1. Create the target

1. `open ios/Runner.xcworkspace` (the workspace, not the project — Flutter
   builds through CocoaPods).
2. **File → New → Target… → iOS → Share Extension**.
   - Product Name: **ShareExtension** (the folder name here — keep it, so
     the generated group matches these files).
   - Language: **Swift**. Embed in Application: **Runner**.
   - Xcode offers to activate the new scheme: **Cancel** it, `flutter run`
     drives the Runner scheme.
3. Xcode generates its own `ShareViewController.swift`, `Info.plist` and
   `MainInterface.storyboard`. **Delete all three** (Move to Trash), then
   **File → Add Files to "Runner"…** and add this directory's
   `ShareViewController.swift` and `Info.plist` with target membership
   **ShareExtension only** (never Runner).
   - Build Settings → `INFOPLIST_FILE` must read
     `ShareExtension/Info.plist`.
   - There is no storyboard on purpose: `Info.plist` declares
     `NSExtensionPrincipalClass` instead.
4. Bundle identifier: `com.jara.jaraUniversalSearch.ShareExtension`
   (it must be prefixed by the host app's id,
   `com.jara.jaraUniversalSearch`).
5. Deployment target: **13.0**, matching Runner.

## 2. Share the App Group (both targets — this is the channel)

Signing & Capabilities → **+ Capability → App Groups** on **Runner**
*and* on **ShareExtension**, and tick the same group on both:

```
group.com.jara.universalsearch
```

Xcode creates `Runner.entitlements` and `ShareExtension.entitlements` and
registers the group on the Apple Developer portal. Without this the
extension writes into its own sandbox and the app reads an empty
container — the failure is silent, so verify the group appears **ticked**
under both targets before moving on.

The identifier is duplicated in three places and all three must agree:

| Where | Constant |
|---|---|
| `ShareViewController.swift` | `appGroupID` |
| Both `.entitlements` files | `com.apple.security.application-groups` |
| `docs/SHARE_INTAKE.md` | the contract table |

## 3. Signing

Both targets need a team and a provisioning profile that includes the App
Group. Automatic signing handles it once the capability is added; with
manual profiles, regenerate both after registering the group.

## 4. What is still missing after this (host side)

The extension hands off; nothing reads the hand-off yet.

1. `ios/Runner/Info.plist` already registers the `jara` URL scheme — done,
   in this repo.
2. `ios/Runner/AppDelegate.swift` needs a `MethodChannel` named
   `jara/share_intake` answering the same two methods Kotlin answers:
   `getInitialShare` (returns the parked payload map, or nil) and pushing
   `onShare` when a payload is found on `applicationDidBecomeActive`.
   Reading it = decode `share_inbox.json` from the App Group container,
   then delete the file.
3. The Dart side needs **no change**: `lib/core/data/share_intake.dart`
   already speaks that channel, and the JSON keys are the same
   `{type, value, extras}` map. The TODO block at the bottom of that file
   points back here.

## Known limits of this scaffold

- **One inbox file, last share wins.** Two shares queued before the app is
  opened lose the first. Upgrade path: write `inbox/<uuid>.json` per share
  and drain the directory.
- **Opening the host app** walks the responder chain to reach
  `openURL:`; `extensionContext.open(_:)` does not work from a share
  extension. If Apple closes that route the payload is still on disk, so
  the app can drain it on next launch — the JSON is written before the
  hand-off is attempted, deliberately.
- **Images are copied** into the App Group container
  (`SharedImages/<uuid>.<ext>`). Nothing deletes them yet; the indexer
  must, once it owns the file.
