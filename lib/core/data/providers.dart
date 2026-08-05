import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/locales.dart';
import '../models/memory_item.dart';
import 'connectivity_service.dart';
import 'mock_memory_repository.dart';
import 'prefs.dart';

/// The app's one clock. Goldens and widget tests override this to a fixed
/// instant so greetings, timeline days and relative dates stop drifting.
final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

final memoryRepositoryProvider = Provider<MockMemoryRepository>(
    (ref) => MockMemoryRepository(clock: ref.watch(clockProvider)));

/// Defaults stay literal (ThemeMode.dark, Locale('en')) rather than reading
/// prefs in `create`: [localeProvider] is watched by every screen through
/// `ref.strings` (l10n/strings.dart's stringsProvider watches it), goldens
/// included — and goldens' ProviderScope never overrides [prefsProvider],
/// so `ref.watch(prefsProvider)` here would crash them.
/// [bootstrapThemeAndLocale] seeds the persisted values once the container
/// exists instead; anything that skips it (goldens, most widget tests)
/// just keeps these same defaults, unchanged from before persistence
/// existed.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

/// Explicit user choice only — see [bootstrapThemeAndLocale] for the
/// device-locale fallback used while nothing is stored yet.
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));

/// Tag <-> Locale for the persisted language choice. This app always
/// builds its Locales with the 2-arg constructor (lib/l10n/locales.dart,
/// e.g. `Locale('zh', 'Hant')`), which puts the second BCP-47 subtag in
/// `countryCode` even when it's really a script — so a 2-segment tag
/// round-trips through `countryCode` too, matching every entry in
/// `jaraLocales`. A 3-segment tag (real script *and* region together,
/// which only a live device locale supplies) is the one case that needs
/// `scriptCode`.
String serializeLocaleTag(Locale locale) {
  final segments = [locale.languageCode];
  if (locale.scriptCode != null) segments.add(locale.scriptCode!);
  if (locale.countryCode != null) segments.add(locale.countryCode!);
  return segments.join('-');
}

Locale parseLocaleTag(String tag) {
  final segments = tag.split('-');
  return switch (segments.length) {
    1 => Locale(segments[0]),
    2 => Locale(segments[0], segments[1]),
    _ => Locale.fromSubtags(
        languageCode: segments[0],
        scriptCode: segments[1],
        countryCode: segments[2],
      ),
  };
}

/// Seeds [themeModeProvider]/[localeProvider] from [prefsProvider] and
/// wires write-through listeners. Call once, right after building the
/// container (see main()) — see the doc on [themeModeProvider] for why
/// this can't live in the providers' own `create` callbacks.
void bootstrapThemeAndLocale(ProviderContainer container) {
  final prefs = container.read(prefsProvider);

  final storedTheme = prefs.themeMode;
  if (storedTheme != null) {
    container.read(themeModeProvider.notifier).state = storedTheme;
  }
  container.listen(themeModeProvider, (_, next) => prefs.setThemeMode(next));

  final storedTag = prefs.localeTag;
  container.read(localeProvider.notifier).state = storedTag != null
      ? parseLocaleTag(storedTag)
      : resolveJaraLocale(WidgetsBinding.instance.platformDispatcher.locale)
          .locale;
  container.listen(
    localeProvider,
    (_, next) => prefs.setLocaleTag(serializeLocaleTag(next)),
  );
}

final searchQueryProvider = StateProvider<String>((ref) => '');

final activeFilterProvider = StateProvider<MemoryType?>((ref) => null);

/// Simulates index latency so loading states are honest.
final searchResultsProvider =
    FutureProvider.autoDispose<SearchOutcome>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final filter = ref.watch(activeFilterProvider);
  final repo = ref.watch(memoryRepositoryProvider);
  if (query.trim().isEmpty) {
    if (filter == null) {
      return const SearchOutcome(
          query: '', items: [], elapsed: Duration.zero);
    }
    // Browsing a source type without a query (home tiles, "All" chips).
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return SearchOutcome(
      query: '',
      items: repo.ofType(filter),
      elapsed: const Duration(milliseconds: 60),
    );
  }
  await Future<void>.delayed(const Duration(milliseconds: 260));
  return repo.search(query, filter: filter);
});

