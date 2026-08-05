import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/breakpoints.dart';
import '../../core/design/haptics.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/widgets/filter_chips.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/notch_app_bar.dart';
import '../../l10n/locales.dart';

/// Inside a Wrap, SearchFilterChip's centered AnimatedContainer greedily
/// fills the run's available width (each chip becomes a full-width bar).
/// IntrinsicWidth forces it back to its natural label width — chips hug
/// their text and the group reads as one segmented row, wrapping to a
/// second line only if it genuinely can't fit (large text scale).
Widget _segmented(Widget chip) => IntrinsicWidth(child: chip);

/// A settings list is a form: a 1400 dp row with a 60 dp label in it is a
/// bug, so the column caps and centres. Phones fall through untouched.
Widget _formColumn(WindowClass w, Widget child) => w.isPhone
    ? child
    : Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: JaraBreakpoints.proseMaxWidth),
          child: child,
        ),
      );

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _voiceEnabled = true;

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _startReindex(JaraStrings s) {
    JaraHaptics.confirm();
    ref.read(indexStateProvider.notifier).state = IndexState.indexing;
    _snack(s.connectionReindex);
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      ref.read(indexStateProvider.notifier).state = IndexState.idle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final stats = ref.watch(memoryStatsProvider);
    final w = context.windowClass;
    final inset = JaraBreakpoints.pageInsetFor(w);

    return Scaffold(
      backgroundColor: t.surface,
      body: SafeArea(
        child: _formColumn(
          w,
          ListView(
            padding: EdgeInsets.fromLTRB(inset, JaraSpacing.sm, inset,
                w.usesRail ? JaraSpacing.xxxl : 140),
            children: [
              Text(s.settingsTitle, style: JaraType.title1.copyWith(color: t.textPrimary)),
              const SizedBox(height: JaraSpacing.lg),
              _identityCard(t, s),
              const SizedBox(height: JaraSpacing.xl),
              _premiumCard(t, s),
              const SizedBox(height: JaraSpacing.xxl),
              SectionHeader(title: s.settingsTheme),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _segmented(SearchFilterChip(
                    label: s.settingsThemeDark,
                    selected: themeMode == ThemeMode.dark,
                    onSky: false,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).state = ThemeMode.dark,
                  )),
                  _segmented(SearchFilterChip(
                    label: s.settingsThemeLight,
                    selected: themeMode == ThemeMode.light,
                    onSky: false,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).state = ThemeMode.light,
                  )),
                  _segmented(SearchFilterChip(
                    label: s.settingsThemeSystem,
                    selected: themeMode == ThemeMode.system,
                    onSky: false,
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).state = ThemeMode.system,
                  )),
                ],
              ),
              const SizedBox(height: JaraSpacing.lg),
              SectionHeader(title: s.settingsLanguage),
              // Twenty languages is a list, not a chip row. Each name is
              // written in its own language so someone who cannot read the
              // current UI can still find theirs.
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final entry in jaraLocales)
                    _segmented(SearchFilterChip(
                      label: entry.endonym,
                      selected: resolveJaraLocale(locale).locale ==
                          entry.locale,
                      onSky: false,
                      onTap: () => ref.read(localeProvider.notifier).state =
                          entry.locale,
                    )),
                ],
              ),
              const SizedBox(height: JaraSpacing.xxl),
              SectionHeader(title: s.sectionGeneral),
              _SettingsTile(
                icon: Icons.hub_outlined,
                label: s.settingsConnectedAccounts,
                onTap: () => context.push('/profile/connections'),
              ),
              const SizedBox(height: 10),
              _SettingsTile(
                icon: Icons.shield_outlined,
                label: s.settingsPrivacySecurity,
                onTap: () => context.push('/profile/privacy'),
              ),
              const SizedBox(height: 10),
              _SettingsTile(
                icon: Icons.manage_search_rounded,
                label: s.settingsSearchSources,
                onTap: () => _snack(s.settingsSearchSources),
              ),
              const SizedBox(height: 10),
              _SettingsTile(
                icon: Icons.mic_none_rounded,
                label: s.settingsVoice,
                trailing: Semantics(
                  label: s.settingsVoice,
                  child: Switch.adaptive(
                    value: _voiceEnabled,
                    activeThumbColor: t.accent,
                    onChanged: (v) => setState(() => _voiceEnabled = v),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _SettingsTile(
                icon: Icons.notifications_none_rounded,
                label: s.settingsNotifications,
                onTap: () => _snack(s.settingsNotifications),
              ),
              const SizedBox(height: 10),
              _SettingsTile(
                icon: Icons.donut_small_outlined,
                label: s.settingsStorage,
                onTap: () => _snack(stats.storageUsedLabel),
              ),
              const SizedBox(height: 10),
              _SettingsTile(
                icon: Icons.sync_rounded,
                label: s.settingsIndexing,
                onTap: () => _startReindex(s),
              ),
              const SizedBox(height: JaraSpacing.xxl),
              Center(
                child: Text(
                  '${s.appName} · 0.1.0',
                  style: JaraType.caption.copyWith(color: t.textTertiary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _identityCard(JaraTokens t, JaraStrings s) {
    // Pill on its own row: sharing the top row with the pill squeezed the
    // email down to an unreadable ellipsis. The text column now gets the
    // full card width and the pill (a trust signal) still reads clearly
    // underneath, indented to the identity block it belongs to.
    return NeuCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(gradient: t.accentGradient, shape: BoxShape.circle),
                child: Text('A', style: JaraType.headline.copyWith(color: Colors.white)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Azad', style: JaraType.headline.copyWith(color: t.textPrimary)),
                    const SizedBox(height: 2),
                    Text(
                      'justarealassistant@gmail.com',
                      style: JaraType.footnote.copyWith(color: t.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 70),
            child: PrivacyPill(label: s.privacyLocalActive, active: true),
          ),
        ],
      ),
    );
  }

  Widget _premiumCard(JaraTokens t, JaraStrings s) {
    return NeuCard(
      onTap: () => _snack(s.settingsSubscription),
      semanticLabel: s.settingsPremium,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: t.gold.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.auto_awesome_rounded, color: t.gold, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.settingsPremium, style: JaraType.headline.copyWith(color: t.textPrimary)),
                const SizedBox(height: 3),
                Text(s.settingsPremiumBody,
                    style: JaraType.footnote.copyWith(color: t.textSecondary)),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: t.gold),
        ],
      ),
    );
  }
}

/// Row item for the General settings list: icon badge + label + trailing.
class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
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
              color: t.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: t.accent, size: 19),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: JaraType.bodyMedium.copyWith(color: t.textPrimary)),
          ),
          const SizedBox(width: 10),
          trailing ?? Icon(Icons.chevron_right_rounded, color: t.textTertiary),
        ],
      ),
    );
  }
}
