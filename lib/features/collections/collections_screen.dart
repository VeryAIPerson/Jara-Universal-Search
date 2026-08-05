import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/breakpoints.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/models/memory_item.dart';
import '../../core/widgets/horizon_scaffold.dart';
import '../../core/widgets/jara_search_field.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/state_views.dart';

/// Query block cap: a search field the width of a monitor is a bug.
Widget _queryColumn(WindowClass w, Widget child) => w.isPhone
    ? child
    : Align(
        alignment: AlignmentDirectional.centerStart,
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: JaraBreakpoints.proseMaxWidth),
          child: child,
        ),
      );

/// Collections tab — sky holds the title and a shortcut back into search,
/// the surface holds the collection grid.
class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  static const _gap = 14.0;

  /// A collection card carries a name, a count and a date — past this it
  /// only gets emptier, so the grid takes another column instead.
  static const _maxCard = 240.0;
  static const _minCard = 150.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.jara;
    final s = ref.strings;
    ref.watch(memoryRevisionProvider);
    final repo = ref.watch(memoryRepositoryProvider);
    final collections = repo.collections;
    final totalItems =
        collections.fold<int>(0, (sum, c) => sum + c.itemCount);
    final w = context.windowClass;
    final inset = JaraBreakpoints.pageInsetFor(w);

    Widget grid(int columns) => GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: _gap,
            crossAxisSpacing: _gap,
            childAspectRatio: 1.08,
          ),
          itemCount: collections.length,
          itemBuilder: (context, index) => StaggeredItem(
            index: index,
            child: _CollectionCard(
              collection: collections[index],
              itemsLabel: s.collectionItems(collections[index].itemCount),
              updatedLabel: relativeDate(s, collections[index].updated),
            ),
          ),
        );

    return HorizonScaffold(
      skyPadding:
          EdgeInsets.fromLTRB(inset, JaraSpacing.sm, inset, 96),
      surfacePadding: EdgeInsets.fromLTRB(inset, JaraSpacing.lg, inset,
          w.usesRail ? JaraSpacing.xxxl : 130),
      sky: _queryColumn(
        w,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.collectionsTitle,
              style: JaraType.title1.copyWith(color: t.textOnSky),
            ),
            const SizedBox(height: 6),
            Text(
              s.collectionItems(totalItems),
              style: JaraType.caption.copyWith(color: t.textOnSkySecondary),
            ),
            const SizedBox(height: JaraSpacing.lg),
            JaraSearchField(
              readOnly: true,
              hero: false,
              hints: [s.searchHints.first],
              onTap: () => context.go('/search'),
            ),
          ],
        ),
      ),
      // Collections run one column behind the source tiles (2/3/4/5): the
      // card is twice a tile's content, so it needs twice its width.
      surface: w.isPhone
          ? grid(2)
          : LayoutBuilder(
              builder: (context, c) {
                final fits =
                    ((c.maxWidth + _gap) / (_minCard + _gap)).floor();
                final wanted =
                    (JaraBreakpoints.gridColumnsFor(w) - 1).clamp(1, 5);
                final columns =
                    wanted < fits ? wanted : (fits < 1 ? 1 : fits);
                return Align(
                  alignment: AlignmentDirectional.topStart,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: columns * _maxCard + (columns - 1) * _gap),
                    child: grid(columns),
                  ),
                );
              },
            ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({
    required this.collection,
    required this.itemsLabel,
    required this.updatedLabel,
  });

  final MemoryCollection collection;
  final String itemsLabel;
  final String updatedLabel;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return NeuCard(
      padding: const EdgeInsets.all(14),
      onTap: () => context.push('/collections/${collection.id}'),
      semanticLabel: '${collection.name}, $itemsLabel',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: collection.color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.folder_rounded,
                  color: collection.color,
                  size: 20,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right_rounded,
                color: t.textTertiary,
                size: 18,
              ),
            ],
          ),
          const Spacer(),
          Text(
            collection.name,
            style: JaraType.headline.copyWith(color: t.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: JaraSpacing.xs),
          Text(
            itemsLabel,
            style: JaraType.footnote.copyWith(color: t.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: JaraSpacing.sm),
          Row(
            children: [
              for (final type in collection.types.take(3)) ...[
                Icon(type.icon, size: 13, color: type.color),
                const SizedBox(width: 6),
              ],
              Expanded(
                child: Text(
                  updatedLabel,
                  style: JaraType.caption.copyWith(color: t.textTertiary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
