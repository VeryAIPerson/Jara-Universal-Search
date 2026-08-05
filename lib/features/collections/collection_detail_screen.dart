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
import '../../core/widgets/neu_tile.dart';
import '../../core/widgets/result_cards.dart';
import '../../core/widgets/state_views.dart';
import '../add/add_sheet.dart';

/// Result cards read better side by side than as one very wide column —
/// but only while each card keeps a scannable width.
Widget _cardGrid(List<Widget> cards, int columns) {
  const gap = JaraSpacing.md;
  const minCard = 320.0;
  return LayoutBuilder(
    builder: (context, c) {
      final fits = ((c.maxWidth + gap) / (minCard + gap)).floor();
      final n = columns < fits ? columns : (fits < 1 ? 1 : fits);
      if (n < 2) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < cards.length; i++) ...[
              if (i > 0) const SizedBox(height: gap),
              cards[i],
            ],
          ],
        );
      }
      final width = ((c.maxWidth - gap * (n - 1)) / n).floorToDouble();
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [
          for (final card in cards) SizedBox(width: width, child: card),
        ],
      );
    },
  );
}

/// One collection's contents — pushed inside the shell, so the list keeps
/// bottom room for the floating bar.
class CollectionDetailScreen extends ConsumerWidget {
  const CollectionDetailScreen({super.key, required this.collectionId});

  final String collectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.jara;
    final s = ref.strings;
    ref.watch(memoryRevisionProvider);
    final repo = ref.watch(memoryRepositoryProvider);

    MemoryCollection? collection;
    for (final c in repo.collections) {
      if (c.id.toLowerCase() == collectionId.toLowerCase()) {
        collection = c;
        break;
      }
    }
    final items = repo.inCollection(collectionId);
    final color = collection?.color ?? t.accent;
    final w = context.windowClass;
    final inset = JaraBreakpoints.pageInsetFor(w);

    void togglePin(String id) {
      repo.togglePin(id);
      ref.read(memoryRevisionProvider.notifier).state++;
      JaraHaptics.confirm();
    }

    final cards = [
      for (var i = 0; i < items.length; i++)
        StaggeredItem(
          index: i,
          child: UniversalResultCard(
            item: items[i],
            dateLabel: relativeDate(s, items[i].date),
            onTap: () => context.push('/item/${items[i].id}'),
            onPin: () => togglePin(items[i].id),
          ),
        ),
    ];

    final list = ListView(
      padding: EdgeInsets.fromLTRB(inset, JaraSpacing.md, inset,
          w.usesRail ? JaraSpacing.xxxl : 140),
      children: [
        Row(
          children: [
            NeuIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              semanticLabel: s.back,
              onTap: () => context.pop(),
            ),
            const SizedBox(width: JaraSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collection?.name ?? collectionId,
                    style: JaraType.title2.copyWith(color: t.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    s.collectionItems(items.length),
                    style:
                        JaraType.footnote.copyWith(color: t.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(width: JaraSpacing.md),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.folder_rounded, color: color, size: 20),
            ),
          ],
        ),
        const SizedBox(height: JaraSpacing.xl),
        if (items.isEmpty)
          EmptyStateView(
            icon: Icons.folder_open_rounded,
            title: s.emptyResultsTitle,
            message: s.emptyMemoryBody,
            primaryLabel: s.emptyMemoryCta,
            onPrimary: () => showAddSheet(context),
          )
        // Same content shape as the memory library, so the same rule: two
        // columns once the window is wide enough to keep cards readable.
        else if (w.usesTwoPane)
          _cardGrid(cards, 2)
        else
          for (var i = 0; i < cards.length; i++) ...[
            cards[i],
            if (i != cards.length - 1) const SizedBox(height: JaraSpacing.md),
          ],
      ],
    );

    return Scaffold(
      backgroundColor: t.surface,
      body: SafeArea(
        bottom: false,
        child: w == WindowClass.large
            ? Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: JaraBreakpoints.contentMaxWidth),
                  child: list,
                ),
              )
            : list,
      ),
    );
  }
}
