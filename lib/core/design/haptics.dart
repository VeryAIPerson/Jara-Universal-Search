import 'package:flutter/services.dart';

/// Central haptic map — keep feedback consistent and sparse.
abstract final class JaraHaptics {
  /// Any tappable card/tile/button press.
  static void tap() => HapticFeedback.lightImpact();

  /// Chip toggles, segmented switches, timeline day change.
  static void select() => HapticFeedback.selectionClick();

  /// Pin, save-to-memory, connect success.
  static void confirm() => HapticFeedback.mediumImpact();

  /// Destructive confirm (delete from memory).
  static void heavy() => HapticFeedback.heavyImpact();
}
