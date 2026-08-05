import 'package:flutter/material.dart';

import '../design/haptics.dart';
import '../design/jara_theme.dart';
import '../design/motion.dart';
import '../design/tokens.dart';
import '../design/typography.dart';
import '../models/memory_item.dart';

/// Horizontal source-filter rail. Pass [onSky] true when it sits on the
/// dark hemisphere.
class FilterChipRow extends StatelessWidget {
  const FilterChipRow({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.allLabel,
    required this.labelOf,
    this.onSky = true,
    this.types = MemoryType.values,
  });

  final MemoryType? selected;
  final ValueChanged<MemoryType?> onSelected;
  final String allLabel;
  final String Function(MemoryType) labelOf;
  final bool onSky;
  final List<MemoryType> types;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          SearchFilterChip(
            label: allLabel,
            selected: selected == null,
            onTap: () => onSelected(null),
            onSky: onSky,
          ),
          for (final type in types)
            SearchFilterChip(
              label: labelOf(type),
              icon: type.icon,
              selected: selected == type,
              onTap: () => onSelected(type),
              onSky: onSky,
            ),
        ],
      ),
    );
  }
}

class SearchFilterChip extends StatelessWidget {
  const SearchFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
    this.onSky = true,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;
  final bool onSky;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final baseBg = onSky ? t.tileOnSky : t.tile;
    final baseFg = onSky ? t.textOnSkySecondary : t.textSecondary;

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        child: GestureDetector(
          onTap: () {
            JaraHaptics.select();
            onTap();
          },
          child: AnimatedContainer(
            duration: JaraMotion.of(context, JaraMotion.base),
            curve: JaraMotion.standard,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? t.accent : baseBg,
              borderRadius: BorderRadius.circular(JaraRadius.chip),
              border: Border.all(
                color: selected
                    ? t.accent
                    : (onSky ? t.borderOnSky : t.border),
              ),
              boxShadow: selected ? t.accentGlow : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon,
                      size: 15, color: selected ? Colors.white : baseFg),
                  const SizedBox(width: 5),
                ],
                Text(
                  label,
                  style: JaraType.footnoteMedium.copyWith(
                    color: selected ? Colors.white : baseFg,
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

/// Small metadata chip (tag, collection, source).
class JaraChip extends StatelessWidget {
  const JaraChip({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final c = color ?? t.accent;
    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: c),
            const SizedBox(width: 4),
          ],
          Text(label, style: JaraType.caption.copyWith(color: c)),
        ],
      ),
    );
    if (onTap == null) return chip;
    return GestureDetector(onTap: onTap, child: chip);
  }
}
