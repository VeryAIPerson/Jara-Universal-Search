import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsPl extends JaraStrings {
  const JaraStringsPl();

  /// Polish counting plural: one / few (2-4) / many (0, 5+, 12-14).
  /// `few` and `many` are sometimes passed the same genitive text on
  /// purpose — under a case-governing preposition (e.g. "na podstawie",
  /// "za") the few/many distinction collapses into one genitive form;
  /// only the "one" form stays distinct. See report for details.
  String _plural(int n, String one, String few, String many) {
    if (n == 1) return one;
    final mod10 = n % 10;
    final mod100 = n % 100;
    if (mod10 >= 2 && mod10 <= 4 && !(mod100 >= 12 && mod100 <= 14)) {
      return few;
    }
    return many;
  }

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Wszystko, co ważne. Jedno wyszukiwanie.';

  @override
  String get onb1Title => 'Wszystko, co ważne.\nJedno wyszukiwanie.';
  @override
  String get onb1Body =>
      'Znajdź swoje pliki, zdjęcia, notatki i linki w jednej osobistej pamięci.';
  @override
  String get onb2Title => 'Prywatność od podstaw';
  @override
  String get onb2Body =>
      'Twoje treści są przetwarzane na twoim urządzeniu, kiedy tylko to możliwe — kontrola zawsze należy do ciebie.';
  @override
  String get onb3Title => 'Zapisz raz.\nZnajdź, kiedy chcesz.';
  @override
  String get onb3Body =>
      'Udostępnij coś z dowolnej aplikacji do JARA, a potem znajdź to własnymi słowami.';
  @override
  String get onbPrimaryCta => 'Zbuduj swoją pamięć';
  @override
  String get onbSecondaryCta => 'Zobacz demo';
  @override
  String get onbSkip => 'Pomiń';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Dzień dobry' : 'Dzień dobry, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'Dzień dobry' : 'Dzień dobry, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'Dobry wieczór' : 'Dobry wieczór, $name';
  @override
  String get searchTitle => 'Znajdź wszystko,\nco zapisano.';
  @override
  List<String> get searchHints => const [
        'Znajdź dokument o mojej podróży do Londynu',
        'Pokaż zrzuty ekranu z danymi płatności',
        'Co zapisano o cenach VoxBridge?',
        'Znajdź moją wizytę u lekarza',
        'Pokaż zdjęcia z paszportem',
      ];
  @override
  String get filterAll => 'Wszystko';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Dokument',
        MemoryType.photo => 'Zdjęcie',
        MemoryType.screenshot => 'Zrzut ekranu',
        MemoryType.note => 'Notatka',
        MemoryType.link => 'Link',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Kalendarz',
        MemoryType.email => 'E-mail',
        MemoryType.chat => 'Czat',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Dokumenty',
        MemoryType.photo => 'Zdjęcia',
        MemoryType.screenshot => 'Zrzuty ekranu',
        MemoryType.note => 'Notatki',
        MemoryType.link => 'Linki',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Kalendarz',
        MemoryType.email => 'E-maile',
        MemoryType.chat => 'Czaty',
      };

  @override
  String get sourcesSection => 'Twoja pamięć';
  @override
  String get recentSearches => 'Ostatnie wyszukiwania';
  @override
  String get recentlySaved => 'Ostatnio zapisane';
  @override
  String get suggestedSearches => 'Spróbuj zapytać';
  @override
  String get seeAll => 'Zobacz wszystko';
  @override
  String get memoryStatusTitle => 'Moja pamięć';
  @override
  String memoryStatusItems(int items, int collections) =>
      '${_plural(items, '$items element', '$items elementy', '$items elementów')} '
      '· ${_plural(collections, '$collections kolekcja', '$collections kolekcje', '$collections kolekcji')}';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'Zaindeksowano $ago';
  @override
  String newItemsThisWeek(int count) => _plural(
        count,
        '+$count nowy element w tym tygodniu',
        '+$count nowe elementy w tym tygodniu',
        '+$count nowych elementów w tym tygodniu',
      );

  @override
  String get suggestionsHistory => 'Ostatnie';
  @override
  String get suggestionsSmart => 'Sugestie';

  @override
  String resultsCount(int count, String elapsed) =>
      '${_plural(count, '$count wynik', '$count wyniki', '$count wyników')} '
      '· $elapsed';
  @override
  String get bestMatch => 'Najlepsze dopasowanie';
  @override
  String get smartSummaryTitle => 'Inteligentne podsumowanie';
  @override
  String basedOnItems(int count) => 'Na podstawie ${_plural(
        count,
        '$count zapisanego elementu',
        '$count zapisanych elementów',
        '$count zapisanych elementów',
      )}';
  @override
  String get viewSources => 'Zobacz źródła';
  @override
  String get refineSearch => 'Zawęź wyszukiwanie';
  @override
  String get saveAnswer => 'Zapisz odpowiedź';
  @override
  String get copied => 'Skopiowano';
  @override
  String get sortRecent => 'Najnowsze';
  @override
  String get sortRelevance => 'Najlepsze dopasowanie';

  @override
  String get actionOpen => 'Otwórz';
  @override
  String get actionPreview => 'Podgląd';
  @override
  String get actionShare => 'Udostępnij';
  @override
  String get actionPin => 'Przypnij';
  @override
  String get actionUnpin => 'Odepnij';
  @override
  String get actionAddTag => 'Dodaj tag';
  @override
  String get actionSaveToCollection => 'Zapisz w kolekcji';
  @override
  String get actionAskAbout => 'Zapytaj o to';
  @override
  String get actionDelete => 'Usuń z pamięci';
  @override
  String get actionOpenOriginal => 'Otwórz oryginał';
  @override
  String get actionAskJara => 'Zapytaj JARA';

  @override
  String get detailRelated => 'Powiązane wspomnienia';
  @override
  String get detailInCollection => 'Kolekcja';
  @override
  String get detailTags => 'Tagi';
  @override
  String get detailPeople => 'Osoby';
  @override
  String get detailSource => 'Źródło';
  @override
  String get detailAskPlaceholder => 'Zapytaj o to wspomnienie…';

  @override
  String get addTitle => 'Dodaj do JARA';
  @override
  String get addScanDocument => 'Zeskanuj dokument';
  @override
  String get addUploadFile => 'Wgraj plik';
  @override
  String get addPhoto => 'Dodaj zdjęcie';
  @override
  String get addScreenshot => 'Dodaj zrzut ekranu';
  @override
  String get addVoiceNote => 'Nagraj notatkę głosową';
  @override
  String get addPasteText => 'Wklej tekst';
  @override
  String get addSaveLink => 'Zapisz link';
  @override
  String get addCreateNote => 'Utwórz notatkę';
  @override
  String get addConnectAccount => 'Połącz konto';
  @override
  String get addImportCalendar => 'Importuj kalendarz';
  @override
  String get addSuccessTitle => 'Zapisano w twojej pamięci';
  @override
  String get addSuccessSearchNow => 'Wyszukaj teraz';
  @override
  String get addSuggestedTitle => 'Sugerowany tytuł';
  @override
  String get addSuggestedTags => 'Sugerowane tagi';
  @override
  String get addCollection => 'Kolekcja';
  @override
  String get addSaveInstantly => 'Zapisz od razu';
  @override
  String get addSave => 'Zapisz';

  @override
  String get memoryTitle => 'Pamięć';
  @override
  String get memoryAll => 'Wszystkie wspomnienia';
  @override
  String get memoryPinned => 'Przypięte';
  @override
  String get memoryRecent => 'Ostatnie';
  @override
  String get memoryTimeline => 'Oś czasu';
  @override
  String get collectionsTitle => 'Kolekcje';
  @override
  String collectionItems(int count) =>
      _plural(count, '$count element', '$count elementy', '$count elementów');
  @override
  String updatedAgo(String ago) => 'Zaktualizowano $ago';

  @override
  String get connectionsTitle => 'Połączenia';
  @override
  String get connectionsSubtitle =>
      'Wybierz, co JARA może indeksować. Możesz odłączyć się w każdej chwili.';
  @override
  String get connectionConnected => 'Połączono';
  @override
  String get connectionSyncing => 'Synchronizowanie…';
  @override
  String get connectionDisconnected => 'Nie połączono';
  @override
  String get connectionAttention => 'Wymaga uwagi';
  @override
  String get connectionConnect => 'Połącz';
  @override
  String get connectionDisconnect => 'Odłącz';
  @override
  String get connectionReindex => 'Zaindeksuj ponownie';
  @override
  String lastSynced(String ago) => 'Zsynchronizowano $ago';

  @override
  String get privacyTitle => 'Centrum prywatności';
  @override
  String get privacyLocalActive => 'Przetwarzanie lokalne aktywne';
  @override
  String get privacyCloudOff => 'Inteligencja w chmurze wyłączona';
  @override
  String get privacyCloudOn => 'Inteligencja w chmurze włączona';
  @override
  String get privacyOnDevice => 'Pozostaje na tym urządzeniu';
  @override
  String get privacyOnDeviceBody =>
      'Twój indeks, podglądy i historia wyszukiwania są przechowywane na twoim urządzeniu.';
  @override
  String get privacyCloudSection => 'Wysyłane do chmury';
  @override
  String get privacyCloudBody =>
      'Nic — chyba że włączysz inteligencję w chmurze, aby uzyskać bogatsze odpowiedzi.';
  @override
  String get privacyLocalAi => 'AI na urządzeniu';
  @override
  String get privacyCloudAi => 'Inteligencja w chmurze';
  @override
  String get privacyAppLock => 'Blokada aplikacji';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Ochrona wrażliwych treści';
  @override
  String get privacyExport => 'Eksportuj moje dane';
  @override
  String get privacyClearHistory => 'Wyczyść historię wyszukiwania';
  @override
  String get privacyDeleteAll => 'Usuń wszystkie dane';
  @override
  String get privacyDeleteConfirmTitle => 'Usunąć wszystko?';
  @override
  String get privacyDeleteConfirmBody =>
      'To usunie cały indeks pamięci z tego urządzenia. Oryginały w twoich aplikacjach pozostaną nienaruszone.';
  @override
  String get privacyDeleted =>
      'Pamięć usunięta z tego urządzenia.';
  @override
  String get cancel => 'Anuluj';
  @override
  String get confirmDelete => 'Usuń';

  @override
  String get settingsTitle => 'Profil';
  @override
  String get settingsTheme => 'Motyw';
  @override
  String get settingsThemeDark => 'Ciemny';
  @override
  String get settingsThemeLight => 'Jasny';
  @override
  String get settingsThemeSystem => 'Systemowy';
  @override
  String get settingsLanguage => 'Język';
  @override
  String get settingsSearchSources => 'Domyślne źródła wyszukiwania';
  @override
  String get settingsVoice => 'Wyszukiwanie głosowe';
  @override
  String get settingsStorage => 'Pamięć';
  @override
  String get settingsIndexing => 'Indeksowanie';
  @override
  String get settingsNotifications => 'Powiadomienia';
  @override
  String get settingsConnectedAccounts => 'Połączone konta';
  @override
  String get settingsPrivacySecurity => 'Prywatność i bezpieczeństwo';
  @override
  String get settingsSubscription => 'Subskrypcja';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Inteligencja w chmurze, nieograniczone połączenia i priorytetowe indeksowanie.';

  @override
  String get paywallTitle => 'Większy zasięg, kiedy go potrzebujesz';
  @override
  String get paywallSubtitle =>
      'Premium dodaje do JARA trzy rzeczy. Wyszukiwanie zostaje dokładnie '
      'takie, jakie jest.';
  @override
  String get paywallFeatCloudTitle => 'Inteligencja w chmurze';
  @override
  String get paywallFeatCloudBody =>
      'Pełniejsze odpowiedzi, kiedy wybierzesz chmurę. Pozostaje wyłączona, '
      'dopóki jej nie włączysz, a decyzja zawsze należy do ciebie.';
  @override
  String get paywallFeatConnectionsTitle => 'Nieograniczone połączenia';
  @override
  String get paywallFeatConnectionsBody =>
      'Plan bezpłatny utrzymuje połączoną ograniczoną liczbę źródeł. Premium '
      'łączy każde konto, z którego korzystasz.';
  @override
  String get paywallFeatIndexingTitle => 'Priorytetowe indeksowanie';
  @override
  String get paywallFeatIndexingBody =>
      'Nowe zapisy stają się wyszukiwalne jako pierwsze, nawet gdy trwa duży '
      'import.';
  @override
  String get paywallMonthly => 'Miesięcznie';
  @override
  String get paywallYearly => 'Rocznie';
  @override
  String get paywallYearlyBadge => 'Najlepszy wybór';
  @override
  String get paywallPriceNote =>
      'Cena pojawia się przy płatności, w walucie twojego regionu.';
  @override
  String get paywallCta => 'Zacznij z Premium';
  @override
  String get paywallRestore => 'Przywróć zakupy';
  @override
  String get paywallTerms => 'Warunki';
  @override
  String get paywallSearchFree =>
      'Przeszukiwanie własnej pamięci jest zawsze bezpłatne. Premium nigdy '
      'nie blokuje tego, co już masz.';
  @override
  String get paywallNotWiredNote => 'Zakupy pojawią się w wersji ze sklepu.';

  @override
  String get back => 'Wstecz';
  @override
  String get moreActions => 'Więcej opcji';
  @override
  String get done => 'Gotowe';
  @override
  String get apply => 'Zastosuj';
  @override
  String get continueCta => 'Dalej';
  @override
  String get searchAction => 'Szukaj';
  @override
  String get sortBy => 'Sortuj według';
  @override
  String get listening => 'Słucham…';
  @override
  String get alwaysOn => 'Zawsze włączone';
  @override
  String get clearDateFilter => 'Wyczyść filtr daty';
  @override
  String get sectionGeneral => 'Ogólne';
  @override
  String get sectionIntelligence => 'Inteligencja';
  @override
  String get sectionData => 'Dane';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Dodane przez ciebie';
  @override
  String get addedJustNow => 'Dodano przed chwilą — JARA już to indeksuje.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA potrzebuje twojej zgody',
        JaraError.fileUnreadable => 'Tego pliku nie można otworzyć',
        JaraError.indexingFailed => 'Indeksowanie zatrzymało się przedwcześnie',
        JaraError.accountDisconnected => 'Konto wymaga ponownego połączenia',
        JaraError.noConnection => 'Jesteś offline',
        JaraError.localModelNotReady => 'Jeszcze się przygotowuje',
        JaraError.storageFull => 'Brak miejsca na tym urządzeniu',
        JaraError.sourceMissing => 'Oryginał zniknął',
        JaraError.generic => 'Spróbuj jeszcze raz',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Zezwól na dostęp do tego źródła, a od razu stanie się przeszukiwalne.',
        JaraError.fileUnreadable =>
          'Plik może być uszkodzony albo ma format, którego JARA jeszcze nie obsługuje.',
        JaraError.indexingFailed =>
          'Niektóre elementy nie zostały dodane. Twoja dotychczasowa pamięć pozostaje nienaruszona.',
        JaraError.accountDisconnected =>
          'Zaloguj się ponownie, aby elementy z tego konta były aktualne.',
        JaraError.noConnection =>
          'Twoja pamięć na urządzeniu nadal działa. Funkcje w chmurze wznowią się automatycznie.',
        JaraError.localModelNotReady =>
          'Wyszukiwanie na urządzeniu kończy konfigurację. Przy pierwszym uruchomieniu zajmuje to chwilę.',
        JaraError.storageFull =>
          'Zwolnij trochę miejsca — JARA dokończy wtedy indeksowanie.',
        JaraError.sourceMissing =>
          'Ten element został przeniesiony lub usunięty w swojej oryginalnej aplikacji.',
        JaraError.generic =>
          'To się nie udało. Twoja pamięć jest bezpieczna — spróbuj ponownie.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Otwórz ustawienia',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Spróbuj ponownie',
        JaraError.accountDisconnected => 'Połącz ponownie',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Zarządzaj pamięcią',
        JaraError.sourceMissing => 'Usuń z pamięci',
        JaraError.generic => 'Spróbuj ponownie',
      };

  @override
  String get needsConnection => 'Wymaga połączenia';

  @override
  String get emptyResultsTitle => 'Na razie brak wyników';
  @override
  String get emptyResultsBody =>
      'Spróbuj zmienić datę, źródło lub sformułowanie.';
  @override
  String get emptyResultsAdjust => 'Dostosuj filtry';
  @override
  String get emptyResultsSearchAll => 'Przeszukaj całą pamięć';
  @override
  String get emptyMemoryTitle => 'Tu zaczyna się twoja pamięć';
  @override
  String get emptyMemoryBody =>
      'Dodaj plik, zrzut ekranu, link lub notatkę. JARA to zindeksuje.';
  @override
  String get emptyMemoryCta => 'Dodaj pierwsze wspomnienie';
  @override
  String get offlineLabel => 'Wyszukiwanie offline jest aktywne';
  @override
  String get offlineBody =>
      'Twoja pamięć na urządzeniu nadal działa. Funkcje w chmurze wznowią się automatycznie.';
  @override
  String get errorGenericTitle => 'Spróbuj jeszcze raz';
  @override
  String get errorGenericBody =>
      'To się nie udało. Twoja pamięć jest bezpieczna — spróbuj ponownie.';
  @override
  String get retry => 'Ponów';

  @override
  String get shareTitle => 'Zapisz w JARA';
  @override
  String get shareSaveInstantly => 'Zapisz od razu';
  @override
  String get shareReview => 'Sprawdź szczegóły';
  @override
  String get shareSaved => 'Zapisano w twojej pamięci';

  @override
  String get today => 'Dziś';
  @override
  String get tomorrow => 'Jutro';
  @override
  String get yesterday => 'Wczoraj';
  @override
  String daysAgo(int days) =>
      _plural(days, '$days dzień temu', '$days dni temu', '$days dni temu');
  @override
  String inDays(int days) =>
      _plural(days, 'za $days dzień', 'za $days dni', 'za $days dni');
  @override
  String minutesAgo(int m) => _plural(
        m,
        '$m minutę temu',
        '$m minuty temu',
        '$m minut temu',
      );
  @override
  String hoursAgo(int h) => _plural(
        h,
        '$h godzinę temu',
        '$h godziny temu',
        '$h godzin temu',
      );
}
