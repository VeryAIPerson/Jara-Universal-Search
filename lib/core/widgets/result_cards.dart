import 'package:flutter/material.dart';

import '../design/jara_theme.dart';
import '../design/typography.dart';
import '../models/memory_item.dart';
import 'filter_chips.dart';
import 'highlight_text.dart';
import 'neu_card.dart';

/// One result card for every memory type. Layout adapts per type:
/// photos/screenshots lead with a thumbnail block, calendar with a date
/// block, documents with a file badge. Query tokens are highlighted.
class UniversalResultCard extends StatelessWidget {
  const UniversalResultCard({
    super.key,
    required this.item,
    this.query = '',
    this.onTap,
    this.onPin,
    this.onSky = false,
    this.dateLabel,
  });

  final MemoryItem item;
  final String query;
  final VoidCallback? onTap;
  final VoidCallback? onPin;
  final bool onSky;

  /// Preformatted relative date ("2d ago", "Sep 12").
  final String? dateLabel;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final titleColor = onSky ? t.textOnSky : t.textPrimary;
    final secondary = onSky ? t.textOnSkySecondary : t.textSecondary;
    final tertiary = onSky ? t.textOnSkyTertiary : t.textTertiary;

    return NeuCard(
      onSky: onSky,
      onTap: onTap,
      semanticLabel: '${item.title}, ${item.source}',
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LeadingBlock(item: item),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        highlightSpans(
                          item.title,
                          query,
                          style: JaraType.headline.copyWith(color: titleColor),
                          highlightStyle: JaraType.headline
                              .copyWith(color: t.accentBright),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item.pinned)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 6),
                        child: Icon(Icons.push_pin_rounded,
                            size: 14, color: t.gold),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text.rich(
                  highlightSpans(
                    item.snippet,
                    query,
                    style: JaraType.footnote.copyWith(color: secondary),
                    highlightStyle: JaraType.footnoteMedium
                        .copyWith(color: titleColor),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(item.type.icon, size: 12, color: tertiary),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        [
                          item.source,
                          if (dateLabel != null) dateLabel!,
                          if (item.pageLabel != null) item.pageLabel!,
                          if (item.timeLabel != null) item.timeLabel!,
                        ].join(' · '),
                        style: JaraType.caption.copyWith(color: tertiary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    if (item.matchReason != null)
                      JaraChip(
                        label: item.matchReason!,
                        color: t.violet,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeadingBlock extends StatelessWidget {
  const _LeadingBlock({required this.item});

  final MemoryItem item;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final color = item.type.color;

    if (item.type == MemoryType.calendar) {
      final day = item.date.day.toString().padLeft(2, '0');
      final month = _monthShort(item.date.month);
      return Container(
        width: 52,
        height: 56,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(day, style: JaraType.title2.copyWith(color: color)),
            Text(month.toUpperCase(),
                style: JaraType.caption.copyWith(color: color)),
          ],
        ),
      );
    }

    final isVisual =
        item.type == MemoryType.photo || item.type == MemoryType.screenshot;
    return Container(
      width: 52,
      height: 56,
      decoration: BoxDecoration(
        color: color.withValues(alpha: t.isDark ? 0.16 : 0.14),
        borderRadius: BorderRadius.circular(14),
        image: null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isVisual)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withValues(alpha: 0.35),
                        color.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Icon(item.type.icon, color: color, size: 22),
          if (item.extLabel != null)
            Positioned(
              bottom: 4,
              child: Text(
                item.extLabel!,
                style: JaraType.caption
                    .copyWith(color: color, fontSize: 9),
              ),
            ),
        ],
      ),
    );
  }

  String _monthShort(int m) => const [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ][m - 1];
}
