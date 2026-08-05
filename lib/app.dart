import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/data/providers.dart';
import 'core/data/share_intake.dart';
import 'core/design/jara_theme.dart';
import 'core/router/app_router.dart';
import 'core/widgets/adaptive_nav.dart';
import 'l10n/locales.dart';

class JaraApp extends ConsumerStatefulWidget {
  const JaraApp({super.key});

  @override
  ConsumerState<JaraApp> createState() => _JaraAppState();
}

class _JaraAppState extends ConsumerState<JaraApp> {
  StreamSubscription<SharedPayload>? _shares;

  @override
  void initState() {
    super.initState();
    // Above the router on purpose: a share can arrive on any route, and
    // the OS may deliver one before the first frame exists.
    final intake = ref.read(shareIntakeProvider);
    _shares = intake.shares.listen(_openCapture);
    unawaited(intake.initialShare().then((payload) {
      if (payload != null) _openCapture(payload);
    }));
  }

  @override
  void dispose() {
    _shares?.cancel();
    super.dispose();
  }

  /// The router builds `/share-capture` as `const ShareCaptureScreen()`,
  /// so the payload travels through [pendingShareProvider] instead of the
  /// route. Order matters: fill the mailbox, then navigate.
  ///
  /// A cold-start share replaces the splash route, and SplashScreen
  /// cancels its own hand-off timer in `dispose` — so its 1.2 s
  /// "go to /search" can no longer fire over the capture screen.
  void _openCapture(SharedPayload payload) {
    if (!mounted) return;
    ref.read(pendingShareProvider).value = payload;
    ref.read(appRouterProvider).go('/share-capture');
  }

  @override
  Widget build(BuildContext context) {
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
