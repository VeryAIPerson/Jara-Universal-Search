import 'package:flutter/material.dart';
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
  static const _keyThemeMode = 'theme_mode';
  static const _keyLocaleTag = 'locale_tag';
  static const _keyRecentSearches = 'recent_searches';
  static const _keyPinnedIds = 'pinned_ids';
  static const _keyUnpinnedIds = 'unpinned_ids';

  bool get hasSeenOnboarding =>
      _prefs.getBool(_keyHasSeenOnboarding) ?? false;

  Future<void> setHasSeenOnboarding(bool value) =>
      _prefs.setBool(_keyHasSeenOnboarding, value);

  /// Null until the user picks a theme explicitly; callers keep today's
  /// ThemeMode.dark default in that case.
  ThemeMode? get themeMode =>
      ThemeMode.values.asNameMap()[_prefs.getString(_keyThemeMode)];

  Future<void> setThemeMode(ThemeMode mode) =>
      _prefs.setString(_keyThemeMode, mode.name);

  /// BCP-47-ish tag for an explicit language choice (see providers.dart's
  /// serializeLocaleTag/parseLocaleTag). Null until the user picks one;
  /// callers then follow the device locale instead of hardcoding English.
  String? get localeTag => _prefs.getString(_keyLocaleTag);

  Future<void> setLocaleTag(String tag) =>
      _prefs.setString(_keyLocaleTag, tag);

  /// Null on first run — caller keeps MockMemoryRepository's demo seed.
  /// Capped to 6 defensively; the writer already caps too.
  List<String>? get recentSearches =>
      _prefs.getStringList(_keyRecentSearches)?.take(6).toList();

  Future<void> setRecentSearches(List<String> values) =>
      _prefs.setStringList(_keyRecentSearches, values.take(6).toList());

  /// Ids pinned beyond the repository's seed defaults. Null on first run —
  /// see providers.dart for the full pin-persistence scheme.
  Set<String>? get pinnedIds =>
      _prefs.getStringList(_keyPinnedIds)?.toSet();

  Future<void> setPinnedIds(Set<String> ids) =>
      _prefs.setStringList(_keyPinnedIds, ids.toList());

  /// Ids explicitly unpinned despite being pinned in the seed by default.
  Set<String>? get unpinnedIds =>
      _prefs.getStringList(_keyUnpinnedIds)?.toSet();

  Future<void> setUnpinnedIds(Set<String> ids) =>
      _prefs.setStringList(_keyUnpinnedIds, ids.toList());
}

/// Overridden in `main()` with the real instance — see the
/// `ProviderContainer(overrides: [...])` there. Never read before that
/// runs.
final prefsProvider = Provider<JaraPrefs>(
  (ref) => throw UnimplementedError('prefsProvider not overridden in main()'),
);
