import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/add/add_sheet.dart';
import '../../features/collections/collection_detail_screen.dart';
import '../../features/collections/collections_screen.dart';
import '../../features/connections/connections_screen.dart';
import '../../features/detail/result_detail_screen.dart';
import '../../features/memory/memory_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/privacy/privacy_screen.dart';
import '../../features/search/search_home_screen.dart';
import '../../features/search/search_results_screen.dart';
import '../../features/settings/profile_screen.dart';
import '../../features/share/share_capture_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../data/providers.dart';
import '../design/jara_theme.dart';
import '../l10n_bridge.dart';
import '../widgets/jara_bottom_bar.dart';
import '../widgets/jara_fab.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SplashScreen()),
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: OnboardingScreen()),
      ),
      GoRoute(
        path: '/share-capture',
        builder: (context, state) => const ShareCaptureScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => JaraShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/search',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: SearchHomeScreen()),
              routes: [
                GoRoute(
                  path: 'results',
                  builder: (context, state) => SearchResultsScreen(
                    initialQuery: state.uri.queryParameters['q'] ?? '',
                  ),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/memory',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: MemoryScreen()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/collections',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: CollectionsScreen()),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) => CollectionDetailScreen(
                    collectionId: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfileScreen()),
              routes: [
                GoRoute(
                  path: 'connections',
                  builder: (context, state) => const ConnectionsScreen(),
                ),
                GoRoute(
                  path: 'privacy',
                  builder: (context, state) => const PrivacyScreen(),
                ),
              ],
            ),
          ]),
        ],
      ),
      GoRoute(
        path: '/item/:id',
        builder: (context, state) =>
            ResultDetailScreen(itemId: state.pathParameters['id']!),
      ),
    ],
  );
});

/// App shell: indexed branches over a floating bottom bar + center FAB.
class JaraShell extends ConsumerStatefulWidget {
  const JaraShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  ConsumerState<JaraShell> createState() => _JaraShellState();
}

class _JaraShellState extends ConsumerState<JaraShell> {
  /// Long enough to register as "done", short enough not to sit in the way
  /// of the add action the FAB normally offers.
  static const _successFlash = Duration(milliseconds: 900);

  JaraFabState _fabState = JaraFabState.add;
  Timer? _flash;

  @override
  void dispose() {
    _flash?.cancel();
    super.dispose();
  }

  void _onIndexState(IndexState? previous, IndexState next) {
    _flash?.cancel();
    if (next == IndexState.indexing) {
      setState(() => _fabState = JaraFabState.indexing);
      return;
    }
    // Only a finished run earns the check — landing on idle any other way
    // (first build, hot restart) just goes back to add.
    if (previous != IndexState.indexing) {
      setState(() => _fabState = JaraFabState.add);
      return;
    }
    setState(() => _fabState = JaraFabState.success);
    _flash = Timer(_successFlash, () {
      if (!mounted) return;
      setState(() => _fabState = JaraFabState.add);
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.strings;
    final shell = widget.shell;
    ref.listen(indexStateProvider, _onIndexState);

    return Scaffold(
      backgroundColor: context.jara.surface,
      extendBody: true,
      body: shell,
      bottomNavigationBar: JaraBottomBar(
        currentIndex: shell.currentIndex,
        onTap: (index) => shell.goBranch(
          index,
          initialLocation: index == shell.currentIndex,
        ),
        onFabTap: () => showAddSheet(context),
        fabState: _fabState,
        fabSemanticLabel: s.addTitle,
        items: [
          JaraBottomBarItem(
            icon: Icons.search_rounded,
            selectedIcon: Icons.search_rounded,
            label: s.searchAction,
          ),
          JaraBottomBarItem(
            icon: Icons.auto_awesome_motion_outlined,
            selectedIcon: Icons.auto_awesome_motion_rounded,
            label: s.memoryTitle,
          ),
          JaraBottomBarItem(
            icon: Icons.grid_view_outlined,
            selectedIcon: Icons.grid_view_rounded,
            label: s.collectionsTitle,
          ),
          JaraBottomBarItem(
            icon: Icons.person_outline_rounded,
            selectedIcon: Icons.person_rounded,
            label: s.settingsTitle,
          ),
        ],
      ),
    );
  }
}
