import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/providers.dart';
import '../../core/design/jara_theme.dart';
import '../../core/design/tokens.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';
import '../../core/models/memory_item.dart';
import '../../core/widgets/horizon_scaffold.dart';
import '../../core/widgets/jara_search_field.dart';
import '../../core/widgets/neu_card.dart';
import '../../core/widgets/state_views.dart';

/// Collections tab — sky holds the title and a shortcut back into search,
/// the surface holds the collection grid.
class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.jara;
    final s = ref.strings;
    ref.watch(memoryRevisionProvider);
    final repo = ref.watch(memoryRepositoryProvider);
    final collections = repo.collections;
    final totalItems =
        collections.fold<int>(0, (sum, c) => sum + c.itemCount);

    return HorizonScaffold(
      skyPadding: const EdgeInsets.fromLTRB(
          JaraSpacing.page, JaraSpacing.sm, JaraSpacing.page, 96),
      surfacePadding: const EdgeInsets.fromLTRB(
          JaraSpacing.page, JaraSpacing.lg, JaraSpacing.page, 130),
      sky: Column(
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
      surface: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
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
