import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jara_universal_search/core/data/providers.dart';
import 'package:jara_universal_search/core/design/jara_theme.dart';
import 'package:jara_universal_search/features/collections/collections_screen.dart';
import 'package:jara_universal_search/features/memory/memory_screen.dart';
import 'package:jara_universal_search/features/search/search_home_screen.dart';
import 'package:jara_universal_search/features/search/search_results_screen.dart';

/// Golden net for the four signature screens × both themes (D16).
///
/// Deterministic by construction: the clock is pinned (morning greeting,
/// and the timeline lands on 15 AUG — the reference composition's date),
/// and the real bundled Inter renders instead of the test stub font, so
/// these bytes match what ships.
///
/// The images are rasterized on Linux; run them in CI or a container.
/// A macOS host shapes text differently and will diff — that is a host
/// difference, not a regression.
final _fixedNow = DateTime(2026, 8, 15, 9, 30);

Widget _host(Widget screen, Brightness brightness) {
  return ProviderScope(
    overrides: [
      clockProvider.overrideWithValue(() => _fixedNow),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildJaraTheme(brightness),
      // Tab screens live inside the shell's Scaffold in production; the
      // bare Scaffold here mirrors that without pulling in the nav chrome.
      home: Scaffold(body: screen),
    ),
  );
}

Future<void> _pumpSettled(WidgetTester tester, Widget app) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  // Post-frame seeding, the 260 ms mock search latency, then the staggered
  // card entrances (≤ 560 ms). Total stays under the 3.6 s hint rotation,
  // so the search field always shows the first hint.
  await tester.pump(const Duration(milliseconds: 50));
  await tester.pump(const Duration(milliseconds: 350));
  await tester.pump(const Duration(milliseconds: 700));
}

void main() {
  setUpAll(() async {
    final inter = FontLoader('Inter')
      ..addFont(rootBundle.load('assets/fonts/Inter-Variable.ttf'));
    await inter.load();

    // Icons must be pixels too, or every glyph regresses to a box and the
    // net stops covering them. flutter test always exports FLUTTER_ROOT.
    final root = Platform.environment['FLUTTER_ROOT'];
    final iconFont = File(
      '$root/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
    );
    if (!iconFont.existsSync()) {
      fail('MaterialIcons-Regular.otf not found under FLUTTER_ROOT — '
          'goldens would silently render boxes.');
    }
    final bytes = await iconFont.readAsBytes();
    final icons = FontLoader('MaterialIcons')
      ..addFont(Future.value(ByteData.view(bytes.buffer)));
    await icons.load();
  });

  final screens = <String, Widget Function()>{
    'search_home': () => const SearchHomeScreen(),
    'search_results': () => const SearchResultsScreen(
          initialQuery: 'voxbridge tts',
        ),
    'memory': () => const MemoryScreen(),
    'collections': () => const CollectionsScreen(),
  };

  for (final MapEntry(key: name, value: build) in screens.entries) {
    for (final brightness in Brightness.values) {
      final theme = brightness == Brightness.dark ? 'dark' : 'light';
      testWidgets('$name · $theme', (tester) async {
        await _pumpSettled(tester, _host(build(), brightness));
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/${name}_$theme.png'),
        );
      });
    }
  }
}
