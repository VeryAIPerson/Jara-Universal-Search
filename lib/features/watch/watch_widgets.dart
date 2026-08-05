import 'package:flutter/material.dart';

import '../../core/design/jara_theme.dart';
import '../../core/design/motion.dart';
import '../../core/design/tokens.dart';
import '../../core/models/memory_item.dart';
import '../../core/widgets/pressable.dart';
import 'watch_layout.dart';
import 'watch_type.dart';

/// Quiet wordmark: the phone splash treatment reduced to one tracked
/// line, so the face still says whose app this is without spending
/// pixels a mic button needs.
class WatchWordmark extends StatelessWidget {
  const WatchWordmark({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Text(
      label.toUpperCase(),
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: WatchType.wordmark.copyWith(color: t.textOnSkyTertiary),
    );
  }
}

/// The one thing the watch is for. JaraFab's language — accent gradient,
/// hairline white rim, accent glow — at thumb scale for a wrist.
class WatchMicButton extends StatelessWidget {
  const WatchMicButton({
    super.key,
    required this.onTap,
    required this.semanticLabel,
  });

  final VoidCallback onTap;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final size = WatchMetrics.of(context).micSize;
    return Pressable(
      onTap: onTap,
      semanticLabel: semanticLabel,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: t.accentGradient,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.18),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: t.accent.withValues(alpha: 0.45),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(
          Icons.mic_rounded,
          color: Colors.white,
          size: size * 0.44,
        ),
      ),
    );
  }
}

class WatchSectionHeader extends StatelessWidget {
  const WatchSectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        title.toUpperCase(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: WatchType.section.copyWith(color: t.textOnSkyTertiary),
      ),
    );
  }
}

/// A past query the wearer can re-run with one tap.
class WatchRecentRow extends StatelessWidget {
  const WatchRecentRow({super.key, required this.query, required this.onTap});

  final String query;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Pressable(
      onTap: onTap,
      semanticLabel: query,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: WatchSize.touchMin),
        padding: const EdgeInsets.symmetric(
          horizontal: JaraSpacing.md,
          vertical: JaraSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: t.tileOnSky,
          borderRadius: BorderRadius.circular(JaraRadius.card),
          border: Border.all(color: t.borderOnSky),
        ),
        child: Row(
          children: [
            Icon(Icons.history_rounded, size: 18, color: t.textOnSkyTertiary),
            const SizedBox(width: JaraSpacing.sm),
            Expanded(
              child: Text(
                query,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: WatchType.recent.copyWith(color: t.textOnSky),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact result row: type icon, title (2 lines), one metadata line.
class WatchResultRow extends StatelessWidget {
  const WatchResultRow({
    super.key,
    required this.item,
    required this.meta,
    required this.onTap,
  });

  final MemoryItem item;
  final String meta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Pressable(
      onTap: onTap,
      semanticLabel: '${item.title}, $meta',
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: WatchSize.rowMin),
        padding: const EdgeInsets.all(JaraSpacing.md),
        decoration: BoxDecoration(
          color: t.tileOnSky,
          borderRadius: BorderRadius.circular(JaraRadius.card),
          border: Border.all(color: t.borderOnSky),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: WatchSize.typeChip,
              height: WatchSize.typeChip,
              decoration: BoxDecoration(
                color: item.type.color.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(JaraRadius.chip),
              ),
              child: Icon(item.type.icon, size: 18, color: item.type.color),
            ),
            const SizedBox(width: JaraSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: WatchType.rowTitle.copyWith(color: t.textOnSky),
                  ),
                  const SizedBox(height: JaraSpacing.xs),
                  Text(
                    meta,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        WatchType.meta.copyWith(color: t.textOnSkySecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The single primary action a watch screen may carry. [confirmed] swaps
/// the accent gradient for the success fill and the label for [doneLabel]
/// — a wrist has no room for a snackbar, so the button reports on itself.
class WatchPrimaryAction extends StatelessWidget {
  const WatchPrimaryAction({
    super.key,
    required this.label,
    required this.doneLabel,
    required this.icon,
    required this.onTap,
    this.confirmed = false,
  });

  final String label;
  final String doneLabel;
  final IconData icon;
  final VoidCallback onTap;
  final bool confirmed;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final text = confirmed ? doneLabel : label;
    return Pressable(
      onTap: confirmed ? null : onTap,
      semanticLabel: text,
      child: AnimatedContainer(
        duration: JaraMotion.of(context, JaraMotion.fast),
        curve: JaraMotion.standard,
        width: double.infinity,
        constraints:
            const BoxConstraints(minHeight: WatchSize.actionHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: JaraSpacing.lg,
          vertical: JaraSpacing.md,
        ),
        decoration: BoxDecoration(
          gradient: confirmed ? null : t.accentGradient,
          color: confirmed ? t.success.withValues(alpha: 0.18) : null,
          borderRadius: BorderRadius.circular(JaraRadius.tile),
          border: Border.all(
            color: confirmed
                ? t.success.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              confirmed ? Icons.check_rounded : icon,
              size: 20,
              color: confirmed ? t.success : Colors.white,
            ),
            const SizedBox(width: JaraSpacing.sm),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: WatchType.action.copyWith(
                  color: confirmed ? t.success : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty, offline and error all land here — one soft ring, a title, a
/// message and at most one action, constrained to the inscribed square.
class WatchStateView extends StatelessWidget {
  const WatchStateView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.tint,
    this.actionLabel,
    this.actionIcon = Icons.refresh_rounded,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color? tint;
  final String? actionLabel;
  final IconData actionIcon;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final ring = tint ?? t.accent;
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: WatchMetrics.of(context).heroWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: ring.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: ring.withValues(alpha: 0.25)),
            ),
            child: Icon(icon, color: ring, size: 26),
          ),
          const SizedBox(height: JaraSpacing.lg),
          Text(
            title,
            textAlign: TextAlign.center,
            style: WatchType.title.copyWith(color: t.textOnSky),
          ),
          const SizedBox(height: JaraSpacing.sm),
          Text(
            message,
            textAlign: TextAlign.center,
            style: WatchType.meta.copyWith(color: t.textOnSkySecondary),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: JaraSpacing.lg),
            WatchPrimaryAction(
              label: actionLabel!,
              doneLabel: actionLabel!,
              icon: actionIcon,
              onTap: onAction!,
            ),
          ],
        ],
      ),
    );
  }
}

/// Slim offline marker. Local search keeps working, so this states the
/// fact and never blocks the list underneath it.
class WatchNotice extends StatelessWidget {
  const WatchNotice({super.key, required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: JaraSpacing.md,
        vertical: JaraSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: t.warning.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(JaraRadius.chip),
        border: Border.all(color: t.warning.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: t.warning),
          const SizedBox(width: JaraSpacing.sm),
          Flexible(
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: WatchType.meta.copyWith(color: t.warning),
            ),
          ),
        ],
      ),
    );
  }
}
