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
import '../../core/models/memory_item.dart';
import '../../core/widgets/filter_chips.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/neu_tile.dart';
import '../../core/widgets/result_cards.dart';
import '../../core/widgets/state_views.dart';

enum _DetailAction { saveToCollection, addTag, ask, delete }

/// This screen is a reading column: title, meta, body, tags. Past ~680 the
/// line length stops being readable, so wide windows gain margin instead.
/// Phones fall through untouched — 390 was never near the cap.
Widget _prose(WindowClass w, Widget child) => w.isPhone
    ? child
    : Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: JaraBreakpoints.proseMaxWidth),
          child: child,
        ),
      );

/// Full memory detail — lives outside the shell, so it owns its own
/// bottom action bar instead of the floating tab bar.
class ResultDetailScreen extends ConsumerWidget {
  const ResultDetailScreen({super.key, required this.itemId});

  final String itemId;

  static const _months = [
    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
  ];

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _togglePin(WidgetRef ref) {
    ref.read(memoryRepositoryProvider).togglePin(itemId);
    ref.read(memoryRevisionProvider.notifier).state++;
    JaraHaptics.confirm();
  }

  Future<void> _showActions(
    BuildContext context,
    WidgetRef ref,
    JaraStrings s,
    MemoryItem item,
  ) async {
    final t = context.jara;

    Widget menu(BuildContext sheetContext, {required bool dialog}) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: JaraSpacing.md),
            if (!dialog) ...[
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: t.textTertiary.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: JaraSpacing.sm),
            ],
            _SheetAction(
              icon: Icons.folder_rounded,
              label: s.actionSaveToCollection,
              onTap: () => Navigator.of(sheetContext)
                  .pop(_DetailAction.saveToCollection),
            ),
            _SheetAction(
              icon: Icons.sell_outlined,
              label: s.actionAddTag,
              onTap: () => Navigator.of(sheetContext).pop(_DetailAction.addTag),
            ),
            _SheetAction(
              icon: Icons.auto_awesome_rounded,
              label: s.actionAskAbout,
              onTap: () => Navigator.of(sheetContext).pop(_DetailAction.ask),
            ),
            const Divider(indent: JaraSpacing.xl, endIndent: JaraSpacing.xl),
            _SheetAction(
              icon: Icons.delete_outline_rounded,
              label: s.actionDelete,
              color: t.error,
              onTap: () => Navigator.of(sheetContext).pop(_DetailAction.delete),
            ),
            const SizedBox(height: JaraSpacing.md),
          ],
        );

    // Sheets reach for a thumb; from `medium` up there is none, so the
    // same menu lands as a centred surface.
    final action = JaraBreakpoints.of(context).usesRail
        ? await showDialog<_DetailAction>(
            context: context,
            barrierColor: t.scrim,
            builder: (dialogContext) => Dialog(
              backgroundColor: t.surfaceElevated,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(JaraRadius.sheet),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: menu(dialogContext, dialog: true),
              ),
            ),
          )
        : await showModalBottomSheet<_DetailAction>(
            context: context,
            useSafeArea: true,
            builder: (sheetContext) => SafeArea(
              top: false,
              child: menu(sheetContext, dialog: false),
            ),
          );
    if (action == null || !context.mounted) return;
    switch (action) {
      case _DetailAction.saveToCollection:
        _snack(context, s.actionSaveToCollection);
      case _DetailAction.addTag:
        _snack(context, s.actionAddTag);
      case _DetailAction.ask:
        _snack(context, s.actionAskJara);
      case _DetailAction.delete:
        await _confirmDelete(context, ref, s, item);
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    JaraStrings s,
    MemoryItem item,
  ) async {
    final t = context.jara;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: t.surfaceElevated,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JaraRadius.card),
        ),
        title: Text(
          s.actionDelete,
          style: JaraType.title2.copyWith(color: t.textPrimary),
        ),
        content: Text(
          item.title,
          style: JaraType.subhead.copyWith(color: t.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              s.cancel,
              style: JaraType.button.copyWith(color: t.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              s.actionDelete,
              style: JaraType.button.copyWith(color: t.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    JaraHaptics.heavy();
    ref.read(memoryRepositoryProvider).remove(itemId);
    ref.read(memoryRevisionProvider.notifier).state++;
    context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.jara;
    final s = ref.strings;
    ref.watch(memoryRevisionProvider);
    final repo = ref.watch(memoryRepositoryProvider);
    final item = repo.byId(itemId);
    final w = context.windowClass;
    final inset = JaraBreakpoints.pageInsetFor(w);

    if (item == null) {
      return Scaffold(
        backgroundColor: t.surface,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(JaraSpacing.page),
              child: EmptyStateView(
                icon: Icons.link_off_rounded,
                title: s.errorGenericTitle,
                message: s.errorGenericBody,
                primaryLabel: s.retry,
                onPrimary: () => context.pop(),
              ),
            ),
          ),
        ),
      );
    }

    MemoryCollection? collection;
    final collectionName = item.collection;
    if (collectionName != null) {
      final needle = collectionName.toLowerCase();
      for (final c in repo.collections) {
        if (c.id.toLowerCase() == needle || c.name.toLowerCase() == needle) {
          collection = c;
          break;
        }
      }
    }

    final meta = [
      item.source,
      relativeDate(s, item.date),
      if (item.sizeLabel != null) item.sizeLabel!,
      if (item.pageLabel != null) item.pageLabel!,
    ].join(' · ');
    final related = repo.related(item);

    return Scaffold(
      backgroundColor: t.surface,
      body: SafeArea(
        bottom: false,
        child: _prose(
          w,
          ListView(
            padding: EdgeInsets.fromLTRB(inset, JaraSpacing.sm, inset,
                w.usesRail ? JaraSpacing.xl : 120),
            children: [
              Row(
                children: [
                  NeuIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    semanticLabel: s.back,
                    onTap: () => context.pop(),
                  ),
                  const Spacer(),
                  NeuIconButton(
                    icon: Icons.ios_share_rounded,
                    semanticLabel: s.actionShare,
                    onTap: () => _snack(context, s.actionShare),
                  ),
                  const SizedBox(width: 10),
                  NeuIconButton(
                    icon: item.pinned
                        ? Icons.push_pin_rounded
                        : Icons.push_pin_outlined,
                    iconColor: item.pinned ? t.gold : null,
                    semanticLabel: item.pinned ? s.actionUnpin : s.actionPin,
                    onTap: () => _togglePin(ref),
                  ),
                  const SizedBox(width: 10),
                  NeuIconButton(
                    icon: Icons.more_horiz_rounded,
                    semanticLabel: s.moreActions,
                    onTap: () => _showActions(context, ref, s, item),
                  ),
                ],
              ),
              const SizedBox(height: JaraSpacing.xl),
              _PreviewBlock(
                item: item,
                monthLabel: _months[item.date.month - 1],
                onLongPress: () => _showActions(context, ref, s, item),
              ),
              const SizedBox(height: JaraSpacing.xl),
              Text(
                item.title,
                style: JaraType.title1.copyWith(color: t.textPrimary),
              ),
              const SizedBox(height: JaraSpacing.sm),
              Text(
                meta,
                style: JaraType.footnote.copyWith(color: t.textSecondary),
              ),
              const SizedBox(height: JaraSpacing.lg),
              NeuCard(
                child: Text(
                  item.snippet,
                  style: JaraType.body.copyWith(color: t.textPrimary),
                ),
              ),
              if (item.matchReason != null) ...[
                const SizedBox(height: JaraSpacing.md),
                Align(
                  alignment: Alignment.centerLeft,
                  child: JaraChip(
                    label: item.matchReason!,
                    icon: Icons.auto_awesome_rounded,
                    color: t.violet,
                  ),
                ),
              ],
              const SizedBox(height: JaraSpacing.xl),
              SectionHeader(title: s.detailTags),
              Wrap(
                spacing: JaraSpacing.sm,
                runSpacing: JaraSpacing.sm,
                children: [
                  for (final tag in item.tags)
                    JaraChip(label: tag, color: t.accent),
                  Semantics(
                    button: true,
                    label: s.actionAddTag,
                    child: JaraChip(
                      label: '+ ${s.actionAddTag}',
                      color: t.textTertiary,
                      onTap: () => _snack(context, s.actionAddTag),
                    ),
                  ),
                ],
              ),
              if (item.people.isNotEmpty) ...[
                const SizedBox(height: JaraSpacing.xl),
                SectionHeader(title: s.detailPeople),
                Wrap(
                  spacing: JaraSpacing.sm,
                  runSpacing: JaraSpacing.sm,
                  children: [
                    for (final person in item.people)
                      JaraChip(
                        label: person,
                        icon: Icons.person_outline_rounded,
                        color: t.accentBright,
                      ),
                  ],
                ),
              ],
              if (collectionName != null) ...[
                const SizedBox(height: JaraSpacing.xl),
                SectionHeader(title: s.detailInCollection),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Semantics(
                    button: true,
                    label: collection?.name ?? collectionName,
                    child: JaraChip(
                      label: collection?.name ?? collectionName,
                      icon: Icons.folder_rounded,
                      color: collection?.color ?? t.accent,
                      onTap: () => context.push(
                        '/collections/${collection?.id ?? collectionName.toLowerCase()}',
                      ),
                    ),
                  ),
                ),
              ],
              if (related.isNotEmpty) ...[
                const SizedBox(height: JaraSpacing.xl),
                SectionHeader(title: s.detailRelated),
                for (var i = 0; i < related.length; i++) ...[
                  UniversalResultCard(
                    item: related[i],
                    dateLabel: relativeDate(s, related[i].date),
                    onTap: () => context.push('/item/${related[i].id}'),
                  ),
                  if (i != related.length - 1)
                    const SizedBox(height: JaraSpacing.md),
                ],
              ],
              const SizedBox(height: JaraSpacing.xl),
              NeuCard(
                semanticLabel: s.actionAskJara,
                onTap: () => _snack(context, s.actionAskJara),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome_rounded, color: t.gold, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        s.detailAskPlaceholder,
                        style: JaraType.callout.copyWith(color: t.textTertiary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: JaraSpacing.sm),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: t.accentGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: _prose(
          w,
          Padding(
            padding: const EdgeInsets.all(JaraSpacing.lg),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final share = JaraSoftButton(
                  label: s.actionShare,
                  icon: Icons.ios_share_rounded,
                  expanded: true,
                  onTap: () => _snack(context, s.actionShare),
                );
                final open = JaraButton(
                  label: s.actionOpenOriginal,
                  icon: Icons.open_in_new_rounded,
                  expanded: true,
                  onTap: () => _snack(context, s.actionOpenOriginal),
                );
                // Narrow screens stack instead of squeezing the labels.
                if (constraints.maxWidth < 340) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      open,
                      const SizedBox(height: JaraSpacing.md),
                      share,
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(flex: 4, child: share),
                    const SizedBox(width: JaraSpacing.md),
                    Expanded(flex: 6, child: open),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Type-aware hero block: gradient panel with a big glyph, a calendar
/// date, or a static waveform.
class _PreviewBlock extends StatelessWidget {
  const _PreviewBlock({
    required this.item,
    required this.monthLabel,
    required this.onLongPress,
  });

  final MemoryItem item;
  final String monthLabel;
  final VoidCallback onLongPress;

  static const _bars = [22.0, 46.0, 74.0, 96.0, 62.0, 38.0, 20.0];

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final color = item.type.color;

    Widget center;
    switch (item.type) {
      case MemoryType.calendar:
        center = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${item.date.day}',
              style: JaraType.title1.copyWith(color: color),
            ),
            Text(monthLabel, style: JaraType.label.copyWith(color: color)),
            if (item.timeLabel != null) ...[
              const SizedBox(height: JaraSpacing.md),
              JaraChip(
                label: item.timeLabel!,
                icon: Icons.schedule_rounded,
                color: color,
              ),
            ],
          ],
        );
      case MemoryType.audio:
        center = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (final height in _bars)
                  Container(
                    width: 6,
                    height: height,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
              ],
            ),
            if (item.timeLabel != null) ...[
              const SizedBox(height: JaraSpacing.lg),
              JaraChip(
                label: item.timeLabel!,
                icon: Icons.graphic_eq_rounded,
                color: color,
              ),
            ],
          ],
        );
      default:
        center = Icon(item.type.icon, size: 64, color: color);
    }

    return Semantics(
      label: item.title,
      image: true,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.30),
                color.withValues(alpha: 0.08),
              ],
            ),
            borderRadius: BorderRadius.circular(JaraRadius.tile),
            border: Border.all(color: t.border),
          ),
          child: Stack(
            children: [
              Center(child: center),
              if (item.extLabel != null)
                Positioned(
                  right: JaraSpacing.lg,
                  bottom: JaraSpacing.lg,
                  child: JaraChip(label: item.extLabel!, color: color),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One row of the overflow action sheet.
class _SheetAction extends StatelessWidget {
  const _SheetAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final fg = color ?? t.textPrimary;
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: JaraSpacing.xl,
            vertical: JaraSpacing.lg,
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: fg),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: JaraType.callout.copyWith(color: fg),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
