import 'package:flutter/widgets.dart';

import '../../core/design/typography.dart';

/// Watch type scale, derived from [JaraType] so the Inter variable weight
/// axis stays paired with every FontWeight.
///
/// The phone scale assumes a steady two-hand grip at ~35 cm. A wrist is
/// glanced at, usually mid-motion, so the small end of the scale is what
/// fails first: every role at or below body steps up 1.15–1.2×, and the
/// metadata floor moves from caption 11 to 15. Titles carry over
/// unscaled — title2 at 22 is already 11% of a 192 dp face.
TextStyle _up(TextStyle base, double factor) =>
    base.copyWith(fontSize: base.fontSize! * factor);

abstract final class WatchType {
  /// Quiet wordmark above the mic. label 11 → 13, tracking kept.
  static final wordmark = _up(JaraType.label, 1.18);

  /// Section header over the recents list. label 11 → 13.
  static final section = _up(JaraType.label, 1.18);

  /// Detail and state titles. title2 22, unchanged.
  static final title = JaraType.title2;

  /// Result row title, two lines max. callout 15 → 17.
  static final rowTitle = _up(JaraType.callout, 1.15);

  /// Detail snippet and state body. body 16 → 18.
  static final body = _up(JaraType.body, 1.15);

  /// A recent search the wearer can re-run. subhead 14 → 17.
  static final recent = _up(JaraType.subhead, 1.2);

  /// The single metadata line under a row — the floor of the scale.
  static final meta = _up(JaraType.footnoteMedium, 1.15);

  /// Primary action label. button 16 → 17.
  static final action = _up(JaraType.button, 1.06);
}
