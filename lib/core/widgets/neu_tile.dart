import 'package:flutter/material.dart';

import '../design/jara_theme.dart';
import '../design/tokens.dart';
import '../design/typography.dart';
import 'pressable.dart';

/// Soft neumorphic square tile — the reference grid's building block.
/// Icon sits in a tinted badge; [label] below; [meta] is the tiny
/// third line (".pdf", "128 items").
class NeuTile extends StatelessWidget {
  const NeuTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    this.meta,
    this.onTap,
    this.badge,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String? meta;
  final VoidCallback? onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Pressable(
      onTap: onTap,
      semanticLabel: meta == null ? label : '$label, $meta',
      child: Container(
        decoration: BoxDecoration(
          color: t.tile,
          borderRadius: BorderRadius.circular(JaraRadius.tile),
          border: Border.all(color: t.border, width: 1),
          boxShadow: t.neuShadows,
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: t.isDark ? 0.16 : 0.14),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(icon, color: iconColor, size: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    label,
                    style:
                        JaraType.footnoteMedium.copyWith(color: t.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (meta != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      meta!,
                      style: JaraType.caption.copyWith(color: t.textTertiary),
                      maxLines: 1,
                    ),
                  ],
                ],
              ),
            ),
            if (badge != null)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: t.accent.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge!,
                    style: JaraType.caption.copyWith(color: t.accent),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Small soft circular icon button (app-bar actions, quick actions).
class NeuIconButton extends StatelessWidget {
  const NeuIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.onSky = false,
    this.size = 44,
    this.iconColor,
    this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback? onTap;

  /// True when rendered on the dark hemisphere.
  final bool onSky;
  final double size;
  final Color? iconColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final bg = onSky ? t.tileOnSky : t.tile;
    final fg = iconColor ?? (onSky ? t.textOnSkySecondary : t.textSecondary);
    return Pressable(
      onTap: onTap,
      semanticLabel: semanticLabel,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(color: onSky ? t.borderOnSky : t.border),
          boxShadow: onSky ? null : t.neuShadows,
        ),
        child: Icon(icon, size: size * 0.44, color: fg),
      ),
    );
  }
}
