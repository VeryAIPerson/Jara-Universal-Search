import 'package:flutter/material.dart';

/// JARA "Lamplight" design tokens.
///
/// The visual signature is a dual-hemisphere layout: a deep "memory sky"
/// panel and a soft neumorphic "surface" panel separated by an S-curve
/// horizon. Light theme reproduces the reference look (dark top, lavender
/// bottom); dark theme keeps the split as two-tone dark.
abstract final class JaraPalette {
  // Brand family (locked upstream in jara-premium-prototype).
  static const gold = Color(0xFFD4AF6E);
  static const goldBright = Color(0xFFF1CE88);
  static const goldOnLight = Color(0xFFA98530);

  // Universal Search product accent.
  static const primary = Color(0xFF5B7CFA); // electric indigo
  static const primaryBright = Color(0xFF7AA8FF); // kinship with Voxbridge sky
  static const violet = Color(0xFF836BFF);
  static const primaryOnLight = Color(0xFF4156D6);

  // Memory sky (dark hemisphere).
  static const void_ = Color(0xFF080A0F);
  static const skyDeep = Color(0xFF0D1220);
  static const surfaceDark = Color(0xFF11141C);
  static const elevatedDark = Color(0xFF171B25);
  static const tileDark = Color(0xFF1A1F2B);

  // Soft surface (light hemisphere).
  static const mist = Color(0xFFE9ECF5); // lavender mist background
  static const surfaceLight = Color(0xFFF1F3FA);
  static const tileLight = Color(0xFFEDF0F8);
  static const neuShadowLight = Color(0xFFA6B1D2);

  // Ink.
  static const textOnDark = Color(0xFFF5F7FF);
  static const textOnDarkSecondary = Color(0xFFA6ADBE);
  static const textOnDarkTertiary = Color(0xFF707892);
  static const ink = Color(0xFF171B2C);
  static const inkSecondary = Color(0xFF5B6378);
  static const inkTertiary = Color(0xFF8B92A8);

  // Status.
  static const success = Color(0xFF4CC38A);
  static const warning = Color(0xFFE8B04B);
  static const error = Color(0xFFE5595E);

  // Source-type identities (soft, one hue per content source).
  static const srcDocument = Color(0xFFF5A25B);
  static const srcPhoto = Color(0xFF56C2E6);
  static const srcScreenshot = Color(0xFF7AA8FF);
  static const srcNote = Color(0xFFF2C94C);
  static const srcLink = Color(0xFF64D2B4);
  static const srcAudio = Color(0xFFEF8BA8);
  static const srcCalendar = Color(0xFF836BFF);
  static const srcEmail = Color(0xFF5B7CFA);
  static const srcChat = Color(0xFFB48BEF);
}

abstract final class JaraSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;
  static const double page = 20; // default horizontal page inset
}

abstract final class JaraRadius {
  static const double chip = 12;
  static const double field = 22;
  static const double card = 20;
  static const double tile = 26;
  static const double sheet = 28;
  static const double bar = 28;
}

abstract final class JaraSize {
  static const double touchMin = 44;
  static const double searchFieldHeight = 58;
  static const double fab = 64;
  static const double bottomBar = 72;
  static const double avatarNotch = 52;
}

/// Semantic colors resolved per brightness, exposed as a ThemeExtension.
class JaraTokens extends ThemeExtension<JaraTokens> {
  const JaraTokens({
    required this.brightness,
    required this.skyTop,
    required this.skyBottom,
    required this.surface,
    required this.surfaceElevated,
    required this.tile,
    required this.tileOnSky,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textOnSky,
    required this.textOnSkySecondary,
    required this.textOnSkyTertiary,
    required this.accent,
    required this.accentBright,
    required this.violet,
    required this.gold,
    required this.border,
    required this.borderOnSky,
    required this.success,
    required this.warning,
    required this.error,
    required this.neuShadowDark,
    required this.neuShadowLight,
    required this.scrim,
  });

  final Brightness brightness;

  /// Dark hemisphere ("memory sky") gradient ends — dark in both themes.
  final Color skyTop;
  final Color skyBottom;

  /// Light hemisphere surface + cards.
  final Color surface;
  final Color surfaceElevated;
  final Color tile;
  final Color tileOnSky;

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textOnSky;
  final Color textOnSkySecondary;
  final Color textOnSkyTertiary;

