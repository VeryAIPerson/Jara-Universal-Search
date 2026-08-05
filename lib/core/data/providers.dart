import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/memory_item.dart';
import 'connectivity_service.dart';
import 'mock_memory_repository.dart';

final memoryRepositoryProvider =
    Provider<MockMemoryRepository>((ref) => MockMemoryRepository());

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

/// 'en' | 'tr'
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));

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
