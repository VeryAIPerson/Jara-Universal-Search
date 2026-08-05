import 'package:flutter/material.dart';

import '../design/jara_theme.dart';
import '../design/typography.dart';
import '../models/memory_item.dart';
import 'filter_chips.dart';
import 'neu_card.dart';
import 'pressable.dart';
import 'skeletons.dart';

/// Optional answer card above results. Short, sourced, never authoritative:
/// always carries "Based on N saved items" and links back to sources.
class SmartSummaryCard extends StatelessWidget {
  const SmartSummaryCard({
    super.key,
    required this.summary,
    required this.titleLabel,
    required this.basedOnLabel,
    required this.viewSourcesLabel,
    this.onViewSources,
    this.onCopy,
    this.onSave,
  });

  final SmartSummary summary;
  final String titleLabel;

  /// e.g. "Based on 4 saved items"
  final String basedOnLabel;
  final String viewSourcesLabel;
  final VoidCallback? onViewSources;
  final VoidCallback? onCopy;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return NeuCard(
      onSky: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded, size: 16, color: t.gold),
              const SizedBox(width: 6),
              Text(
                titleLabel.toUpperCase(),
                style: JaraType.label.copyWith(color: t.gold),
              ),
              const Spacer(),
              if (onCopy != null)
                Pressable(
                  onTap: onCopy,
                  semanticLabel: 'Copy summary',
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(Icons.copy_rounded,
                        size: 16, color: t.textOnSkyTertiary),
                  ),
                ),
              if (onSave != null) ...[
                const SizedBox(width: 8),
                Pressable(
                  onTap: onSave,
                  semanticLabel: 'Save answer',
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(Icons.bookmark_add_outlined,
                        size: 16, color: t.textOnSkyTertiary),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Text(
            summary.text,
            style: JaraType.body.copyWith(color: t.textOnSky),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              JaraChip(
                label: basedOnLabel,
                icon: Icons.layers_outlined,
                color: t.accentBright,
                onTap: onViewSources,
              ),
              const Spacer(),
              Pressable(
                onTap: onViewSources,
                semanticLabel: viewSourcesLabel,
                child: Text(
                  viewSourcesLabel,
                  style:
                      JaraType.footnoteMedium.copyWith(color: t.accent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SmartSummarySkeleton extends StatelessWidget {
  const SmartSummarySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const NeuCard(
      onSky: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLine(width: 110, height: 10),
          SizedBox(height: 14),
          SkeletonLine(height: 12),
          SizedBox(height: 8),
          SkeletonLine(height: 12),
          SizedBox(height: 8),
          SkeletonLine(width: 180, height: 12),
        ],
      ),
    );
  }
}
