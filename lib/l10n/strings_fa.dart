import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsFa extends JaraStrings {
  const JaraStringsFa();

  /// Unicode bidi isolates. Wrap a run whose direction or content is
  /// decided at runtime (a user name, a formatted duration, a relative
  /// date that may arrive as `5.8.2026`) so it cannot reorder against
  /// the Persian around it. The fixed Latin brand tokens below sit
  /// between two Persian runs and resolve correctly unaided.
  static const String _fsi = '⁨';
  static const String _pdi = '⁩';

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'هر چیز مهمی. یک جست‌وجو.';

  @override
  String get onb1Title => 'هر چیز مهمی.\nیک جست‌وجو.';
  @override
  String get onb1Body =>
      'فایل‌ها، عکس‌ها، یادداشت‌ها و لینک‌هایتان را در یک حافظهٔ شخصی پیدا کنید.';
  @override
  String get onb2Title => 'حریم خصوصی از پایه';
  @override
  String get onb2Body =>
      'محتوای شما تا جای ممکن روی همین دستگاه پردازش می‌شود — کنترل همیشه دست خودتان است.';
  @override
  String get onb3Title => 'یک‌بار ذخیره کنید.\nهر وقت خواستید پیدا کنید.';
  @override
  String get onb3Body =>
      'از هر برنامه‌ای در JARA به اشتراک بگذارید و بعداً با کلمات خودتان پیدایش کنید.';
  @override
  String get onbPrimaryCta => 'ساخت حافظهٔ من';
  @override
  String get onbSecondaryCta => 'دیدن نسخهٔ نمایشی';
  @override
  String get onbSkip => 'رد کردن';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'صبح بخیر' : 'صبح بخیر، $_fsi$name$_pdi';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'روز بخیر' : 'روز بخیر، $_fsi$name$_pdi';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'عصر بخیر' : 'عصر بخیر، $_fsi$name$_pdi';
  @override
  String get searchTitle => 'هر چیزی را که ذخیره کرده‌اید\nپیدا کنید.';
  @override
  List<String> get searchHints => const [
        'سند مربوط به سفر لندن را پیدا کن',
        'اسکرین‌شات‌های حاوی جزئیات پرداخت را نشان بده',
        'دربارهٔ قیمت VoxBridge چه چیزی ذخیره کرده بودم؟',
        'نوبت دکترم را پیدا کن',
        'عکس‌هایی که پاسپورت دارند را نشان بده',
      ];
  @override
  String get filterAll => 'همه';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'سند',
        MemoryType.photo => 'عکس',
        MemoryType.screenshot => 'اسکرین‌شات',
        MemoryType.note => 'یادداشت',
        MemoryType.link => 'لینک',
        MemoryType.audio => 'صدا',
        MemoryType.calendar => 'تقویم',
        MemoryType.email => 'ایمیل',
        MemoryType.chat => 'گفتگو',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'اسناد',
        MemoryType.photo => 'عکس‌ها',
        MemoryType.screenshot => 'اسکرین‌شات‌ها',
        MemoryType.note => 'یادداشت‌ها',
        MemoryType.link => 'لینک‌ها',
        MemoryType.audio => 'صداها',
        MemoryType.calendar => 'تقویم',
        MemoryType.email => 'ایمیل‌ها',
        MemoryType.chat => 'گفتگوها',
      };

  @override
  String get sourcesSection => 'حافظهٔ شما';
  @override
  String get recentSearches => 'جست‌وجوهای اخیر';
  @override
  String get recentlySaved => 'ذخیره‌شده‌های اخیر';
  @override
  String get suggestedSearches => 'این‌ها را بپرسید';
  @override
  String get seeAll => 'دیدن همه';
  @override
  String get memoryStatusTitle => 'حافظهٔ من';
  @override
  String memoryStatusItems(int items, int collections) =>
      '$items مورد · $collections مجموعه';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => '$_fsi$ago$_pdi نمایه‌سازی شد';
  @override
  String newItemsThisWeek(int count) => '$_fsi+$count$_pdi مورد این هفته';

  @override
  String get suggestionsHistory => 'اخیر';
  @override
  String get suggestionsSmart => 'پیشنهادها';

  @override
  String resultsCount(int count, String elapsed) => count == 0
      ? 'بدون نتیجه · $_fsi$elapsed$_pdi'
      : '$count نتیجه · $_fsi$elapsed$_pdi';
  @override
  String get bestMatch => 'بهترین تطابق';
  @override
  String get smartSummaryTitle => 'خلاصهٔ هوشمند';
  @override
  String basedOnItems(int count) => count == 1
      ? 'بر پایهٔ یک مورد ذخیره‌شده'
      : 'بر پایهٔ $count مورد ذخیره‌شده';
  @override
  String get viewSources => 'دیدن منابع';
  @override
  String get refineSearch => 'دقیق‌تر کردن جست‌وجو';
  @override
  String get saveAnswer => 'ذخیرهٔ پاسخ';
  @override
  String get copied => 'کپی شد';
  @override
  String get sortRecent => 'جدیدترین';
  @override
  String get sortRelevance => 'بهترین تطابق';

  @override
  String get actionOpen => 'باز کردن';
  @override
  String get actionPreview => 'پیش‌نمایش';
  @override
  String get actionShare => 'اشتراک‌گذاری';
  @override
  String get actionPin => 'سنجاق کردن';
  @override
  String get actionUnpin => 'برداشتن سنجاق';
  @override
  String get actionAddTag => 'افزودن برچسب';
  @override
  String get actionSaveToCollection => 'ذخیره در مجموعه';
  @override
  String get actionAskAbout => 'پرسیدن دربارهٔ این';
  @override
  String get actionDelete => 'حذف از حافظه';
  @override
  String get actionOpenOriginal => 'باز کردن نسخهٔ اصلی';
  @override
  String get actionAskJara => 'پرسیدن از JARA';

  @override
  String get detailRelated => 'موارد مرتبط';
  @override
  String get detailInCollection => 'مجموعه';
  @override
  String get detailTags => 'برچسب‌ها';
  @override
  String get detailPeople => 'افراد';
  @override
  String get detailSource => 'منبع';
  @override
  String get detailAskPlaceholder => 'دربارهٔ این مورد بپرسید…';

  @override
  String get addTitle => 'افزودن به JARA';
  @override
  String get addScanDocument => 'اسکن سند';
  @override
  String get addUploadFile => 'بارگذاری فایل';
  @override
  String get addPhoto => 'افزودن عکس';
  @override
  String get addScreenshot => 'افزودن اسکرین‌شات';
  @override
  String get addVoiceNote => 'ضبط یادداشت صوتی';
  @override
  String get addPasteText => 'چسباندن متن';
  @override
  String get addSaveLink => 'ذخیرهٔ لینک';
  @override
  String get addCreateNote => 'ساخت یادداشت';
  @override
  String get addConnectAccount => 'اتصال حساب';
  @override
  String get addImportCalendar => 'وارد کردن تقویم';
  @override
  String get addSuccessTitle => 'در حافظه‌تان ذخیره شد';
  @override
  String get addSuccessSearchNow => 'همین حالا جست‌وجو کنید';
  @override
  String get addSuggestedTitle => 'عنوان پیشنهادی';
  @override
  String get addSuggestedTags => 'برچسب‌های پیشنهادی';
  @override
  String get addCollection => 'مجموعه';
  @override
  String get addSaveInstantly => 'ذخیرهٔ فوری';
  @override
  String get addSave => 'ذخیره';

  @override
  String get memoryTitle => 'حافظه';
  @override
  String get memoryAll => 'همهٔ موارد';
  @override
  String get memoryPinned => 'سنجاق‌شده‌ها';
  @override
  String get memoryRecent => 'اخیر';
  @override
  String get memoryTimeline => 'خط زمانی';
  @override
  String get collectionsTitle => 'مجموعه‌ها';
  @override
  String collectionItems(int count) => switch (count) {
        0 => 'بدون مورد',
        1 => 'یک مورد',
        _ => '$count مورد',
      };
  @override
  String updatedAgo(String ago) => '$_fsi$ago$_pdi به‌روز شد';

  @override
  String get connectionsTitle => 'اتصال‌ها';
  @override
  String get connectionsSubtitle =>
      'انتخاب کنید JARA چه چیزی را نمایه‌سازی کند. هر وقت خواستید می‌توانید قطع کنید.';
  @override
  String get connectionConnected => 'متصل';
  @override
  String get connectionSyncing => 'در حال همگام‌سازی…';
  @override
  String get connectionDisconnected => 'متصل نیست';
  @override
  String get connectionAttention => 'نیاز به بررسی';
  @override
  String get connectionConnect => 'اتصال';
  @override
  String get connectionDisconnect => 'قطع اتصال';
  @override
  String get connectionReindex => 'نمایه‌سازی دوباره';
  @override
  String lastSynced(String ago) => '$_fsi$ago$_pdi همگام شد';

  @override
  String get privacyTitle => 'مرکز حریم خصوصی';
  @override
  String get privacyLocalActive => 'پردازش روی دستگاه فعال است';
  @override
  String get privacyCloudOff => 'هوش ابری خاموش';
  @override
  String get privacyCloudOn => 'هوش ابری روشن';
  @override
  String get privacyOnDevice => 'روی همین دستگاه می‌ماند';
  @override
  String get privacyOnDeviceBody =>
      'نمایه، پیش‌نمایش‌ها و تاریخچهٔ جست‌وجوی شما روی دستگاهتان ذخیره می‌شود.';
  @override
  String get privacyCloudSection => 'آنچه به ابر می‌رود';
  @override
  String get privacyCloudBody =>
      'هیچ‌چیز، مگر آنکه هوش ابری را برای پاسخ‌های کامل‌تر روشن کنید.';
  @override
  String get privacyLocalAi => 'هوش مصنوعی روی دستگاه';
  @override
  String get privacyCloudAi => 'هوش ابری';
  @override
  String get privacyAppLock => 'قفل برنامه';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'محافظت از محتوای حساس';
  @override
  String get privacyExport => 'خروجی گرفتن از داده‌هایم';
  @override
  String get privacyClearHistory => 'پاک کردن تاریخچهٔ جست‌وجو';
  @override
  String get privacyDeleteAll => 'حذف همهٔ داده‌ها';
  @override
  String get privacyDeleteConfirmTitle => 'همه‌چیز حذف شود؟';
  @override
  String get privacyDeleteConfirmBody =>
      'این کار کل نمایهٔ حافظهٔ شما را از این دستگاه پاک می‌کند. نسخه‌های اصلی در برنامه‌هایتان دست‌نخورده می‌مانند.';
  @override
  String get cancel => 'انصراف';
  @override
  String get confirmDelete => 'حذف';

  @override
  String get settingsTitle => 'پروفایل';
  @override
  String get settingsTheme => 'تم';
  @override
  String get settingsThemeDark => 'تیره';
  @override
  String get settingsThemeLight => 'روشن';
  @override
  String get settingsThemeSystem => 'سیستم';
  @override
  String get settingsLanguage => 'زبان';
  @override
  String get settingsSearchSources => 'منابع پیش‌فرض جست‌وجو';
  @override
  String get settingsVoice => 'جست‌وجوی صوتی';
  @override
  String get settingsStorage => 'فضای ذخیره‌سازی';
  @override
  String get settingsIndexing => 'نمایه‌سازی';
  @override
  String get settingsNotifications => 'اعلان‌ها';
  @override
  String get settingsConnectedAccounts => 'حساب‌های متصل';
  @override
  String get settingsPrivacySecurity => 'حریم خصوصی و امنیت';
  @override
  String get settingsSubscription => 'اشتراک';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'هوش ابری، اتصال‌های نامحدود و نمایه‌سازی با اولویت.';

  @override
  String get back => 'بازگشت';
  @override
  String get moreActions => 'کارهای بیشتر';
  @override
  String get done => 'انجام شد';
  @override
  String get apply => 'اعمال';
  @override
  String get continueCta => 'ادامه';
  @override
  String get searchAction => 'جست‌وجو';
  @override
  String get sortBy => 'مرتب‌سازی بر اساس';
  @override
  String get listening => 'در حال شنیدن…';
  @override
  String get alwaysOn => 'همیشه روشن';
  @override
  String get clearDateFilter => 'حذف فیلتر تاریخ';
  @override
  String get sectionGeneral => 'عمومی';
  @override
  String get sectionIntelligence => 'هوشمندی';
  @override
  String get sectionData => 'داده';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'افزودهٔ شما';
  @override
  String get addedJustNow =>
      'همین حالا افزوده شد — JARA دارد آن را قابل جست‌وجو می‌کند.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA به اجازهٔ شما نیاز دارد',
        JaraError.fileUnreadable => 'این فایل باز نمی‌شود',
        JaraError.indexingFailed => 'نمایه‌سازی نیمه‌کاره ماند',
        JaraError.accountDisconnected => 'حساب باید دوباره وصل شود',
        JaraError.noConnection => 'آفلاین هستید',
        JaraError.localModelNotReady => 'هنوز در حال آماده‌سازی',
        JaraError.storageFull => 'جایی روی این دستگاه نمانده',
        JaraError.sourceMissing => 'نسخهٔ اصلی دیگر نیست',
        JaraError.generic => 'باید دوباره تلاش کنید',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'به این منبع دسترسی بدهید تا بی‌درنگ قابل جست‌وجو شود.',
        JaraError.fileUnreadable =>
          'شاید فایل آسیب دیده یا قالبی دارد که JARA هنوز نمی‌تواند بخواند.',
        JaraError.indexingFailed =>
          'بعضی موارد افزوده نشدند. حافظهٔ فعلی شما دست‌نخورده است.',
        JaraError.accountDisconnected =>
          'دوباره وارد شوید تا موارد این حساب به‌روز بماند.',
        JaraError.noConnection =>
          'حافظهٔ روی دستگاهتان کار می‌کند. قابلیت‌های ابری خودکار برمی‌گردند.',
        JaraError.localModelNotReady =>
          'جست‌وجوی روی دستگاه دارد آماده‌سازی را تمام می‌کند. بار اول کمی طول می‌کشد.',
        JaraError.storageFull =>
          'کمی فضا خالی کنید تا JARA نمایه‌سازی را تمام کند.',
        JaraError.sourceMissing =>
          'این مورد در برنامهٔ اصلی‌اش جابه‌جا یا حذف شده است.',
        JaraError.generic =>
          'انجام نشد. حافظهٔ شما امن است — دوباره تلاش کنید.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'باز کردن تنظیمات',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'تلاش دوباره',
        JaraError.accountDisconnected => 'اتصال دوباره',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'مدیریت فضا',
        JaraError.sourceMissing => 'حذف از حافظه',
        JaraError.generic => 'تلاش دوباره',
      };

  @override
  String get needsConnection => 'نیازمند اتصال';

  @override
  String get emptyResultsTitle => 'هنوز چیزی پیدا نشد';
  @override
  String get emptyResultsBody =>
      'تاریخ، منبع یا عبارت را عوض کنید.';
  @override
  String get emptyResultsAdjust => 'تنظیم فیلترها';
  @override
  String get emptyResultsSearchAll => 'جست‌وجو در کل حافظه';
  @override
  String get emptyMemoryTitle => 'حافظهٔ شما از اینجا شروع می‌شود';
  @override
  String get emptyMemoryBody =>
      'یک فایل، اسکرین‌شات، لینک یا یادداشت اضافه کنید. JARA آن را قابل جست‌وجو می‌کند.';
  @override
  String get emptyMemoryCta => 'افزودن اولین مورد';
  @override
  String get offlineLabel => 'جست‌وجوی آفلاین فعال است';
  @override
  String get offlineBody =>
      'حافظهٔ روی دستگاهتان کار می‌کند. قابلیت‌های ابری خودکار برمی‌گردند.';
  @override
  String get errorGenericTitle => 'باید دوباره تلاش کنید';
  @override
  String get errorGenericBody =>
      'انجام نشد. حافظهٔ شما امن است — دوباره تلاش کنید.';
  @override
  String get retry => 'تلاش دوباره';

  @override
  String get shareTitle => 'ذخیره در JARA';
  @override
  String get shareSaveInstantly => 'ذخیرهٔ فوری';
  @override
  String get shareReview => 'بررسی جزئیات';
  @override
  String get shareSaved => 'در حافظه‌تان ذخیره شد';

  @override
  String get today => 'امروز';
  @override
  String get tomorrow => 'فردا';
  @override
  String get yesterday => 'دیروز';
  @override
  String daysAgo(int days) =>
      days == 1 ? 'یک روز پیش' : '$days روز پیش';
  @override
  String inDays(int days) =>
      days == 1 ? 'یک روز دیگر' : '$days روز دیگر';
  @override
  String minutesAgo(int m) => m == 1 ? 'یک دقیقه پیش' : '$m دقیقه پیش';
  @override
  String hoursAgo(int h) => h == 1 ? 'یک ساعت پیش' : '$h ساعت پیش';
}
