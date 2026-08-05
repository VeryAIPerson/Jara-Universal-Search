import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/data/providers.dart';
import 'core/design/jara_theme.dart';
import 'core/router/app_router.dart';
import 'core/widgets/adaptive_nav.dart';
import 'l10n/locales.dart';

class JaraApp extends ConsumerWidget {
  const JaraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'JARA Universal Search',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      // Above the Navigator so a shortcut still fires while a pushed page
      // or a sheet holds focus; the shell overrides the actions it can
      // answer better (branch switching, focusing its own search field).
      builder: (context, child) => Shortcuts(
        shortcuts: jaraShortcuts(),
        child: Actions(
          actions: jaraRootShortcutActions(router),
          child: child ?? const SizedBox.shrink(),
        ),
      ),
      themeMode: themeMode,
      theme: buildJaraTheme(Brightness.light),
      darkTheme: buildJaraTheme(Brightness.dark),
      locale: locale,
      supportedLocales: jaraSupportedLocales,
      // Flutter derives text direction from the locale, but only for the
      // tags its own delegates know. Resolving through our registry keeps
      // Arabic and Persian mirroring even when a device asks for a
      // regional variant we map by language tag alone.
      localeResolutionCallback: (device, supported) =>
          resolveJaraLocale(device ?? const Locale('en')).locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
