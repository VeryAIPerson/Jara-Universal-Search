import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/data/prefs.dart';
import 'core/data/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // Loaded once before runApp so screens can read prefs synchronously.
  final prefs = await JaraPrefs.create();
  // A plain ProviderContainer instead of ProviderScope(overrides: [...])
  // so the bootstrap calls below can seed providers from prefs before the
  // first frame; UncontrolledProviderScope then exposes it to the widget
  // tree exactly like ProviderScope would.
  final container = ProviderContainer(
    overrides: [prefsProvider.overrideWithValue(prefs)],
  );
  bootstrapThemeAndLocale(container);
  bootstrapMemoryPersistence(container);
  runApp(UncontrolledProviderScope(
    container: container,
    child: const JaraApp(),
  ));
}
