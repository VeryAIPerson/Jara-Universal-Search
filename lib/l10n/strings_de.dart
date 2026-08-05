import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsDe extends JaraStrings {
  const JaraStringsDe();

  /// Simple singular/plural branch (German only needs two forms).
  String _p(int n, String one, String many) => n == 1 ? one : many;

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Alles Wichtige. Eine Suche.';

  @override
  String get onb1Title => 'Alles Wichtige.\nEine Suche.';
  @override
  String get onb1Body =>
      'Finde deine Dateien, Fotos, Notizen und Links in einem persönlichen Gedächtnis.';
  @override
  String get onb2Title => 'Privat von Grund auf';
  @override
  String get onb2Body =>
      'Deine Inhalte werden möglichst auf deinem Gerät verarbeitet — die Kontrolle bleibt immer bei dir.';
  @override
  String get onb3Title => 'Einmal speichern.\nJederzeit finden.';
  @override
  String get onb3Body =>
      'Teile aus jeder App mit JARA und finde es später in deinen eigenen Worten.';
  @override
  String get onbPrimaryCta => 'Mein Gedächtnis aufbauen';
  @override
  String get onbSecondaryCta => 'Demo entdecken';
  @override
  String get onbSkip => 'Überspringen';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Guten Morgen' : 'Guten Morgen, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'Guten Tag' : 'Guten Tag, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'Guten Abend' : 'Guten Abend, $name';
  @override
  String get searchTitle => 'Finde alles,\nwas du gespeichert hast.';
  @override
  List<String> get searchHints => const [
        'Finde das Dokument zu meiner London-Reise',
        'Zeig Screenshots mit Zahlungsdetails',
        'Was habe ich zu VoxBridge-Preisen gespeichert?',
        'Finde meinen Arzttermin',
        'Zeig Fotos mit einem Reisepass',
      ];
  @override
  String get filterAll => 'Alle';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Dokument',
        MemoryType.photo => 'Foto',
        MemoryType.screenshot => 'Screenshot',
        MemoryType.note => 'Notiz',
        MemoryType.link => 'Link',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Kalender',
        MemoryType.email => 'E-Mail',
        MemoryType.chat => 'Chat',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Dokumente',
        MemoryType.photo => 'Fotos',
        MemoryType.screenshot => 'Screenshots',
        MemoryType.note => 'Notizen',
        MemoryType.link => 'Links',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Kalender',
        MemoryType.email => 'E-Mails',
        MemoryType.chat => 'Chats',
      };

  @override
  String get sourcesSection => 'Dein Gedächtnis';
  @override
  String get recentSearches => 'Letzte Suchen';
  @override
  String get recentlySaved => 'Zuletzt gespeichert';
  @override
  String get suggestedSearches => 'Frag zum Beispiel';
  @override
  String get seeAll => 'Alle anzeigen';
  @override
  String get memoryStatusTitle => 'Mein Gedächtnis';
  @override
  String memoryStatusItems(int items, int collections) =>
      '${_p(items, '1 Element', '$items Elemente')} · '
      '${_p(collections, '1 Sammlung', '$collections Sammlungen')}';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'Indiziert $ago';
  @override
  String newItemsThisWeek(int count) => _p(
        count,
        '+1 neues Element diese Woche',
        '+$count neue Elemente diese Woche',
      );

  @override
  String get suggestionsHistory => 'Zuletzt';
  @override
  String get suggestionsSmart => 'Vorschläge';

  @override
  String resultsCount(int count, String elapsed) =>
      '${_p(count, '1 Ergebnis', '$count Ergebnisse')} · $elapsed';
  @override
  String get bestMatch => 'Bester Treffer';
  @override
  String get smartSummaryTitle => 'Smart-Zusammenfassung';
  @override
  String basedOnItems(int count) => 'Basiert auf '
      '${_p(count, '1 gespeichertem Element', '$count gespeicherten Elementen')}';
  @override
  String get viewSources => 'Quellen ansehen';
  @override
  String get refineSearch => 'Suche verfeinern';
  @override
  String get saveAnswer => 'Antwort speichern';
  @override
  String get copied => 'Kopiert';
  @override
  String get sortRecent => 'Neueste';
  @override
  String get sortRelevance => 'Bester Treffer';

  @override
  String get actionOpen => 'Öffnen';
  @override
  String get actionPreview => 'Vorschau';
  @override
  String get actionShare => 'Teilen';
  @override
  String get actionPin => 'Anheften';
  @override
  String get actionUnpin => 'Nicht mehr anheften';
  @override
  String get actionAddTag => 'Tag hinzufügen';
  @override
  String get actionSaveToCollection => 'In Sammlung speichern';
  @override
  String get actionAskAbout => 'Dazu fragen';
  @override
  String get actionDelete => 'Aus dem Gedächtnis löschen';
  @override
  String get actionOpenOriginal => 'Original öffnen';
  @override
  String get actionAskJara => 'JARA fragen';

  @override
  String get detailRelated => 'Verwandte Erinnerungen';
  @override
  String get detailInCollection => 'Sammlung';
  @override
  String get detailTags => 'Tags';
  @override
  String get detailPeople => 'Personen';
  @override
  String get detailSource => 'Quelle';
  @override
  String get detailAskPlaceholder => 'Frag zu dieser Erinnerung …';

  @override
  String get addTitle => 'Zu JARA hinzufügen';
  @override
  String get addScanDocument => 'Dokument scannen';
  @override
  String get addUploadFile => 'Datei hochladen';
  @override
  String get addPhoto => 'Foto hinzufügen';
  @override
  String get addScreenshot => 'Screenshot hinzufügen';
  @override
  String get addVoiceNote => 'Sprachnotiz aufnehmen';
  @override
  String get addPasteText => 'Text einfügen';
  @override
  String get addSaveLink => 'Link speichern';
  @override
  String get addCreateNote => 'Notiz erstellen';
  @override
  String get addConnectAccount => 'Konto verbinden';
  @override
  String get addImportCalendar => 'Kalender importieren';
  @override
  String get addSuccessTitle => 'In deinem Gedächtnis gespeichert';
  @override
  String get addSuccessSearchNow => 'Jetzt suchen';
  @override
  String get addSuggestedTitle => 'Vorgeschlagener Titel';
  @override
  String get addSuggestedTags => 'Vorgeschlagene Tags';
  @override
  String get addCollection => 'Sammlung';
  @override
  String get addSaveInstantly => 'Sofort speichern';
  @override
  String get addSave => 'Speichern';

  @override
  String get memoryTitle => 'Gedächtnis';
  @override
  String get memoryAll => 'Alle Erinnerungen';
  @override
  String get memoryPinned => 'Angeheftet';
  @override
  String get memoryRecent => 'Zuletzt';
  @override
  String get memoryTimeline => 'Zeitleiste';
  @override
  String get collectionsTitle => 'Sammlungen';
  @override
  String collectionItems(int count) => _p(count, '1 Element', '$count Elemente');
  @override
  String updatedAgo(String ago) => 'Aktualisiert $ago';

  @override
  String get connectionsTitle => 'Verbindungen';
  @override
  String get connectionsSubtitle =>
      'Wähle, was JARA indizieren darf. Du kannst die Verbindung jederzeit trennen.';
  @override
  String get connectionConnected => 'Verbunden';
  @override
  String get connectionSyncing => 'Wird synchronisiert …';
  @override
  String get connectionDisconnected => 'Nicht verbunden';
  @override
  String get connectionAttention => 'Braucht Aufmerksamkeit';
  @override
  String get connectionConnect => 'Verbinden';
  @override
  String get connectionDisconnect => 'Trennen';
  @override
  String get connectionReindex => 'Neu indizieren';
  @override
  String lastSynced(String ago) => 'Synchronisiert $ago';

  @override
  String get privacyTitle => 'Datenschutz-Center';
  @override
  String get privacyLocalActive => 'Lokale Verarbeitung aktiv';
  @override
  String get privacyCloudOff => 'Cloud-Intelligenz aus';
  @override
  String get privacyCloudOn => 'Cloud-Intelligenz an';
  @override
  String get privacyOnDevice => 'Bleibt auf diesem Gerät';
  @override
  String get privacyOnDeviceBody =>
      'Dein Index, deine Vorschauen und dein Suchverlauf werden auf deinem Gerät gespeichert.';
  @override
  String get privacyCloudSection => 'An die Cloud gesendet';
  @override
  String get privacyCloudBody =>
      'Nichts — außer du aktivierst Cloud-Intelligenz für ausführlichere Antworten.';
  @override
  String get privacyLocalAi => 'KI auf dem Gerät';
  @override
  String get privacyCloudAi => 'Cloud-Intelligenz';
  @override
  String get privacyAppLock => 'App-Sperre';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Schutz sensibler Inhalte';
  @override
  String get privacyExport => 'Meine Daten exportieren';
  @override
  String get privacyClearHistory => 'Suchverlauf löschen';
  @override
  String get privacyDeleteAll => 'Alle Daten löschen';
  @override
  String get privacyDeleteConfirmTitle => 'Alles löschen?';
  @override
  String get privacyDeleteConfirmBody =>
      'Dies entfernt deinen gesamten Gedächtnis-Index von diesem Gerät. Originale in deinen Apps sind davon nicht betroffen.';
  @override
  String get privacyDeleted =>
      'Gedächtnis von diesem Gerät gelöscht.';
  @override
  String get cancel => 'Abbrechen';
  @override
  String get confirmDelete => 'Löschen';

  @override
  String get settingsTitle => 'Profil';
  @override
  String get settingsTheme => 'Design';
  @override
  String get settingsThemeDark => 'Dunkel';
  @override
  String get settingsThemeLight => 'Hell';
  @override
  String get settingsThemeSystem => 'System';
  @override
  String get settingsLanguage => 'Sprache';
  @override
  String get settingsSearchSources => 'Standard-Suchquellen';
  @override
  String get settingsVoice => 'Sprachsuche';
  @override
  String get settingsStorage => 'Speicher';
  @override
  String get settingsIndexing => 'Indizierung';
  @override
  String get settingsNotifications => 'Benachrichtigungen';
  @override
  String get settingsConnectedAccounts => 'Verbundene Konten';
  @override
  String get settingsPrivacySecurity => 'Datenschutz & Sicherheit';
  @override
  String get settingsSubscription => 'Abo';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Cloud-Intelligenz, unbegrenzte Verbindungen und priorisierte Indizierung.';

  @override
  String get paywallTitle => 'Mehr Reichweite, wenn du sie brauchst';
  @override
  String get paywallSubtitle =>
      'Premium ergänzt JARA um drei Dinge. Die Suche bleibt genau so, wie '
      'sie ist.';
  @override
  String get paywallFeatCloudTitle => 'Cloud-Intelligenz';
  @override
  String get paywallFeatCloudBody =>
      'Ausführlichere Antworten, wenn du die Cloud wählst. Sie bleibt aus, '
      'bis du sie einschaltest — die Entscheidung bleibt bei dir.';
  @override
  String get paywallFeatConnectionsTitle => 'Unbegrenzte Verbindungen';
  @override
  String get paywallFeatConnectionsBody =>
      'Im kostenlosen Tarif bleibt nur eine begrenzte Zahl an Quellen '
      'verbunden. Mit Premium verbindest du jedes Konto, das du nutzt.';
  @override
  String get paywallFeatIndexingTitle => 'Priorisierte Indizierung';
  @override
  String get paywallFeatIndexingBody =>
      'Neu Gespeichertes wird zuerst durchsuchbar — auch während ein großer '
      'Import noch läuft.';
  @override
  String get paywallMonthly => 'Monatlich';
  @override
  String get paywallYearly => 'Jährlich';
  @override
  String get paywallYearlyBadge => 'Bestes Angebot';
  @override
  String get paywallPriceNote =>
      'Der Preis erscheint beim Bezahlen, in der Währung deiner Region.';
  @override
  String get paywallCta => 'Mit Premium starten';
  @override
  String get paywallRestore => 'Käufe wiederherstellen';
  @override
  String get paywallTerms => 'Bedingungen';
  @override
  String get paywallSearchFree =>
      'Die Suche in deinem eigenen Gedächtnis ist immer kostenlos. Premium '
      'sperrt nie, was du schon hast.';
  @override
  String get paywallNotWiredNote => 'Käufe kommen mit der Store-Version.';

  @override
  String get back => 'Zurück';
  @override
  String get moreActions => 'Weitere Aktionen';
  @override
  String get done => 'Fertig';
  @override
  String get apply => 'Anwenden';
  @override
  String get continueCta => 'Weiter';
  @override
  String get searchAction => 'Suchen';
  @override
  String get sortBy => 'Sortieren nach';
  @override
  String get listening => 'Ich höre …';
  @override
  String get alwaysOn => 'Immer aktiv';
  @override
  String get clearDateFilter => 'Datumsfilter zurücksetzen';
  @override
  String get sectionGeneral => 'Allgemein';
  @override
  String get sectionIntelligence => 'Intelligenz';
  @override
  String get sectionData => 'Daten';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Von dir hinzugefügt';
  @override
  String get addedJustNow =>
      'Gerade eben hinzugefügt — JARA macht es jetzt durchsuchbar.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA braucht deine Zustimmung',
        JaraError.fileUnreadable => 'Diese Datei lässt sich nicht öffnen',
        JaraError.indexingFailed => 'Indizierung wurde vorzeitig beendet',
        JaraError.accountDisconnected => 'Konto muss erneut verbunden werden',
        JaraError.noConnection => 'Du bist offline',
        JaraError.localModelNotReady => 'Wird noch vorbereitet',
        JaraError.storageFull => 'Kein Speicherplatz mehr auf diesem Gerät',
        JaraError.sourceMissing => 'Das Original ist nicht mehr da',
        JaraError.generic => 'Noch einmal versuchen',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Erlaube den Zugriff auf diese Quelle, dann ist sie sofort durchsuchbar.',
        JaraError.fileUnreadable =>
          'Die Datei ist möglicherweise beschädigt oder hat ein Format, das JARA noch nicht lesen kann.',
        JaraError.indexingFailed =>
          'Einige Elemente wurden nicht hinzugefügt. Dein bisheriges Gedächtnis bleibt unverändert.',
        JaraError.accountDisconnected =>
          'Melde dich erneut an, damit die Elemente dieses Kontos aktuell bleiben.',
        JaraError.noConnection =>
          'Dein Gedächtnis auf dem Gerät funktioniert weiter. Cloud-Funktionen werden automatisch fortgesetzt.',
        JaraError.localModelNotReady =>
          'Die Suche auf dem Gerät wird gerade eingerichtet. Das dauert beim ersten Start einen Moment.',
        JaraError.storageFull =>
          'Schaffe etwas Speicherplatz, dann kann JARA die Indizierung abschließen.',
        JaraError.sourceMissing =>
          'Dieses Element wurde in der ursprünglichen App verschoben oder gelöscht.',
        JaraError.generic =>
          'Das hat nicht geklappt. Dein Gedächtnis ist sicher — versuch es erneut.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Einstellungen öffnen',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Erneut versuchen',
        JaraError.accountDisconnected => 'Erneut verbinden',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Speicher verwalten',
        JaraError.sourceMissing => 'Aus dem Gedächtnis entfernen',
        JaraError.generic => 'Erneut versuchen',
      };

  @override
  String get needsConnection => 'Verbindung erforderlich';

  @override
  String get emptyResultsTitle => 'Noch keine Treffer';
  @override
  String get emptyResultsBody =>
      'Versuch, Datum, Quelle oder Formulierung zu ändern.';
  @override
  String get emptyResultsAdjust => 'Filter anpassen';
  @override
  String get emptyResultsSearchAll => 'Gesamtes Gedächtnis durchsuchen';
  @override
  String get emptyMemoryTitle => 'Dein Gedächtnis beginnt hier';
  @override
  String get emptyMemoryBody =>
      'Füge eine Datei, einen Screenshot, einen Link oder eine Notiz hinzu. JARA macht es durchsuchbar.';
  @override
  String get emptyMemoryCta => 'Erste Erinnerung hinzufügen';
  @override
  String get offlineLabel => 'Offline-Suche ist aktiv';
  @override
  String get offlineBody =>
      'Dein Gedächtnis auf dem Gerät funktioniert weiter. Cloud-Funktionen werden automatisch fortgesetzt.';
  @override
  String get errorGenericTitle => 'Noch einmal versuchen';
  @override
  String get errorGenericBody =>
      'Das hat nicht geklappt. Dein Gedächtnis ist sicher — versuch es erneut.';
  @override
  String get retry => 'Wiederholen';

  @override
  String get shareTitle => 'In JARA speichern';
  @override
  String get shareSaveInstantly => 'Sofort speichern';
  @override
  String get shareReview => 'Details prüfen';
  @override
  String get shareSaved => 'In deinem Gedächtnis gespeichert';

  @override
  String get today => 'Heute';
  @override
  String get tomorrow => 'Morgen';
  @override
  String get yesterday => 'Gestern';
  @override
  String daysAgo(int days) => _p(days, 'vor 1 Tag', 'vor $days Tagen');
  @override
  String inDays(int days) => _p(days, 'in 1 Tag', 'in $days Tagen');
  @override
  String minutesAgo(int m) => _p(m, 'vor 1 Minute', 'vor $m Minuten');
  @override
  String hoursAgo(int h) => _p(h, 'vor 1 Stunde', 'vor $h Stunden');
}
