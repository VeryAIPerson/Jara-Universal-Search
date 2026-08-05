import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Typed wrapper over [SharedPreferences]. `getInstance()` is async, so
/// `main()` awaits [JaraPrefs.create] once before `runApp` and hands the
/// instance to [prefsProvider] via an override — screens then read/write
/// synchronously. Add new persisted keys here as a key constant plus a
/// get/set pair.
class JaraPrefs {
  JaraPrefs(this._prefs);

  final SharedPreferences _prefs;

  static Future<JaraPrefs> create() async =>
      JaraPrefs(await SharedPreferences.getInstance());

  static const _keyHasSeenOnboarding = 'has_seen_onboarding';

  bool get hasSeenOnboarding =>
      _prefs.getBool(_keyHasSeenOnboarding) ?? false;

  Future<void> setHasSeenOnboarding(bool value) =>
      _prefs.setBool(_keyHasSeenOnboarding, value);
}

/// Overridden in `main()` with the real instance — see
/// `ProviderScope(overrides: [...])`. Never read before that runs.
final prefsProvider = Provider<JaraPrefs>(
  (ref) => throw UnimplementedError('prefsProvider not overridden in main()'),
);
