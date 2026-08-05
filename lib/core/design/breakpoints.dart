import 'package:flutter/widgets.dart';

/// Device classes JARA adapts to. Follows the Material 3 window-size
/// classes, plus a `watch` class below them for Wear OS.
///
/// The Horizon signature behaves differently per class — see
/// [HorizonAxis]: phones keep the horizontal S-curve, anything wider
/// rotates it into a vertical divider so the brand mark survives at
/// desktop width instead of stretching into a flat line.
enum WindowClass {
  /// Wear OS. ~192–227 dp. No nav chrome, voice-first, one screen.
  watch,

  /// Phones portrait. < 600 dp.
  compact,

  /// Large phones landscape, small tablets, unfolded foldables. 600–839.
  medium,

  /// Tablets, half-screen desktop windows. 840–1199.
  expanded,

  /// Desktop. >= 1200.
  large;

  bool get isWatch => this == watch;
  bool get isPhone => this == compact;

  /// Anything that should show a rail/sidebar instead of a bottom bar.
  bool get usesRail => index >= medium.index;

  /// Anything wide enough to show list + detail side by side.
  bool get usesTwoPane => index >= expanded.index;

  /// Rail is labelled rather than icon-only.
  bool get usesExtendedRail => index >= large.index;
}

/// Which way the Horizon divider runs.
enum HorizonAxis {
  /// Sky on top, surface below, S-curve horizontal. Phones.
  horizontal,

  /// Sky as a left command column, surface right, S-curve vertical.
  /// Tablets and desktop.
  vertical,

  /// No split — the screen is too small to carry two hemispheres.
  none,
}

abstract final class JaraBreakpoints {
  static const double watchMax = 320;
  static const double compactMax = 600;
  static const double mediumMax = 840;
  static const double expandedMax = 1200;

  /// Content never stretches past this; wide windows gain margin, not
  /// longer line lengths.
  static const double contentMaxWidth = 1320;

  /// Reading column cap for detail/settings panes (~65 characters).
  static const double proseMaxWidth = 680;

  /// Width of the command column when the Horizon is vertical.
  static const double skyColumnWidth = 380;

  /// A HorizonScaffold narrower than this lays out like a phone even on a
  /// wide window — a two-pane branch pane is phone-sized, and forcing the
  /// vertical column into it starves both hemispheres.
  static const double horizonVerticalMin = 700;

  static const double railWidth = 88;
  static const double railExtendedWidth = 232;

  /// Desktop windows below this get the compact (phone) layout.
  static const Size desktopMinimum = Size(420, 640);

  static WindowClass of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);

  static WindowClass fromWidth(double width) {
    if (width < watchMax) return WindowClass.watch;
    if (width < compactMax) return WindowClass.compact;
    if (width < mediumMax) return WindowClass.medium;
    if (width < expandedMax) return WindowClass.expanded;
    return WindowClass.large;
  }

  static HorizonAxis axisFor(WindowClass w) => switch (w) {
        WindowClass.watch => HorizonAxis.none,
        WindowClass.compact => HorizonAxis.horizontal,
        _ => HorizonAxis.vertical,
      };

  /// Page inset scales with the window; phones keep the signed-off 20.
  static double pageInsetFor(WindowClass w) => switch (w) {
        WindowClass.watch => 10,
        WindowClass.compact => 20,
        WindowClass.medium => 28,
        WindowClass.expanded => 32,
        WindowClass.large => 40,
      };

  /// Source-tile / collection grid columns.
  static int gridColumnsFor(WindowClass w) => switch (w) {
        WindowClass.watch => 1,
        WindowClass.compact => 3,
        WindowClass.medium => 4,
        WindowClass.expanded => 5,
        WindowClass.large => 6,
      };
}

extension WindowClassContext on BuildContext {
  WindowClass get windowClass => JaraBreakpoints.of(this);
  HorizonAxis get horizonAxis =>
      JaraBreakpoints.axisFor(JaraBreakpoints.of(this));
}
