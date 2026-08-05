import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsNl extends JaraStrings {
  const JaraStringsNl();

  /// Simple singular/plural branch (Dutch only needs two forms).
  String _p(int n, String one, String many) => n == 1 ? one : many;

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Al het belangrijke. Eén zoekopdracht.';

  @override
  String get onb1Title => 'Al het belangrijke.\nÉén zoekopdracht.';
  @override
  String get onb1Body =>
      'Vind je bestanden, foto\'s, notities en links in één persoonlijk geheugen.';
  @override
  String get onb2Title => 'Ontworpen voor privacy';
  @override
  String get onb2Body =>
      'Je content wordt zoveel mogelijk op je apparaat verwerkt — jij houdt altijd de controle.';
  @override
  String get onb3Title => 'Eén keer opslaan.\nAltijd terugvinden.';
  @override
  String get onb3Body =>
      'Deel vanuit elke app met JARA en vind het later terug in je eigen woorden.';
  @override
  String get onbPrimaryCta => 'Mijn geheugen opbouwen';
  @override
  String get onbSecondaryCta => 'Demo verkennen';
  @override
  String get onbSkip => 'Overslaan';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Goedemorgen' : 'Goedemorgen, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'Goedemiddag' : 'Goedemiddag, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'Goedenavond' : 'Goedenavond, $name';
  @override
  String get searchTitle => 'Vind alles\nwat je hebt opgeslagen.';
  @override
  List<String> get searchHints => const [
        'Zoek het document over mijn reis naar Londen',
        'Laat screenshots zien met betaalgegevens',
        'Wat heb ik opgeslagen over VoxBridge-prijzen?',
        'Zoek mijn doktersafspraak',
        'Laat foto\'s zien met een paspoort',
      ];
  @override
  String get filterAll => 'Alles';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Document',
        MemoryType.photo => 'Foto',
        MemoryType.screenshot => 'Screenshot',
        MemoryType.note => 'Notitie',
        MemoryType.link => 'Link',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Agenda',
        MemoryType.email => 'E-mail',
        MemoryType.chat => 'Chat',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Documenten',
        MemoryType.photo => 'Foto\'s',
        MemoryType.screenshot => 'Screenshots',
        MemoryType.note => 'Notities',
        MemoryType.link => 'Links',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Agenda',
        MemoryType.email => 'E-mails',
        MemoryType.chat => 'Chats',
      };

  @override
  String get sourcesSection => 'Je geheugen';
  @override
  String get recentSearches => 'Recente zoekopdrachten';
  @override
  String get recentlySaved => 'Recent opgeslagen';
  @override
  String get suggestedSearches => 'Probeer te vragen';
  @override
  String get seeAll => 'Alles bekijken';
  @override
  String get memoryStatusTitle => 'Mijn geheugen';
  @override
  String memoryStatusItems(int items, int collections) =>
      '${_p(items, '1 item', '$items items')} · '
      '${_p(collections, '1 collectie', '$collections collecties')}';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'Geïndexeerd $ago';
  @override
  String newItemsThisWeek(int count) => _p(
        count,
        '+1 nieuw item deze week',
        '+$count nieuwe items deze week',
      );

  @override
  String get suggestionsHistory => 'Recent';
  @override
  String get suggestionsSmart => 'Suggesties';

  @override
  String resultsCount(int count, String elapsed) =>
      '${_p(count, '1 resultaat', '$count resultaten')} · $elapsed';
  @override
  String get bestMatch => 'Beste match';
  @override
  String get smartSummaryTitle => 'Slimme samenvatting';
  @override
  String basedOnItems(int count) => 'Gebaseerd op '
      '${_p(count, '1 opgeslagen item', '$count opgeslagen items')}';
  @override
  String get viewSources => 'Bronnen bekijken';
  @override
  String get refineSearch => 'Zoekopdracht verfijnen';
  @override
  String get saveAnswer => 'Antwoord opslaan';
  @override
  String get copied => 'Gekopieerd';
  @override
  String get sortRecent => 'Meest recent';
  @override
  String get sortRelevance => 'Beste match';

  @override
  String get actionOpen => 'Openen';
  @override
  String get actionPreview => 'Voorbeeld';
  @override
  String get actionShare => 'Delen';
  @override
  String get actionPin => 'Vastzetten';
  @override
  String get actionUnpin => 'Losmaken';
  @override
  String get actionAddTag => 'Label toevoegen';
  @override
  String get actionSaveToCollection => 'Opslaan in collectie';
  @override
  String get actionAskAbout => 'Hierover vragen';
  @override
  String get actionDelete => 'Uit geheugen verwijderen';
  @override
  String get actionOpenOriginal => 'Origineel openen';
  @override
  String get actionAskJara => 'JARA vragen';

  @override
  String get detailRelated => 'Gerelateerde herinneringen';
  @override
  String get detailInCollection => 'Collectie';
  @override
  String get detailTags => 'Labels';
  @override
  String get detailPeople => 'Personen';
  @override
  String get detailSource => 'Bron';
  @override
  String get detailAskPlaceholder => 'Vraag iets over deze herinnering …';

  @override
  String get addTitle => 'Toevoegen aan JARA';
  @override
  String get addScanDocument => 'Document scannen';
  @override
  String get addUploadFile => 'Bestand uploaden';
  @override
  String get addPhoto => 'Foto toevoegen';
  @override
  String get addScreenshot => 'Screenshot toevoegen';
  @override
  String get addVoiceNote => 'Spraaknotitie opnemen';
  @override
  String get addPasteText => 'Tekst plakken';
  @override
  String get addSaveLink => 'Link opslaan';
  @override
  String get addCreateNote => 'Notitie maken';
  @override
  String get addConnectAccount => 'Account verbinden';
  @override
  String get addImportCalendar => 'Agenda importeren';
  @override
  String get addSuccessTitle => 'Opgeslagen in je geheugen';
  @override
  String get addSuccessSearchNow => 'Nu zoeken';
  @override
  String get addSuggestedTitle => 'Voorgestelde titel';
  @override
  String get addSuggestedTags => 'Voorgestelde labels';
  @override
  String get addCollection => 'Collectie';
  @override
  String get addSaveInstantly => 'Direct opslaan';
  @override
  String get addSave => 'Opslaan';

  @override
  String get memoryTitle => 'Geheugen';
  @override
  String get memoryAll => 'Alle herinneringen';
  @override
  String get memoryPinned => 'Vastgezet';
  @override
  String get memoryRecent => 'Recent';
  @override
  String get memoryTimeline => 'Tijdlijn';
  @override
  String get collectionsTitle => 'Collecties';
  @override
  String collectionItems(int count) => _p(count, '1 item', '$count items');
  @override
  String updatedAgo(String ago) => 'Bijgewerkt $ago';

  @override
  String get connectionsTitle => 'Verbindingen';
  @override
  String get connectionsSubtitle =>
      'Kies wat JARA mag indexeren. Je kunt de verbinding altijd verbreken.';
  @override
  String get connectionConnected => 'Verbonden';
  @override
  String get connectionSyncing => 'Synchroniseren …';
  @override
  String get connectionDisconnected => 'Niet verbonden';
  @override
  String get connectionAttention => 'Vereist aandacht';
  @override
  String get connectionConnect => 'Verbinden';
  @override
  String get connectionDisconnect => 'Loskoppelen';
  @override
  String get connectionReindex => 'Opnieuw indexeren';
  @override
  String lastSynced(String ago) => 'Gesynchroniseerd $ago';

  @override
  String get privacyTitle => 'Privacycentrum';
  @override
  String get privacyLocalActive => 'Lokale verwerking actief';
  @override
  String get privacyCloudOff => 'Cloudintelligentie uit';
  @override
  String get privacyCloudOn => 'Cloudintelligentie aan';
  @override
  String get privacyOnDevice => 'Blijft op dit apparaat';
  @override
  String get privacyOnDeviceBody =>
      'Je index, previews en zoekgeschiedenis worden op je apparaat opgeslagen.';
  @override
  String get privacyCloudSection => 'Naar de cloud verzonden';
  @override
  String get privacyCloudBody =>
      'Niets — tenzij je Cloudintelligentie inschakelt voor uitgebreidere antwoorden.';
  @override
  String get privacyLocalAi => 'AI op je apparaat';
  @override
  String get privacyCloudAi => 'Cloudintelligentie';
  @override
  String get privacyAppLock => 'App-vergrendeling';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Bescherming van gevoelige inhoud';
  @override
  String get privacyExport => 'Mijn gegevens exporteren';
  @override
  String get privacyClearHistory => 'Zoekgeschiedenis wissen';
  @override
  String get privacyDeleteAll => 'Alle gegevens verwijderen';
  @override
  String get privacyDeleteConfirmTitle => 'Alles verwijderen?';
  @override
  String get privacyDeleteConfirmBody =>
      'Dit verwijdert je volledige geheugenindex van dit apparaat. Originelen in je apps blijven ongewijzigd.';
  @override
  String get cancel => 'Annuleren';
  @override
  String get confirmDelete => 'Verwijderen';

  @override
  String get settingsTitle => 'Profiel';
  @override
  String get settingsTheme => 'Thema';
  @override
  String get settingsThemeDark => 'Donker';
  @override
  String get settingsThemeLight => 'Licht';
  @override
  String get settingsThemeSystem => 'Systeem';
  @override
  String get settingsLanguage => 'Taal';
  @override
  String get settingsSearchSources => 'Standaard zoekbronnen';
  @override
  String get settingsVoice => 'Spraakzoeken';
  @override
  String get settingsStorage => 'Opslag';
  @override
  String get settingsIndexing => 'Indexeren';
  @override
  String get settingsNotifications => 'Meldingen';
  @override
  String get settingsConnectedAccounts => 'Verbonden accounts';
  @override
  String get settingsPrivacySecurity => 'Privacy en beveiliging';
  @override
  String get settingsSubscription => 'Abonnement';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Cloudintelligentie, onbeperkte verbindingen en prioritaire indexering.';

  @override
  String get paywallTitle => 'Meer bereik, wanneer je het nodig hebt';
  @override
  String get paywallSubtitle =>
      'Premium voegt drie dingen toe aan JARA. Zoeken blijft precies zoals '
      'het is.';
  @override
  String get paywallFeatCloudTitle => 'Cloudintelligentie';
  @override
  String get paywallFeatCloudBody =>
      'Uitgebreidere antwoorden wanneer je voor de cloud kiest. Het blijft '
      'uit tot jij het aanzet, en de keuze blijft van jou.';
  @override
  String get paywallFeatConnectionsTitle => 'Onbeperkte verbindingen';
  @override
  String get paywallFeatConnectionsBody =>
      'Het gratis abonnement houdt een beperkt aantal bronnen verbonden. Met '
      'Premium verbind je elk account dat je gebruikt.';
  @override
  String get paywallFeatIndexingTitle => 'Prioritaire indexering';
  @override
  String get paywallFeatIndexingBody =>
      'Nieuw opgeslagen items worden als eerste doorzoekbaar, ook terwijl '
      'een grote import nog loopt.';
  @override
  String get paywallMonthly => 'Maandelijks';
  @override
  String get paywallYearly => 'Jaarlijks';
  @override
  String get paywallYearlyBadge => 'Beste keuze';
  @override
  String get paywallPriceNote =>
      'De prijs verschijnt bij het afrekenen, in de valuta van jouw regio.';
  @override
  String get paywallCta => 'Beginnen met Premium';
  @override
  String get paywallRestore => 'Aankopen herstellen';
  @override
  String get paywallTerms => 'Voorwaarden';
  @override
  String get paywallSearchFree =>
      'Zoeken in je eigen geheugen is altijd gratis. Premium zet nooit een '
      'slot op wat je al hebt.';
  @override
  String get paywallNotWiredNote => 'Aankopen komen met de storeversie.';

  @override
  String get back => 'Terug';
  @override
  String get moreActions => 'Meer acties';
  @override
  String get done => 'Klaar';
  @override
  String get apply => 'Toepassen';
  @override
  String get continueCta => 'Doorgaan';
  @override
  String get searchAction => 'Zoeken';
  @override
  String get sortBy => 'Sorteren op';
  @override
  String get listening => 'Ik luister …';
  @override
  String get alwaysOn => 'Altijd actief';
  @override
  String get clearDateFilter => 'Datumfilter wissen';
  @override
  String get sectionGeneral => 'Algemeen';
  @override
  String get sectionIntelligence => 'Intelligentie';
  @override
  String get sectionData => 'Gegevens';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Door jou toegevoegd';
  @override
  String get addedJustNow =>
      'Zojuist toegevoegd — JARA maakt dit doorzoekbaar.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA heeft je toestemming nodig',
        JaraError.fileUnreadable => 'Dit bestand kan niet worden geopend',
        JaraError.indexingFailed => 'Indexeren is voortijdig gestopt',
        JaraError.accountDisconnected =>
          'Account moet opnieuw worden verbonden',
        JaraError.noConnection => 'Je bent offline',
        JaraError.localModelNotReady => 'Wordt nog voorbereid',
        JaraError.storageFull => 'Geen opslagruimte meer op dit apparaat',
        JaraError.sourceMissing => 'Het origineel is verdwenen',
        JaraError.generic => 'Nog een keer proberen',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Geef toegang tot deze bron, dan is deze meteen doorzoekbaar.',
        JaraError.fileUnreadable =>
          'Het bestand is mogelijk beschadigd of heeft een formaat dat JARA nog niet kan lezen.',
        JaraError.indexingFailed =>
          'Sommige items zijn niet toegevoegd. Je bestaande geheugen blijft ongewijzigd.',
        JaraError.accountDisconnected =>
          'Log opnieuw in om de items van dit account actueel te houden.',
        JaraError.noConnection =>
          'Je geheugen op het apparaat blijft werken. Cloudfuncties hervatten automatisch.',
        JaraError.localModelNotReady =>
          'Zoeken op het apparaat wordt nog ingesteld. Dit duurt even bij de eerste keer.',
        JaraError.storageFull =>
          'Maak wat ruimte vrij, dan kan JARA het indexeren afronden.',
        JaraError.sourceMissing =>
          'Dit item is verplaatst of verwijderd in de oorspronkelijke app.',
        JaraError.generic =>
          'Dat is niet gelukt. Je geheugen is veilig — probeer het opnieuw.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Instellingen openen',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Opnieuw proberen',
        JaraError.accountDisconnected => 'Opnieuw verbinden',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Opslag beheren',
        JaraError.sourceMissing => 'Uit geheugen verwijderen',
        JaraError.generic => 'Opnieuw proberen',
      };

  @override
  String get needsConnection => 'Verbinding vereist';

  @override
  String get emptyResultsTitle => 'Nog geen resultaten';
  @override
  String get emptyResultsBody =>
      'Probeer de datum, bron of bewoording aan te passen.';
  @override
  String get emptyResultsAdjust => 'Filters aanpassen';
  @override
  String get emptyResultsSearchAll => 'Volledig geheugen doorzoeken';
  @override
  String get emptyMemoryTitle => 'Je geheugen begint hier';
  @override
  String get emptyMemoryBody =>
      'Voeg een bestand, screenshot, link of notitie toe. JARA maakt het doorzoekbaar.';
  @override
  String get emptyMemoryCta => 'Eerste herinnering toevoegen';
  @override
  String get offlineLabel => 'Offline zoeken is actief';
  @override
  String get offlineBody =>
      'Je geheugen op het apparaat blijft werken. Cloudfuncties hervatten automatisch.';
  @override
  String get errorGenericTitle => 'Nog een keer proberen';
  @override
  String get errorGenericBody =>
      'Dat is niet gelukt. Je geheugen is veilig — probeer het opnieuw.';
  @override
  String get retry => 'Herhalen';

  @override
  String get shareTitle => 'Opslaan in JARA';
  @override
  String get shareSaveInstantly => 'Direct opslaan';
  @override
  String get shareReview => 'Details bekijken';
  @override
  String get shareSaved => 'Opgeslagen in je geheugen';

  @override
  String get today => 'Vandaag';
  @override
  String get tomorrow => 'Morgen';
  @override
  String get yesterday => 'Gisteren';
  @override
  String daysAgo(int days) =>
      _p(days, '1 dag geleden', '$days dagen geleden');
  @override
  String inDays(int days) => _p(days, 'over 1 dag', 'over $days dagen');
  @override
  String minutesAgo(int m) =>
      _p(m, '1 minuut geleden', '$m minuten geleden');
  @override
  String hoursAgo(int h) => _p(h, '1 uur geleden', '$h uur geleden');
}
