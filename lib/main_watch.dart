import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/data/prefs.dart';
import 'features/watch/watch_app.dart';

/// Wear OS entrypoint (D18). Build with
/// `flutter build apk -t lib/main_watch.dart`; the phone keeps
/// `lib/main.dart`. Same prefs bootstrap as the phone so every provider
/// that reads [prefsProvider] behaves identically on the wrist.
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
  runApp(ProviderScope(
    overrides: [prefsProvider.overrideWithValue(prefs)],
    child: const JaraWatchApp(),
  ));
}
