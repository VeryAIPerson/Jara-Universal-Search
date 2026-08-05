import 'dart:async';
import 'dart:math' show pi, sin;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/jara_theme.dart';
import '../../core/design/motion.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';

/// Quiet, premium entry point on the memory sky: a breathing lamp glow,
/// two staggered fade-ins, then a fixed hand-off to onboarding. The 1.2s
/// wait never shortens under reduce-motion — only the decorative loops do.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  static const _navDelay = Duration(milliseconds: 1200);

  late final AnimationController _glowController;
  late final Animation<double> _glowScale;
  late final AnimationController _dotsController;
  Timer? _navTimer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    _glowScale = Tween<double>(begin: 0.9, end: 1.05).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _navTimer = Timer(_navDelay, _goNext);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Loops only run without reduce-motion; navigation timing is untouched.
    if (JaraMotion.reduced(context)) {
      _glowController.stop();
      _dotsController.stop();
    } else {
      if (!_glowController.isAnimating) _glowController.repeat(reverse: true);
      if (!_dotsController.isAnimating) _dotsController.repeat();
    }
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    _glowController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_navigated || !mounted) return;
    _navigated = true;
    context.go('/onboarding');
  }

  void _skip() {
    _navTimer?.cancel();
    _goNext();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    final reduced = JaraMotion.reduced(context);

    return Scaffold(
      backgroundColor: t.skyBottom,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        excludeFromSemantics: true,
        onTap: _skip,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(gradient: t.skyGradient),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _lampWithGlow(t, reduced),
                  const SizedBox(height: JaraSpacing.xl),
                  _delayedFadeIn(
                    delayMs: 200,
                    reduced: reduced,
                    child: Text(
                      'Universal Search', // l10n-todo: no key; appName carries full brand
                      textAlign: TextAlign.center,
                      style: JaraType.title2.copyWith(color: t.textOnSky),
                    ),
                  ),
                  const SizedBox(height: 6),
                  _delayedFadeIn(
                    delayMs: 350,
                    reduced: reduced,
                    child: Text(
                      s.tagline,
                      textAlign: TextAlign.center,
                      style: JaraType.footnote
                          .copyWith(color: t.textOnSkySecondary),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.paddingOf(context).bottom + 28,
              child: _memoryDots(t, reduced),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lampWithGlow(JaraTokens t, bool reduced) {
    final glow = Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            t.accent.withValues(alpha: 0.35),
            t.accent.withValues(alpha: 0),
          ],
        ),
      ),
    );
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          reduced
              ? glow
              : AnimatedBuilder(
                  animation: _glowScale,
                  builder: (context, child) => Transform.scale(
                    scale: _glowScale.value,
                    child: child,
                  ),
                  child: glow,
                ),
          Image.asset('assets/brand/lamp.png', height: 88),
        ],
      ),
    );
  }

  /// Fades [child] in over [durationMs] starting [delayMs] after mount by
  /// packing the wait into an [Interval], so one implicit animation can
  /// express "hold, then ease in" without a separate Timer/setState pair.
  Widget _delayedFadeIn({
    required Widget child,
    required int delayMs,
    required bool reduced,
    int durationMs = 400,
  }) {
    final totalMs = delayMs + durationMs;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: JaraMotion.of(context, Duration(milliseconds: totalMs)),
      curve: Interval(delayMs / totalMs, 1.0, curve: Curves.easeOut),
      builder: (context, v, c) => Opacity(opacity: v, child: c),
      child: child,
    );
  }

  Widget _memoryDots(JaraTokens t, bool reduced) {
    final colors = [t.accent, t.violet, t.gold];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < colors.length; i++)
          Padding(
            padding: EdgeInsets.only(left: i == 0 ? 0 : 6),
            child: reduced
                ? _dot(colors[i], 0.8)
                : AnimatedBuilder(
                    animation: _dotsController,
                    builder: (context, _) => _dot(colors[i], _dotAlpha(i)),
                  ),
          ),
      ],
    );
  }

  /// Sine pulse per dot, phase-shifted by 150ms so the three fade in turn.
  double _dotAlpha(int index) {
    final phase = index * 0.125;
    final wave = (sin(2 * pi * (_dotsController.value - phase)) + 1) / 2;
    return 0.25 + wave * 0.55;
  }

  Widget _dot(Color color, double alpha) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color.withValues(alpha: alpha),
        shape: BoxShape.circle,
      ),
    );
  }
}
