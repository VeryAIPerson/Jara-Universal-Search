import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/breakpoints.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/models/memory_item.dart';
import '../../core/widgets/filter_chips.dart';
import '../../core/widgets/horizon_scaffold.dart';
import '../../core/widgets/jara_search_field.dart';
import '../../core/widgets/memory_status_card.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/neu_tile.dart';
import '../../core/widgets/notch_app_bar.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/result_cards.dart';
import '../../core/widgets/state_views.dart';
import 'search_overlays.dart';

/// Source tiles, in reading order, with the file hint shown under the count.
const _sourceTiles = <(MemoryType, String)>[
  (MemoryType.document, '.pdf'),
  (MemoryType.photo, '.jpeg'),
  (MemoryType.screenshot, '.png'),
  (MemoryType.note, '.txt'),
  (MemoryType.link, '.url'),
  (MemoryType.audio, '.m4a'),
];

/// The shell bar floats over the content on phones only; from `medium` up
/// it becomes a rail, so the reservation would just be a gap.
double _bottomRoom(WindowClass w) => w.usesRail ? JaraSpacing.xxxl : 120;

/// Only the surface pane actually gains width with the window. Once the
/// Horizon rotates, the sky is a fixed 380 dp command column that already
/// spends 86 dp on the wave clearance — growing its inset there would eat
/// the column, not add margin to it.
double _skyInset(WindowClass w) => w.isPhone
    ? JaraBreakpoints.pageInsetFor(w)
    : JaraSpacing.page;

/// Result cards read better side by side than as one very wide column —
/// but only while each card keeps a scannable width.
Widget _cardGrid(List<Widget> cards, int columns) {
  const gap = JaraSpacing.md;
  const minCard = 320.0;
  return LayoutBuilder(
    builder: (context, c) {
      final fits = ((c.maxWidth + gap) / (minCard + gap)).floor();
      final n = columns < fits ? columns : (fits < 1 ? 1 : fits);
      if (n < 2) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < cards.length; i++) ...[
              if (i > 0) const SizedBox(height: gap),
              cards[i],
            ],
          ],
        );
      }
      final width = ((c.maxWidth - gap * (n - 1)) / n).floorToDouble();
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [
          for (final card in cards) SizedBox(width: width, child: card),
        ],
      );
    },
  );
}

/// Tab 0 — the command screen. Sky: identity, greeting, search. Surface:
/// what is already in the memory (sources, recent searches, recent saves).
class SearchHomeScreen extends ConsumerStatefulWidget {
  const SearchHomeScreen({super.key});

  @override
  ConsumerState<SearchHomeScreen> createState() => _SearchHomeScreenState();
}

class _SearchHomeScreenState extends ConsumerState<SearchHomeScreen> {
  final _controller = TextEditingController();
  String _typed = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Every route into results goes through here: remember the query, set the
  /// source filter (null = all sources) and hand over to the results screen.
  void _runSearch(String query, {MemoryType? filter}) {
    final q = query.trim();
    if (q.isEmpty) return;

    final recents = ref.read(memoryRepositoryProvider).recentSearches;
    if (!recents.contains(q)) {
      recents.insert(0, q);
      if (recents.length > 6) recents.removeRange(6, recents.length);
    }

    ref.read(activeFilterProvider.notifier).state = filter;
    ref.read(searchQueryProvider.notifier).state = q;
    ref.read(memoryRevisionProvider.notifier).state++;
    context.push('/search/results?q=${Uri.encodeComponent(q)}');
  }

  /// Source tiles browse a type directly: blank query + filter renders the
  /// full type listing on the results screen.
  void _browseType(MemoryType type) {
    ref.read(activeFilterProvider.notifier).state = type;
    ref.read(searchQueryProvider.notifier).state = '';
    context.push('/search/results');
  }

  Future<void> _startVoiceSearch() async {
    final spoken = await showVoiceSearchSheet(context);
    if (!context.mounted) return;
    if (spoken == null || spoken.isEmpty) return;
    _controller.text = spoken;
    setState(() => _typed = spoken);
    _runSearch(spoken);
  }

