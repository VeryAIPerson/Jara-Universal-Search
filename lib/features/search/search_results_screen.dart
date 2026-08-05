import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/haptics.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/motion.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/models/memory_item.dart';
import '../../core/widgets/filter_chips.dart';
import '../../core/widgets/horizon_scaffold.dart';
import '../../core/widgets/jara_search_field.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/neu_tile.dart';
import '../../core/widgets/result_cards.dart';
import '../../core/widgets/skeletons.dart';
import '../../core/widgets/smart_summary_card.dart';
import '../../core/widgets/state_views.dart';
import 'search_overlays.dart';

/// Results live in the same Horizon frame as the home screen: the query
/// tools stay on the sky, the answers rise on the surface.
class SearchResultsScreen extends ConsumerStatefulWidget {
  const SearchResultsScreen({super.key, required this.initialQuery});

  final String initialQuery;

  @override
  ConsumerState<SearchResultsScreen> createState() =>
      _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialQuery);
  final _scroll = ScrollController();
  final _resultsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    final q = widget.initialQuery.trim();
    if (q.isEmpty) return;
    // Providers may not be written while the first frame is building.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(searchQueryProvider.notifier).state = q;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _submit(String query) {
    final q = query.trim();
    if (q.isEmpty) return;
    final recents = ref.read(memoryRepositoryProvider).recentSearches;
    if (!recents.contains(q)) {
      recents.insert(0, q);
      if (recents.length > 6) recents.removeRange(6, recents.length);
    }
    ref.read(searchQueryProvider.notifier).state = q;
    ref.read(memoryRevisionProvider.notifier).state++;
  }

  Future<void> _startVoiceSearch() async {
    final spoken = await showVoiceSearchSheet(context);
    if (!context.mounted) return;
    if (spoken == null || spoken.isEmpty) return;
    _controller.text = spoken;
    _submit(spoken);
  }

  void _scrollToResults() {
    final target = _resultsKey.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      alignment: 0.05,
      duration: JaraMotion.of(context, JaraMotion.gentle),
      curve: JaraMotion.standard,
    );
  }

  void _notify(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    final results = ref.watch(searchResultsProvider);
    final outcome = results.valueOrNull;
    final loading = results.isLoading;
    final summary = outcome?.summary;
    final offline = ref.watch(offlineProvider);
    // Type browsing (blank query) never asks for an answer, so the cloud
    // notice would be noise there.
    final answerable = ref.watch(searchQueryProvider).trim().isNotEmpty;

    return HorizonScaffold(
      controller: _scroll,
      skyPadding: const EdgeInsets.fromLTRB(
          JaraSpacing.page, JaraSpacing.sm, JaraSpacing.page, 96),
      surfacePadding: const EdgeInsets.fromLTRB(
          JaraSpacing.page, JaraSpacing.huge, JaraSpacing.page, 120),
      sky: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OfflineSlot(offline: offline, label: s.offlineLabel),
          Row(
            children: [
              NeuIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onSky: true,
                semanticLabel: s.back,
                onTap: () => context.pop(),
              ),
              const SizedBox(width: JaraSpacing.md),
              Expanded(
                child: JaraSearchField(
                  controller: _controller,
                  hints: const [],
                  onSubmitted: _submit,
                  onVoiceTap: _startVoiceSearch,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          FilterChipRow(
            selected: ref.watch(activeFilterProvider),
            onSelected: (type) =>
                ref.read(activeFilterProvider.notifier).state = type,
            allLabel: s.filterAll,
            labelOf: s.typeLabel,
          ),
          const SizedBox(height: JaraSpacing.md),
          SizedBox(
            height: 16,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: loading || outcome == null
                  ? const SkeletonLine(width: 140, height: 10)
                  : Text(
                      s.resultsCount(
                        outcome.items.length,
                        '${(outcome.elapsed.inMilliseconds / 1000).toStringAsFixed(1)} s',
                      ),
                      style:
                          JaraType.caption.copyWith(color: t.textOnSkyTertiary),
                    ),
            ),
          ),
          // The answer is the one cloud-bound block here; local results
          // below keep rendering either way.
          if (offline && answerable) ...[
            const SizedBox(height: JaraSpacing.lg),
            _SummaryUnavailable(
              title: s.smartSummaryTitle,
              caption: s.needsConnection,
            ),
          ]
          // Only promise an answer if the last outcome actually had one.
          else if (summary != null) ...[
            const SizedBox(height: JaraSpacing.lg),
            if (loading)
              const SmartSummarySkeleton()
            else
              SmartSummaryCard(
                summary: summary,
                titleLabel: s.smartSummaryTitle,
                basedOnLabel: s.basedOnItems(summary.sourceCount),
                viewSourcesLabel: s.viewSources,
                onViewSources: _scrollToResults,
                onCopy: () {
                  Clipboard.setData(ClipboardData(text: summary.text));
                  _notify(s.copied);
                },
                onSave: () {
                  JaraHaptics.confirm();
                  _notify(s.shareSaved);
                },
              ),
          ],
        ],
      ),
      surface: _surface(context, s, results),
    );
  }

  Widget _surface(
    BuildContext context,
    JaraStrings s,
    AsyncValue<SearchOutcome> results,
  ) {
    if (results.isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < 4; i++) ...[
            if (i > 0) const SizedBox(height: JaraSpacing.md),
            const SkeletonCard(height: 96),
          ],
        ],
      );
    }

    if (results.hasError) {
      // Being offline only explains the failure when the query would have
      // left the device at all; local-only search fails for other reasons.
      final cloudQuery =
          ref.watch(privacyTierProvider) == PrivacyTier.hybrid;
      final offline = ref.watch(offlineProvider);
      return ErrorStateView(
        offline && cloudQuery ? JaraError.noConnection : JaraError.generic,
        onPrimary: () => ref.invalidate(searchResultsProvider),
      );
    }

    final outcome = results.valueOrNull;
    if (outcome == null || outcome.items.isEmpty) {
      return EmptyStateView(
        icon: Icons.search_off_rounded,
        title: s.emptyResultsTitle,
        message: s.emptyResultsBody,
        primaryLabel: s.emptyResultsAdjust,
        onPrimary: () => showSearchFilterSheet(context),
        secondaryLabel: s.emptyResultsSearchAll,
        onSecondary: () =>
            ref.read(activeFilterProvider.notifier).state = null,
      );
    }

    final best = outcome.items.first;
    var order = 0;

    Widget card(MemoryItem item) => StaggeredItem(
          index: order++,
          child: UniversalResultCard(
            item: item,
            query: outcome.query,
            dateLabel: relativeDate(s, item.date),
            onTap: () => context.push('/item/${item.id}'),
            onPin: () {
              ref.read(memoryRepositoryProvider).togglePin(item.id);
              ref.read(memoryRevisionProvider.notifier).state++;
              JaraHaptics.confirm();
            },
          ),
        );

    final sections = <Widget>[
      SectionHeader(title: s.bestMatch),
      card(best),
    ];

    // The best match keeps its own section; its group only reappears when
    // it holds something else.
    for (final group in outcome.grouped.entries) {
      final rest = group.value.where((item) => item.id != best.id).toList();
      if (rest.isEmpty) continue;
      sections
        ..add(const SizedBox(height: JaraSpacing.xl))
        ..add(SectionHeader(title: s.typePluralLabel(group.key)));
      for (var i = 0; i < rest.length; i++) {
        if (i > 0) sections.add(const SizedBox(height: JaraSpacing.md));
        sections.add(card(rest[i]));
      }
    }

    return Column(
      key: _resultsKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: sections,
    );
  }
}

/// Marks the Smart Summary as cloud-only while offline — a quiet card in
/// its slot instead of a skeleton that would spin forever.
class _SummaryUnavailable extends StatelessWidget {
  const _SummaryUnavailable({required this.title, required this.caption});

  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return MergeSemantics(
      child: NeuCard(
        onSky: true,
        padding: const EdgeInsets.symmetric(
            horizontal: JaraSpacing.lg, vertical: JaraSpacing.md),
        child: Row(
          children: [
            Icon(Icons.cloud_off_rounded,
                size: 18, color: t.textOnSkyTertiary),
            const SizedBox(width: JaraSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: JaraType.footnoteMedium
                        .copyWith(color: t.textOnSkySecondary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    caption,
                    style: JaraType.caption
                        .copyWith(color: t.textOnSkyTertiary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
