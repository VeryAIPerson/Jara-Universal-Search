import 'package:flutter/material.dart';

import '../design/haptics.dart';
import '../design/jara_theme.dart';
import '../design/motion.dart';
import '../design/typography.dart';

/// Vertical day columns on the memory sky — the reference's date rail.
/// Selected day fills with the accent gradient and shows "15 AUG".
class TimelineRail extends StatelessWidget {
  const TimelineRail({
    super.key,
    required this.days,
    required this.selected,
    required this.onSelect,
    this.counts = const {},
    this.height = 168,
  });

  final List<DateTime> days;
  final DateTime selected;
  final ValueChanged<DateTime> onSelect;

  /// Item count per day drives the column height feel.
  final Map<DateTime, int> counts;
  final double height;

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final maxCount = counts.values.fold<int>(1, (m, c) => c > m ? c : m);

    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final day in days) ...[
            Expanded(
              child: _DayColumn(
                day: day,
                selected: _sameDay(day, selected),
                fraction: ((counts[DateTime(day.year, day.month, day.day)] ??
                            0) /
                        maxCount)
                    .clamp(0.25, 1.0),
                onTap: () {
                  JaraHaptics.select();
                  onSelect(day);
                },
              ),
            ),
            const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _DayColumn extends StatelessWidget {
  const _DayColumn({
    required this.day,
    required this.selected,
    required this.fraction,
    required this.onTap,
  });

  final DateTime day;
  final bool selected;
  final double fraction;
  final VoidCallback onTap;

  static const _months = [
    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
  ];

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Semantics(
      button: true,
      selected: selected,
      label: '${day.day} ${_months[day.month - 1]}',
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedFractionallySizedBox(
          duration: JaraMotion.of(context, JaraMotion.gentle),
          curve: JaraMotion.standard,
          heightFactor: selected ? 1.0 : fraction,
          child: AnimatedContainer(
            duration: JaraMotion.of(context, JaraMotion.gentle),
            curve: JaraMotion.standard,
            decoration: BoxDecoration(
              gradient: selected ? t.accentGradient : null,
              color: selected
                  ? null
                  : Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected
                    ? Colors.white.withValues(alpha: 0.2)
                    : t.borderOnSky,
              ),
              boxShadow: selected ? t.accentGlow : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (selected) ...[
                  Text('${day.day}',
                      style:
                          JaraType.title2.copyWith(color: Colors.white)),
                  Text(_months[day.month - 1],
                      style: JaraType.caption
                          .copyWith(color: Colors.white)),
                  const SizedBox(height: 12),
                ] else
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      '${day.day}',
                      style: JaraType.footnoteMedium
                          .copyWith(color: t.textOnSkyTertiary),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
