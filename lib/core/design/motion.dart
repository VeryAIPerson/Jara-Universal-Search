import 'package:flutter/widgets.dart';

/// Motion tokens — every animation in the app uses these.
/// Fast by default: motion must never slow the path to a result.
abstract final class JaraMotion {
  static const instant = Duration(milliseconds: 80);
  static const fast = Duration(milliseconds: 120);
  static const base = Duration(milliseconds: 200);
  static const gentle = Duration(milliseconds: 320);
  static const slow = Duration(milliseconds: 480);

  static const standard = Curves.easeOutCubic;
  static const emphasized = Curves.easeInOutCubic;
  static const enter = Curves.easeOutQuart;
  static const spring = Curves.easeOutBack;

  /// Per-card stagger for search results.
  static const stagger = Duration(milliseconds: 40);

  /// Honors the OS "reduce motion" setting.
  static bool reduced(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  static Duration of(BuildContext context, Duration d) =>
      reduced(context) ? Duration.zero : d;
}
