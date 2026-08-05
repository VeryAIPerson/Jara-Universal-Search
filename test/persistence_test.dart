import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jara_universal_search/core/data/prefs.dart';
import 'package:jara_universal_search/core/data/providers.dart';
import 'package:jara_universal_search/l10n/locales.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Same shape as main(): prefs overridden, nothing else bootstrapped yet —
/// each test calls the bootstrap function(s) it means to exercise.
Future<ProviderContainer> _containerWith(Map<String, Object> stored) async {
  SharedPreferences.setMockInitialValues(stored);
  final prefs = await JaraPrefs.create();
  final container =
      ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
  addTearDown(container.dispose);
  return container;
}

/// A fresh container over the same prefs instance as [old] — simulates
/// relaunching the app without losing whatever was on disk.
ProviderContainer _relaunch(ProviderContainer old) {
  final container = ProviderContainer(
    overrides: [prefsProvider.overrideWithValue(old.read(prefsProvider))],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  // bootstrapThemeAndLocale falls back to WidgetsBinding's platform locale,
  // so every test below needs a binding even though none of them pump a
  // widget.
  TestWidgetsFlutterBinding.ensureInitialized();
  tearDown(
    () => TestWidgetsFlutterBinding.instance.platformDispatcher
        .clearLocaleTestValue(),
  );

  group('JaraPrefs accessors', () {
    test('theme, locale tag, recents and pin sets round-trip', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await JaraPrefs.create();

      expect(prefs.themeMode, isNull);
      await prefs.setThemeMode(ThemeMode.light);
      expect(prefs.themeMode, ThemeMode.light);

      expect(prefs.localeTag, isNull);
      await prefs.setLocaleTag('pt-BR');
      expect(prefs.localeTag, 'pt-BR');

      expect(prefs.recentSearches, isNull);
      await prefs.setRecentSearches(['a', 'b']);
      expect(prefs.recentSearches, ['a', 'b']);

      expect(prefs.pinnedIds, isNull);
      expect(prefs.unpinnedIds, isNull);
      await prefs.setPinnedIds({'x'});
      await prefs.setUnpinnedIds({'y'});
      expect(prefs.pinnedIds, {'x'});
      expect(prefs.unpinnedIds, {'y'});
    });

    test('recentSearches caps both the write and the read at 6', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await JaraPrefs.create();
      await prefs.setRecentSearches(['1', '2', '3', '4', '5', '6', '7']);
      expect(prefs.recentSearches, ['1', '2', '3', '4', '5', '6']);
    });
  });

  group('locale tag serialize/parse', () {
    test('round-trips every shipped tag shape', () {
      const cases = {
        'en': Locale('en'),
        'tr': Locale('tr'),
        'zh-Hant': Locale('zh', 'Hant'),
        'zh-Hans': Locale('zh', 'Hans'),
        'pt-BR': Locale('pt', 'BR'),
        'ar': Locale('ar'),
      };
      for (final MapEntry(key: tag, value: locale) in cases.entries) {
        expect(serializeLocaleTag(locale), tag, reason: tag);
        expect(parseLocaleTag(tag), locale, reason: tag);
      }
    });

    test('round-trips a genuine script+region device tag', () {
      const locale = Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hant',
        countryCode: 'TW',
      );
      expect(parseLocaleTag(serializeLocaleTag(locale)), locale);
    });

    test('every shipped JaraLocale round-trips', () {
      for (final entry in jaraLocales) {
        final tag = serializeLocaleTag(entry.locale);
        expect(parseLocaleTag(tag), entry.locale, reason: entry.endonym);
      }
    });
  });

  group('theme persistence', () {
    test('first run keeps ThemeMode.dark and stores nothing', () async {
      final container = await _containerWith({});
      bootstrapThemeAndLocale(container);
      expect(container.read(themeModeProvider), ThemeMode.dark);
      expect(container.read(prefsProvider).themeMode, isNull);
    });

    test('an explicit pick survives a relaunch', () async {
      final container = await _containerWith({});
      bootstrapThemeAndLocale(container);
      container.read(themeModeProvider.notifier).state = ThemeMode.light;
      expect(container.read(prefsProvider).themeMode, ThemeMode.light);

      final relaunched = _relaunch(container);
      bootstrapThemeAndLocale(relaunched);
      expect(relaunched.read(themeModeProvider), ThemeMode.light);
    });
  });

  group('locale persistence', () {
    test('follows the device locale when nothing is stored', () async {
      TestWidgetsFlutterBinding.instance.platformDispatcher.localeTestValue =
          const Locale('tr');
      final container = await _containerWith({});
      bootstrapThemeAndLocale(container);
      expect(container.read(localeProvider), const Locale('tr'));
      // The fallback itself must not be written back as an explicit pick —
      // otherwise the app would stop following the device after one launch.
      expect(container.read(prefsProvider).localeTag, isNull);
    });

    test('an explicit pick wins over the device and survives a relaunch',
        () async {
      TestWidgetsFlutterBinding.instance.platformDispatcher.localeTestValue =
          const Locale('en');
      final container = await _containerWith({});
      bootstrapThemeAndLocale(container);
      container.read(localeProvider.notifier).state =
          const Locale('pt', 'BR');
      expect(container.read(prefsProvider).localeTag, 'pt-BR');

      // Device now claims Turkish; the stored pick still wins.
      TestWidgetsFlutterBinding.instance.platformDispatcher.localeTestValue =
          const Locale('tr');
      final relaunched = _relaunch(container);
      bootstrapThemeAndLocale(relaunched);
      expect(relaunched.read(localeProvider), const Locale('pt', 'BR'));
    });
  });

  group('recent searches persistence', () {
    test('first run keeps the 4-item demo seed', () async {
      final container = await _containerWith({});
      bootstrapMemoryPersistence(container);
      final repo = container.read(memoryRepositoryProvider);
      expect(repo.recentSearches, hasLength(4));
      expect(repo.recentSearches.first, 'VoxBridge pricing');
    });

    test('a memoryRevisionProvider bump writes the list through', () async {
      final container = await _containerWith({});
      bootstrapMemoryPersistence(container);
      final repo = container.read(memoryRepositoryProvider);

      // Mirrors the insert-then-bump convention in search_home_screen.dart
      // and search_results_screen.dart.
      repo.recentSearches.insert(0, 'new query');
      container.read(memoryRevisionProvider.notifier).state++;

      expect(
        container.read(prefsProvider).recentSearches!.first,
        'new query',
      );
    });

    test('restores on a fresh repository construction, capped at 6',
        () async {
      final container = await _containerWith({
        'recent_searches': ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
      });
      bootstrapMemoryPersistence(container);
      final repo = container.read(memoryRepositoryProvider);
      expect(repo.recentSearches, ['a', 'b', 'c', 'd', 'e', 'f']);
    });
  });

  group('pin persistence', () {
    test('first run keeps the seed pin (doc-vox-pricing only)', () async {
      final container = await _containerWith({});
      bootstrapMemoryPersistence(container);
      final repo = container.read(memoryRepositoryProvider);
      expect(repo.pinned().map((i) => i.id), ['doc-vox-pricing']);
    });

    test('restores a pin added on top of the seed', () async {
      final container = await _containerWith({
        'pinned_ids': ['note-tts-compare'],
      });
      bootstrapMemoryPersistence(container);
      final repo = container.read(memoryRepositoryProvider);
      expect(
        repo.pinned().map((i) => i.id).toSet(),
        {'doc-vox-pricing', 'note-tts-compare'},
      );
    });

    test('restores an explicit unpin of a default-pinned seed item',
        () async {
      final container = await _containerWith({
        'unpinned_ids': ['doc-vox-pricing'],
      });
      bootstrapMemoryPersistence(container);
      final repo = container.read(memoryRepositoryProvider);
      expect(repo.byId('doc-vox-pricing')!.pinned, isFalse);
    });

    test('a pin change round-trips through a fresh construction', () async {
      final container = await _containerWith({});
      bootstrapMemoryPersistence(container);
      final repo = container.read(memoryRepositoryProvider);

      repo.togglePin('note-tts-compare'); // pin an extra item
      repo.togglePin('doc-vox-pricing'); // unpin the seed default
      container.read(memoryRevisionProvider.notifier).state++;

      final relaunched = _relaunch(container);
      bootstrapMemoryPersistence(relaunched);
      final restored = relaunched.read(memoryRepositoryProvider);
      expect(restored.byId('note-tts-compare')!.pinned, isTrue);
      expect(restored.byId('doc-vox-pricing')!.pinned, isFalse);
    });
  });

  test('first-run defaults: dark theme, demo recents, seed pins', () async {
    TestWidgetsFlutterBinding.instance.platformDispatcher.localeTestValue =
        const Locale('en');
    final container = await _containerWith({});
    bootstrapThemeAndLocale(container);
    bootstrapMemoryPersistence(container);

    expect(container.read(themeModeProvider), ThemeMode.dark);
    expect(container.read(localeProvider), const Locale('en'));
    final repo = container.read(memoryRepositoryProvider);
    expect(repo.recentSearches, hasLength(4));
    expect(repo.pinned().map((i) => i.id), ['doc-vox-pricing']);
  });
}
