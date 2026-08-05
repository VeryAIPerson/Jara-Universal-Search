import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../design/jara_theme.dart';
import '../design/motion.dart';
import '../design/tokens.dart';
import '../design/typography.dart';
import '../l10n_bridge.dart';
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
  Widget build(BuildContext context) => _StateBody(
        icon: icon,
        tint: context.jara.accent,
        title: title,
        message: message,
        primaryLabel: primaryLabel,
        onPrimary: onPrimary,
        secondaryLabel: secondaryLabel,
        onSecondary: onSecondary,
        onSky: onSky,
        compact: compact,
      );
}

/// Layout shared by [EmptyStateView] and [ErrorStateView]; the ring tint is
/// the only thing that separates a calm empty state from a failure.
class _StateBody extends StatelessWidget {
  const _StateBody({
    required this.icon,
    required this.tint,
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
  final Color tint;
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
              color: tint.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: tint.withValues(alpha: 0.25)),
            ),
            child: Icon(icon, color: tint, size: 32),
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

/// The one component every failure goes through. Copy comes from the
/// error catalogue (`s.errorTitle/errorBody/errorCta`) so no screen ever
/// invents its own wording, and technical codes never reach the user.
///
/// Reachable today: [JaraError.generic] and [JaraError.noConnection] on the
/// results screen, [JaraError.accountDisconnected] from a connection that
/// needs attention. The rest wait on the real index and will be raised by:
/// permissionDenied + sourceMissing from the source connectors,
/// fileUnreadable + indexingFailed + storageFull from the indexer,
/// localModelNotReady from the on-device model loader.
class ErrorStateView extends ConsumerWidget {
  const ErrorStateView(
    this.error, {
    super.key,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.onSky = false,
    this.compact = false,
  });

  final JaraError error;

  /// Runs the catalogue's CTA. Without it the button is not drawn — a
  /// failure screen must never offer an action that does nothing.
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final bool onSky;
  final bool compact;

  IconData get _icon => switch (error) {
        JaraError.permissionDenied => Icons.lock_outline_rounded,
        JaraError.fileUnreadable => Icons.broken_image_outlined,
        JaraError.indexingFailed => Icons.sync_problem_rounded,
        JaraError.accountDisconnected => Icons.link_off_rounded,
        JaraError.noConnection => Icons.cloud_off_rounded,
        JaraError.localModelNotReady => Icons.hourglass_empty_rounded,
        JaraError.storageFull => Icons.sd_storage_outlined,
        JaraError.sourceMissing => Icons.folder_off_outlined,
        JaraError.generic => Icons.refresh_rounded,
      };

  /// Accent = resolves itself, warning = needs a decision but nothing was
  /// lost, error = genuinely blocked until the user frees space.
  Color _tint(JaraTokens t) => switch (error) {
        JaraError.noConnection => t.accent,
        JaraError.localModelNotReady => t.accent,
        JaraError.generic => t.accent,
        JaraError.storageFull => t.error,
        _ => t.warning,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.strings;
    final cta = s.errorCta(error);

    return _StateBody(
      icon: _icon,
      tint: _tint(context.jara),
      title: s.errorTitle(error),
      message: s.errorBody(error),
      primaryLabel: onPrimary == null ? null : cta,
      onPrimary: onPrimary,
      secondaryLabel: secondaryLabel,
      onSecondary: onSecondary,
      onSky: onSky,
      compact: compact,
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
            // Flexible so a long translation or large Dynamic Type
            // ellipsizes instead of overflowing the fixed-height pill;
            // loose fit keeps short labels shrink-wrapped as before.
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: JaraType.button.copyWith(
                  color: gold ? const Color(0xFF171B2C) : Colors.white,
                ),
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
  const OfflineBanner({
    super.key,
    required this.label,
    this.margin = const EdgeInsets.fromLTRB(20, 8, 20, 0),
  });

  final String label;

  /// Screens that already carry page padding pass [EdgeInsets.zero] so the
  /// banner stays on the same grid as the search field above it.
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Container(
      margin: margin,
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

/// Reveals [OfflineBanner] without shoving the page around: the slot
/// collapses to zero height when online and grows by exactly the banner's
/// height when the connection drops. Reduce-motion turns the grow into a
/// cut via [JaraMotion.of].
class OfflineSlot extends StatelessWidget {
  const OfflineSlot({super.key, required this.offline, required this.label});

  final bool offline;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: JaraMotion.of(context, JaraMotion.base),
      curve: JaraMotion.standard,
      alignment: Alignment.topCenter,
      child: offline
          ? Padding(
              padding: const EdgeInsets.only(bottom: JaraSpacing.md),
              child: OfflineBanner(label: label, margin: EdgeInsets.zero),
            )
          : const SizedBox(width: double.infinity),
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
