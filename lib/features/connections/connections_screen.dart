import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/design/jara_theme.dart';
import '../../core/design/typography.dart';
import '../../core/l10n_bridge.dart';

class ConnectionsScreen extends ConsumerWidget {
  const ConnectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.jara;
    return Scaffold(
      backgroundColor: t.surface,
      body: Center(
        child: Text('ConnectionsScreen', style: JaraType.title2.copyWith(color: t.textPrimary)),
      ),
    );
  }
}
