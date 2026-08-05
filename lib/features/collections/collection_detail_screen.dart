import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/design/jara_theme.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';

class CollectionDetailScreen extends ConsumerWidget {
  const CollectionDetailScreen({super.key, required this.collectionId});

  final String collectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.jara;
    return Scaffold(
      backgroundColor: t.surface,
      body: Center(
        child: Text('CollectionDetailScreen', style: JaraType.title2.copyWith(color: t.textPrimary)),
      ),
    );
  }
}