  String _greeting(JaraStrings s) {
    final hour = DateTime.now().hour;
    if (hour < 12) return s.greetingMorning('');
    if (hour < 18) return s.greetingDay('');
    return s.greetingEvening('');
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    final stats = ref.watch(memoryStatsProvider);
    final prefix = _typed.trim();
    final offline = ref.watch(offlineProvider);
    final w = context.windowClass;
    final inset = JaraBreakpoints.pageInsetFor(w);
    final skyInset = _skyInset(w);

    return HorizonScaffold(
      skyPadding:
          EdgeInsets.fromLTRB(skyInset, JaraSpacing.sm, skyInset, 96),
      surfacePadding: EdgeInsets.fromLTRB(
          inset, JaraSpacing.huge, inset, _bottomRoom(w)),
      sky: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OfflineSlot(offline: offline, label: s.offlineLabel),
          NotchAppBar(
            leadingIcon: Icons.shield_outlined,
            onLeadingTap: () => context.push('/profile/privacy'),
            leadingSemanticLabel: s.privacyTitle,
            trailingIcon: Icons.settings_outlined,
            onTrailingTap: () => context.go('/profile'),
            trailingSemanticLabel: s.settingsTitle,
            avatarInitials: 'A',
            onAvatarTap: () => context.go('/profile'),
          ),
          const SizedBox(height: JaraSpacing.md),
          _GreetingRow(
            greeting: _greeting(s),
            pillLabel: s.privacyLocalActive,
            stacked: !w.isPhone,
            onPillTap: () => context.push('/profile/privacy'),
          ),
          const SizedBox(height: JaraSpacing.lg),
          Text(
            s.searchTitle,
            style: JaraType.display.copyWith(color: t.textOnSky),
          ),
          const SizedBox(height: JaraSpacing.xl),
          JaraSearchField(
            controller: _controller,
            hints: s.searchHints,
            onChanged: (value) => setState(() => _typed = value),
            onSubmitted: (value) => _runSearch(value),
            onVoiceTap: _startVoiceSearch,
            onFilterTap: () => showSearchFilterSheet(context),
          ),
          if (prefix.isEmpty) ...[
            const SizedBox(height: JaraSpacing.xl),
            MemoryStatusCard(
              stats: stats,
              title: s.memoryStatusTitle,
              itemsLabel:
                  s.memoryStatusItems(stats.totalItems, stats.collections),
              freeLabel: stats.storageFreeLabel,
              lastIndexedLabel:
                  s.indexedAgo(relativeDate(s, stats.lastIndexed)),
              onTap: () => context.go('/memory'),
            ),
          ] else ...[
            const SizedBox(height: JaraSpacing.md),
            _Suggestions(prefix: prefix, onPick: _runSearch),
          ],
        ],
      ),
      surface: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: s.sourcesSection),
          _SourceGrid(onSelect: _browseType),
          const SizedBox(height: JaraSpacing.xxl),
          SectionHeader(title: s.recentSearches),
          _RecentSearches(onPick: _runSearch),
          const SizedBox(height: JaraSpacing.xxl),
          SectionHeader(
            title: s.recentlySaved,
            actionLabel: s.seeAll,
            onAction: () => context.go('/memory'),
          ),
          const _RecentlySaved(),
        ],
      ),
    );
  }
}

/// Greeting plus the local-only trust pill. They share a line on phones;
/// in the rotated Horizon's 380 dp command column there is no room for
/// two things side by side, so the pill drops under the greeting instead
/// of squeezing it to an ellipsis.
class _GreetingRow extends StatelessWidget {
  const _GreetingRow({
    required this.greeting,
    required this.pillLabel,
    required this.stacked,
    required this.onPillTap,
  });

  final String greeting;
  final String pillLabel;
  final bool stacked;
  final VoidCallback onPillTap;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final text = Text(
      greeting,
      style: JaraType.callout.copyWith(color: t.textOnSkySecondary),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
    final pill = PrivacyPill(
      label: pillLabel,
      active: true,
      onTap: onPillTap,
    );

    if (stacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text,
          const SizedBox(height: JaraSpacing.sm),
          pill,
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: text),
        const SizedBox(width: JaraSpacing.sm),
        pill,
      ],
    );
  }
}

/// Live query completions, shown on the sky in place of the status card.
class _Suggestions extends ConsumerWidget {
  const _Suggestions({required this.prefix, required this.onPick});

  final String prefix;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestions = ref.watch(suggestionsProvider(prefix));
    if (suggestions.isEmpty) return const SizedBox.shrink();

