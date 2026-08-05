import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/breakpoints.dart';
import '../../core/design/haptics.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/widgets/filter_chips.dart';
import '../../core/widgets/horizon_scaffold.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/neu_tile.dart';
import '../../core/widgets/result_cards.dart';
import '../../core/widgets/state_views.dart';
import '../../core/widgets/timeline_rail.dart';
import '../add/add_sheet.dart';

/// Wide monitors gain margin, not longer rows.
Widget _pageColumn(WindowClass w, Widget child) =>
    w == WindowClass.large
        ? Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxWidth: JaraBreakpoints.contentMaxWidth),
              child: child,
            ),
          )
        : child;

/// The three stat cards are a compact dashboard strip, not a banner: past
/// this they stop carrying more information and only get emptier.
Widget _statStrip(WindowClass w, Widget child) => w.isPhone
    ? child
    : Align(
        alignment: AlignmentDirectional.centerStart,
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: JaraBreakpoints.proseMaxWidth),
          child: child,
        ),
      );

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

/// Memory tab — the inverted Horizon: the soft library sits on top, the
/// deep sky carries the timeline underneath. Picking a day on the rail
/// filters the list above it.
class MemoryScreen extends ConsumerStatefulWidget {
  const MemoryScreen({super.key});

  @override
  ConsumerState<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends ConsumerState<MemoryScreen> {
  int _segment = 0;

  /// Null = no day filter; the rail still highlights today.
  DateTime? _selectedDay;

  static DateTime _dayOf(DateTime d) => DateTime(d.year, d.month, d.day);

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _togglePin(String id) {
    ref.read(memoryRepositoryProvider).togglePin(id);
    ref.read(memoryRevisionProvider.notifier).state++;
    JaraHaptics.confirm();
  }

  void _selectDay(DateTime day) {
    final current = _selectedDay;
    setState(() {
      _selectedDay =
          current != null && _sameDay(current, day) ? null : _dayOf(day);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    ref.watch(memoryRevisionProvider);
    final repo = ref.watch(memoryRepositoryProvider);
    final stats = ref.watch(memoryStatsProvider);

    final today = _dayOf(DateTime.now());
    final days = List.generate(7, (i) => today.subtract(Duration(days: 6 - i)));
    final counts = <DateTime, int>{
      for (final day in days)
        day: repo.all.where((item) => _sameDay(item.date, day)).length,
    };

    final segments = [s.memoryAll, s.memoryPinned, s.memoryRecent];
    final base = switch (_segment) {
      1 => repo.pinned(),
      2 => repo.recentlySaved(limit: 8),
      _ => (List.of(repo.all)..sort((a, b) => b.date.compareTo(a.date))),
    };
    final day = _selectedDay;
    final items = day == null
        ? base
        : base.where((item) => _sameDay(item.date, day)).toList();
    final w = context.windowClass;
    final inset = JaraBreakpoints.pageInsetFor(w);

    final cards = [
      for (var i = 0; i < items.length; i++)
        StaggeredItem(
          index: i,
          child: UniversalResultCard(
            item: items[i],
            dateLabel: relativeDate(s, items[i].date),
            onTap: () => context.push('/item/${items[i].id}'),
            onPin: () => _togglePin(items[i].id),
          ),
        ),
    ];

    final surface = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                s.memoryTitle,
                style: JaraType.title1.copyWith(color: t.textPrimary),
              ),
            ),
            NeuIconButton(
              icon: Icons.search_rounded,
              onSky: false,
              semanticLabel: s.searchAction,
              onTap: () => context.go('/search'),
            ),
          ],
        ),
        const SizedBox(height: JaraSpacing.sm),
        _statStrip(
          w,
          Row(
            children: [
              _StatCard(value: '${stats.totalItems}', label: s.memoryAll),
              const SizedBox(width: 10),
              _StatCard(
                value: '+${stats.addedThisWeek}',
                label: s.memoryRecent,
                accent: true,
              ),
              const SizedBox(width: 10),
              _StatCard(
                  value: '${stats.collections}', label: s.collectionsTitle),
            ],
          ),
        ),
        const SizedBox(height: JaraSpacing.xl),
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              for (var i = 0; i < segments.length; i++)
                SearchFilterChip(
                  label: segments[i],
                  selected: _segment == i,
                  onSky: false,
                  onTap: () => setState(() => _segment = i),
                ),
            ],
          ),
        ),
        const SizedBox(height: JaraSpacing.lg),
        if (day != null) ...[
          Row(
            children: [
              Semantics(
                button: true,
                label: s.clearDateFilter,
                child: JaraChip(
                  label: '${day.day}.${day.month}',
                  icon: Icons.event_rounded,
                  onTap: () => setState(() => _selectedDay = null),
                ),
              ),
              const SizedBox(width: JaraSpacing.sm),
              Text(
                s.collectionItems(items.length),
                style: JaraType.caption.copyWith(color: t.textTertiary),
              ),
            ],
          ),
          const SizedBox(height: JaraSpacing.md),
        ],
        if (items.isEmpty)
          SizedBox(
            width: double.infinity,
            child: EmptyStateView(
              compact: true,
              icon: Icons.push_pin_outlined,
              title: s.emptyMemoryTitle,
              message: s.emptyMemoryBody,
              primaryLabel: s.emptyMemoryCta,
              onPrimary: () => showAddSheet(context),
            ),
          )
        // The library is the longest list in the app; from `expanded` two
        // columns roughly halve the scroll without shrinking a card.
        else if (w.usesTwoPane)
          SizedBox(width: double.infinity, child: _cardGrid(cards, 2))
        else
          for (var i = 0; i < cards.length; i++) ...[
            cards[i],
            if (i != cards.length - 1) const SizedBox(height: JaraSpacing.md),
          ],
      ],
    );

    final sky = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: s.memoryTimeline, onSky: true),
        TimelineRail(
          days: days,
          selected: _selectedDay ?? today,
          onSelect: _selectDay,
          counts: counts,
        ),
        const SizedBox(height: JaraSpacing.xl),
        Row(
          children: [
            Expanded(
              child: Text(
                s.indexedAgo(relativeDate(s, stats.lastIndexed)),
                style: JaraType.caption.copyWith(color: t.textOnSkyTertiary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: JaraSpacing.md),
            Text(
              stats.storageUsedLabel,
              style: JaraType.caption.copyWith(color: t.textOnSkySecondary),
            ),
          ],
        ),
      ],
    );

    return HorizonScaffold(
      inverted: true,
      // Sky is the last panel here — clear the floating bottom bar. From
      // `medium` up that bar is a rail, so the clearance is just a gap,
      // and the sky is a fixed 380 dp column that must keep the phone
      // inset or the wave clearance leaves nothing for the timeline.
      skyPadding: EdgeInsets.fromLTRB(
          w.isPhone ? inset : JaraSpacing.page,
          JaraSpacing.sm,
          w.isPhone ? inset : JaraSpacing.page,
          w.usesRail ? JaraSpacing.huge : 140),
      surfacePadding:
          EdgeInsets.fromLTRB(inset, JaraSpacing.sm, inset, 0),
      sky: _pageColumn(w, sky),
      surface: _pageColumn(w, surface),
    );
  }
}

/// One third of the stats strip.
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    this.accent = false,
  });

  final String value;
  final String label;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Expanded(
      child: MergeSemantics(
        child: NeuCard(
          padding: const EdgeInsets.all(JaraSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: JaraType.title2
                    .copyWith(color: accent ? t.accent : t.textPrimary),
                maxLines: 1,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: JaraType.caption.copyWith(color: t.textTertiary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
