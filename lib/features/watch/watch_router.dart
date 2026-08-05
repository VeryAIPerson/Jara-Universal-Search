import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/motion.dart';
import 'watch_detail_screen.dart';
import 'watch_home_screen.dart';
import 'watch_listening_screen.dart';
import 'watch_results_screen.dart';
import 'watch_routes.dart';

/// Wrist router: four screens, one line. Slides and shared-axis moves
/// read as jitter on a 192 dp face, so every transition is a short fade
/// that disappears entirely under reduce-motion.
final watchRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: WatchRoutes.home,
    routes: [
      GoRoute(
        path: WatchRoutes.home,
        pageBuilder: (context, state) => _fade(const WatchHomeScreen()),
      ),
      GoRoute(
        path: WatchRoutes.listening,
        pageBuilder: (context, state) => _fade(const WatchListeningScreen()),
      ),
      GoRoute(
        path: WatchRoutes.results,
        pageBuilder: (context, state) => _fade(const WatchResultsScreen()),
      ),
      GoRoute(
        path: '${WatchRoutes.item}/:id',
        pageBuilder: (context, state) => _fade(
          WatchDetailScreen(itemId: state.pathParameters['id']!),
        ),
      ),
    ],
  );
});

CustomTransitionPage<void> _fade(Widget child) => CustomTransitionPage<void>(
      child: child,
      transitionDuration: JaraMotion.base,
      reverseTransitionDuration: JaraMotion.fast,
      transitionsBuilder: (context, animation, _, page) =>
          JaraMotion.reduced(context)
              ? page
              : FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: JaraMotion.standard,
                  ),
                  child: page,
                ),
    );
