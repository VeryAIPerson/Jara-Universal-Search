import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// What the OS handed us. `url` is a text share whose whole payload is an
/// http(s) URI — the platform side makes that call, so Kotlin, Swift and
/// Dart can never disagree about which kind a share is.
enum SharedPayloadType { text, url, image }

/// One share, already classified by the platform.
///
/// Wire shape (identical on both platforms):
/// `{ "type": "text"|"url"|"image", "value": String, "extras": [String] }`
///
/// [value] is the text, the URL, or the first image URI; [extras] carries
/// the remaining image URIs of a multi-image share and is empty otherwise.
/// Image URIs are never read here — bytes stay on the platform side until
/// the real indexer exists.
@immutable
class SharedPayload {
  const SharedPayload({
    required this.type,
    required this.value,
    this.extras = const [],
  });

  /// Decodes the platform map, or null if anything is missing or the wrong
  /// shape. A malformed share must be dropped, never thrown — it arrives
  /// from another app's code, so it is untrusted input.
  static SharedPayload? fromMap(Map<Object?, Object?>? map) {
    if (map == null) return null;
    final type = _typeOf(map['type']);
    final value = map['value'];
    if (type == null || value is! String || value.trim().isEmpty) return null;
    final extras = (map['extras'] as List<Object?>?)
            ?.whereType<String>()
            .where((e) => e.trim().isNotEmpty)
            .toList(growable: false) ??
        const <String>[];
    return SharedPayload(type: type, value: value.trim(), extras: extras);
  }

  static SharedPayloadType? _typeOf(Object? raw) => switch (raw) {
        'text' => SharedPayloadType.text,
        'url' => SharedPayloadType.url,
        'image' => SharedPayloadType.image,
        _ => null,
      };

  final SharedPayloadType type;
  final String value;
  final List<String> extras;

  /// Images in this share (1 for every non-image type).
  int get itemCount => 1 + extras.length;

  List<String> get values => [value, ...extras];

  /// Title JARA proposes in the capture form. Null for images: there is no
  /// text to derive one from, so the screen names those from the copy deck.
  String? get suggestedTitle => switch (type) {
        SharedPayloadType.url => _urlTitle(),
        SharedPayloadType.text => _textTitle(),
        SharedPayloadType.image => null,
      };

  /// Host + last path segment — "voxbridge.app/pricing". Nothing is
  /// fetched: a title from the page itself would need the network, which
  /// the local-first promise does not spend on a share.
  String _urlTitle() {
    final uri = Uri.tryParse(value);
    if (uri == null || uri.host.isEmpty) return value;
    final host =
        uri.host.startsWith('www.') ? uri.host.substring(4) : uri.host;
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    return segments.isEmpty ? host : '$host/${segments.last}';
  }

  String _textTitle() {
    final firstLine = value
        .split(RegExp(r'\r?\n'))
        .map((l) => l.trim())
        .firstWhere((l) => l.isNotEmpty, orElse: () => value.trim());
    final collapsed = firstLine.replaceAll(RegExp(r'\s+'), ' ');
    return collapsed.length <= _titleCap
        ? collapsed
        : '${collapsed.substring(0, _titleCap).trimRight()}…';
  }

  static const _titleCap = 60;

  /// Tags JARA can honestly derive without an index pass: a link gives up
  /// its host and section, text and images give up nothing.
  List<String> get suggestedTags {
    if (type != SharedPayloadType.url) return const [];
    final uri = Uri.tryParse(value);
    if (uri == null || uri.host.isEmpty) return const [];
    final host =
        uri.host.startsWith('www.') ? uri.host.substring(4) : uri.host;
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    return [
      host.toLowerCase(),
      if (segments.isNotEmpty) segments.first.toLowerCase(),
    ];
  }
}

