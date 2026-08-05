import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsRu extends JaraStrings {
  const JaraStringsRu();

  /// Russian counting plural: one / few (2-4) / many (0, 5-20, ...).
  /// `few` and `many` are sometimes passed the same genitive-plural
  /// text on purpose — under a case-governing preposition (e.g. "на
  /// основе") the few/many distinction collapses into one genitive
  /// form; only "one" stays distinct. See report for details.
  String _plural(int n, String one, String few, String many) {
    final mod10 = n % 10;
    final mod100 = n % 100;
    if (mod10 == 1 && mod100 != 11) return one;
    if (mod10 >= 2 && mod10 <= 4 && !(mod100 >= 12 && mod100 <= 14)) {
      return few;
    }
    return many;
  }

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Всё важное. Один поиск.';

  @override
  String get onb1Title => 'Всё важное.\nОдин поиск.';
  @override
  String get onb1Body =>
      'Находите свои файлы, фото, заметки и ссылки в единой личной памяти.';
  @override
  String get onb2Title => 'Приватность по умолчанию';
  @override
  String get onb2Body =>
      'Ваш контент по возможности обрабатывается на вашем устройстве — контроль остаётся за вами.';
  @override
  String get onb3Title => 'Сохраните один раз.\nНаходите в любой момент.';
  @override
  String get onb3Body =>
      'Отправляйте что угодно в JARA из любого приложения, а потом находите это своими словами.';
  @override
  String get onbPrimaryCta => 'Создать мою память';
  @override
  String get onbSecondaryCta => 'Смотреть демо';
  @override
  String get onbSkip => 'Пропустить';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Доброе утро' : 'Доброе утро, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'Добрый день' : 'Добрый день, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'Добрый вечер' : 'Добрый вечер, $name';
  @override
  String get searchTitle => 'Найдите всё,\nчто вы сохранили.';
  @override
  List<String> get searchHints => const [
        'Найти документ о поездке в Лондон',
        'Показать скриншоты с платёжными данными',
        'Что у меня сохранено о ценах VoxBridge?',
        'Найти запись к врачу',
        'Показать фото с паспортом',
      ];
  @override
  String get filterAll => 'Все';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Документ',
        MemoryType.photo => 'Фото',
        MemoryType.screenshot => 'Скриншот',
        MemoryType.note => 'Заметка',
        MemoryType.link => 'Ссылка',
        MemoryType.audio => 'Аудио',
        MemoryType.calendar => 'Календарь',
        MemoryType.email => 'Письмо',
        MemoryType.chat => 'Чат',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Документы',
        MemoryType.photo => 'Фото',
        MemoryType.screenshot => 'Скриншоты',
        MemoryType.note => 'Заметки',
        MemoryType.link => 'Ссылки',
        MemoryType.audio => 'Аудио',
        MemoryType.calendar => 'Календарь',
        MemoryType.email => 'Письма',
        MemoryType.chat => 'Чаты',
      };

  @override
  String get sourcesSection => 'Ваша память';
  @override
  String get recentSearches => 'Недавние запросы';
  @override
  String get recentlySaved => 'Недавно сохранённые';
  @override
  String get suggestedSearches => 'Попробуйте спросить';
  @override
  String get seeAll => 'Смотреть всё';
  @override
  String get memoryStatusTitle => 'Моя память';
  @override
  String memoryStatusItems(int items, int collections) =>
      '${_plural(items, '$items запись', '$items записи', '$items записей')} · '
      '${_plural(collections, '$collections коллекция', '$collections коллекции', '$collections коллекций')}';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'Проиндексировано $ago';
  @override
  String newItemsThisWeek(int count) => _plural(
        count,
        '+$count новая запись на этой неделе',
        '+$count новые записи на этой неделе',
        '+$count новых записей на этой неделе',
      );

  @override
  String get suggestionsHistory => 'Недавние';
  @override
  String get suggestionsSmart => 'Подсказки';

  @override
  String resultsCount(int count, String elapsed) =>
      '${_plural(count, '$count результат', '$count результата', '$count результатов')} '
      '· $elapsed';
  @override
  String get bestMatch => 'Лучшее совпадение';
  @override
  String get smartSummaryTitle => 'Умная сводка';
  @override
  String basedOnItems(int count) => 'На основе ${_plural(
        count,
        '$count сохранённой записи',
        '$count сохранённых записей',
        '$count сохранённых записей',
      )}';
  @override
  String get viewSources => 'Просмотреть источники';
  @override
  String get refineSearch => 'Уточнить поиск';
  @override
  String get saveAnswer => 'Сохранить ответ';
  @override
  String get copied => 'Скопировано';
  @override
  String get sortRecent => 'Сначала новые';
  @override
  String get sortRelevance => 'Лучшее совпадение';

  @override
  String get actionOpen => 'Открыть';
  @override
  String get actionPreview => 'Просмотр';
  @override
  String get actionShare => 'Поделиться';
  @override
  String get actionPin => 'Закрепить';
  @override
  String get actionUnpin => 'Открепить';
  @override
  String get actionAddTag => 'Добавить тег';
  @override
  String get actionSaveToCollection => 'Сохранить в коллекцию';
  @override
  String get actionAskAbout => 'Спросить об этом';
  @override
  String get actionDelete => 'Удалить из памяти';
  @override
  String get actionOpenOriginal => 'Открыть оригинал';
  @override
  String get actionAskJara => 'Спросить у JARA';

  @override
  String get detailRelated => 'Похожие воспоминания';
  @override
  String get detailInCollection => 'Коллекция';
  @override
  String get detailTags => 'Теги';
  @override
  String get detailPeople => 'Люди';
  @override
  String get detailSource => 'Источник';
  @override
  String get detailAskPlaceholder => 'Задайте вопрос об этом воспоминании…';

  @override
  String get addTitle => 'Добавить в JARA';
  @override
  String get addScanDocument => 'Сканировать документ';
  @override
  String get addUploadFile => 'Загрузить файл';
  @override
  String get addPhoto => 'Добавить фото';
  @override
  String get addScreenshot => 'Добавить скриншот';
  @override
  String get addVoiceNote => 'Записать голосовую заметку';
  @override
  String get addPasteText => 'Вставить текст';
  @override
  String get addSaveLink => 'Сохранить ссылку';
  @override
  String get addCreateNote => 'Создать заметку';
  @override
  String get addConnectAccount => 'Подключить аккаунт';
  @override
  String get addImportCalendar => 'Импортировать календарь';
  @override
  String get addSuccessTitle => 'Сохранено в вашей памяти';
  @override
  String get addSuccessSearchNow => 'Найти сейчас';
  @override
  String get addSuggestedTitle => 'Предлагаемое название';
  @override
  String get addSuggestedTags => 'Предлагаемые теги';
  @override
  String get addCollection => 'Коллекция';
  @override
  String get addSaveInstantly => 'Сохранить мгновенно';
  @override
  String get addSave => 'Сохранить';

  @override
  String get memoryTitle => 'Память';
  @override
  String get memoryAll => 'Все воспоминания';
  @override
  String get memoryPinned => 'Закреплённые';
  @override
  String get memoryRecent => 'Недавние';
  @override
  String get memoryTimeline => 'Хронология';
  @override
  String get collectionsTitle => 'Коллекции';
  @override
  String collectionItems(int count) =>
      _plural(count, '$count запись', '$count записи', '$count записей');
  @override
  String updatedAgo(String ago) => 'Обновлено $ago';

  @override
  String get connectionsTitle => 'Подключения';
  @override
  String get connectionsSubtitle =>
      'Выберите, что JARA может индексировать. Вы можете отключиться в любой момент.';
  @override
  String get connectionConnected => 'Подключено';
  @override
  String get connectionSyncing => 'Синхронизация…';
  @override
  String get connectionDisconnected => 'Не подключено';
  @override
  String get connectionAttention => 'Требует внимания';
  @override
  String get connectionConnect => 'Подключить';
  @override
  String get connectionDisconnect => 'Отключить';
  @override
  String get connectionReindex => 'Переиндексировать';
  @override
  String lastSynced(String ago) => 'Синхронизировано $ago';

  @override
  String get privacyTitle => 'Центр конфиденциальности';
  @override
  String get privacyLocalActive => 'Локальная обработка активна';
  @override
  String get privacyCloudOff => 'Облачный интеллект выключен';
  @override
  String get privacyCloudOn => 'Облачный интеллект включён';
  @override
  String get privacyOnDevice => 'Остаётся на этом устройстве';
  @override
  String get privacyOnDeviceBody =>
      'Ваш индекс, превью и история поиска хранятся на вашем устройстве.';
  @override
  String get privacyCloudSection => 'Отправляется в облако';
  @override
  String get privacyCloudBody =>
      'Ничего — если только вы не включите облачный интеллект для более развёрнутых ответов.';
  @override
  String get privacyLocalAi => 'ИИ на устройстве';
  @override
  String get privacyCloudAi => 'Облачный интеллект';
  @override
  String get privacyAppLock => 'Блокировка приложения';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Защита конфиденциального контента';
  @override
  String get privacyExport => 'Экспортировать мои данные';
  @override
  String get privacyClearHistory => 'Очистить историю поиска';
  @override
  String get privacyDeleteAll => 'Удалить все данные';
  @override
  String get privacyDeleteConfirmTitle => 'Удалить всё?';
  @override
  String get privacyDeleteConfirmBody =>
      'Это удалит весь индекс памяти с этого устройства. Оригиналы в ваших приложениях не будут затронуты.';
  @override
  String get privacyDeleted =>
      'Память удалена с этого устройства.';
  @override
  String get cancel => 'Отмена';
  @override
  String get confirmDelete => 'Удалить';

  @override
  String get settingsTitle => 'Профиль';
  @override
  String get settingsTheme => 'Тема';
  @override
  String get settingsThemeDark => 'Тёмная';
  @override
  String get settingsThemeLight => 'Светлая';
  @override
  String get settingsThemeSystem => 'Системная';
  @override
  String get settingsLanguage => 'Язык';
  @override
  String get settingsSearchSources => 'Источники поиска по умолчанию';
  @override
  String get settingsVoice => 'Голосовой поиск';
  @override
  String get settingsStorage => 'Хранилище';
  @override
  String get settingsIndexing => 'Индексирование';
  @override
  String get settingsNotifications => 'Уведомления';
  @override
  String get settingsConnectedAccounts => 'Подключённые аккаунты';
  @override
  String get settingsPrivacySecurity => 'Конфиденциальность и безопасность';
  @override
  String get settingsSubscription => 'Подписка';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Облачный интеллект, неограниченные подключения и приоритетное индексирование.';

  @override
  String get paywallTitle => 'Больше охвата, когда он нужен';
  @override
  String get paywallSubtitle =>
      'Premium добавляет в JARA три вещи. Поиск остаётся ровно таким же.';
  @override
  String get paywallFeatCloudTitle => 'Облачный интеллект';
  @override
  String get paywallFeatCloudBody =>
      'Более развёрнутые ответы, когда вы выбираете облако. Он остаётся '
      'выключенным, пока вы его не включите, — решение всегда за вами.';
  @override
  String get paywallFeatConnectionsTitle => 'Неограниченные подключения';
  @override
  String get paywallFeatConnectionsBody =>
      'На бесплатном тарифе подключено ограниченное число источников. С '
      'Premium подключайте любые аккаунты, которыми пользуетесь.';
  @override
  String get paywallFeatIndexingTitle => 'Приоритетное индексирование';
  @override
  String get paywallFeatIndexingBody =>
      'Новые сохранения становятся доступными для поиска первыми — даже пока '
      'идёт большой импорт.';
  @override
  String get paywallMonthly => 'Ежемесячно';
  @override
  String get paywallYearly => 'Ежегодно';
  @override
  String get paywallYearlyBadge => 'Выгоднее всего';
  @override
  String get paywallPriceNote =>
      'Цена появится при оплате, в валюте вашего региона.';
  @override
  String get paywallCta => 'Начать с Premium';
  @override
  String get paywallRestore => 'Восстановить покупки';
  @override
  String get paywallTerms => 'Условия';
  @override
  String get paywallSearchFree =>
      'Поиск по вашей собственной памяти всегда бесплатный. Premium никогда '
      'не закрывает то, что у вас уже есть.';
  @override
  String get paywallNotWiredNote => 'Покупки появятся в версии из магазина.';

  @override
  String get back => 'Назад';
  @override
  String get moreActions => 'Другие действия';
  @override
  String get done => 'Готово';
  @override
  String get apply => 'Применить';
  @override
  String get continueCta => 'Продолжить';
  @override
  String get searchAction => 'Найти';
  @override
  String get sortBy => 'Сортировка';
  @override
  String get listening => 'Слушаю…';
  @override
  String get alwaysOn => 'Всегда включено';
  @override
  String get clearDateFilter => 'Сбросить фильтр по дате';
  @override
  String get sectionGeneral => 'Общие';
  @override
  String get sectionIntelligence => 'Интеллект';
  @override
  String get sectionData => 'Данные';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Добавлено вами';
  @override
  String get addedJustNow =>
      'Добавлено только что — JARA делает это доступным для поиска.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA нужно ваше разрешение',
        JaraError.fileUnreadable => 'Этот файл не открывается',
        JaraError.indexingFailed => 'Индексирование остановилось раньше времени',
        JaraError.accountDisconnected => 'Аккаунт нужно переподключить',
        JaraError.noConnection => 'Нет подключения к интернету',
        JaraError.localModelNotReady => 'Ещё готовится',
        JaraError.storageFull => 'На устройстве закончилось место',
        JaraError.sourceMissing => 'Оригинал исчез',
        JaraError.generic => 'Требуется повторить попытку',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Разрешите доступ к этому источнику — и он сразу станет доступен для поиска.',
        JaraError.fileUnreadable =>
          'Возможно, файл повреждён или имеет формат, который JARA пока не поддерживает.',
        JaraError.indexingFailed =>
          'Некоторые записи не удалось добавить. Остальная память не затронута.',
        JaraError.accountDisconnected =>
          'Войдите снова, чтобы данные этого аккаунта оставались актуальными.',
        JaraError.noConnection =>
          'Память на вашем устройстве продолжает работать. Облачные функции возобновятся автоматически.',
        JaraError.localModelNotReady =>
          'Поиск на устройстве завершает настройку. При первом запуске это занимает немного времени.',
        JaraError.storageFull =>
          'Освободите немного места — и JARA сможет завершить индексирование.',
        JaraError.sourceMissing =>
          'Эта запись была перемещена или удалена в исходном приложении.',
        JaraError.generic =>
          'Это не удалось выполнить. Ваша память в безопасности — попробуйте ещё раз.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Открыть настройки',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Повторить попытку',
        JaraError.accountDisconnected => 'Переподключить',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Управление хранилищем',
        JaraError.sourceMissing => 'Удалить из памяти',
        JaraError.generic => 'Повторить попытку',
      };

  @override
  String get needsConnection => 'Требуется подключение';

  @override
  String get emptyResultsTitle => 'Пока ничего не найдено';
  @override
  String get emptyResultsBody =>
      'Попробуйте изменить дату, источник или формулировку запроса.';
  @override
  String get emptyResultsAdjust => 'Изменить фильтры';
  @override
  String get emptyResultsSearchAll => 'Искать по всей памяти';
  @override
  String get emptyMemoryTitle => 'Здесь начинается ваша память';
  @override
  String get emptyMemoryBody =>
      'Добавьте файл, скриншот, ссылку или заметку — JARA сделает это доступным для поиска.';
  @override
  String get emptyMemoryCta => 'Добавить первое воспоминание';
  @override
  String get offlineLabel => 'Офлайн-поиск активен';
  @override
  String get offlineBody =>
      'Память на вашем устройстве продолжает работать. Облачные функции возобновятся автоматически.';
  @override
  String get errorGenericTitle => 'Требуется повторить попытку';
  @override
  String get errorGenericBody =>
      'Это не удалось выполнить. Ваша память в безопасности — попробуйте ещё раз.';
  @override
  String get retry => 'Повторить';

  @override
  String get shareTitle => 'Сохранить в JARA';
  @override
  String get shareSaveInstantly => 'Сохранить мгновенно';
  @override
  String get shareReview => 'Проверить детали';
  @override
  String get shareSaved => 'Сохранено в вашей памяти';

  @override
  String get today => 'Сегодня';
  @override
  String get tomorrow => 'Завтра';
  @override
  String get yesterday => 'Вчера';
  @override
  String daysAgo(int days) => _plural(
        days,
        '$days день назад',
        '$days дня назад',
        '$days дней назад',
      );
  @override
  String inDays(int days) => _plural(
        days,
        'через $days день',
        'через $days дня',
        'через $days дней',
      );
  @override
  String minutesAgo(int m) => _plural(
        m,
        '$m минуту назад',
        '$m минуты назад',
        '$m минут назад',
      );
  @override
  String hoursAgo(int h) => _plural(
        h,
        '$h час назад',
        '$h часа назад',
        '$h часов назад',
      );
}
