import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
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

/// Opens the "Add to JARA" capture sheet — the center-FAB action shared by
/// every shell tab. Two-step flow: pick a capture kind, review the mocked
/// auto-enrichment, land on a success beat with a "search it now" shortcut.
Future<void> showAddSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const _AddSheet(),
  );
}

enum _AddStep { options, details, success }

/// One entry on the options grid. [type] is null only for "Connect
/// account", which deep-links out instead of entering step 2.
class _AddOption {
  const _AddOption({
    required this.icon,
    required this.color,
    required this.label,
    this.type,
    this.mockTitle,
  });

  final IconData icon;
  final Color color;
  final String label;
  final MemoryType? type;
  final String? mockTitle;
}

List<_AddOption> _captureOptions(JaraStrings s) => [
      _AddOption(
        icon: Icons.document_scanner_outlined,
        color: MemoryType.document.color,
        label: s.addScanDocument,
        type: MemoryType.document,
        mockTitle: 'Scanned document',
      ),
      _AddOption(
        icon: Icons.upload_file_outlined,
        color: MemoryType.document.color,
        label: s.addUploadFile,
        type: MemoryType.document,
        mockTitle: 'Uploaded file',
      ),
      _AddOption(
        icon: Icons.image_outlined,
        color: MemoryType.photo.color,
        label: s.addPhoto,
        type: MemoryType.photo,
        mockTitle: 'New photo',
      ),
      _AddOption(
        icon: Icons.screenshot_outlined,
        color: MemoryType.screenshot.color,
        label: s.addScreenshot,
        type: MemoryType.screenshot,
        mockTitle: 'New screenshot',
      ),
      _AddOption(
        icon: Icons.mic_none_rounded,
        color: MemoryType.audio.color,
        label: s.addVoiceNote,
        type: MemoryType.audio,
        mockTitle: 'Voice note',
      ),
      _AddOption(
        icon: Icons.content_paste_rounded,
        color: MemoryType.note.color,
        label: s.addPasteText,
        type: MemoryType.note,
        mockTitle: 'Pasted text',
      ),
      _AddOption(
        icon: Icons.link_rounded,
        color: MemoryType.link.color,
        label: s.addSaveLink,
        type: MemoryType.link,
        mockTitle: 'Saved link',
      ),
      _AddOption(
        icon: Icons.sticky_note_2_outlined,
        color: MemoryType.note.color,
        label: s.addCreateNote,
        type: MemoryType.note,
        mockTitle: 'Untitled note',
      ),
      _AddOption(
        icon: Icons.hub_outlined,
        color: MemoryType.email.color,
        label: s.addConnectAccount,
      ),
    ];

class _AddSheet extends ConsumerStatefulWidget {
  const _AddSheet();

  @override
  ConsumerState<_AddSheet> createState() => _AddSheetState();
}

class _AddSheetState extends ConsumerState<_AddSheet> {
  _AddStep _step = _AddStep.options;
  _AddOption? _selected;
  final _titleController = TextEditingController();
  List<String> _tags = const [];
  String? _collection;
  MemoryItem? _saved;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _pick(_AddOption option) {
    if (option.type == null) {
      // Connect account is a deep link out, not a capture — no step 2.
      Navigator.pop(context);
      context.push('/profile/connections');
      return;
    }
    setState(() {
      _selected = option;
      _titleController.text = option.mockTitle ?? option.label;
      _tags = ['inbox', 'new', option.type!.name];
      _collection = null;
      _step = _AddStep.details;
    });
  }

  void _back() => setState(() {
        _step = _AddStep.options;
        _selected = null;
      });

