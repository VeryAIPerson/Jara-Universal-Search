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
import '../design/breakpoints.dart';
import '../l10n_bridge.dart';
import '../widgets/adaptive_nav.dart';
import '../widgets/jara_bottom_bar.dart';
import '../widgets/jara_fab.dart';

/// Branch roots in destination order — the one list the bar, the rail and
/// the Cmd/Ctrl+1..4 shortcuts navigate by.
const _branchRoots = ['/search', '/memory', '/collections', '/profile'];

const _detailPath = '/item/:id';

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
        path: _detailPath,
        pageBuilder: _detailPageBuilder,
      ),
    ],
  );
});

/// The detail is one route with two presentations. Narrow windows push the
/// full page exactly as before; two-pane windows keep the route on the
/// stack — so back, Esc and deep links behave identically — but render it
/// as nothing, because [JaraShell] paints it in its trailing pane.
Page<void> _detailPageBuilder(BuildContext context, GoRouterState state) {
  final id = state.pathParameters['id']!;
  if (JaraBreakpoints.of(context).usesTwoPane) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      name: state.name ?? state.path,
      restorationId: state.pageKey.value,
      opaque: false,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondary, child) => child,
      child: _DetailPaneHandoff(itemId: id),
    );
  }
  return MaterialPage<void>(
    key: state.pageKey,
    name: state.name ?? state.path,
    restorationId: state.pageKey.value,
    arguments: <String, String>{
      ...state.pathParameters,
      ...state.uri.queryParameters,
    },
    child: ResultDetailScreen(itemId: id),
  );
}

/// Stand-in for the detail page on two-pane windows. A deep link that
/// lands straight on `/item/:id` has no shell underneath to paint the
/// pane, so the stack is rebuilt once as list + detail.
class _DetailPaneHandoff extends StatefulWidget {
  const _DetailPaneHandoff({required this.itemId});

  final String itemId;

  @override
  State<_DetailPaneHandoff> createState() => _DetailPaneHandoffState();
}

class _DetailPaneHandoffState extends State<_DetailPaneHandoff> {
  bool _restacked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureShell());
  }

  void _ensureShell() {
    if (!mounted || _restacked) return;
    final router = GoRouter.of(context);
    if (router.canPop()) return; // a shell is already below us
    _restacked = true;
    router.go(_branchRoots.first);
    router.push('/item/${widget.itemId}');
  }

  @override
  Widget build(BuildContext context) =>
      const IgnorePointer(child: SizedBox.shrink());
}

/// Shortcut actions for when focus sits outside the shell — a pushed page,
/// a sheet, a dialog. [JaraShell] overrides these with branch-aware ones
/// while focus is inside it.
Map<Type, Action<Intent>> jaraRootShortcutActions(GoRouter router) {
  BuildContext? navigatorContext() =>
      router.routerDelegate.navigatorKey.currentContext;

  return <Type, Action<Intent>>{
    JaraFocusSearchIntent: CallbackAction<JaraFocusSearchIntent>(
      onInvoke: (_) {
        router.go(_branchRoots.first);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final context = navigatorContext();
          if (context != null) focusFirstField(context);
        });
        return null;
      },
    ),
    JaraAddIntent: CallbackAction<JaraAddIntent>(
      onInvoke: (_) {
        final context = navigatorContext();
        if (context != null) showAddSheet(context);
        return null;
      },
    ),
    JaraDismissIntent: CallbackAction<JaraDismissIntent>(
      onInvoke: (_) {
        if (router.canPop()) router.pop();
        return null;
      },
    ),
    JaraDestinationIntent: CallbackAction<JaraDestinationIntent>(
      onInvoke: (intent) {
        router.go(_branchRoots[intent.index]);
        return null;
      },
    ),
  };
}

/// App shell: indexed branches under adaptive navigation chrome, plus the
/// trailing detail pane on windows wide enough to carry two.
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

  void _goBranch(int index) => widget.shell.goBranch(
        index,
        initialLocation: index == widget.shell.currentIndex,
      );

  /// Cmd/Ctrl+K: land on the search branch, then focus the field that
  /// screen owns. Already inside it (home or results) means "focus what is
  /// on screen" — never throw away a query the user typed.
  void _focusSearch() {
    if (widget.shell.currentIndex != 0) widget.shell.goBranch(0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) focusFirstField(context);
    });
  }

  /// The memory the router currently points at, or null. Selection travels
  /// through the route so feature screens keep pushing `/item/:id` and
  /// never learn about panes.
  String? _selectedItemId() {
    final state = GoRouter.of(context).state;
    if (state.fullPath != _detailPath) return null;
    return state.pathParameters['id'];
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.strings;
    final shell = widget.shell;
    ref.listen(indexStateProvider, _onIndexState);

    final twoPane = JaraBreakpoints.of(context).usesTwoPane;
    final selectedId = twoPane ? _selectedItemId() : null;

    return Actions(
      actions: <Type, Action<Intent>>{
        JaraFocusSearchIntent: CallbackAction<JaraFocusSearchIntent>(
          onInvoke: (_) {
            _focusSearch();
            return null;
          },
        ),
        JaraAddIntent: CallbackAction<JaraAddIntent>(
          onInvoke: (_) {
            showAddSheet(context);
            return null;
          },
        ),
        JaraDismissIntent: CallbackAction<JaraDismissIntent>(
          onInvoke: (_) {
            final router = GoRouter.of(context);
            if (router.canPop()) router.pop();
            return null;
          },
        ),
        JaraDestinationIntent: CallbackAction<JaraDestinationIntent>(
          onInvoke: (intent) {
            _goBranch(intent.index);
            return null;
          },
        ),
      },
      child: AdaptiveNavShell(
        currentIndex: shell.currentIndex,
        onDestinationSelected: _goBranch,
        onAdd: () => showAddSheet(context),
        fabState: _fabState,
        addLabel: s.addTitle,
        body: shell,
        detail: selectedId == null
            ? null
            : ResultDetailScreen(
                key: ValueKey('detail-$selectedId'),
                itemId: selectedId,
              ),
        destinations: [
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
