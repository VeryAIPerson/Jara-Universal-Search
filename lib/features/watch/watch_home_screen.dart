import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/tokens.dart';
import '../../core/l10n_bridge.dart';
import 'watch_layout.dart';
import 'watch_routes.dart';
import 'watch_widgets.dart';

/// Wrist home: wordmark, one thumb-sized mic, and the searches the wearer
/// already made. No nav chrome — the phone keeps the rest of the app.
class WatchHomeScreen extends ConsumerWidget {
  const WatchHomeScreen({super.key});

  /// A wrist list is glanced at, not browsed.
  static const _recentLimit = 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.strings;
    final recents = ref
        .watch(memoryRepositoryProvider)
        .recentSearches
        .take(_recentLimit)
        .toList();

    void run(String query) {
      ref.read(searchQueryProvider.notifier).state = query;
      context.push(WatchRoutes.results);
    }

    return WatchScaffold(
      child: WatchScrollView(
        children: [
          WatchWordmark(label: s.productName),
          const SizedBox(height: JaraSpacing.md),
          WatchMicButton(
            semanticLabel: s.settingsVoice,
            onTap: () => context.push(WatchRoutes.listening),
          ),
          if (recents.isNotEmpty) ...[
            const SizedBox(height: JaraSpacing.xl),
            WatchSectionHeader(title: s.recentSearches),
            const SizedBox(height: JaraSpacing.sm),
            for (final query in recents) ...[
              WatchRecentRow(query: query, onTap: () => run(query)),
              const SizedBox(height: JaraSpacing.sm),
            ],
          ],
        ],
      ),
    );
  }
}
