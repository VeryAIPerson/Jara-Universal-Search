import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/tokens.dart';
import '../../core/l10n_bridge.dart';
import '../../core/models/memory_item.dart';
import '../../core/widgets/skeletons.dart';
import 'watch_layout.dart';
import 'watch_routes.dart';
import 'watch_type.dart';
import 'watch_widgets.dart';

/// The few matches, scrolling. Tapping one opens the wrist detail; the
/// full record still lives on the phone.
class WatchResultsScreen extends ConsumerWidget {
  const WatchResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.strings;
    final query = ref.watch(searchQueryProvider);
    final offline = ref.watch(offlineProvider);
    final results = ref.watch(searchResultsProvider);

    void dismiss() {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(WatchRoutes.home);
      }
    }

    return WatchScaffold(
      child: WatchDismissible(
        onDismiss: dismiss,
        child: results.when(
          loading: () => _Frame(
            query: query,
            offline: offline,
            offlineLabel: s.offlineLabel,
            children: const [
              SkeletonCard(height: WatchSize.rowMin),
              SizedBox(height: JaraSpacing.sm),
              SkeletonCard(height: WatchSize.rowMin),
              SizedBox(height: JaraSpacing.sm),
              SkeletonCard(height: WatchSize.rowMin),
            ],
          ),
          error: (_, __) => _Centered(
            child: WatchStateView(
              icon: Icons.refresh_rounded,
              title: s.errorGenericTitle,
              message: s.errorGenericBody,
              actionLabel: s.retry,
              onAction: () => ref.invalidate(searchResultsProvider),
            ),
          ),
          data: (outcome) {
            if (outcome.items.isEmpty) {
              return _Centered(
                child: WatchStateView(
                  icon: Icons.search_off_rounded,
                  title: s.emptyResultsTitle,
                  message: s.emptyResultsBody,
                  actionLabel: s.searchAction,
                  actionIcon: Icons.mic_rounded,
                  onAction: () =>
                      context.pushReplacement(WatchRoutes.listening),
                ),
              );
            }
            return _Frame(
              query: query,
              offline: offline,
              offlineLabel: s.offlineLabel,
              children: [
                for (final item in outcome.items) ...[
                  WatchResultRow(
                    item: item,
                    meta: _metaFor(s, item, ref.now),
                    onTap: () => context.push(WatchRoutes.itemPath(item.id)),
                  ),
                  const SizedBox(height: JaraSpacing.sm),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  /// Date first: the line ellipsizes on a narrow face, and "when" is what
  /// a wearer is triangulating on — the coloured icon already says what.
  static String _metaFor(JaraStrings s, MemoryItem item, DateTime now) =>
      '${relativeDate(s, item.date, now: now)} · ${item.source}';
}

/// Query line, optional offline marker, then whatever the state supplies.
class _Frame extends StatelessWidget {
  const _Frame({
    required this.query,
    required this.offline,
    required this.offlineLabel,
    required this.children,
  });

  final String query;
  final bool offline;
  final String offlineLabel;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return WatchScrollView(
      centered: false,
      children: [
        if (query.isNotEmpty) ...[
          Text(
            query,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: WatchType.meta.copyWith(color: t.textOnSkyTertiary),
          ),
          const SizedBox(height: JaraSpacing.md),
        ],
        if (offline) ...[
          WatchNotice(label: offlineLabel, icon: Icons.cloud_off_rounded),
          const SizedBox(height: JaraSpacing.md),
        ],
        ...children,
      ],
    );
  }
}

class _Centered extends StatelessWidget {
  const _Centered({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => WatchScrollView(children: [child]);
}
