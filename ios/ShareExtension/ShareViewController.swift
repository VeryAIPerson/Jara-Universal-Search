import UIKit

/// JARA share extension — the iOS half of the intake contract Kotlin
/// implements in android/app/src/main/kotlin/.../MainActivity.kt.
///
/// An app extension is its own process with its own sandbox, so it cannot
/// talk to the Flutter engine. The hand-off is therefore two steps:
///  1. write the payload as JSON into the shared App Group container;
///  2. open the host app on `jara://share` so it comes forward and drains
///     the container (see docs/SHARE_INTAKE.md).
///
/// Payload, byte-identical to the Android channel map:
/// `{ "type": "text"|"url"|"image", "value": String, "extras": [String] }`
///
/// Deliberately not an `SLComposeServiceViewController`: JARA's capture
/// screen — title, tags, collection — lives in the app, and duplicating it
/// in a compose sheet would mean two designs to keep in step. This
/// controller shows nothing and gets out of the way.
final class ShareViewController: UIViewController {

    // MARK: - Contract constants (single source of truth: docs/SHARE_INTAKE.md)

    /// Must match the App Group capability enabled on BOTH targets.
    static let appGroupID = "group.com.jara.universalsearch"
    /// Must match CFBundleURLTypes in ios/Runner/Info.plist.
    static let hostURL = "jara://share"
    static let inboxFileName = "share_inbox.json"
    static let imageDirectoryName = "SharedImages"

    // Raw UTI strings rather than `UTType`: the app deploys to iOS 13 and
    // the UniformTypeIdentifiers framework starts at iOS 14.
    private static let imageUTI = "public.image"
    private static let urlUTI = "public.url"
    private static let textUTI = "public.plain-text"

    // MARK: - Collected payload

