import 'package:flutter/material.dart';

import '../design/jara_theme.dart';
import '../design/tokens.dart';
import '../design/typography.dart';
import 'pressable.dart';

/// Soft rounded card. On the sky hemisphere it renders as an elevated
/// dark panel; on the surface hemisphere it gets the neumorphic dual
/// shadow.
class NeuCard extends StatelessWidget {
  const NeuCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.onSky = false,
    this.padding = const EdgeInsets.all(16),
    this.radius = JaraRadius.card,
    this.semanticLabel,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool onSky;
  final EdgeInsetsGeometry padding;
  final double radius;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: onSky ? t.tileOnSky : t.surfaceElevated,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: onSky ? t.borderOnSky : t.border),
        boxShadow: onSky ? null : t.neuShadows,
      ),
      child: child,
    );
    if (onTap == null && onLongPress == null) return card;
    return Pressable(
      onTap: onTap,
      onLongPress: onLongPress,
      semanticLabel: semanticLabel,
      child: card,
    );
  }
}

/// Uppercase caption header with optional trailing action.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.onSky = false,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool onSky;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: JaraType.label.copyWith(
              color: onSky ? t.textOnSkyTertiary : t.textTertiary,
            ),
          ),
          if (actionLabel != null)
            Pressable(
              onTap: onAction,
              semanticLabel: actionLabel,
              child: Text(
                actionLabel!,
                style: JaraType.footnoteMedium.copyWith(color: t.accent),
              ),
            ),
        ],
      ),
    );
  }
}
