import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

import 'tokens.dart';
import 'typography.dart';

/// Builds the Material theme skinned with Lamplight tokens.
/// Components read [JaraTokens] via `context.jara`; ThemeData exists so
/// Material widgets (sheets, dialogs, ink) blend in.
ThemeData buildJaraTheme(Brightness brightness) {
  final t = brightness == Brightness.dark ? JaraTokens.dark : JaraTokens.light;

  final colorScheme = ColorScheme(
    brightness: brightness,
    primary: t.accent,
    onPrimary: Colors.white,
    secondary: t.violet,
    onSecondary: Colors.white,
    error: t.error,
    onError: Colors.white,
    surface: t.surface,
    onSurface: t.textPrimary,
    surfaceContainerHighest: t.surfaceElevated,
    outline: t.border,
  );

  final textTheme = TextTheme(
    displaySmall: JaraType.display,
    headlineMedium: JaraType.title1,
    headlineSmall: JaraType.title2,
    titleMedium: JaraType.headline,
    bodyLarge: JaraType.body,
    bodyMedium: JaraType.subhead,
    bodySmall: JaraType.footnote,
    labelLarge: JaraType.button,
    labelSmall: JaraType.caption,
  ).apply(bodyColor: t.textPrimary, displayColor: t.textPrimary);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: t.surface,
    fontFamily: 'Inter',
    textTheme: textTheme,
    splashFactory: InkSparkle.splashFactory,
    highlightColor: Colors.transparent,
    dividerTheme: DividerThemeData(color: t.border, thickness: 1, space: 1),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: t.surfaceElevated,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(JaraRadius.sheet)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: t.isDark ? JaraPalette.elevatedDark : JaraPalette.ink,
      contentTextStyle: JaraType.callout.copyWith(color: JaraPalette.textOnDark),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
    }),
    extensions: [t],
  );
}

extension JaraContext on BuildContext {
  JaraTokens get jara => Theme.of(this).extension<JaraTokens>()!;
}
