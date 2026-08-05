import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/data/providers.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/motion.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/models/memory_item.dart';
import '../../core/widgets/filter_chips.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/state_views.dart';

/// Voice capture overlay — D12: full flow with waveform today, real STT in
/// v1.1. Completes with the recognised query, or null when dismissed.
Future<String?> showVoiceSearchSheet(BuildContext context) {
  final t = context.jara;
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: t.skyBottom,
    barrierColor: t.scrim,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _VoiceSheet(),
  );
}

/// Source + sort refinement sheet. Writes straight to [activeFilterProvider]
/// so the results list reacts while the sheet is still open.
Future<void> showSearchFilterSheet(BuildContext context) {
  final t = context.jara;
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: t.surfaceElevated,
    barrierColor: t.scrim,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _FilterSheet(),
  );
}

class _VoiceSheet extends StatefulWidget {
  const _VoiceSheet();

  @override
  State<_VoiceSheet> createState() => _VoiceSheetState();
}

class _VoiceSheetState extends State<_VoiceSheet>
    with SingleTickerProviderStateMixin {
  /// Demo transcription until the on-device STT engine lands (D12).
  static const _demoQuery = 'passport photo';

  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );
  Timer? _transcribe;

  @override
  void initState() {
    super.initState();
    _transcribe = Timer(const Duration(milliseconds: 2400), () {
      if (!mounted) return;
      Navigator.of(context).pop(_demoQuery);
    });
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
    _transcribe?.cancel();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final reduced = JaraMotion.reduced(context);

    return SizedBox(
      height: 300,
      child: Column(
        children: [
          const SizedBox(height: JaraSpacing.md),
          const _SheetHandle(onSky: true),
          const Spacer(),
          AnimatedBuilder(
            animation: _pulse,
            builder: (context, _) => _MicOrb(
              value: _pulse.value,
              reduced: reduced,
            ),
          ),
          const SizedBox(height: JaraSpacing.xxl),
          AnimatedBuilder(
            animation: _pulse,
            builder: (context, _) => _Waveform(
              value: _pulse.value,
              reduced: reduced,
            ),
          ),
          const SizedBox(height: JaraSpacing.xl),
          Semantics(
            liveRegion: true,
            child: Text(
              // l10n-todo: no voice-capture keys in the copy deck yet.
              'Listening…',
              style: JaraType.callout.copyWith(color: t.textOnSkySecondary),
            ),
          ),
          const Spacer(),
          const SizedBox(height: JaraSpacing.md),
        ],
      ),
    );
  }
}

/// Pulsing mic with an expanding halo — the "we are hearing you" signal.
class _MicOrb extends StatelessWidget {
  const _MicOrb({required this.value, required this.reduced});

  final double value;
  final bool reduced;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final breathe = reduced ? 1.0 : 1 + 0.05 * math.sin(value * 2 * math.pi);
    final halo = reduced ? 1.12 : 1 + 0.45 * value;
    final haloAlpha = reduced ? 0.16 : 0.26 * (1 - value);

    return SizedBox(
      width: 128,
      height: 128,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: halo,
            child: Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: t.accent.withValues(alpha: haloAlpha),
              ),
            ),
          ),
          Transform.scale(
            scale: breathe,
            child: Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: t.accentGradient,
                boxShadow: t.accentGlow,
              ),
              child: const Icon(Icons.mic_rounded,
                  color: Colors.white, size: 34),
            ),
          ),
        ],
      ),
    );
  }
}

/// Five-bar level meter; a staggered sine keeps it alive without input.
class _Waveform extends StatelessWidget {
  const _Waveform({required this.value, required this.reduced});

  final double value;
  final bool reduced;

  static const _restingHeights = [14.0, 24.0, 38.0, 24.0, 14.0];

  double _heightOf(int index) {
    if (reduced) return _restingHeights[index];
    final phase = value * 2 * math.pi + index * 0.9;
    return 12 + 26 * (0.5 + 0.5 * math.sin(phase));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < _restingHeights.length; i++) ...[
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

class _FilterSheet extends ConsumerStatefulWidget {
  const _FilterSheet();

  @override
  ConsumerState<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<_FilterSheet> {
  /// Sort is presentation-only in v1: relevance is what the index returns.
  bool _byRelevance = true;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    final selected = ref.watch(activeFilterProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          JaraSpacing.page,
          JaraSpacing.md,
          JaraSpacing.page,
          JaraSpacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SheetHandle(),
            const SizedBox(height: JaraSpacing.xl),
            Text(s.refineSearch,
                style: JaraType.title2.copyWith(color: t.textPrimary)),
            const SizedBox(height: JaraSpacing.lg),
            Wrap(
              runSpacing: JaraSpacing.sm,
              children: [
                _chip(
                  label: s.filterAll,
                  selected: selected == null,
                  onTap: () =>
                      ref.read(activeFilterProvider.notifier).state = null,
                ),
                for (final type in MemoryType.values)
                  _chip(
                    label: s.typeLabel(type),
                    icon: type.icon,
                    selected: selected == type,
                    onTap: () =>
                        ref.read(activeFilterProvider.notifier).state = type,
                  ),
              ],
            ),
            const SizedBox(height: JaraSpacing.xxl),
            // l10n-todo: no "sort by" key in the copy deck yet.
            const SectionHeader(title: 'Sort by'),
            Row(
              children: [
                _SortChip(
                  label: s.sortRelevance,
                  selected: _byRelevance,
                  onTap: () => setState(() => _byRelevance = true),
                ),
                const SizedBox(width: JaraSpacing.sm),
                _SortChip(
                  label: s.sortRecent,
                  selected: !_byRelevance,
                  onTap: () => setState(() => _byRelevance = false),
                ),
              ],
            ),
            const SizedBox(height: JaraSpacing.xxl),
            JaraButton(
              // l10n-todo: no "apply" key in the copy deck yet.
              label: 'Apply',
              expanded: true,
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    IconData? icon,
  }) =>
      SizedBox(
        height: JaraSize.touchMin,
        child: SearchFilterChip(
          label: label,
          icon: icon,
          selected: selected,
          onTap: onTap,
          onSky: false,
        ),
      );
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Pressable(
      onTap: onTap,
      semanticLabel: label,
      child: SizedBox(
        height: JaraSize.touchMin,
        child: Center(
          child: JaraChip(
            label: label,
            icon: selected ? Icons.check_rounded : null,
            color: selected ? t.accent : t.textTertiary,
          ),
        ),
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle({this.onSky = false});

  final bool onSky;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Center(
      child: Container(
        width: 42,
        height: 4,
        decoration: BoxDecoration(
          color: (onSky ? t.textOnSkyTertiary : t.textTertiary)
              .withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
