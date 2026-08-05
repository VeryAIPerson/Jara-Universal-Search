import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/data/providers.dart';
import '../core/models/memory_item.dart';
import 'locales.dart';

/// Typed copy deck. Hand-rolled instead of gen-l10n: with 20 shipped
/// languages the real risk is a missing key, and ARB resolves that
/// silently at runtime while this makes it a compile error (D20b).
/// The locale registry lives in locales.dart.
abstract class JaraStrings {
  const JaraStrings();

  String get appName;
  String get tagline;

  // Onboarding
  String get onb1Title;
  String get onb1Body;
  String get onb2Title;
  String get onb2Body;
  String get onb3Title;
  String get onb3Body;
  String get onbPrimaryCta;
  String get onbSecondaryCta;
  String get onbSkip;

  // Search home
  String greetingMorning(String name);
  String greetingDay(String name);
  String greetingEvening(String name);
  String get searchTitle;
  List<String> get searchHints;
  String get filterAll;
  String typeLabel(MemoryType type);
  String typePluralLabel(MemoryType type);
  String get sourcesSection;
  String get recentSearches;
  String get recentlySaved;
  String get suggestedSearches;
  String get seeAll;
  String get memoryStatusTitle;
  String memoryStatusItems(int items, int collections);
  String memoryStatusFree(String free);
  String indexedAgo(String ago);
  String newItemsThisWeek(int count);

  // Suggestions
  String get suggestionsHistory;
  String get suggestionsSmart;

  // Results
  String resultsCount(int count, String elapsed);
  String get bestMatch;
  String get smartSummaryTitle;
  String basedOnItems(int count);
  String get viewSources;
  String get refineSearch;
  String get saveAnswer;
  String get copied;
  String get sortRecent;
  String get sortRelevance;

  // Result actions
  String get actionOpen;
  String get actionPreview;
  String get actionShare;
  String get actionPin;
  String get actionUnpin;
  String get actionAddTag;
  String get actionSaveToCollection;
  String get actionAskAbout;
  String get actionDelete;
  String get actionOpenOriginal;
  String get actionAskJara;

  // Detail
  String get detailRelated;
  String get detailInCollection;
  String get detailTags;
  String get detailPeople;
  String get detailSource;
  String get detailAskPlaceholder;

  // Add flow
  String get addTitle;
  String get addScanDocument;
  String get addUploadFile;
  String get addPhoto;
  String get addScreenshot;
  String get addVoiceNote;
  String get addPasteText;
  String get addSaveLink;
  String get addCreateNote;
  String get addConnectAccount;
  String get addImportCalendar;
  String get addSuccessTitle;
  String get addSuccessSearchNow;
  String get addSuggestedTitle;
  String get addSuggestedTags;
  String get addCollection;
  String get addSaveInstantly;
  String get addSave;

  // Memory
  String get memoryTitle;
  String get memoryAll;
  String get memoryPinned;
  String get memoryRecent;
  String get memoryTimeline;
  String get collectionsTitle;
  String collectionItems(int count);
  String updatedAgo(String ago);

  // Connections
  String get connectionsTitle;
  String get connectionsSubtitle;
  String get connectionConnected;
  String get connectionSyncing;
  String get connectionDisconnected;
  String get connectionAttention;
  String get connectionConnect;
  String get connectionDisconnect;
  String get connectionReindex;
  String lastSynced(String ago);

  // Privacy
  String get privacyTitle;
  String get privacyLocalActive;
  String get privacyCloudOff;
  String get privacyCloudOn;
  String get privacyOnDevice;
  String get privacyOnDeviceBody;
  String get privacyCloudSection;
  String get privacyCloudBody;
  String get privacyLocalAi;
  String get privacyCloudAi;
  String get privacyAppLock;
  String get privacyBiometric;
  String get privacySensitive;
  String get privacyExport;
  String get privacyClearHistory;
  String get privacyDeleteAll;
  String get privacyDeleteConfirmTitle;
  String get privacyDeleteConfirmBody;
  String get cancel;
  String get confirmDelete;

  // Settings
  String get settingsTitle;
  String get settingsTheme;
  String get settingsThemeDark;
  String get settingsThemeLight;
  String get settingsThemeSystem;
  String get settingsLanguage;
  String get settingsSearchSources;
  String get settingsVoice;
  String get settingsStorage;
  String get settingsIndexing;
  String get settingsNotifications;
  String get settingsConnectedAccounts;
  String get settingsPrivacySecurity;
  String get settingsSubscription;
  String get settingsPremium;
  String get settingsPremiumBody;

  // Generic UI verbs / section labels
  String get back;
  String get moreActions;
  String get done;
  String get apply;
  String get continueCta;
  String get searchAction;
  String get sortBy;
  String get listening;
  String get alwaysOn;
  String get clearDateFilter;
  String get sectionGeneral;
  String get sectionIntelligence;
  String get sectionData;
  String get productName;
  String get manualAddSource;
  String get addedJustNow;

  // Error catalogue (see JaraError)
  String errorTitle(JaraError e);
  String errorBody(JaraError e);
  String? errorCta(JaraError e);

  /// Marks a cloud-only affordance while offline.
  String get needsConnection;

  // States
  String get emptyResultsTitle;
  String get emptyResultsBody;
  String get emptyResultsAdjust;
  String get emptyResultsSearchAll;
  String get emptyMemoryTitle;
  String get emptyMemoryBody;
  String get emptyMemoryCta;
  String get offlineLabel;
  String get offlineBody;
  String get errorGenericTitle;
  String get errorGenericBody;
  String get retry;

  // Share sheet
  String get shareTitle;
  String get shareSaveInstantly;
  String get shareReview;
  String get shareSaved;

  // Time
  String get today;
  String get tomorrow;
  String get yesterday;
  String daysAgo(int days);
  String inDays(int days);
  String minutesAgo(int m);
  String hoursAgo(int h);
}

/// Every user-visible failure the app can reach. Technical codes never
/// surface — each case maps to a plain title/body/CTA triple.
enum JaraError {
  permissionDenied,
  fileUnreadable,
  indexingFailed,
  accountDisconnected,
  noConnection,
  localModelNotReady,
  storageFull,
  sourceMissing,
  generic,
}

final stringsProvider = Provider<JaraStrings>(
  (ref) => resolveJaraLocale(ref.watch(localeProvider)).strings,
);

extension StringsContext on WidgetRef {
  JaraStrings get strings => watch(stringsProvider);

  /// The pinned-in-tests wall clock; pass to [relativeDate] so labels
  /// stay deterministic under a fixed [clockProvider].
  DateTime get now => read(clockProvider)();
}

/// Relative date label helper shared by cards. [now] defaults to the wall
/// clock; screens pass `ref.now` so goldens can pin it.
String relativeDate(JaraStrings s, DateTime date, {DateTime? now}) {
  now ??= DateTime.now();
  final diff = now.difference(date);
  if (diff.isNegative) {
    final ahead = date.difference(now);
    if (ahead.inHours < 24 && date.day == now.day) return s.today;
    final days = ahead.inDays + 1;
    if (days <= 1) return s.tomorrow;
    return s.inDays(days);
  }
  if (diff.inMinutes < 60) return s.minutesAgo(diff.inMinutes.clamp(1, 59));
  if (diff.inHours < 24) return s.hoursAgo(diff.inHours);
  if (diff.inDays < 2) return s.yesterday;
  if (diff.inDays < 30) return s.daysAgo(diff.inDays);
  return '${date.day}.${date.month}.${date.year}';
}
