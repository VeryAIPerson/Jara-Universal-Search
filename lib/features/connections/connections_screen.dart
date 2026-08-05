import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/haptics.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/models/memory_item.dart';
import '../../core/widgets/filter_chips.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/neu_tile.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/state_views.dart';

class ConnectionsScreen extends ConsumerStatefulWidget {
  const ConnectionsScreen({super.key});

  @override
  ConsumerState<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

class _ConnectionsScreenState extends ConsumerState<ConnectionsScreen> {
  final Map<String, ConnectionStatus> _overrides = {};

  @override
  void initState() {
    super.initState();
    // ConnectionInfo is immutable — connect/disconnect taps only mutate this
    // local copy, seeded once from the repo's current statuses.
    for (final c in ref.read(memoryRepositoryProvider).connections) {
      _overrides[c.id] = c.status;
    }
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _reconnect(ConnectionInfo c) {
    setState(() => _overrides[c.id] = ConnectionStatus.connected);
    JaraHaptics.confirm();
  }

  /// A card that needs attention is otherwise a dead end: tapping it opens
  /// the one place that explains what broke and offers the way back.
  Future<void> _showReconnectSheet(ConnectionInfo c) {
    final t = context.jara;
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: t.surfaceElevated,
      barrierColor: t.scrim,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(JaraRadius.sheet)),
      ),
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.fromLTRB(
            JaraSpacing.xl, JaraSpacing.md, JaraSpacing.xl, JaraSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: t.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ErrorStateView(
              JaraError.accountDisconnected,
              compact: true,
              onPrimary: () {
                Navigator.of(sheetContext).pop();
                _reconnect(c);
              },
            ),
          ],
        ),
      ),
    );
  }

  (Color, String) _statusVisuals(JaraTokens t, JaraStrings s, ConnectionStatus status) {
    return switch (status) {
      ConnectionStatus.connected => (t.success, s.connectionConnected),
      ConnectionStatus.syncing => (t.accent, s.connectionSyncing),
      ConnectionStatus.disconnected => (t.textTertiary, s.connectionDisconnected),
      ConnectionStatus.attention => (t.warning, s.connectionAttention),
    };
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(memoryRevisionProvider);
    final t = context.jara;
    final s = ref.strings;
    final connections = ref.watch(memoryRepositoryProvider).connections;

    return Scaffold(
      backgroundColor: t.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            JaraSpacing.page, JaraSpacing.xl, JaraSpacing.page, JaraSpacing.huge),
          children: [
            Row(
              children: [
                NeuIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => context.pop(),
                  semanticLabel: s.back,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.connectionsTitle,
                          style: JaraType.title2.copyWith(color: t.textPrimary)),
                      const SizedBox(height: 2),
                      Text(s.connectionsSubtitle,
                          style: JaraType.footnote.copyWith(color: t.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: JaraSpacing.xl),
            for (var i = 0; i < connections.length; i++) ...[
              StaggeredItem(index: i, child: _card(t, s, connections[i])),
              if (i != connections.length - 1) const SizedBox(height: JaraSpacing.md),
            ],
          ],
        ),
      ),
    );
  }

  Widget _card(JaraTokens t, JaraStrings s, ConnectionInfo c) {
    final status = _overrides[c.id] ?? c.status;
    final (statusColor, statusLabel) = _statusVisuals(t, s, status);
    final connected = status == ConnectionStatus.connected;
    final needsAttention = status == ConnectionStatus.attention;

    return NeuCard(
      padding: const EdgeInsets.all(14),
      onTap: needsAttention ? () => _showReconnectSheet(c) : null,
      semanticLabel: needsAttention ? '${c.name} · $statusLabel' : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: t.accent.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(c.icon, color: statusColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name, style: JaraType.headline.copyWith(color: t.textPrimary)),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration:
                              BoxDecoration(color: statusColor, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 6),
                        Text(statusLabel, style: JaraType.caption.copyWith(color: statusColor)),
                        // The whole card is the reconnect entry point;
                        // the chevron is what says so.
                        if (needsAttention) ...[
                          const SizedBox(width: 2),
                          Icon(Icons.chevron_right_rounded,
                              size: 14, color: statusColor),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (status == ConnectionStatus.disconnected)
                JaraChip(
                  label: s.connectionConnect,
                  color: t.accent,
                  onTap: () {
                    setState(() => _overrides[c.id] = ConnectionStatus.connected);
                    JaraHaptics.confirm();
                  },
                )
              else
                NeuIconButton(
                  icon: Icons.sync_rounded,
                  size: 38,
                  semanticLabel: s.connectionReindex,
                  onTap: () {
                    JaraHaptics.confirm();
                    _snack(s.connectionSyncing);
                  },
                ),
            ],
          ),
          if (connected) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  s.lastSynced(relativeDate(s, c.lastSync ?? DateTime.now())),
                  style: JaraType.caption.copyWith(color: t.textTertiary),
                ),
                const Spacer(),
                Text(c.permissionLabel ?? '',
                    style: JaraType.caption.copyWith(color: t.textSecondary)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Pressable(
                  onTap: () {
                    setState(() => _overrides[c.id] = ConnectionStatus.disconnected);
                    JaraHaptics.heavy();
                  },
                  semanticLabel: s.connectionDisconnect,
                  child: Text(
                    s.connectionDisconnect,
                    style: JaraType.footnoteMedium.copyWith(color: t.error),
                  ),
                ),
                const Spacer(),
                Pressable(
                  onTap: () => _snack(s.connectionSyncing),
                  semanticLabel: s.connectionReindex,
                  child: Text(
                    s.connectionReindex,
                    style: JaraType.footnoteMedium.copyWith(color: t.accent),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
