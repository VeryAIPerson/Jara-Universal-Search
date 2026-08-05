import 'package:flutter/material.dart';

import '../design/jara_theme.dart';
import '../design/typography.dart';
import '../models/memory_item.dart';
import 'neu_card.dart';

/// The "MyDocs" analog from the reference: memory totals + index progress
/// on an elevated sky card.
class MemoryStatusCard extends StatelessWidget {
  const MemoryStatusCard({
    super.key,
    required this.stats,
    required this.title,
    required this.itemsLabel,
    required this.freeLabel,
    required this.lastIndexedLabel,
    this.onTap,
  });

  final MemoryStats stats;
  final String title;

  /// e.g. "3,248 items · 26 collections"
  final String itemsLabel;

  /// e.g. "38 GB free"
  final String freeLabel;

  /// e.g. "Indexed 2m ago"
  final String lastIndexedLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return NeuCard(
      onSky: true,
      onTap: onTap,
      semanticLabel: '$title, $itemsLabel, $lastIndexedLabel',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: t.accentGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: t.accentGlow,
                ),
                child: const Icon(Icons.auto_awesome_rounded,
                    color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: JaraType.headline
                            .copyWith(color: t.textOnSky)),
                    const SizedBox(height: 2),
                    Text(itemsLabel,
                        style: JaraType.footnote
                            .copyWith(color: t.textOnSkySecondary)),
                  ],
                ),
              ),
              // chevron_right_rounded carries matchTextDirection, so
              // Icon flips it itself in RTL — no manual mirroring.
              Icon(Icons.chevron_right_rounded,
                  color: t.textOnSkyTertiary),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: SizedBox(
              height: 6,
              child: Stack(
                // Progress grows from the reading edge: the fill is an
                // unpositioned child, so the stack alignment places it.
                alignment: AlignmentDirectional.topStart,
                children: [
                  Container(color: Colors.white.withValues(alpha: 0.08)),
                  FractionallySizedBox(
                    widthFactor: stats.indexedFraction.clamp(0, 1),
                    child: DecoratedBox(
                      decoration:
                          BoxDecoration(gradient: t.accentGradient),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // The card is as narrow as the vertical Horizon's command
          // column; the variable label yields rather than overflow.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(lastIndexedLabel,
                    style: JaraType.caption
                        .copyWith(color: t.textOnSkyTertiary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
              Text(freeLabel,
                  style: JaraType.caption
                      .copyWith(color: t.textOnSkySecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
    );
  }
}
