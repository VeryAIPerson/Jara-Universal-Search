import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/breakpoints.dart';
import '../../core/design/haptics.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/motion.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/models/memory_item.dart';
import '../../core/widgets/filter_chips.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/neu_tile.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/state_views.dart';

/// Standalone demo of the OS share-sheet target: JARA mocks the enrichment
/// for whatever landed here and one tap saves it — the "two taps to saved"
/// promise (share, then Save instantly).
class ShareCaptureScreen extends ConsumerStatefulWidget {
  const ShareCaptureScreen({super.key});

  @override
  ConsumerState<ShareCaptureScreen> createState() => _ShareCaptureScreenState();
}

class _ShareCaptureScreenState extends ConsumerState<ShareCaptureScreen> {
  static const _mockTitle = 'VoxBridge pricing page';
  static const List<String> _mockTags = ['voxbridge', 'pricing', 'links'];

  final _titleController = TextEditingController(text: _mockTitle);
  String? _collection = 'VoxBridge';
  MemoryItem? _saved;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveInstantly() {
    final s = ref.read(stringsProvider);
    final typed = _titleController.text.trim();
    final item = MemoryItem(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      type: MemoryType.link,
      title: typed.isEmpty ? _mockTitle : typed,
      snippet: s.addedJustNow,
      source: s.manualAddSource,
      date: DateTime.now(),
      tags: _mockTags,
      collection: _collection ?? 'VoxBridge',
    );
    ref.read(memoryRepositoryProvider).add(item);
    ref.read(memoryRevisionProvider.notifier).state++;
    JaraHaptics.confirm();
    setState(() => _saved = item);
    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      context.go('/search');
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;
    final collections = ref.watch(memoryRepositoryProvider).collections;
    final w = context.windowClass;
    final inset = JaraBreakpoints.pageInsetFor(w);
    // The capture card is a form, not a page: it grows a little off the
    // phone and stops well short of the 680 reading cap.
    final cardWidth = w.isPhone ? 380.0 : 460.0;

    return Scaffold(
      backgroundColor: t.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              inset,
              JaraSpacing.xl,
              inset,
              JaraSpacing.xl + MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: cardWidth),
              child: NeuCard(
                padding: const EdgeInsets.all(JaraSpacing.xl),
                radius: JaraRadius.sheet,
                child: AnimatedSwitcher(
                  duration: JaraMotion.of(context, JaraMotion.base),
                  switchInCurve: JaraMotion.standard,
                  switchOutCurve: JaraMotion.standard,
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: ScaleTransition(scale: anim, child: child),
                  ),
                  child: _saved == null
                      ? _buildForm(t, s, collections)
                      : _buildSuccess(t, s, _saved!),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(
    JaraTokens t,
    JaraStrings s,
    List<MemoryCollection> collections,
  ) {
    return Column(
      key: const ValueKey('form'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset('assets/brand/lamp.png', height: 22),
            const SizedBox(width: JaraSpacing.sm),
            Text(s.shareTitle,
                style: JaraType.headline.copyWith(color: t.textPrimary)),
            const Spacer(),
            NeuIconButton(
              icon: Icons.close_rounded,
              semanticLabel: s.cancel,
              onTap: () => context.go('/search'),
            ),
          ],
        ),
        const SizedBox(height: JaraSpacing.lg),
        Container(
          height: 96,
          padding: const EdgeInsets.all(JaraSpacing.md),
          decoration: BoxDecoration(
            color: MemoryType.link.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(Icons.link_rounded, color: MemoryType.link.color, size: 28),
              const SizedBox(width: JaraSpacing.md),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VoxBridge — pricing page',
                      style: JaraType.bodyMedium.copyWith(color: t.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: JaraSpacing.xs),
                    Text(
                      'voxbridge.app/pricing',
                      style: JaraType.footnote.copyWith(color: t.textTertiary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: JaraSpacing.md),
        SectionHeader(title: s.addSuggestedTitle),
        NeuCard(
          padding: const EdgeInsets.all(JaraSpacing.sm),
          child: TextField(
            controller: _titleController,
            style: JaraType.bodyMedium.copyWith(color: t.textPrimary),
            cursorColor: t.accent,
            decoration: const InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: JaraSpacing.md),
        SectionHeader(title: s.addSuggestedTags),
        const Wrap(
          spacing: JaraSpacing.sm,
          runSpacing: JaraSpacing.sm,
          children: [
            JaraChip(label: 'voxbridge'),
            JaraChip(label: 'pricing'),
            JaraChip(label: 'links'),
          ],
        ),
        const SizedBox(height: JaraSpacing.md),
        SectionHeader(title: s.addCollection),
        Wrap(
          spacing: JaraSpacing.sm,
          runSpacing: JaraSpacing.sm,
          children: [
            for (final c in collections.take(3))
              JaraChip(
                label: c.name,
                color: _collection == c.name ? c.color : t.textTertiary,
                onTap: () {
                  JaraHaptics.select();
                  setState(
                    () => _collection = _collection == c.name ? null : c.name,
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: JaraSpacing.xl),
        JaraButton(
          label: s.shareSaveInstantly,
          expanded: true,
          onTap: _saveInstantly,
        ),
        const SizedBox(height: JaraSpacing.sm),
        Center(
          child: Pressable(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(s.shareReview)),
              );
            },
            semanticLabel: s.shareReview,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: JaraSpacing.xs),
              child: Text(s.shareReview,
                  style: JaraType.callout.copyWith(color: t.accent)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccess(JaraTokens t, JaraStrings s, MemoryItem item) {
    final reduced = JaraMotion.reduced(context);
    return Column(
      key: const ValueKey('success'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: JaraSpacing.sm),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: reduced ? 1.0 : 0.8, end: 1.0),
          duration: JaraMotion.of(context, JaraMotion.slow),
          curve: JaraMotion.spring,
          builder: (context, scale, child) =>
              Transform.scale(scale: scale, child: child),
          child: _successRing(t),
        ),
        const SizedBox(height: JaraSpacing.lg),
        Text(
          s.shareSaved,
          style: JaraType.title2.copyWith(color: t.textPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: JaraSpacing.sm),
        Text(
          '${s.typeLabel(item.type)} · ${item.tags.join(' · ')}',
          style: JaraType.subhead.copyWith(color: t.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: JaraSpacing.sm),
      ],
    );
  }

  Widget _successRing(JaraTokens t) => SizedBox(
        width: 84,
        height: 84,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: t.gold, width: 2),
          ),
          child: Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: t.accentGradient,
              ),
              child: const Icon(Icons.check_rounded,
                  color: Colors.white, size: 32),
            ),
          ),
        ),
      );
}
