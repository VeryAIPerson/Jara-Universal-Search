import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/breakpoints.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/motion.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/widgets/filter_chips.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/neu_tile.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/state_views.dart';

/// Plan cards and explanatory copy are a form, so the column caps and
/// centres instead of stretching two cards across a monitor.
Widget _formColumn(WindowClass w, Widget child) => w.isPhone
    ? child
    : Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: JaraBreakpoints.proseMaxWidth),
          child: child,
        ),
      );

/// Store pricing is unset until the purchase build (v1.1), so the plan
/// cards show a typographic placeholder rather than an invented number in
/// twenty markets. [JaraStrings.paywallPriceNote] says where the real
/// figure comes from.
const _priceUnset = '—';

enum _Plan { monthly, yearly }

/// The one screen where gold is the subject rather than an accent (D2):
/// hero glow, the Cloud Intelligence badge, the value chip and the CTA.
/// Everything else stays on the product accent so it still reads calm.
class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  /// Yearly leads because it carries the value chip; nothing is charged
  /// either way until purchases exist.
  _Plan _plan = _Plan.yearly;

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    final w = context.windowClass;
    final inset = JaraBreakpoints.pageInsetFor(w);

    return Scaffold(
      backgroundColor: t.surface,
      body: SafeArea(
        child: _formColumn(
          w,
          ListView(
            padding: EdgeInsets.fromLTRB(
                inset, JaraSpacing.xl, inset, JaraSpacing.huge),
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
                    child: Text(s.settingsPremium,
                        style: JaraType.title2.copyWith(color: t.textPrimary)),
                  ),
                ],
              ),
              const SizedBox(height: JaraSpacing.xl),
              _hero(t, s),
              const SizedBox(height: JaraSpacing.xxl),
              _feature(t, Icons.cloud_queue_rounded, t.gold,
                  s.paywallFeatCloudTitle, s.paywallFeatCloudBody),
              const SizedBox(height: JaraSpacing.md),
              _feature(t, Icons.hub_outlined, t.accent,
                  s.paywallFeatConnectionsTitle, s.paywallFeatConnectionsBody),
              const SizedBox(height: JaraSpacing.md),
              _feature(t, Icons.bolt_rounded, t.accentBright,
                  s.paywallFeatIndexingTitle, s.paywallFeatIndexingBody),
              const SizedBox(height: JaraSpacing.xxl),
              _plans(t, s, w),
              const SizedBox(height: JaraSpacing.md),
              Text(
                s.paywallPriceNote,
                style: JaraType.caption.copyWith(color: t.textTertiary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: JaraSpacing.xl),
              JaraButton(
                label: s.paywallCta,
                gold: true,
                expanded: true,
                onTap: () => _snack(s.paywallNotWiredNote),
              ),
              const SizedBox(height: JaraSpacing.lg),
              _footerLinks(t, s),
              const SizedBox(height: JaraSpacing.lg),
              _searchStaysFree(t, s),
            ],
          ),
        ),
      ),
    );
  }

  /// Lamp over a soft gold pool. The glow eases in once on entry and is
  /// simply painted at rest under Reduce Motion.
  Widget _hero(JaraTokens t, JaraStrings s) {
    final glow = Container(
      width: 176,
      height: 176,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            t.gold.withValues(alpha: t.isDark ? 0.28 : 0.20),
            t.gold.withValues(alpha: 0),
          ],
        ),
      ),
    );
    return Column(
      children: [
        SizedBox(
          height: 176,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (JaraMotion.reduced(context))
                glow
              else
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: JaraMotion.slow,
                  curve: JaraMotion.enter,
                  builder: (context, v, child) => Opacity(
                    opacity: v,
                    child: Transform.scale(scale: 0.92 + (0.08 * v), child: child),
                  ),
                  child: glow,
                ),
              Image.asset('assets/brand/lamp.png', height: 72),
            ],
          ),
        ),
        const SizedBox(height: JaraSpacing.lg),
        Text(
          s.paywallTitle,
          style: JaraType.title1.copyWith(color: t.textPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: JaraSpacing.sm),
        Text(
          s.paywallSubtitle,
          style: JaraType.subhead.copyWith(color: t.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _feature(JaraTokens t, IconData icon, Color iconColor, String title,
      String body) {
    return NeuCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: JaraType.bodyMedium.copyWith(color: t.textPrimary)),
                const SizedBox(height: 4),
                Text(body,
                    style: JaraType.footnote.copyWith(color: t.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Side by side once there is room; stacked on phones. [IntrinsicHeight]
  /// keeps both cards equal when only one carries the value chip.
  Widget _plans(JaraTokens t, JaraStrings s, WindowClass w) {
    final monthly = _planCard(t, _Plan.monthly, s.paywallMonthly, null);
    final yearly =
        _planCard(t, _Plan.yearly, s.paywallYearly, s.paywallYearlyBadge);
    if (w.isPhone) {
      return Column(
        children: [monthly, const SizedBox(height: JaraSpacing.md), yearly],
      );
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: monthly),
          const SizedBox(width: JaraSpacing.md),
          Expanded(child: yearly),
        ],
      ),
    );
  }

  Widget _planCard(JaraTokens t, _Plan plan, String label, String? badge) {
    final selected = _plan == plan;
    // The ring lives outside the card so the card keeps exactly one
    // shadow level; the padding reserves its space in both states.
    return MergeSemantics(
      child: Semantics(
        selected: selected,
        child: AnimatedContainer(
          duration: JaraMotion.of(context, JaraMotion.fast),
          curve: JaraMotion.standard,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(JaraRadius.card + 4),
            border: Border.all(
              color: selected ? t.accent : Colors.transparent,
              width: 2,
            ),
          ),
          child: NeuCard(
            onTap: () => setState(() => _plan = plan),
            semanticLabel: label,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      selected
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      size: 20,
                      color: selected ? t.accent : t.textTertiary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        label,
                        style:
                            JaraType.bodyMedium.copyWith(color: t.textPrimary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(_priceUnset,
                    style: JaraType.title2.copyWith(color: t.textPrimary)),
                if (badge != null) ...[
                  const SizedBox(height: JaraSpacing.sm),
                  JaraChip(
                    label: badge,
                    color: t.gold,
                    icon: Icons.auto_awesome_rounded,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _footerLinks(JaraTokens t, JaraStrings s) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: JaraSpacing.xxl,
      runSpacing: JaraSpacing.xs,
      children: [
        _quietLink(t, s.paywallRestore, s.paywallNotWiredNote),
        _quietLink(t, s.paywallTerms, s.paywallNotWiredNote),
      ],
    );
  }

  Widget _quietLink(JaraTokens t, String label, String note) {
    return Pressable(
      onTap: () => _snack(note),
      semanticLabel: label,
      minHitSize: JaraSize.touchMin,
      child: Text(label,
          style: JaraType.footnoteMedium.copyWith(color: t.textSecondary)),
    );
  }

  /// D9, stated where the doubt is: search over your own memory is never
  /// what Premium sells. It gets a card and primary text — a promise this
  /// product makes, not a disclaimer it hides.
  Widget _searchStaysFree(JaraTokens t, JaraStrings s) {
    return NeuCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.search_rounded, color: t.success, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              s.paywallSearchFree,
              style: JaraType.footnoteMedium.copyWith(color: t.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
