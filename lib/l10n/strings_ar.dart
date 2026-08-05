import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsAr extends JaraStrings {
  const JaraStringsAr();

  /// Unicode bidi isolates. Wrap a run whose direction or content is
  /// decided at runtime (a user name, a formatted duration) so it can
  /// never reorder against the Arabic around it. Used sparingly — the
  /// fixed Latin brand tokens below resolve correctly on their own.
  static const String _fsi = '\u2068';
  static const String _pdi = '\u2069';

  /// Arabic noun agreement after a numeral: 1 takes the singular, 2 the
  /// dual, 3–10 the plural, 11–99 the accusative singular (tamyīz) and
  /// 100+ the singular again. Mirrors the CLDR `ar` categories
  /// zero/one/two/few/many/other so counts read correctly at every size.
  static String _plural(
    int n, {
    required String zero,
    required String one,
    required String two,
    required String few,
    required String many,
    required String other,
  }) {
    if (n == 0) return zero;
    if (n == 1) return one;
    if (n == 2) return two;
    final rem = n % 100;
    if (rem >= 3 && rem <= 10) return few;
    if (rem >= 11 && rem <= 99) return many;
    return other;
  }

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'كل ما يهمك. بحث واحد.';

  @override
  String get onb1Title => 'كل ما يهمك.\nبحث واحد.';
  @override
  String get onb1Body =>
      'اعثر على ملفاتك وصورك وملاحظاتك وروابطك في ذاكرة شخصية واحدة.';
  @override
  String get onb2Title => 'خصوصية من الأساس';
  @override
  String get onb2Body =>
      'تُعالَج محتوياتك على جهازك كلما أمكن — والتحكم يبقى لك دائمًا.';
  @override
  String get onb3Title => 'احفظ مرة.\nاعثر عليه في أي وقت.';
  @override
  String get onb3Body =>
      'شارك من أي تطبيق إلى JARA، ثم اعثر عليه لاحقًا بكلماتك أنت.';
  @override
  String get onbPrimaryCta => 'إنشاء ذاكرتي';
  @override
  String get onbSecondaryCta => 'استكشاف العرض التجريبي';
  @override
  String get onbSkip => 'تخطي';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'صباح الخير' : 'صباح الخير، $_fsi$name$_pdi';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'طاب يومك' : 'طاب يومك، $_fsi$name$_pdi';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'مساء الخير' : 'مساء الخير، $_fsi$name$_pdi';
  @override
  String get searchTitle => 'اعثر على كل ما\nحفظته.';
  @override
  List<String> get searchHints => const [
        'ابحث عن المستند الخاص برحلتي إلى لندن',
        'اعرض لقطات الشاشة التي فيها تفاصيل الدفع',
        'ماذا حفظت عن أسعار VoxBridge؟',
        'ابحث عن موعد الطبيب',
        'اعرض الصور التي فيها جواز سفر',
      ];
  @override
  String get filterAll => 'الكل';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'مستند',
        MemoryType.photo => 'صورة',
        MemoryType.screenshot => 'لقطة شاشة',
        MemoryType.note => 'ملاحظة',
        MemoryType.link => 'رابط',
        MemoryType.audio => 'صوت',
        MemoryType.calendar => 'تقويم',
        MemoryType.email => 'بريد إلكتروني',
        MemoryType.chat => 'محادثة',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'مستندات',
        MemoryType.photo => 'صور',
        MemoryType.screenshot => 'لقطات شاشة',
        MemoryType.note => 'ملاحظات',
        MemoryType.link => 'روابط',
        MemoryType.audio => 'مقاطع صوتية',
        MemoryType.calendar => 'تقويم',
        MemoryType.email => 'رسائل بريدية',
        MemoryType.chat => 'محادثات',
      };

  @override
  String get sourcesSection => 'ذاكرتك';
  @override
  String get recentSearches => 'عمليات البحث الأخيرة';
  @override
  String get recentlySaved => 'المحفوظ حديثًا';
  @override
  String get suggestedSearches => 'جرّب أن تسأل';
  @override
  String get seeAll => 'عرض الكل';
  @override
  String get memoryStatusTitle => 'ذاكرتي';
  @override
  String memoryStatusItems(int items, int collections) {
    final i = _plural(
      items,
      zero: 'لا عناصر',
      one: 'عنصر واحد',
      two: 'عنصران',
      few: '$items عناصر',
      many: '$items عنصرًا',
      other: '$items عنصر',
    );
    final c = _plural(
      collections,
      zero: 'لا مجموعات',
      one: 'مجموعة واحدة',
      two: 'مجموعتان',
      few: '$collections مجموعات',
      many: '$collections مجموعةً',
      other: '$collections مجموعة',
    );
    return '$i · $c';
  }

  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'تمت الفهرسة $_fsi$ago$_pdi';
  @override
  String newItemsThisWeek(int count) => _plural(
        count,
        zero: 'لا جديد هذا الأسبوع',
        one: 'عنصر واحد هذا الأسبوع',
        two: 'عنصران هذا الأسبوع',
        few: '$_fsi+$count$_pdi عناصر هذا الأسبوع',
        many: '$_fsi+$count$_pdi عنصرًا هذا الأسبوع',
        other: '$_fsi+$count$_pdi عنصر هذا الأسبوع',
      );

  @override
  String get suggestionsHistory => 'الأخيرة';
  @override
  String get suggestionsSmart => 'اقتراحات';

  @override
  String resultsCount(int count, String elapsed) {
    final n = _plural(
      count,
      zero: 'لا نتائج',
      one: 'نتيجة واحدة',
      two: 'نتيجتان',
      few: '$count نتائج',
      many: '$count نتيجةً',
      other: '$count نتيجة',
    );
    return '$n · $_fsi$elapsed$_pdi';
  }

  @override
  String get bestMatch => 'أفضل تطابق';
  @override
  String get smartSummaryTitle => 'ملخص ذكي';
  @override
  String basedOnItems(int count) => _plural(
        count,
        zero: 'استنادًا إلى عناصرك المحفوظة',
        one: 'استنادًا إلى عنصر واحد محفوظ',
        two: 'استنادًا إلى عنصرين محفوظين',
        few: 'استنادًا إلى $count عناصر محفوظة',
        many: 'استنادًا إلى $count عنصرًا محفوظًا',
        other: 'استنادًا إلى $count عنصر محفوظ',
      );
  @override
  String get viewSources => 'عرض المصادر';
  @override
  String get refineSearch => 'تحسين البحث';
  @override
  String get saveAnswer => 'حفظ الإجابة';
  @override
  String get copied => 'تم النسخ';
  @override
  String get sortRecent => 'الأحدث';
  @override
  String get sortRelevance => 'أفضل تطابق';

  @override
  String get actionOpen => 'فتح';
  @override
  String get actionPreview => 'معاينة';
  @override
  String get actionShare => 'مشاركة';
  @override
  String get actionPin => 'تثبيت';
  @override
  String get actionUnpin => 'إلغاء التثبيت';
  @override
  String get actionAddTag => 'إضافة وسم';
  @override
  String get actionSaveToCollection => 'الحفظ في مجموعة';
  @override
  String get actionAskAbout => 'اسأل عن هذا';
  @override
  String get actionDelete => 'حذف من الذاكرة';
  @override
  String get actionOpenOriginal => 'فتح الأصل';
  @override
  String get actionAskJara => 'اسأل JARA';

  @override
  String get detailRelated => 'عناصر ذات صلة';
  @override
  String get detailInCollection => 'المجموعة';
  @override
  String get detailTags => 'الوسوم';
  @override
  String get detailPeople => 'الأشخاص';
  @override
  String get detailSource => 'المصدر';
  @override
  String get detailAskPlaceholder => 'اسأل عن هذا العنصر…';

  @override
  String get addTitle => 'إضافة إلى JARA';
  @override
  String get addScanDocument => 'مسح مستند ضوئيًا';
  @override
  String get addUploadFile => 'رفع ملف';
  @override
  String get addPhoto => 'إضافة صورة';
  @override
  String get addScreenshot => 'إضافة لقطة شاشة';
  @override
  String get addVoiceNote => 'تسجيل ملاحظة صوتية';
  @override
  String get addPasteText => 'لصق نص';
  @override
  String get addSaveLink => 'حفظ رابط';
  @override
  String get addCreateNote => 'إنشاء ملاحظة';
  @override
  String get addConnectAccount => 'ربط حساب';
  @override
  String get addImportCalendar => 'استيراد التقويم';
  @override
  String get addSuccessTitle => 'تم الحفظ في ذاكرتك';
  @override
  String get addSuccessSearchNow => 'ابحث عنه الآن';
  @override
  String get addSuggestedTitle => 'عنوان مقترح';
  @override
  String get addSuggestedTags => 'وسوم مقترحة';
  @override
  String get addCollection => 'المجموعة';
  @override
  String get addSaveInstantly => 'حفظ فوري';
  @override
  String get addSave => 'حفظ';

  @override
  String get memoryTitle => 'الذاكرة';
  @override
  String get memoryAll => 'كل العناصر';
  @override
  String get memoryPinned => 'المثبّتة';
  @override
  String get memoryRecent => 'الأخيرة';
  @override
  String get memoryTimeline => 'المخطط الزمني';
  @override
  String get collectionsTitle => 'المجموعات';
  @override
  String collectionItems(int count) => _plural(
        count,
        zero: 'لا عناصر',
        one: 'عنصر واحد',
        two: 'عنصران',
        few: '$count عناصر',
        many: '$count عنصرًا',
        other: '$count عنصر',
      );
  @override
  String updatedAgo(String ago) => 'آخر تحديث $_fsi$ago$_pdi';

  @override
  String get connectionsTitle => 'الاتصالات';
  @override
  String get connectionsSubtitle =>
      'اختر ما يمكن أن يفهرسه JARA. يمكنك قطع الاتصال في أي وقت.';
  @override
  String get connectionConnected => 'متصل';
  @override
  String get connectionSyncing => 'جارٍ المزامنة…';
  @override
  String get connectionDisconnected => 'غير متصل';
  @override
  String get connectionAttention => 'يحتاج إلى مراجعة';
  @override
  String get connectionConnect => 'ربط';
  @override
  String get connectionDisconnect => 'قطع الاتصال';
  @override
  String get connectionReindex => 'إعادة الفهرسة';
  @override
  String lastSynced(String ago) => 'تمت المزامنة $_fsi$ago$_pdi';

  @override
  String get privacyTitle => 'مركز الخصوصية';
  @override
  String get privacyLocalActive => 'المعالجة المحلية نشطة';
  @override
  String get privacyCloudOff => 'ذكاء السحابة معطّل';
  @override
  String get privacyCloudOn => 'ذكاء السحابة مفعّل';
  @override
  String get privacyOnDevice => 'يبقى على هذا الجهاز';
  @override
  String get privacyOnDeviceBody =>
      'يُخزَّن فهرسك ومعايناتك وسجل بحثك على جهازك.';
  @override
  String get privacyCloudSection => 'ما يُرسل إلى السحابة';
  @override
  String get privacyCloudBody =>
      'لا شيء، إلا إذا فعّلت ذكاء السحابة للحصول على إجابات أوفى.';
  @override
  String get privacyLocalAi => 'ذكاء اصطناعي على الجهاز';
  @override
  String get privacyCloudAi => 'ذكاء السحابة';
  @override
  String get privacyAppLock => 'قفل التطبيق';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'حماية المحتوى الحساس';
  @override
  String get privacyExport => 'تصدير بياناتي';
  @override
  String get privacyClearHistory => 'مسح سجل البحث';
  @override
  String get privacyDeleteAll => 'حذف كل البيانات';
  @override
  String get privacyDeleteConfirmTitle => 'حذف كل شيء؟';
  @override
  String get privacyDeleteConfirmBody =>
      'سيؤدي هذا إلى إزالة فهرس ذاكرتك بالكامل من هذا الجهاز. أما النسخ الأصلية في تطبيقاتك فلن تتأثر.';
  @override
  String get privacyDeleted =>
      'حُذفت الذاكرة من هذا الجهاز.';
  @override
  String get cancel => 'إلغاء';
  @override
  String get confirmDelete => 'حذف';

  @override
  String get settingsTitle => 'الملف الشخصي';
  @override
  String get settingsTheme => 'المظهر';
  @override
  String get settingsThemeDark => 'داكن';
  @override
  String get settingsThemeLight => 'فاتح';
  @override
  String get settingsThemeSystem => 'النظام';
  @override
  String get settingsLanguage => 'اللغة';
  @override
  String get settingsSearchSources => 'مصادر البحث الافتراضية';
  @override
  String get settingsVoice => 'البحث الصوتي';
  @override
  String get settingsStorage => 'التخزين';
  @override
  String get settingsIndexing => 'الفهرسة';
  @override
  String get settingsNotifications => 'الإشعارات';
  @override
  String get settingsConnectedAccounts => 'الحسابات المرتبطة';
  @override
  String get settingsPrivacySecurity => 'الخصوصية والأمان';
  @override
  String get settingsSubscription => 'الاشتراك';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'ذكاء السحابة واتصالات غير محدودة وفهرسة ذات أولوية.';

  @override
  String get paywallTitle => 'وصول أوسع، عندما تحتاج إليه';
  @override
  String get paywallSubtitle =>
      'يضيف Premium ثلاثة أشياء إلى JARA. أما البحث فيبقى كما هو تمامًا.';
  @override
  String get paywallFeatCloudTitle => 'ذكاء السحابة';
  @override
  String get paywallFeatCloudBody =>
      'إجابات أغنى عندما تختار السحابة. يبقى معطّلًا حتى تشغّله بنفسك، والقرار يبقى لك دائمًا.';
  @override
  String get paywallFeatConnectionsTitle => 'اتصالات غير محدودة';
  @override
  String get paywallFeatConnectionsBody =>
      'تُبقي الخطة المجانية عددًا محدودًا من المصادر متصلة. أما Premium فيربط كل حساب تستخدمه.';
  @override
  String get paywallFeatIndexingTitle => 'فهرسة ذات أولوية';
  @override
  String get paywallFeatIndexingBody =>
      'تصبح العناصر الجديدة قابلة للبحث أولًا، حتى أثناء استيراد كبير.';
  @override
  String get paywallMonthly => 'شهريًا';
  @override
  String get paywallYearly => 'سنويًا';
  @override
  String get paywallYearlyBadge => 'أفضل قيمة';
  @override
  String get paywallPriceNote => 'يظهر السعر عند الدفع، بعملة منطقتك.';
  @override
  String get paywallCta => 'ابدأ مع Premium';
  @override
  String get paywallRestore => 'استعادة المشتريات';
  @override
  String get paywallTerms => 'الشروط';
  @override
  String get paywallSearchFree =>
      'البحث في ذاكرتك الخاصة مجاني دائمًا. لا يقفل Premium أبدًا ما لديك بالفعل.';
  @override
  String get paywallNotWiredNote => 'ستصل المشتريات مع نسخة المتجر.';

  @override
  String get back => 'رجوع';
  @override
  String get moreActions => 'إجراءات أخرى';
  @override
  String get done => 'تم';
  @override
  String get apply => 'تطبيق';
  @override
  String get continueCta => 'متابعة';
  @override
  String get searchAction => 'بحث';
  @override
  String get sortBy => 'ترتيب حسب';
  @override
  String get listening => 'جارٍ الاستماع…';
  @override
  String get alwaysOn => 'مفعّل دائمًا';
  @override
  String get clearDateFilter => 'مسح فلتر التاريخ';
  @override
  String get sectionGeneral => 'عام';
  @override
  String get sectionIntelligence => 'الذكاء';
  @override
  String get sectionData => 'البيانات';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'أضفته أنت';
  @override
  String get addedJustNow =>
      'أُضيف للتو — يعمل JARA على جعله قابلًا للبحث.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'يحتاج JARA إلى إذنك',
        JaraError.fileUnreadable => 'هذا الملف لا يُفتح',
        JaraError.indexingFailed => 'توقفت الفهرسة قبل أن تكتمل',
        JaraError.accountDisconnected => 'الحساب بحاجة إلى إعادة ربط',
        JaraError.noConnection => 'أنت دون اتصال',
        JaraError.localModelNotReady => 'التجهيز ما زال جاريًا',
        JaraError.storageFull => 'لا مساحة متبقية على هذا الجهاز',
        JaraError.sourceMissing => 'الملف الأصلي لم يعد موجودًا',
        JaraError.generic => 'الأمر يحتاج إلى محاولة أخرى',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'اسمح بالوصول إلى هذا المصدر ليصبح قابلًا للبحث على الفور.',
        JaraError.fileUnreadable =>
          'قد يكون الملف تالفًا أو بصيغة لا يستطيع JARA قراءتها بعد.',
        JaraError.indexingFailed =>
          'لم تُضَف بعض العناصر. أما ذاكرتك الحالية فلم تتغير.',
        JaraError.accountDisconnected =>
          'سجّل الدخول مجددًا لتبقى عناصر هذا الحساب محدّثة.',
        JaraError.noConnection =>
          'تواصل الذاكرة الموجودة على جهازك عملها، وستعود ميزات السحابة تلقائيًا.',
        JaraError.localModelNotReady =>
          'البحث على الجهاز يكمل تجهيزه. يستغرق ذلك لحظة في أول تشغيل.',
        JaraError.storageFull =>
          'وفّر بعض المساحة ليتمكن JARA من إكمال الفهرسة.',
        JaraError.sourceMissing =>
          'نُقل هذا العنصر أو حُذف من تطبيقه الأصلي.',
        JaraError.generic =>
          'لم تكتمل العملية. ذاكرتك بأمان — حاول مرة أخرى.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'فتح الإعدادات',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'إعادة المحاولة',
        JaraError.accountDisconnected => 'إعادة الربط',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'إدارة التخزين',
        JaraError.sourceMissing => 'إزالة من الذاكرة',
        JaraError.generic => 'إعادة المحاولة',
      };

  @override
  String get needsConnection => 'يتطلب اتصالًا';

  @override
  String get emptyResultsTitle => 'لا نتائج مطابقة بعد';
  @override
  String get emptyResultsBody =>
      'جرّب تغيير التاريخ أو المصدر أو الصياغة.';
  @override
  String get emptyResultsAdjust => 'تعديل الفلاتر';
  @override
  String get emptyResultsSearchAll => 'البحث في كل الذاكرة';
  @override
  String get emptyMemoryTitle => 'ذاكرتك تبدأ من هنا';
  @override
  String get emptyMemoryBody =>
      'أضف ملفًا أو لقطة شاشة أو رابطًا أو ملاحظة، وسيجعلها JARA قابلة للبحث.';
  @override
  String get emptyMemoryCta => 'إضافة أول عنصر';
  @override
  String get offlineLabel => 'البحث دون اتصال نشط';
  @override
  String get offlineBody =>
      'تواصل الذاكرة الموجودة على جهازك عملها، وستعود ميزات السحابة تلقائيًا.';
  @override
  String get errorGenericTitle => 'الأمر يحتاج إلى محاولة أخرى';
  @override
  String get errorGenericBody =>
      'لم تكتمل العملية. ذاكرتك بأمان — حاول مرة أخرى.';
  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get shareTitle => 'الحفظ في JARA';
  @override
  String get shareSaveInstantly => 'حفظ فوري';
  @override
  String get shareReview => 'مراجعة التفاصيل';
  @override
  String get shareSaved => 'تم الحفظ في ذاكرتك';

  @override
  String get today => 'اليوم';
  @override
  String get tomorrow => 'غدًا';
  @override
  String get yesterday => 'أمس';
  @override
  String daysAgo(int days) => _plural(
        days,
        zero: 'اليوم',
        one: 'قبل يوم',
        two: 'قبل يومين',
        few: 'قبل $days أيام',
        many: 'قبل $days يومًا',
        other: 'قبل $days يوم',
      );
  @override
  String inDays(int days) => _plural(
        days,
        zero: 'اليوم',
        one: 'بعد يوم',
        two: 'بعد يومين',
        few: 'بعد $days أيام',
        many: 'بعد $days يومًا',
        other: 'بعد $days يوم',
      );
  @override
  String minutesAgo(int m) => _plural(
        m,
        zero: 'الآن',
        one: 'قبل دقيقة',
        two: 'قبل دقيقتين',
        few: 'قبل $m دقائق',
        many: 'قبل $m دقيقةً',
        other: 'قبل $m دقيقة',
      );
  @override
  String hoursAgo(int h) => _plural(
        h,
        zero: 'الآن',
        one: 'قبل ساعة',
        two: 'قبل ساعتين',
        few: 'قبل $h ساعات',
        many: 'قبل $h ساعةً',
        other: 'قبل $h ساعة',
      );
}