/// Bridge to the OS share sheet — the product promise "share from any app
/// into JARA" lands here.
///
/// Two deliveries, one payload shape:
/// * **cold start** — the intent already sat on the Activity before Dart
///   booted, so the platform parks it and Dart pulls it once with
///   [initialShare];
/// * **warm** — the app is already running, the platform pushes over
///   [shares].
///
/// [channel] is injectable so tests can drive both paths without a host.
class ShareIntake {
  ShareIntake({MethodChannel? channel})
      : _channel = channel ?? const MethodChannel(channelName) {
    _channel.setMethodCallHandler(_handleCall);
  }

  static const String channelName = 'jara/share_intake';

  final MethodChannel _channel;
  final StreamController<SharedPayload> _warm =
      StreamController<SharedPayload>.broadcast();

  /// Shares that arrive while the app is alive.
  Stream<SharedPayload> get shares => _warm.stream;

  /// The share that launched this session, consumed exactly once. Null on
  /// a normal launch — and on every host without the intake (desktop, web,
  /// widget tests), where the channel simply has no handler.
  Future<SharedPayload?> initialShare() async {
    try {
      final raw = await _channel
          .invokeMethod<Map<Object?, Object?>>('getInitialShare');
      return SharedPayload.fromMap(raw);
    } on MissingPluginException {
      return null;
    } on PlatformException {
      return null;
    }
  }

  Future<void> _handleCall(MethodCall call) async {
    if (call.method != 'onShare' || _warm.isClosed) return;
    final payload =
        SharedPayload.fromMap(call.arguments as Map<Object?, Object?>?);
    if (payload != null) _warm.add(payload);
  }

  void dispose() {
    _channel.setMethodCallHandler(null);
    _warm.close();
  }
}

final shareIntakeProvider = Provider<ShareIntake>((ref) {
  final intake = ShareIntake();
  ref.onDispose(intake.dispose);
  return intake;
});

/// Hand-off between [ShareIntake] (owned by the app widget) and the share
/// capture screen.
///
/// The router builds `/share-capture` as `const ShareCaptureScreen()` and
/// the router is not ours to change, so the payload cannot travel as a
/// constructor argument or a route parameter. `app.dart` fills this
/// notifier immediately *before* navigating; the screen takes the value
/// once in `initState` via [PendingShare.take] and clears it, so the same
/// route opened later from the demo entry point shows the mock again.
///
/// A plain [ValueNotifier] behind a provider rather than a StateProvider:
/// nothing rebuilds on it, it is a one-shot mailbox, and tests can seed it
/// with `pendingShareProvider.overrideWithValue(ValueNotifier(payload))`.
final pendingShareProvider = Provider<ValueNotifier<SharedPayload?>>((ref) {
  final notifier = ValueNotifier<SharedPayload?>(null);
  ref.onDispose(notifier.dispose);
  return notifier;
});

extension PendingShare on ValueNotifier<SharedPayload?> {
  /// Reads and clears in one step — a share is consumed by exactly one
  /// screen instance.
  SharedPayload? take() {
    final payload = value;
    value = null;
    return payload;
  }
}

// TODO(ios): read side of the iOS hand-off. The share extension
// (ios/ShareExtension/ShareViewController.swift) writes the same
// `{type,value,extras}` JSON into the App Group container
// `group.com.jara.universalsearch` and then opens `jara://share`. Picking
// it up needs, on a real machine:
//   1. the App Group entitlement on BOTH targets (Runner + ShareExtension)
//      — ios/Runner/Runner.entitlements does not exist yet, Xcode creates
//      it when the capability is added;
//   2. a Swift MethodChannel in ios/Runner/AppDelegate.swift on
//      `jara/share_intake`, answering `getInitialShare` and pushing
//      `onShare` on `applicationDidBecomeActive` — the same two methods
//      Kotlin answers, so nothing in this file changes.
// Left as a TODO rather than half-written: an entitlement cannot be added
// from files alone, and code that silently reads nothing is worse than
// code that is honestly absent. See docs/SHARE_INTAKE.md.
