import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/data/providers.dart';
import '../../core/design/jara_theme.dart';
import 'watch_router.dart';

/// Wear OS shell (D18). Same providers, same repository, same copy deck
/// as the phone — only the surface changes.
class JaraWatchApp extends ConsumerWidget {
  const JaraWatchApp({super.key});

  /// Wear's own font-size setting can push text far past what a 192 dp
  /// face holds. Rows grow with their text rather than clipping it, but
  /// the ceiling keeps the mic and its label on one screen.
  static const _maxTextScale = 1.3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(watchRouterProvider);
    final locale = ref.watch(localeProvider);
    final theme = buildJaraTheme(Brightness.dark);

    return MaterialApp.router(
      title: 'JARA Universal Search',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      // Dark only: the neumorphic light hemisphere reads as mud on a
      // small OLED and costs battery on a device that has none to spare.
      themeMode: ThemeMode.dark,
      theme: theme,
      darkTheme: theme,
      locale: locale,
      supportedLocales: const [Locale('en'), Locale('tr')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        maxScaleFactor: _maxTextScale,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
