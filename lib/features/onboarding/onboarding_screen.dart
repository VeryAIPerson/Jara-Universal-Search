import 'dart:math' show cos, pi, sin;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/prefs.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/motion.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/models/memory_item.dart';
import '../../core/widgets/filter_chips.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/notch_app_bar.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/state_views.dart';

/// Three-page introduction, entirely on the memory sky. A swipeable
/// PageView drives a shared dot rail and a CTA zone that swaps from
/// "Continue" to the two closing actions on the final page.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;
  late final AnimationController _orbitController;
  late final AnimationController _arrowController;
  late final Animation<double> _arrowAnimation;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _floatAnimation = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _arrowAnimation = Tween<double>(begin: 0, end: 4).animate(
      CurvedAnimation(parent: _arrowController, curve: Curves.easeInOut),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (JaraMotion.reduced(context)) {
      _floatController.stop();
      _orbitController.stop();
      _arrowController.stop();
    } else {
      if (!_floatController.isAnimating) _floatController.repeat(reverse: true);
      if (!_orbitController.isAnimating) _orbitController.repeat();
      if (!_arrowController.isAnimating) _arrowController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatController.dispose();
    _orbitController.dispose();
    _arrowController.dispose();
    super.dispose();
  }

  // Shared by Skip, the primary CTA and the secondary CTA — every way off
  // this screen marks onboarding seen before handing off to search.
  void _finish(BuildContext context) {
    ref.read(prefsProvider).setHasSeenOnboarding(true);
    context.go('/search');
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    final reduced = JaraMotion.reduced(context);

    return Scaffold(
      backgroundColor: t.skyBottom,
      body: Container(
        decoration: BoxDecoration(gradient: t.skyGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(JaraSpacing.page),
                child: Row(
                  children: [
                    const Spacer(),
                    Pressable(
                      onTap: () => _finish(context),
                      semanticLabel: s.onbSkip,
                      child: Text(
                        s.onbSkip,
                        style: JaraType.callout
                            .copyWith(color: t.textOnSkyTertiary),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  children: [
                    _buildPage(
                      t: t,
                      illustration: _page1Illustration(t, reduced),
                      title: s.onb1Title,
                      body: s.onb1Body,
                    ),
                    _buildPage(
                      t: t,
                      illustration: _page2Illustration(t, s, reduced),
                      title: s.onb2Title,
                      body: s.onb2Body,
                    ),
                    _buildPage(
                      t: t,
                      illustration: _page3Illustration(t, s, reduced),
                      title: s.onb3Title,
                      body: s.onb3Body,
                    ),
                  ],
                ),
              ),
              _pageDots(t),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  JaraSpacing.page,
                  JaraSpacing.xxl,
                  JaraSpacing.page,
                  JaraSpacing.md,
                ),
                child: _ctaZone(t, s),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage({
    required JaraTokens t,
    required Widget illustration,
    required String title,
    required String body,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: JaraSpacing.xxxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 260, child: illustration),
          const SizedBox(height: 28),
          Text(
            title,
            textAlign: TextAlign.center,
            style: JaraType.title1.copyWith(color: t.textOnSky, height: 1.2),
          ),
          const SizedBox(height: JaraSpacing.md),
          Text(
            body,
            textAlign: TextAlign.center,
            style: JaraType.body.copyWith(color: t.textOnSkySecondary),
          ),
        ],
      ),
    );
  }

  // --- Page 1: a tilted collage of source cards over a search badge. ---

  Widget _page1Illustration(JaraTokens t, bool reduced) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 4,
          left: 0,
          child: _collageCard(t, angle: -0.06, type: MemoryType.document),
        ),
        Positioned(
          top: 34,
          right: 0,
          child: _collageCard(t, angle: 0.05, type: MemoryType.photo),
        ),
        Positioned(
          top: 64,
          left: 44,
          child: _collageCard(t, angle: 0, type: MemoryType.link),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(child: _searchBadge(t, reduced)),
        ),
      ],
    );
  }

  Widget _collageCard(
    JaraTokens t, {
    required double angle,
    required MemoryType type,
  }) {
    return Transform.rotate(
      angle: angle,
      child: NeuCard(
        onSky: true,
        padding: const EdgeInsets.all(JaraSpacing.md),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: type.color.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(type.icon, size: 16, color: type.color),
            ),
            const SizedBox(width: JaraSpacing.sm),
            SizedBox(
              width: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _textBar(70),
                  const SizedBox(height: JaraSpacing.xs),
                  _textBar(44),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textBar(double width) {
    return Container(
      height: 8,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _searchBadge(JaraTokens t, bool reduced) {
    final badge = Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: t.accentGradient,
        boxShadow: t.accentGlow,
      ),
      child: const Icon(Icons.search_rounded, color: Colors.white, size: 26),
    );
    if (reduced) return badge;
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _floatAnimation.value),
        child: child,
      ),
      child: badge,
    );
  }

  // --- Page 2: a shield with three dots orbiting it. ---

  Widget _page2Illustration(JaraTokens t, JaraStrings s, bool reduced) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 176,
          height: 176,
          child: reduced
              ? _shieldWithDots(t, 0)
              : AnimatedBuilder(
                  animation: _orbitController,
                  builder: (context, _) =>
                      _shieldWithDots(t, _orbitController.value * 2 * pi),
                ),
        ),
        const SizedBox(height: JaraSpacing.lg),
        PrivacyPill(label: s.privacyLocalActive, active: true),
      ],
    );
  }

  Widget _shieldWithDots(JaraTokens t, double baseAngle) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: t.success.withValues(alpha: 0.10),
            border: Border.all(color: t.success.withValues(alpha: 0.25), width: 1.5),
          ),
          child: Icon(Icons.shield_rounded, color: t.success, size: 52),
        ),
        _orbitDot(baseAngle, t.accent),
        _orbitDot(baseAngle + (2 * pi / 3), t.violet),
        _orbitDot(baseAngle + (4 * pi / 3), t.gold),
      ],
    );
  }

  Widget _orbitDot(double angle, Color color) {
    const radius = 78.0;
    return Transform.translate(
      offset: Offset(radius * cos(angle), radius * sin(angle)),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  // --- Page 3: capture-to-memory vertical flow. ---

  Widget _page3Illustration(JaraTokens t, JaraStrings s, bool reduced) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        JaraChip(
          label: 'Safari', // brand name — not translatable
          color: t.accentBright,
          icon: Icons.ios_share_rounded,
        ),
        const SizedBox(height: JaraSpacing.sm),
        _flowArrow(t, reduced),
        const SizedBox(height: JaraSpacing.sm),
        Image.asset('assets/brand/lamp.png', height: 56),
        const SizedBox(height: JaraSpacing.sm),
        _flowArrow(t, reduced),
        const SizedBox(height: JaraSpacing.sm),
        JaraChip(
          label: s.memoryTitle,
          color: t.gold,
          icon: Icons.auto_awesome_rounded,
        ),
      ],
    );
  }

  Widget _flowArrow(JaraTokens t, bool reduced) {
    final arrow = Icon(Icons.south_rounded, color: t.textOnSkyTertiary, size: 20);
    if (reduced) return arrow;
    return AnimatedBuilder(
      animation: _arrowAnimation,
      builder: (context, child) =>
          Transform.translate(offset: Offset(0, _arrowAnimation.value), child: child),
      child: arrow,
    );
  }

  // --- Shared chrome: page dots + CTA zone. ---

  Widget _pageDots(JaraTokens t) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < 3; i++)
          Padding(
            padding: EdgeInsets.only(left: i == 0 ? 0 : 6),
            child: AnimatedContainer(
              duration: JaraMotion.of(context, JaraMotion.base),
              curve: JaraMotion.standard,
              width: i == _currentPage ? 22 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: i == _currentPage
                    ? t.accent
                    : Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
      ],
    );
  }

  Widget _ctaZone(JaraTokens t, JaraStrings s) {
    final isLastPage = _currentPage == 2;
    return AnimatedSwitcher(
      duration: JaraMotion.of(context, JaraMotion.base),
      child: isLastPage
          ? Column(
              key: const ValueKey('cta-final'),
              mainAxisSize: MainAxisSize.min,
              children: [
                JaraButton(
                  label: s.onbPrimaryCta,
                  expanded: true,
                  gold: true,
                  onTap: () => _finish(context),
                ),
                const SizedBox(height: 10),
                Pressable(
                  onTap: () => _finish(context),
                  semanticLabel: s.onbSecondaryCta,
                  child: Text(
                    s.onbSecondaryCta,
                    textAlign: TextAlign.center,
                    style: JaraType.callout.copyWith(color: t.accentBright),
                  ),
                ),
              ],
            )
          : JaraButton(
              key: const ValueKey('cta-continue'),
              label: s.continueCta,
              expanded: true,
              onTap: () => _pageController.nextPage(
                duration: JaraMotion.of(context, JaraMotion.gentle),
                curve: JaraMotion.standard,
              ),
            ),
    );
  }
}
