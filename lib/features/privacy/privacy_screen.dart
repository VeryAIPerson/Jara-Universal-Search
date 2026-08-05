import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/haptics.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/neu_tile.dart';

class PrivacyScreen extends ConsumerStatefulWidget {
  const PrivacyScreen({super.key});

  @override
  ConsumerState<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends ConsumerState<PrivacyScreen> {
  bool _appLock = false;
  bool _biometric = false;
  bool _sensitive = true;

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _confirmDelete(JaraTokens t, JaraStrings s) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: t.surfaceElevated,
        title: Text(s.privacyDeleteConfirmTitle,
            style: JaraType.title2.copyWith(color: t.textPrimary)),
        content: Text(s.privacyDeleteConfirmBody,
            style: JaraType.subhead.copyWith(color: t.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(s.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              JaraHaptics.heavy();
              _snack('Your memory has been cleared.'); // l10n-todo
            },
            style: TextButton.styleFrom(foregroundColor: t.error),
            child: Text(s.confirmDelete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    final tier = ref.watch(privacyTierProvider);
    final localOnly = tier == PrivacyTier.localOnly;

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
                  child: Text(s.privacyTitle,
                      style: JaraType.title2.copyWith(color: t.textPrimary)),
                ),
              ],
            ),
            const SizedBox(height: JaraSpacing.xl),
            NeuCard(
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: t.success.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: Border.all(color: t.success.withValues(alpha: 0.3)),
                    ),
                    child: Icon(Icons.shield_rounded, color: t.success, size: 30),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    localOnly ? s.privacyLocalActive : s.privacyCloudOn,
                    style: JaraType.headline.copyWith(color: t.textPrimary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    localOnly ? s.privacyCloudOff : '',
                    style: JaraType.caption.copyWith(color: t.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: JaraSpacing.xl),
            _infoBlock(t, Icons.smartphone_rounded, t.success, s.privacyOnDevice,
                s.privacyOnDeviceBody),
            const SizedBox(height: JaraSpacing.md),
            _infoBlock(t, Icons.cloud_outlined, t.accentBright, s.privacyCloudSection,
                s.privacyCloudBody),
            const SizedBox(height: JaraSpacing.xxl),
            SectionHeader(title: s.sectionIntelligence),
            _ToggleTile(
              icon: Icons.memory_rounded,
              iconColor: t.success,
              label: s.privacyLocalAi,
              value: true,
              onChanged: (_) => _snack(s.alwaysOn),
            ),
            const SizedBox(height: 10),
            _ToggleTile(
              icon: Icons.cloud_queue_rounded,
              iconColor: t.accentBright,
              label: s.privacyCloudAi,
              value: tier == PrivacyTier.hybrid,
              onChanged: (v) {
                JaraHaptics.select();
                ref.read(privacyTierProvider.notifier).state =
                    v ? PrivacyTier.hybrid : PrivacyTier.localOnly;
              },
            ),
            const SizedBox(height: JaraSpacing.lg),
            SectionHeader(title: s.settingsPrivacySecurity),
            _ToggleTile(
              icon: Icons.lock_outline_rounded,
              iconColor: t.accent,
              label: s.privacyAppLock,
              value: _appLock,
              onChanged: (v) => setState(() => _appLock = v),
            ),
            const SizedBox(height: 10),
            _ToggleTile(
              icon: Icons.fingerprint_rounded,
              iconColor: t.accent,
              label: s.privacyBiometric,
              value: _biometric,
              onChanged: (v) => setState(() => _biometric = v),
            ),
            const SizedBox(height: 10),
            _ToggleTile(
              icon: Icons.visibility_off_outlined,
              iconColor: t.accent,
              label: s.privacySensitive,
              value: _sensitive,
              onChanged: (v) => setState(() => _sensitive = v),
            ),
            const SizedBox(height: JaraSpacing.xxl),
            SectionHeader(title: s.sectionData),
            _ActionTile(
              icon: Icons.file_download_outlined,
              label: s.privacyExport,
              onTap: () => _snack(s.privacyExport),
            ),
            const SizedBox(height: 10),
            _ActionTile(
              icon: Icons.history_toggle_off_rounded,
              label: s.privacyClearHistory,
              onTap: () {
                JaraHaptics.confirm();
                _snack(s.privacyClearHistory);
              },
            ),
            const SizedBox(height: 10),
            _ActionTile(
              icon: Icons.delete_outline_rounded,
              label: s.privacyDeleteAll,
              danger: true,
              onTap: () => _confirmDelete(t, s),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBlock(
      JaraTokens t, IconData icon, Color iconColor, String title, String body) {
    return NeuCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: JaraType.bodyMedium.copyWith(color: t.textPrimary)),
                const SizedBox(height: 4),
                Text(body, style: JaraType.footnote.copyWith(color: t.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Icon badge + label + Switch row, shared by the Intelligence and
/// Privacy & security sections.
class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return NeuCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 19),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: JaraType.bodyMedium.copyWith(color: t.textPrimary)),
          ),
          const SizedBox(width: 10),
          Semantics(
            label: label,
            child: Switch.adaptive(
              value: value,
              activeThumbColor: t.accent,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

/// Icon badge + label + chevron row for the Data section. [danger] tints
/// every element (badge, label, chevron) in the error color.
class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final color = danger ? t.error : t.accent;
    return NeuCard(
      padding: const EdgeInsets.all(14),
      onTap: onTap,
      semanticLabel: label,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 19),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: JaraType.bodyMedium.copyWith(color: danger ? t.error : t.textPrimary),
            ),
          ),
          const SizedBox(width: 10),
          Icon(Icons.chevron_right_rounded, color: danger ? t.error : t.textTertiary),
        ],
      ),
    );
  }
}