  /// [useDefaults] powers "Save instantly": skip whatever the user edited
  /// and commit the mocked suggestion as-is.
  void _save({required bool useDefaults}) {
    final s = ref.read(stringsProvider);
    final option = _selected!;
    final typedTitle = _titleController.text.trim();
    final title = useDefaults || typedTitle.isEmpty
        ? (option.mockTitle ?? option.label)
        : typedTitle;
    final item = MemoryItem(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      type: option.type!,
      title: title,
      snippet: s.addedJustNow,
      source: s.manualAddSource,
      date: DateTime.now(),
      tags: _tags,
      collection: useDefaults ? null : _collection,
    );
    ref.read(memoryRepositoryProvider).add(item);
    ref.read(memoryRevisionProvider.notifier).state++;
    JaraHaptics.confirm();
    setState(() {
      _saved = item;
      _step = _AddStep.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final s = ref.strings;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.9,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: t.surfaceElevated,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(JaraRadius.sheet),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            JaraSpacing.xl,
            JaraSpacing.md,
            JaraSpacing.xl,
            JaraSpacing.xl + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: t.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: JaraSpacing.lg),
              AnimatedSwitcher(
                duration: JaraMotion.of(context, JaraMotion.base),
                switchInCurve: JaraMotion.standard,
                switchOutCurve: JaraMotion.standard,
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween(
                      begin: const Offset(0, 0.04),
                      end: Offset.zero,
                    ).animate(anim),
                    child: child,
                  ),
                ),
                child: switch (_step) {
                  _AddStep.options => _buildOptions(t, s),
                  _AddStep.details => _buildDetails(t, s),
                  _AddStep.success => _buildSuccess(t, s),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(JaraTokens t, JaraStrings s) {
    return Column(
      key: const ValueKey(_AddStep.options),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(s.addTitle, style: JaraType.title2.copyWith(color: t.textPrimary)),
        const SizedBox(height: JaraSpacing.xl),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: JaraSpacing.md,
          crossAxisSpacing: JaraSpacing.md,
          childAspectRatio: 0.95,
          children: [
            for (final option in _captureOptions(s))
              NeuTile(
                icon: option.icon,
                iconColor: option.color,
                label: option.label,
                onTap: () => _pick(option),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetails(JaraTokens t, JaraStrings s) {
    final option = _selected!;
    final type = option.type!;
    final collections = ref.watch(memoryRepositoryProvider).collections;

    return Column(
      key: const ValueKey(_AddStep.details),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            NeuIconButton(
              icon: Icons.chevron_left_rounded,
              onTap: _back,
              semanticLabel: s.back,
            ),
            const SizedBox(width: JaraSpacing.md),
            Expanded(
              child: Text(
                option.label,
                style: JaraType.headline.copyWith(color: t.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: JaraSpacing.lg),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: type.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(JaraRadius.tile),
          ),
          child: Icon(type.icon, color: type.color, size: 40),
        ),
        const SizedBox(height: JaraSpacing.lg),
        SectionHeader(title: s.addSuggestedTitle),
        NeuCard(
          padding: const EdgeInsets.all(JaraSpacing.md),
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
        Wrap(
          spacing: JaraSpacing.sm,
          runSpacing: JaraSpacing.sm,
          children: [
            for (final tag in _tags) JaraChip(label: tag),
            JaraChip(label: '+', onTap: () {}),
          ],
        ),
        const SizedBox(height: JaraSpacing.md),
        SectionHeader(title: s.addCollection),
        Wrap(
          spacing: JaraSpacing.sm,
          runSpacing: JaraSpacing.sm,
          children: [
            for (final c in collections.take(4))
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
        Row(
          children: [
            Expanded(
              child: JaraSoftButton(
                label: s.addSaveInstantly,
                onTap: () => _save(useDefaults: true),
              ),
            ),
            const SizedBox(width: JaraSpacing.md),
            Expanded(
              child: JaraButton(
                label: s.addSave,
                onTap: () => _save(useDefaults: false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSuccess(JaraTokens t, JaraStrings s) {
    final item = _saved!;
    final reduced = JaraMotion.reduced(context);
    return Column(
      key: const ValueKey(_AddStep.success),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
          s.addSuccessTitle,
          style: JaraType.title2.copyWith(color: t.textPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: JaraSpacing.sm),
        Text(
          '${s.typeLabel(item.type)} · ${item.tags.join(' · ')}',
          style: JaraType.subhead.copyWith(color: t.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: JaraSpacing.xxl),
        JaraButton(
          label: s.addSuccessSearchNow,
          expanded: true,
          onTap: () {
            final query = item.title;
            Navigator.pop(context);
            context.push('/search/results?q=${Uri.encodeComponent(query)}');
          },
        ),
        const SizedBox(height: JaraSpacing.sm),
        Pressable(
          onTap: () => Navigator.pop(context),
          semanticLabel: s.done,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: JaraSpacing.xs),
            child: Text(
              s.done,
              style: JaraType.callout.copyWith(color: t.accent),
            ),
          ),
        ),
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