    private let group = DispatchGroup()
    /// Serialises the accumulators — `loadItem` completions land on
    /// arbitrary queues.
    private let sync = DispatchQueue(label: "app.jara.shareextension.sync")
    private var sharedText: String?
    private var sharedURL: URL?
    private var sharedSubject: String?
    private var imagePaths: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        collectAttachments()
    }

    // MARK: - Intake

    private func collectAttachments() {
        let items = (extensionContext?.inputItems as? [NSExtensionItem]) ?? []
        for item in items {
            // The item title is the page/document name most share sources
            // set — the Android side reads EXTRA_SUBJECT for the same job.
            if sharedSubject == nil,
                let title = item.attributedTitle?.string
                    .trimmingCharacters(in: .whitespacesAndNewlines),
                !title.isEmpty {
                sharedSubject = title
            }
            for provider in item.attachments ?? [] {
                load(provider)
            }
        }
        group.notify(queue: .main) { [weak self] in
            self?.finish()
        }
    }

    /// One attachment can advertise several types (a web page offers both
    /// a URL and text), so the checks are ordered by what JARA can do most
    /// with, and only the first match is loaded.
    private func load(_ provider: NSItemProvider) {
        if provider.hasItemConformingToTypeIdentifier(Self.imageUTI) {
            read(provider, Self.imageUTI) { [weak self] value in
                guard let self = self else { return }
                guard let path = self.persistImage(value) else { return }
                self.sync.sync { self.imagePaths.append(path) }
            }
            return
        }
        if provider.hasItemConformingToTypeIdentifier(Self.urlUTI) {
            read(provider, Self.urlUTI) { [weak self] value in
                guard let self = self, let url = value as? URL else { return }
                self.sync.sync {
                    if self.sharedURL == nil { self.sharedURL = url }
                }
            }
            return
        }
        if provider.hasItemConformingToTypeIdentifier(Self.textUTI) {
            read(provider, Self.textUTI) { [weak self] value in
                guard let self = self, let text = value as? String else {
                    return
                }
                self.sync.sync {
                    if self.sharedText == nil { self.sharedText = text }
                }
            }
        }
    }

    /// `loadItem` plus the DispatchGroup bookkeeping, in one place.
    private func read(
        _ provider: NSItemProvider,
        _ typeIdentifier: String,
        handler: @escaping (NSSecureCoding?) -> Void
    ) {
        group.enter()
        provider.loadItem(
            forTypeIdentifier: typeIdentifier,
            options: nil
        ) { [weak self] value, _ in
            handler(value)
            self?.group.leave()
        }
    }

    /// Copies the attachment into the App Group container and returns its
    /// path. The extension's own temporary files are unreadable from the
    /// host app's sandbox, so this copy is not optional.
    private func persistImage(_ value: NSSecureCoding?) -> String? {
        guard let value = value, let container = Self.containerURL() else {
            return nil
        }
        let directory =
            container.appendingPathComponent(Self.imageDirectoryName)
        try? FileManager.default.createDirectory(
            at: directory,
            withIntermediateDirectories: true
        )

        var data: Data?
        var fileExtension = "jpg"
        switch value {
        case let url as URL:
            data = try? Data(contentsOf: url)
            if !url.pathExtension.isEmpty { fileExtension = url.pathExtension }
        case let image as UIImage:
            data = image.jpegData(compressionQuality: 0.9)
        case let raw as Data:
            data = raw
        default:
            return nil
        }
        guard let bytes = data else { return nil }

        let destination = directory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension(fileExtension)
        do {
            try bytes.write(to: destination, options: .atomic)
        } catch {
            return nil
        }
        return destination.path
    }

    // MARK: - Hand-off

    private func finish() {
        if let payload = buildPayload() {
            write(payload)
            openHostApp()
        }
        extensionContext?.completeRequest(
            returningItems: nil,
            completionHandler: nil
        )
    }

    /// Images win over a URL, a URL wins over loose text — the same
    /// precedence the Android side applies to a mixed intent.
    private func buildPayload() -> [String: Any]? {
        if let first = imagePaths.first {
            return [
                "type": "image",
                "value": first,
                "extras": Array(imagePaths.dropFirst()),
                "subject": sharedSubject as Any,
            ]
        }
        if let url = sharedURL {
            let scheme = url.scheme?.lowercased()
            let isWeb = scheme == "http" || scheme == "https"
            return [
                "type": isWeb ? "url" : "text",
                "value": url.absoluteString,
                "extras": [String](),
                "subject": sharedSubject as Any,
            ]
        }
        let trimmed = sharedText?
            .trimmingCharacters(in: .whitespacesAndNewlines)
        if let text = trimmed, !text.isEmpty {
            // A plain-text share can still *be* a link.
            let url = URL(string: text)
            let scheme = url?.scheme?.lowercased()
            let isWeb = (scheme == "http" || scheme == "https")
                && !(url?.host?.isEmpty ?? true)
            return [
                "type": isWeb ? "url" : "text",
                "value": text,
                "extras": [String](),
                "subject": sharedSubject as Any,
            ]
        }
        return nil
    }

    /// One inbox file, last share wins. Two shares queued before the app
    /// is opened is a real (documented) limitation of this scaffold — a
    /// per-share file in an `inbox/` directory is the upgrade path.
    private func write(_ payload: [String: Any]) {
        guard let container = Self.containerURL(),
              let data = try? JSONSerialization.data(withJSONObject: payload)
        else { return }
        let destination = container.appendingPathComponent(Self.inboxFileName)
        try? data.write(to: destination, options: .atomic)
    }

    private static func containerURL() -> URL? {
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appGroupID
        )
    }

    /// `extensionContext.open(_:)` is documented as Today-widget only and
    /// returns false from a share extension, so the host app is opened by
    /// walking the responder chain to the UIApplication (UIApplication.shared
    /// is unavailable in extensions). This is the long-standing community
    /// approach, not blessed API — if Apple closes it the payload is still
    /// in the App Group and the app picks it up on next activation, which
    /// is why the JSON is written first.
    private func openHostApp() {
        guard let url = URL(string: Self.hostURL) else { return }
        let selector = NSSelectorFromString("openURL:")
        var responder: UIResponder? = self
        while let current = responder {
            if current.responds(to: selector) {
                _ = current.perform(selector, with: url)
                return
            }
            responder = current.next
        }
    }
}
