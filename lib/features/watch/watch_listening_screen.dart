import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/haptics.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/motion.dart';
import '../../core/design/tokens.dart';
import '../../core/l10n_bridge.dart';
import 'watch_layout.dart';
import 'watch_routes.dart';
import 'watch_type.dart';

/// Full-bleed capture state: pulsing orb, level meter, one word of copy.
/// Dismiss by tapping anywhere or swiping right, the way every other Wear
/// OS surface is dismissed.
class WatchListeningScreen extends ConsumerStatefulWidget {
  const WatchListeningScreen({super.key});

  @override
  ConsumerState<WatchListeningScreen> createState() =>
      _WatchListeningScreenState();
}

class _WatchListeningScreenState extends ConsumerState<WatchListeningScreen>
    with SingleTickerProviderStateMixin {
  /// Demo transcription until on-device STT lands (D12) — same stand-in
  /// the phone's voice sheet uses so both surfaces demo the same query.
  static const _demoQuery = 'passport photo';
  static const _captureWindow = Duration(milliseconds: 2400);

  /// Waveform + label + their gaps; the orb takes the rest of the face.
  static const _belowOrb = 68.0;

  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );
  Timer? _capture;

  @override
  void initState() {
    super.initState();
    _capture = Timer(_captureWindow, _finish);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (JaraMotion.reduced(context)) {
      _pulse.stop();
    } else if (!_pulse.isAnimating) {
      _pulse.repeat();
    }
  }

  @override
  void dispose() {
    _capture?.cancel();
    _pulse.dispose();
    super.dispose();
  }

  void _finish() {
    if (!mounted) return;
    JaraHaptics.confirm();
    ref.read(searchQueryProvider.notifier).state = _demoQuery;
    context.pushReplacement(WatchRoutes.results);
  }

  void _cancel() {
    _capture?.cancel();
    if (context.canPop()) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    final m = WatchMetrics.of(context);
    final reduced = JaraMotion.reduced(context);

    return WatchScaffold(
      flat: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        excludeFromSemantics: true,
        onTap: _cancel,
        onHorizontalDragEnd: (d) {
          if ((d.primaryVelocity ?? 0) > 0) _cancel();
        },
        child: LayoutBuilder(
          builder: (context, box) {
            // A circle over two short rows clears a round face far better
            // than a rectangle would, so this screen spends more of the
            // height than the padded content box allows elsewhere.
            final budget = math.min(
              box.maxHeight - m.systemPadding.vertical,
              m.face * 0.86,
            );
            final orb = (budget - _belowOrb).clamp(56.0, m.face * 0.62);

            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _pulse,
                    builder: (context, _) => _Orb(
                      extent: orb,
                      value: _pulse.value,
                      reduced: reduced,
                    ),
                  ),
                  const SizedBox(height: JaraSpacing.md),
                  AnimatedBuilder(
                    animation: _pulse,
                    builder: (context, _) => _Waveform(
                      value: _pulse.value,
                      reduced: reduced,
                    ),
                  ),
                  const SizedBox(height: JaraSpacing.sm),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: m.heroWidth),
                    child: Semantics(
                      liveRegion: true,
                      child: Text(
                        s.listening,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: WatchType.meta
                            .copyWith(color: t.textOnSkySecondary),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Breathing mic inside an expanding halo — "we are hearing you".
class _Orb extends StatelessWidget {
  const _Orb({
    required this.extent,
    required this.value,
    required this.reduced,
  });

  /// Outer box the halo may grow into.
  final double extent;
  final double value;
  final bool reduced;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final base = extent / 1.35;
    final core = base * 0.92;
    final breathe = reduced ? 1.0 : 1 + 0.05 * math.sin(value * 2 * math.pi);
    final halo = reduced ? 1.1 : 1 + 0.35 * value;
    final haloAlpha = reduced ? 0.16 : 0.26 * (1 - value);

    return SizedBox(
      width: extent,
      height: extent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: halo,
            child: Container(
              width: base,
              height: base,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: t.accent.withValues(alpha: haloAlpha),
              ),
            ),
          ),
          Transform.scale(
            scale: breathe,
            child: Container(
              width: core,
              height: core,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: t.accentGradient,
                boxShadow: t.accentGlow,
              ),
              child: Icon(
                Icons.mic_rounded,
                color: Colors.white,
                size: core * 0.42,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Five-bar level meter, staggered sine so it stays alive without input.
class _Waveform extends StatelessWidget {
  const _Waveform({required this.value, required this.reduced});

  final double value;
  final bool reduced;

  static const _resting = [10.0, 17.0, 26.0, 17.0, 10.0];
  static const _box = 26.0;

  double _heightOf(int index) {
    if (reduced) return _resting[index];
    final phase = value * 2 * math.pi + index * 0.9;
    return 9 + 17 * (0.5 + 0.5 * math.sin(phase));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return SizedBox(
      height: _box,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < _resting.length; i++) ...[
            if (i > 0) const SizedBox(width: JaraSpacing.sm),
            Container(
              width: 5,
              height: _heightOf(i),
              decoration: BoxDecoration(
                color: t.accentBright,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