  final Color accent;
  final Color accentBright;
  final Color violet;
  final Color gold;

  final Color border;
  final Color borderOnSky;

  final Color success;
  final Color warning;
  final Color error;

  final Color neuShadowDark;
  final Color neuShadowLight;
  final Color scrim;

  bool get isDark => brightness == Brightness.dark;

  LinearGradient get skyGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [skyTop, skyBottom],
      );

  LinearGradient get accentGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [accent, violet],
      );

  /// Soft dual shadow for neumorphic tiles on the light hemisphere.
  List<BoxShadow> get neuShadows => isDark
      ? [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.45),
            offset: const Offset(5, 6),
            blurRadius: 16,
          ),
          BoxShadow(
            color: const Color(0xFFFFFFFF).withValues(alpha: 0.03),
            offset: const Offset(-3, -3),
            blurRadius: 10,
          ),
        ]
      : [
          BoxShadow(
            color: neuShadowDark.withValues(alpha: 0.55),
            offset: const Offset(6, 7),
            blurRadius: 18,
          ),
          const BoxShadow(
            color: Color(0xFFFFFFFF),
            offset: Offset(-6, -6),
            blurRadius: 16,
          ),
        ];

  List<BoxShadow> get accentGlow => [
        BoxShadow(
          color: accent.withValues(alpha: isDark ? 0.45 : 0.35),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static const dark = JaraTokens(
    brightness: Brightness.dark,
    skyTop: JaraPalette.skyDeep,
    skyBottom: JaraPalette.void_,
    surface: JaraPalette.surfaceDark,
    surfaceElevated: JaraPalette.elevatedDark,
    tile: JaraPalette.tileDark,
    tileOnSky: JaraPalette.surfaceDark,
    textPrimary: JaraPalette.textOnDark,
    textSecondary: JaraPalette.textOnDarkSecondary,
    textTertiary: JaraPalette.textOnDarkTertiary,
    textOnSky: JaraPalette.textOnDark,
    textOnSkySecondary: JaraPalette.textOnDarkSecondary,
    textOnSkyTertiary: JaraPalette.textOnDarkTertiary,
    accent: JaraPalette.primary,
    accentBright: JaraPalette.primaryBright,
    violet: JaraPalette.violet,
    gold: JaraPalette.gold,
    border: Color(0x14FFFFFF),
    borderOnSky: Color(0x14FFFFFF),
    success: JaraPalette.success,
    warning: JaraPalette.warning,
    error: JaraPalette.error,
    neuShadowDark: Color(0xFF000000),
    neuShadowLight: Color(0xFFFFFFFF),
    scrim: Color(0xB3080A0F),
  );

  static const light = JaraTokens(
    brightness: Brightness.light,
    skyTop: JaraPalette.skyDeep,
    skyBottom: JaraPalette.void_,
    surface: JaraPalette.mist,
    surfaceElevated: JaraPalette.surfaceLight,
    tile: JaraPalette.tileLight,
    tileOnSky: JaraPalette.surfaceDark,
    textPrimary: JaraPalette.ink,
    textSecondary: JaraPalette.inkSecondary,
    textTertiary: JaraPalette.inkTertiary,
    textOnSky: JaraPalette.textOnDark,
    textOnSkySecondary: JaraPalette.textOnDarkSecondary,
    textOnSkyTertiary: JaraPalette.textOnDarkTertiary,
    accent: JaraPalette.primary,
    accentBright: JaraPalette.primaryBright,
    violet: JaraPalette.violet,
    gold: JaraPalette.goldOnLight,
    border: Color(0x1F2A3355),
    borderOnSky: Color(0x14FFFFFF),
    success: JaraPalette.success,
    warning: JaraPalette.warning,
    error: JaraPalette.error,
    neuShadowDark: JaraPalette.neuShadowLight,
    neuShadowLight: Color(0xFFFFFFFF),
    scrim: Color(0x66171B2C),
  );

  @override
  JaraTokens copyWith() => this;

  @override
  JaraTokens lerp(ThemeExtension<JaraTokens>? other, double t) =>
      t < 0.5 ? this : (other as JaraTokens? ?? this);
}
