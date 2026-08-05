import 'package:flutter/widgets.dart';

/// Inter variable font is bundled; Flutter needs the wght axis set
/// explicitly for variable fonts, so every style pairs FontWeight with
/// a matching FontVariation.
List<FontVariation> _wght(double w) => [FontVariation('wght', w)];

TextStyle _inter(
  double size,
  double weight, {
  double? height,
  double spacing = 0,
}) =>
    TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      fontWeight: FontWeight.values[(weight ~/ 100) - 1],
      fontVariations: _wght(weight),
      height: height,
      letterSpacing: spacing,
    );

/// Type scale. Color is applied at use-site from JaraTokens.
abstract final class JaraType {
  static final display = _inter(34, 700, height: 1.15, spacing: -0.5);
  static final title1 = _inter(28, 700, height: 1.2, spacing: -0.4);
  static final title2 = _inter(22, 600, height: 1.25, spacing: -0.2);
  static final headline = _inter(17, 600, height: 1.3);
  static final body = _inter(16, 400, height: 1.45);
  static final bodyMedium = _inter(16, 500, height: 1.45);
  static final callout = _inter(15, 500, height: 1.35);
  static final subhead = _inter(14, 400, height: 1.4);
  static final footnote = _inter(13, 400, height: 1.35);
  static final footnoteMedium = _inter(13, 500, height: 1.35);
  static final caption = _inter(11, 500, height: 1.3, spacing: 0.2);
  static final label = _inter(11, 600, height: 1.2, spacing: 0.8);
  static final button = _inter(16, 600, height: 1.2);
}