    return NeuCard(
      onSky: true,
      padding: const EdgeInsets.symmetric(
          horizontal: JaraSpacing.sm, vertical: JaraSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final suggestion in suggestions.take(6))
            _SuggestionRow(
              suggestion: suggestion,
              onTap: () => onPick(suggestion.text),
            ),
        ],
      ),
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({required this.suggestion, required this.onTap});

  final SearchSuggestion suggestion;
  final VoidCallback onTap;

  IconData get _icon => switch (suggestion.kind) {
        SuggestionKind.history => Icons.history_rounded,
        SuggestionKind.completion => Icons.north_west_rounded,
        SuggestionKind.file =>
          suggestion.type?.icon ?? Icons.description_outlined,
        SuggestionKind.type => suggestion.type?.icon ?? Icons.search_rounded,
        _ => Icons.search_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final subtitle = suggestion.subtitle;

    return Pressable(
      onTap: onTap,
      semanticLabel: suggestion.text,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: JaraSize.touchMin),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: JaraSpacing.sm, vertical: JaraSpacing.sm),
          child: Row(
            children: [
              Icon(
                _icon,
                size: 18,
                color: suggestion.type?.color ?? t.textOnSkySecondary,
              ),
              const SizedBox(width: JaraSpacing.md),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestion.text,
                      style: JaraType.callout.copyWith(color: t.textOnSky),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: JaraType.caption
                            .copyWith(color: t.textOnSkyTertiary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Neumorphic source grid — the reference composition's signature block.
class _SourceGrid extends ConsumerWidget {
  const _SourceGrid({required this.onSelect});

  final ValueChanged<MemoryType> onSelect;

  static const _gap = 14.0;

  /// Tiles gain neighbours, not size: 160 is the ceiling a tile reaches
  /// before the grid stops growing and the window gains margin instead.
  static const _maxTile = 160.0;

  /// Under this the icon badge + two label lines stop fitting the square.
  static const _minTile = 96.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(memoryRevisionProvider);
    final s = ref.strings;
    final repo = ref.watch(memoryRepositoryProvider);
    final w = context.windowClass;

    Widget grid(int columns) => GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          // Neu shadows fall outside the tile box; the grid must not clip
          // them.
          clipBehavior: Clip.none,
          crossAxisCount: columns,
          mainAxisSpacing: _gap,
          crossAxisSpacing: _gap,
          childAspectRatio: 0.98,
          children: [
            for (final (type, ext) in _sourceTiles)
              NeuTile(
                icon: type.icon,
                iconColor: type.color,
                label: s.typePluralLabel(type),
                meta: '${repo.countOf(type)} · $ext',
                onTap: () => onSelect(type),
              ),
          ],
        );

    if (w.isPhone) return grid(JaraBreakpoints.gridColumnsFor(w));

    return LayoutBuilder(
      builder: (context, c) {
        // The window class asks for the columns; a narrow pane (the
        // Horizon splits vertically up here) steps them back down.
        final fits = ((c.maxWidth + _gap) / (_minTile + _gap)).floor();
        final wanted = JaraBreakpoints.gridColumnsFor(w);
        final columns = wanted < fits ? wanted : (fits < 1 ? 1 : fits);
        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: columns * _maxTile + (columns - 1) * _gap),
            child: grid(columns),
          ),
        );
      },
    );
  }
}

class _RecentSearches extends ConsumerWidget {
  const _RecentSearches({required this.onPick});

  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(memoryRevisionProvider);
    final t = context.jara;
    final recents = ref.watch(memoryRepositoryProvider).recentSearches;

    return Wrap(
      spacing: JaraSpacing.sm,
      children: [
        for (final query in recents)
          Pressable(
            onTap: () => onPick(query),
            semanticLabel: query,
            child: SizedBox(
              height: JaraSize.touchMin,
              child: Center(
                child: JaraChip(
                  label: query,
                  icon: Icons.history_rounded,
                  color: t.accent,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _RecentlySaved extends ConsumerWidget {
  const _RecentlySaved();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(memoryRevisionProvider);
    final s = ref.strings;
    final items = ref.watch(memoryRepositoryProvider).recentlySaved(limit: 3);
    final w = context.windowClass;

    Widget card(int i) => StaggeredItem(
          index: i,
          child: UniversalResultCard(
            item: items[i],
            dateLabel: relativeDate(s, items[i].date),
            onTap: () => context.push('/item/${items[i].id}'),
          ),
        );

    // Two-up from `expanded`: three full-bleed cards under a source grid
    // read as a wall of whitespace on a desktop window.
    if (w.usesTwoPane) {
      return _cardGrid([for (var i = 0; i < items.length; i++) card(i)], 2);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(height: JaraSpacing.md),
          card(i),
        ],
      ],
    );
  }
}
