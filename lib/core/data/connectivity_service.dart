import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Thin wrapper over connectivity_plus so the rest of the app only ever
/// deals with a bool.
///
/// The plugin reports a *list* of active transports (a phone can be on
/// wifi and cellular at once), so "offline" is the empty list or a list
/// that holds nothing but [ConnectivityResult.none] — losing one of two
/// transports is not going offline.
class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  static bool isOffline(List<ConnectivityResult> results) =>
      results.isEmpty || results.every((r) => r == ConnectivityResult.none);

  /// Seeds with the current state so the first frame is already honest,
  /// then follows the platform stream for the rest of the session.
  Stream<bool> watchOffline() async* {
    try {
      yield isOffline(await _connectivity.checkConnectivity());
      yield* _connectivity.onConnectivityChanged.map(isOffline);
    } on Exception {
      // No platform channel (tests, unsupported host): report online
      // rather than telling the user their device lost the network.
      yield false;
    }
  }
}

final connectivityServiceProvider =
    Provider<ConnectivityService>((ref) => ConnectivityService());

/// Raw platform signal. Screens watch `offlineProvider` (providers.dart)
/// instead — it folds in the manual override and stays online-by-default
/// while this is loading or where the plugin has no host (tests, headless
/// desktop), so a missing platform channel can never block local search.
final connectivityOfflineProvider = StreamProvider<bool>(
  (ref) => ref.watch(connectivityServiceProvider).watchOffline(),
);
