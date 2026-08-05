import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/haptics.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/tokens.dart';
import '../../core/l10n_bridge.dart';
import 'watch_layout.dart';
import 'watch_routes.dart';
import 'watch_type.dart';
import 'watch_widgets.dart';

/// One memory on the wrist: enough to know it is the right one, then the
/// hand-off. Everything else — preview, tags, related, actions — stays on
/// the phone by design (D18).
class WatchDetailScreen extends ConsumerStatefulWidget {
  const WatchDetailScreen({super.key, required this.itemId});

  final String itemId;

  @override
  ConsumerState<WatchDetailScreen> createState() => _WatchDetailScreenState();
}

class _WatchDetailScreenState extends ConsumerState<WatchDetailScreen> {
  /// Long enough to read, short enough that the wrist drops before it
  /// reverts — same flash budget as the phone FAB's success state.
  static const _confirmFlash = Duration(milliseconds: 1800);

  bool _handedOff = false;
  Timer? _revert;

  @override
  void dispose() {
    _revert?.cancel();
    super.dispose();
  }

  void _openOnPhone() {
    // Hand-off hook. On Wear this becomes a Data Layer call —
    // MessageClient.sendMessage("/jara/open", itemId) to the paired node,
    // with the phone app answering through a WearableListenerService and
    // deep-linking to /item/:id. The watchOS twin (v1.1, D18) uses
    // WatchConnectivity.sendMessage with the same payload. Until that
    // plumbing exists the action only confirms locally.
    JaraHaptics.confirm();
    _revert?.cancel();
    setState(() => _handedOff = true);
    _revert = Timer(_confirmFlash, () {
      if (!mounted) return;
      setState(() => _handedOff = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    final item = ref.watch(memoryRepositoryProvider).byId(widget.itemId);

    void dismiss() {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(WatchRoutes.home);
      }
    }

    if (item == null) {
      return WatchScaffold(
        child: WatchDismissible(
          onDismiss: dismiss,
          child: WatchScrollView(
            children: [
              WatchStateView(
                icon: Icons.folder_off_outlined,
                tint: t.warning,
                title: s.errorTitle(JaraError.sourceMissing),
                message: s.errorBody(JaraError.sourceMissing),
              ),
            ],
          ),
        ),
      );
    }

    return WatchScaffold(
      child: WatchDismissible(
        onDismiss: dismiss,
        child: WatchScrollView(
          centered: false,
          children: [
            Container(
              width: WatchSize.typeChip,
              height: WatchSize.typeChip,
              decoration: BoxDecoration(
                color: item.type.color.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(JaraRadius.chip),
              ),
              child: Icon(item.type.icon, size: 16, color: item.type.color),
            ),
            const SizedBox(height: JaraSpacing.md),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: WatchType.title.copyWith(color: t.textOnSky),
            ),
            const SizedBox(height: JaraSpacing.sm),
            Text(
              item.snippet,
              textAlign: TextAlign.center,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: WatchType.body.copyWith(color: t.textOnSkySecondary),
            ),
            const SizedBox(height: JaraSpacing.md),
            Text(
              '${item.source} · ${relativeDate(s, item.date, now: ref.now)}',
              textAlign: TextAlign.center,
              style: WatchType.meta.copyWith(color: t.textOnSkyTertiary),
            ),
            const SizedBox(height: JaraSpacing.xl),
            WatchPrimaryAction(
              // l10n-todo: no deck key covers the wrist→phone hand-off.
              label: 'Open on phone',
              doneLabel: 'Sent to your phone',
              icon: Icons.phonelink_rounded,
              confirmed: _handedOff,
              onTap: _openOnPhone,
            ),
          ],
        ),
      ),
    );
  }
}
