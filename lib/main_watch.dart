import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/data/prefs.dart';
import 'core/data/providers.dart';
import 'features/watch/watch_app.dart';

/// Wear OS entrypoint (D18). Build with
/// `flutter build apk --flavor wear -t lib/main_watch.dart`; the phone
/// keeps `lib/main.dart`. Runs the SAME bootstraps as the phone: the
/// wrist shows recents and pins, and speaks the wearer's language —
/// the watch app itself force-dark-themes, so the seeded theme is
/// simply unused there.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  final prefs = await JaraPrefs.create();
  final container = ProviderContainer(
    overrides: [prefsProvider.overrideWithValue(prefs)],
  );
  bootstrapThemeAndLocale(container);
  bootstrapMemoryPersistence(container);
  runApp(UncontrolledProviderScope(
    container: container,
    child: const JaraWatchApp(),
  ));
}