final suggestionsProvider =
    Provider.autoDispose.family<List<SearchSuggestion>, String>(
  (ref, prefix) => ref.watch(memoryRepositoryProvider).suggest(prefix),
);

final memoryStatsProvider = Provider<MemoryStats>(
  (ref) => ref.watch(memoryRepositoryProvider).stats(),
);

/// Bumps to rebuild memory lists after pin/delete/add.
final memoryRevisionProvider = StateProvider<int>((ref) => 0);

/// Seed ids pinned out of the box (currently just 'doc-vox-pricing').
/// Persistence stores pin *changes* relative to this baseline instead of
/// every item's state — see [bootstrapMemoryPersistence] — so a seed
/// item's own default keeps applying until a user explicitly overrides it.
Set<String> _defaultPinnedIds(MockMemoryRepository repo) =>
    repo.pinned().map((i) => i.id).toSet();

/// Hydrates [memoryRepositoryProvider]'s repository from prefs (pins +
/// recent searches), then keeps prefs in sync afterwards. Call once, right
/// after building the container (see main()).
///
/// `MockMemoryRepository` isn't ours to edit, and neither are the feature
/// files that call `togglePin`/`add`/`recentSearches.insert` — so instead
/// of writing through at the mutation, this listens for
/// [memoryRevisionProvider] to bump, which every one of those call sites
/// already does immediately afterward by convention (verified by reading
/// each: memory_screen.dart, collection_detail_screen.dart,
/// search_home_screen.dart, search_results_screen.dart, add_sheet.dart,
/// share_capture_screen.dart, result_detail_screen.dart). That makes this
/// eventually consistent: the persisted snapshot can trail the real
/// mutation by at most one rebuild, never more.
void bootstrapMemoryPersistence(ProviderContainer container) {
  final prefs = container.read(prefsProvider);
  final repo = container.read(memoryRepositoryProvider);
  final defaultPinnedIds = _defaultPinnedIds(repo);

  _applyPersistedPins(repo, prefs, defaultPinnedIds);
  _applyPersistedRecentSearches(repo, prefs);

  container.listen(memoryRevisionProvider, (_, __) {
    final current = repo.pinned().map((i) => i.id).toSet();
    prefs.setPinnedIds(current.difference(defaultPinnedIds));
    prefs.setUnpinnedIds(defaultPinnedIds.difference(current));
    prefs.setRecentSearches(repo.recentSearches);
  });
}

void _applyPersistedPins(
  MockMemoryRepository repo,
  JaraPrefs prefs,
  Set<String> defaultPinnedIds,
) {
  final pinned = prefs.pinnedIds;
  final unpinned = prefs.unpinnedIds;
  if (pinned == null && unpinned == null) return; // first run: keep seed
  for (final item in repo.all) {
    final shouldPin = defaultPinnedIds.contains(item.id)
        ? !(unpinned?.contains(item.id) ?? false)
        : (pinned?.contains(item.id) ?? false);
    if (shouldPin != item.pinned) repo.togglePin(item.id);
  }
}

void _applyPersistedRecentSearches(
  MockMemoryRepository repo,
  JaraPrefs prefs,
) {
  final stored = prefs.recentSearches;
  if (stored == null) return; // first run: keep the demo seed
  repo.recentSearches
    ..clear()
    ..addAll(stored);
}

enum PrivacyTier { localOnly, hybrid }

final privacyTierProvider =
    StateProvider<PrivacyTier>((ref) => PrivacyTier.localOnly);

/// Manual override for tests, demos and the debug toggle: null follows the
/// platform. Kept apart from [offlineProvider] so screens keep reading a
/// plain bool and never have to reason about "who set this".
final offlineOverrideProvider = StateProvider<bool?>((ref) => null);

/// Single source of truth for "is offline": the connectivity stream, with
/// the override on top and `false` while the first platform read is in
/// flight. Defaulting to online matters — a stream that never arrives must
/// not make the app claim it is offline.
final offlineProvider = Provider<bool>((ref) {
  final override = ref.watch(offlineOverrideProvider);
  if (override != null) return override;
  return ref.watch(connectivityOfflineProvider).valueOrNull ?? false;
});

enum IndexState { idle, indexing }

final indexStateProvider = StateProvider<IndexState>((ref) => IndexState.idle);
