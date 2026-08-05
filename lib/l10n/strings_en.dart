import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsEn extends JaraStrings {
  const JaraStringsEn();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Everything important. One search.';

  @override
  String get onb1Title => 'Everything important.\nOne search.';
  @override
  String get onb1Body =>
      'Find your files, photos, notes and links in one personal memory.';
  @override
  String get onb2Title => 'Private by design';
  @override
  String get onb2Body =>
      'Your content is processed on your device whenever possible — control always stays with you.';
  @override
  String get onb3Title => 'Save once.\nFind anytime.';
  @override
  String get onb3Body =>
      'Share from any app into JARA, then find it later in your own words.';
  @override
  String get onbPrimaryCta => 'Build My Memory';
  @override
  String get onbSecondaryCta => 'Explore Demo';
  @override
  String get onbSkip => 'Skip';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Good morning' : 'Good morning, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'Good afternoon' : 'Good afternoon, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'Good evening' : 'Good evening, $name';
  @override
  String get searchTitle => 'Find anything\nyou’ve saved.';
  @override
  List<String> get searchHints => const [
        'Find the document about my London trip',
        'Show screenshots with payment details',
        'What did I save about VoxBridge pricing?',
        'Find my doctor appointment',
        'Show photos containing a passport',
      ];
  @override
  String get filterAll => 'All';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Document',
        MemoryType.photo => 'Photo',
        MemoryType.screenshot => 'Screenshot',
        MemoryType.note => 'Note',
        MemoryType.link => 'Link',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Calendar',
        MemoryType.email => 'Email',
        MemoryType.chat => 'Chat',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Documents',
        MemoryType.photo => 'Photos',
        MemoryType.screenshot => 'Screenshots',
        MemoryType.note => 'Notes',
        MemoryType.link => 'Links',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Calendar',
        MemoryType.email => 'Emails',
        MemoryType.chat => 'Chats',
      };

  @override
  String get sourcesSection => 'Your memory';
  @override
  String get recentSearches => 'Recent searches';
  @override
  String get recentlySaved => 'Recently saved';
  @override
  String get suggestedSearches => 'Try asking';
  @override
  String get seeAll => 'See all';
  @override
  String get memoryStatusTitle => 'My Memory';
  @override
  String memoryStatusItems(int items, int collections) =>
      '$items items · $collections collections';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'Indexed $ago';
  @override
  String newItemsThisWeek(int count) => '+$count this week';

  @override
  String get suggestionsHistory => 'Recent';
  @override
  String get suggestionsSmart => 'Suggestions';

  @override
  String resultsCount(int count, String elapsed) =>
      '$count results · $elapsed';
  @override
  String get bestMatch => 'Best match';
  @override
  String get smartSummaryTitle => 'Smart Summary';
  @override
  String basedOnItems(int count) => 'Based on $count saved items';
  @override
  String get viewSources => 'View sources';
  @override
  String get refineSearch => 'Refine search';
  @override
  String get saveAnswer => 'Save answer';
  @override
  String get copied => 'Copied';
  @override
  String get sortRecent => 'Most recent';
  @override
  String get sortRelevance => 'Best match';

  @override
  String get actionOpen => 'Open';
  @override
  String get actionPreview => 'Preview';
  @override
  String get actionShare => 'Share';
  @override
  String get actionPin => 'Pin';
  @override
  String get actionUnpin => 'Unpin';
  @override
  String get actionAddTag => 'Add tag';
  @override
  String get actionSaveToCollection => 'Save to collection';
  @override
  String get actionAskAbout => 'Ask about this';
  @override
  String get actionDelete => 'Delete from memory';
  @override
  String get actionOpenOriginal => 'Open original';
  @override
  String get actionAskJara => 'Ask JARA';

  @override
  String get detailRelated => 'Related memories';
  @override
  String get detailInCollection => 'Collection';
  @override
  String get detailTags => 'Tags';
  @override
  String get detailPeople => 'People';
  @override
  String get detailSource => 'Source';
  @override
  String get detailAskPlaceholder => 'Ask about this memory…';

  @override
  String get addTitle => 'Add to JARA';
  @override
  String get addScanDocument => 'Scan document';
  @override
  String get addUploadFile => 'Upload file';
  @override
  String get addPhoto => 'Add photo';
  @override
  String get addScreenshot => 'Add screenshot';
  @override
  String get addVoiceNote => 'Record voice note';
  @override
  String get addPasteText => 'Paste text';
  @override
  String get addSaveLink => 'Save link';
  @override
  String get addCreateNote => 'Create note';
  @override
  String get addConnectAccount => 'Connect account';
  @override
  String get addImportCalendar => 'Import calendar';
  @override
  String get addSuccessTitle => 'Saved to your memory';
  @override
  String get addSuccessSearchNow => 'Search it now';
  @override
  String get addSuggestedTitle => 'Suggested title';
  @override
  String get addSuggestedTags => 'Suggested tags';
  @override
  String get addCollection => 'Collection';
  @override
  String get addSaveInstantly => 'Save instantly';
  @override
  String get addSave => 'Save';

  @override
  String get memoryTitle => 'Memory';
  @override
  String get memoryAll => 'All memories';
  @override
  String get memoryPinned => 'Pinned';
  @override
  String get memoryRecent => 'Recent';
  @override
  String get memoryTimeline => 'Timeline';
  @override
  String get collectionsTitle => 'Collections';
  @override
  String collectionItems(int count) => '$count items';
  @override
  String updatedAgo(String ago) => 'Updated $ago';

  @override
  String get connectionsTitle => 'Connections';
  @override
  String get connectionsSubtitle =>
      'Choose what JARA can index. You can disconnect anytime.';
  @override
  String get connectionConnected => 'Connected';
  @override
  String get connectionSyncing => 'Syncing…';
  @override
  String get connectionDisconnected => 'Not connected';
  @override
  String get connectionAttention => 'Needs attention';
  @override
  String get connectionConnect => 'Connect';
  @override
  String get connectionDisconnect => 'Disconnect';
  @override
  String get connectionReindex => 'Re-index';
  @override
  String lastSynced(String ago) => 'Synced $ago';

  @override
  String get privacyTitle => 'Privacy Center';
  @override
  String get privacyLocalActive => 'Local Processing Active';
  @override
  String get privacyCloudOff => 'Cloud Intelligence Off';
  @override
  String get privacyCloudOn => 'Cloud Intelligence On';
  @override
  String get privacyOnDevice => 'Stays on this device';
  @override
  String get privacyOnDeviceBody =>
      'Your index, previews and search history are stored on your device.';
  @override
  String get privacyCloudSection => 'Sent to cloud';
  @override
  String get privacyCloudBody =>
      'Nothing, unless you turn on Cloud Intelligence for richer answers.';
  @override
  String get privacyLocalAi => 'On-device AI';
  @override
  String get privacyCloudAi => 'Cloud Intelligence';
  @override
  String get privacyAppLock => 'App lock';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Sensitive content protection';
  @override
  String get privacyExport => 'Export my data';
  @override
  String get privacyClearHistory => 'Clear search history';
  @override
  String get privacyDeleteAll => 'Delete all data';
  @override
  String get privacyDeleteConfirmTitle => 'Delete everything?';
  @override
  String get privacyDeleteConfirmBody =>
      'This removes your entire memory index from this device. Originals in your apps are not affected.';
  @override
  String get cancel => 'Cancel';
  @override
  String get confirmDelete => 'Delete';

  @override
  String get settingsTitle => 'Profile';
  @override
  String get settingsTheme => 'Theme';
  @override
  String get settingsThemeDark => 'Dark';
  @override
  String get settingsThemeLight => 'Light';
  @override
  String get settingsThemeSystem => 'System';
  @override
  String get settingsLanguage => 'Language';
  @override
  String get settingsSearchSources => 'Default search sources';
  @override
  String get settingsVoice => 'Voice search';
  @override
  String get settingsStorage => 'Storage';
  @override
  String get settingsIndexing => 'Indexing';
  @override
  String get settingsNotifications => 'Notifications';
  @override
  String get settingsConnectedAccounts => 'Connected accounts';
  @override
  String get settingsPrivacySecurity => 'Privacy & security';
  @override
  String get settingsSubscription => 'Subscription';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Cloud Intelligence, unlimited connections and priority indexing.';

  @override
  String get back => 'Back';
  @override
  String get moreActions => 'More actions';
  @override
  String get done => 'Done';
  @override
  String get apply => 'Apply';
  @override
  String get continueCta => 'Continue';
  @override
  String get searchAction => 'Search';
  @override
  String get sortBy => 'Sort by';
  @override
  String get listening => 'Listening…';
  @override
  String get alwaysOn => 'Always on';
  @override
  String get clearDateFilter => 'Clear date filter';
  @override
  String get sectionGeneral => 'General';
  @override
  String get sectionIntelligence => 'Intelligence';
  @override
  String get sectionData => 'Data';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Added by you';
  @override
  String get addedJustNow => 'Added just now — JARA is making this searchable.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA needs your go-ahead',
        JaraError.fileUnreadable => 'This file won’t open',
        JaraError.indexingFailed => 'Indexing stopped early',
        JaraError.accountDisconnected => 'Account needs reconnecting',
        JaraError.noConnection => 'You’re offline',
        JaraError.localModelNotReady => 'Still getting ready',
        JaraError.storageFull => 'No room left on this device',
        JaraError.sourceMissing => 'The original is gone',
        JaraError.generic => 'Something needs a retry',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Allow access to this source and it becomes searchable right away.',
        JaraError.fileUnreadable =>
          'The file may be damaged or in a format JARA can’t read yet.',
        JaraError.indexingFailed =>
          'Some items weren’t added. Your existing memory is untouched.',
        JaraError.accountDisconnected =>
          'Sign in again to keep this account’s items up to date.',
        JaraError.noConnection =>
          'Your on-device memory keeps working. Cloud features resume automatically.',
        JaraError.localModelNotReady =>
          'On-device search is finishing setup. This takes a moment on first run.',
        JaraError.storageFull =>
          'Free up some space, then JARA can finish indexing.',
        JaraError.sourceMissing =>
          'This item was moved or deleted in its original app.',
        JaraError.generic =>
          'That didn’t go through. Your memory is safe — try again.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Open settings',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Try again',
        JaraError.accountDisconnected => 'Reconnect',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Manage storage',
        JaraError.sourceMissing => 'Remove from memory',
        JaraError.generic => 'Try again',
      };

  @override
  String get needsConnection => 'Needs connection';

  @override
  String get emptyResultsTitle => 'Nothing matched yet';
  @override
  String get emptyResultsBody =>
      'Try changing the date, source or wording.';
  @override
  String get emptyResultsAdjust => 'Adjust filters';
  @override
  String get emptyResultsSearchAll => 'Search all memory';
  @override
  String get emptyMemoryTitle => 'Your memory starts here';
  @override
  String get emptyMemoryBody =>
      'Add a file, screenshot, link or note. JARA will make it searchable.';
  @override
  String get emptyMemoryCta => 'Add First Memory';
  @override
  String get offlineLabel => 'Offline search is active';
  @override
  String get offlineBody =>
      'Your on-device memory keeps working. Cloud features will resume automatically.';
  @override
  String get errorGenericTitle => 'Something needs a retry';
  @override
  String get errorGenericBody =>
      'That didn’t go through. Your memory is safe — try again.';
  @override
  String get retry => 'Retry';

  @override
  String get shareTitle => 'Save to JARA';
  @override
  String get shareSaveInstantly => 'Save instantly';
  @override
  String get shareReview => 'Review details';
  @override
  String get shareSaved => 'Saved to your memory';

  @override
  String get today => 'Today';
  @override
  String get tomorrow => 'Tomorrow';
  @override
  String get yesterday => 'Yesterday';
  @override
  String daysAgo(int days) => '${days}d ago';
  @override
  String inDays(int days) => 'in $days days';
  @override
  String minutesAgo(int m) => '${m}m ago';
  @override
  String hoursAgo(int h) => '${h}h ago';
}
