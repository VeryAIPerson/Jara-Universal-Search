import 'package:flutter/material.dart';

import '../design/jara_theme.dart';
import '../design/typography.dart';
import 'pressable.dart';

/// Shared empty/error scaffold: soft icon ring, title, message, CTAs.
class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.onSky = false,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final bool onSky;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final titleColor = onSky ? t.textOnSky : t.textPrimary;
    final secondary = onSky ? t.textOnSkySecondary : t.textSecondary;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: compact ? 24 : 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: t.accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: t.accent.withValues(alpha: 0.25)),
            ),
            child: Icon(icon, color: t.accent, size: 32),
          ),
          const SizedBox(height: 20),
          Text(title,
              style: JaraType.title2.copyWith(color: titleColor),
              textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              message,
              style: JaraType.subhead.copyWith(color: secondary),
              textAlign: TextAlign.center,
            ),
          ),
          if (primaryLabel != null) ...[
            const SizedBox(height: 24),
            JaraButton(label: primaryLabel!, onTap: onPrimary),
          ],
          if (secondaryLabel != null) ...[
            const SizedBox(height: 12),
            Pressable(
              onTap: onSecondary,
              semanticLabel: secondaryLabel,
              child: Text(
                secondaryLabel!,
                style: JaraType.callout.copyWith(color: t.accent),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Primary filled button — accent gradient, pill radius, glow.
class JaraButton extends StatelessWidget {
  const JaraButton({
    super.key,
    required this.label,
    required this.onTap,
    this.expanded = false,
    this.gold = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onTap;
  final bool expanded;

  /// Gold = reserved for brand-level moments (Build My Memory).
  final bool gold;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final button = Pressable(
      onTap: onTap,
      semanticLabel: label,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          gradient: gold
              ? const LinearGradient(
                  colors: [Color(0xFFD4AF6E), Color(0xFFF1CE88)])
              : t.accentGradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: (gold ? t.gold : t.accent).withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 20,
                  color: gold ? const Color(0xFF171B2C) : Colors.white),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: JaraType.button.copyWith(
                color: gold ? const Color(0xFF171B2C) : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Secondary soft button.
class JaraSoftButton extends StatelessWidget {
  const JaraSoftButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.onSky = false,
    this.expanded = false,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool onSky;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final fg = onSky ? t.textOnSky : t.textPrimary;
    final button = Pressable(
      onTap: onTap,
      semanticLabel: label,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: onSky ? t.tileOnSky : t.tile,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: onSky ? t.borderOnSky : t.border),
          boxShadow: onSky ? null : t.neuShadows,
        ),
        child: Row(
          mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: fg),
              const SizedBox(width: 8),
            ],
            Text(label, style: JaraType.button.copyWith(color: fg)),
          ],
        ),
      ),
    );
    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Slim offline indicator, non-blocking.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: t.warning.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: t.warning.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_off_rounded, size: 14, color: t.warning),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: JaraType.caption.copyWith(color: t.warning),
            ),
          ),
        ],
      ),
    );
  }
}

/// Staggered entrance for result lists.
class StaggeredItem extends StatelessWidget {
  const StaggeredItem({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 240 + (index.clamp(0, 8) * 40)),
      curve: Curves.easeOutQuart,
      builder: (context, v, c) => Opacity(
        opacity: v,
        child: Transform.translate(offset: Offset(0, 14 * (1 - v)), child: c),
      ),
      child: child,
    );
  }
}
