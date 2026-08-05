import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/memory_item.dart';
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
    return const SearchOutcome(
        query: '', items: [], elapsed: Duration.zero);
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

final offlineProvider = StateProvider<bool>((ref) => false);

enum IndexState { idle, indexing }

final indexStateProvider = StateProvider<IndexState>((ref) => IndexState.idle);
