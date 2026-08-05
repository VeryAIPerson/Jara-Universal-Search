import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
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
              semanticLabel: 'Search', // l10n-todo
              onTap: () => context.go('/search'),
            ),
          ],
        ),
        const SizedBox(height: JaraSpacing.sm),
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
            _StatCard(value: '${stats.collections}', label: s.collectionsTitle),
          ],
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
                label: 'Clear date filter', // l10n-todo
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
        else
          for (var i = 0; i < items.length; i++) ...[
            StaggeredItem(
              index: i,
              child: UniversalResultCard(
                item: items[i],
                dateLabel: relativeDate(s, items[i].date),
                onTap: () => context.push('/item/${items[i].id}'),
                onPin: () => _togglePin(items[i].id),
              ),
            ),
            if (i != items.length - 1) const SizedBox(height: JaraSpacing.md),
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
      // Sky is the last panel here — clear the floating bottom bar.
      skyPadding: const EdgeInsets.fromLTRB(
          JaraSpacing.page, JaraSpacing.sm, JaraSpacing.page, 140),
      surfacePadding: const EdgeInsets.fromLTRB(
          JaraSpacing.page, JaraSpacing.sm, JaraSpacing.page, 0),
      sky: sky,
      surface: surface,
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
