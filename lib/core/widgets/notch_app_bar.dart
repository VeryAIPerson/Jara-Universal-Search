import 'package:flutter/material.dart';

import '../design/jara_theme.dart';
import '../design/tokens.dart';
import '../design/typography.dart';
import 'neu_tile.dart';
import 'pressable.dart';

/// Top bar of the memory sky: status action left, avatar hanging in a
/// carved notch center, settings right — mirrors the reference header.
class NotchAppBar extends StatelessWidget {
  const NotchAppBar({
    super.key,
    this.leadingIcon,
    this.onLeadingTap,
    this.leadingSemanticLabel,
    this.trailingIcon,
    this.onTrailingTap,
    this.trailingSemanticLabel,
    this.avatarInitials = 'A',
    this.onAvatarTap,
  });

  final IconData? leadingIcon;
  final VoidCallback? onLeadingTap;
  final String? leadingSemanticLabel;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final String? trailingSemanticLabel;
  final String avatarInitials;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return SizedBox(
      height: 64,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leadingIcon != null)
                NeuIconButton(
                  icon: leadingIcon!,
                  onTap: onLeadingTap,
                  onSky: true,
                  semanticLabel: leadingSemanticLabel,
                )
              else
                const SizedBox(width: 44),
              if (trailingIcon != null)
                NeuIconButton(
                  icon: trailingIcon!,
                  onTap: onTrailingTap,
                  onSky: true,
                  semanticLabel: trailingSemanticLabel,
                )
              else
                const SizedBox(width: 44),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Pressable(
              onTap: onAvatarTap,
              semanticLabel: 'Profile',
              child: Container(
                width: JaraSize.avatarNotch + 12,
                height: JaraSize.avatarNotch + 8,
                decoration: BoxDecoration(
                  color: t.tileOnSky,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  border: Border.all(color: t.borderOnSky),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: JaraSize.avatarNotch - 12,
                  height: JaraSize.avatarNotch - 12,
                  decoration: BoxDecoration(
                    gradient: t.accentGradient,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    avatarInitials,
                    style: JaraType.footnoteMedium
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "Local Processing Active" style trust pill.
class PrivacyPill extends StatelessWidget {
  const PrivacyPill({
    super.key,
    required this.label,
    this.active = true,
    this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final color = active ? t.success : t.textOnSkyTertiary;
    final pill = Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            // Flexible, not Expanded: the pill still shrink-wraps in an
            // unbounded row, but truncates instead of overflowing when a
            // translated label meets a narrow command column.
            Flexible(
              child: Text(
                label,
                style: JaraType.caption.copyWith(color: color),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    if (onTap == null) return Semantics(label: label, child: pill);
    return Pressable(onTap: onTap, semanticLabel: label, child: pill);
  }
}
