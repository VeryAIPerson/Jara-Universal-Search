import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsHi extends JaraStrings {
  const JaraStringsHi();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'हर ज़रूरी चीज़. एक खोज.';

  @override
  String get onb1Title => 'हर ज़रूरी चीज़.\nएक खोज.';
  @override
  String get onb1Body =>
      'अपनी फ़ाइलें, फ़ोटो, नोट और लिंक एक ही निजी मेमोरी में ढूँढें।';
  @override
  String get onb2Title => 'निजता, शुरुआत से ही';
  @override
  String get onb2Body =>
      'आपका कॉन्टेंट जहाँ तक हो सके आपके अपने डिवाइस पर ही प्रोसेस होता है — कंट्रोल हमेशा आपके पास रहता है।';
  @override
  String get onb3Title => 'एक बार सेव करें.\nकभी भी ढूँढें.';
  @override
  String get onb3Body =>
      'किसी भी ऐप से JARA में शेयर करें, फिर बाद में अपने शब्दों में ढूँढें।';
  @override
  String get onbPrimaryCta => 'मेरी मेमोरी बनाएँ';
  @override
  String get onbSecondaryCta => 'डेमो देखें';
  @override
  String get onbSkip => 'छोड़ें';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'सुप्रभात' : 'सुप्रभात, $name';
  @override
  String greetingDay(String name) => name.isEmpty ? 'नमस्ते' : 'नमस्ते, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'शुभ संध्या' : 'शुभ संध्या, $name';
  @override
  String get searchTitle => 'आपने जो कुछ सेव किया है,\nसब ढूँढें।';
  @override
  List<String> get searchHints => const [
        'मेरी लंदन ट्रिप वाला डॉक्यूमेंट ढूँढो',
        'पेमेंट डिटेल वाले स्क्रीनशॉट दिखाओ',
        'VoxBridge की कीमत के बारे में मैंने क्या सेव किया था?',
        'मेरा डॉक्टर अपॉइंटमेंट ढूँढो',
        'पासपोर्ट वाली फ़ोटो दिखाओ',
      ];
  @override
  String get filterAll => 'सभी';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'डॉक्यूमेंट',
        MemoryType.photo => 'फ़ोटो',
        MemoryType.screenshot => 'स्क्रीनशॉट',
        MemoryType.note => 'नोट',
        MemoryType.link => 'लिंक',
        MemoryType.audio => 'ऑडियो',
        MemoryType.calendar => 'कैलेंडर',
        MemoryType.email => 'ईमेल',
        MemoryType.chat => 'चैट',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'डॉक्यूमेंट',
        MemoryType.photo => 'फ़ोटो',
        MemoryType.screenshot => 'स्क्रीनशॉट',
        MemoryType.note => 'नोट',
        MemoryType.link => 'लिंक',
        MemoryType.audio => 'ऑडियो',
        MemoryType.calendar => 'कैलेंडर',
        MemoryType.email => 'ईमेल',
        MemoryType.chat => 'चैट',
      };

  @override
  String get sourcesSection => 'आपकी मेमोरी';
  @override
  String get recentSearches => 'हाल की खोजें';
  @override
  String get recentlySaved => 'हाल में सेव किए गए';
  @override
  String get suggestedSearches => 'यह पूछकर देखें';
  @override
  String get seeAll => 'सभी देखें';
  @override
  String get memoryStatusTitle => 'मेरी मेमोरी';
  @override
  String memoryStatusItems(int items, int collections) =>
      '$items आइटम · $collections कलेक्शन';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => '$ago इंडेक्स हुआ';
  @override
  String newItemsThisWeek(int count) => 'इस हफ़्ते +$count';

  @override
  String get suggestionsHistory => 'हाल के';
  @override
  String get suggestionsSmart => 'सुझाव';

  @override
  String resultsCount(int count, String elapsed) => switch (count) {
        0 => 'कोई नतीजा नहीं · $elapsed',
        1 => '1 नतीजा · $elapsed',
        _ => '$count नतीजे · $elapsed',
      };
  @override
  String get bestMatch => 'सबसे सटीक';
  @override
  String get smartSummaryTitle => 'स्मार्ट सारांश';
  @override
  String basedOnItems(int count) => count == 1
      ? 'एक सेव किए गए आइटम पर आधारित'
      : '$count सेव किए गए आइटम पर आधारित';
  @override
  String get viewSources => 'स्रोत देखें';
  @override
  String get refineSearch => 'खोज को बेहतर करें';
  @override
  String get saveAnswer => 'जवाब सेव करें';
  @override
  String get copied => 'कॉपी हो गया';
  @override
  String get sortRecent => 'सबसे नए';
  @override
  String get sortRelevance => 'सबसे सटीक';

  @override
  String get actionOpen => 'खोलें';
  @override
  String get actionPreview => 'प्रीव्यू';
  @override
  String get actionShare => 'शेयर करें';
  @override
  String get actionPin => 'पिन करें';
  @override
  String get actionUnpin => 'पिन हटाएँ';
  @override
  String get actionAddTag => 'टैग जोड़ें';
  @override
  String get actionSaveToCollection => 'कलेक्शन में सेव करें';
  @override
  String get actionAskAbout => 'इसके बारे में पूछें';
  @override
  String get actionDelete => 'मेमोरी से हटाएँ';
  @override
  String get actionOpenOriginal => 'ओरिजिनल खोलें';
  @override
  String get actionAskJara => 'JARA से पूछें';

  @override
  String get detailRelated => 'मिलती-जुलती चीज़ें';
  @override
  String get detailInCollection => 'कलेक्शन';
  @override
  String get detailTags => 'टैग';
  @override
  String get detailPeople => 'लोग';
  @override
  String get detailSource => 'स्रोत';
  @override
  String get detailAskPlaceholder => 'इस आइटम के बारे में पूछें…';

  @override
  String get addTitle => 'JARA में जोड़ें';
  @override
  String get addScanDocument => 'डॉक्यूमेंट स्कैन करें';
  @override
  String get addUploadFile => 'फ़ाइल अपलोड करें';
  @override
  String get addPhoto => 'फ़ोटो जोड़ें';
  @override
  String get addScreenshot => 'स्क्रीनशॉट जोड़ें';
  @override
  String get addVoiceNote => 'वॉइस नोट रिकॉर्ड करें';
  @override
  String get addPasteText => 'टेक्स्ट पेस्ट करें';
  @override
  String get addSaveLink => 'लिंक सेव करें';
  @override
  String get addCreateNote => 'नोट बनाएँ';
  @override
  String get addConnectAccount => 'अकाउंट कनेक्ट करें';
  @override
  String get addImportCalendar => 'कैलेंडर इंपोर्ट करें';
  @override
  String get addSuccessTitle => 'आपकी मेमोरी में सेव हो गया';
  @override
  String get addSuccessSearchNow => 'अभी खोजें';
  @override
  String get addSuggestedTitle => 'सुझाया गया टाइटल';
  @override
  String get addSuggestedTags => 'सुझाए गए टैग';
  @override
  String get addCollection => 'कलेक्शन';
  @override
  String get addSaveInstantly => 'तुरंत सेव करें';
  @override
  String get addSave => 'सेव करें';

  @override
  String get memoryTitle => 'मेमोरी';
  @override
  String get memoryAll => 'सभी चीज़ें';
  @override
  String get memoryPinned => 'पिन किए गए';
  @override
  String get memoryRecent => 'हाल के';
  @override
  String get memoryTimeline => 'टाइमलाइन';
  @override
  String get collectionsTitle => 'कलेक्शन';
  @override
  String collectionItems(int count) =>
      count == 0 ? 'कोई आइटम नहीं' : '$count आइटम';
  @override
  String updatedAgo(String ago) => '$ago अपडेट हुआ';

  @override
  String get connectionsTitle => 'कनेक्शन';
  @override
  String get connectionsSubtitle =>
      'चुनें कि JARA क्या इंडेक्स कर सकता है। आप कभी भी डिस्कनेक्ट कर सकते हैं।';
  @override
  String get connectionConnected => 'कनेक्ट है';
  @override
  String get connectionSyncing => 'सिंक हो रहा है…';
  @override
  String get connectionDisconnected => 'कनेक्ट नहीं है';
  @override
  String get connectionAttention => 'ध्यान चाहिए';
  @override
  String get connectionConnect => 'कनेक्ट करें';
  @override
  String get connectionDisconnect => 'डिस्कनेक्ट करें';
  @override
  String get connectionReindex => 'फिर से इंडेक्स करें';
  @override
  String lastSynced(String ago) => '$ago सिंक हुआ';

  @override
  String get privacyTitle => 'प्राइवेसी सेंटर';
  @override
  String get privacyLocalActive => 'लोकल प्रोसेसिंग चालू है';
  @override
  String get privacyCloudOff => 'क्लाउड इंटेलिजेंस बंद';
  @override
  String get privacyCloudOn => 'क्लाउड इंटेलिजेंस चालू';
  @override
  String get privacyOnDevice => 'इसी डिवाइस पर रहता है';
  @override
  String get privacyOnDeviceBody =>
      'आपका इंडेक्स, प्रीव्यू और खोज इतिहास आपके डिवाइस पर ही सेव होते हैं।';
  @override
  String get privacyCloudSection => 'क्लाउड पर क्या जाता है';
  @override
  String get privacyCloudBody =>
      'कुछ नहीं — जब तक आप बेहतर जवाबों के लिए क्लाउड इंटेलिजेंस चालू न करें।';
  @override
  String get privacyLocalAi => 'डिवाइस पर AI';
  @override
  String get privacyCloudAi => 'क्लाउड इंटेलिजेंस';
  @override
  String get privacyAppLock => 'ऐप लॉक';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'संवेदनशील कॉन्टेंट की सुरक्षा';
  @override
  String get privacyExport => 'मेरा डेटा एक्सपोर्ट करें';
  @override
  String get privacyClearHistory => 'खोज इतिहास मिटाएँ';
  @override
  String get privacyDeleteAll => 'सारा डेटा डिलीट करें';
  @override
  String get privacyDeleteConfirmTitle => 'सब कुछ डिलीट करें?';
  @override
  String get privacyDeleteConfirmBody =>
      'इससे आपकी पूरी मेमोरी इंडेक्स इस डिवाइस से हट जाएगी। आपके ऐप्स में मौजूद ओरिजिनल पर कोई असर नहीं होगा।';
  @override
  String get cancel => 'रद्द करें';
  @override
  String get confirmDelete => 'डिलीट करें';

  @override
  String get settingsTitle => 'प्रोफ़ाइल';
  @override
  String get settingsTheme => 'थीम';
  @override
  String get settingsThemeDark => 'डार्क';
  @override
  String get settingsThemeLight => 'लाइट';
  @override
  String get settingsThemeSystem => 'सिस्टम';
  @override
  String get settingsLanguage => 'भाषा';
  @override
  String get settingsSearchSources => 'डिफ़ॉल्ट खोज स्रोत';
  @override
  String get settingsVoice => 'वॉइस खोज';
  @override
  String get settingsStorage => 'स्टोरेज';
  @override
  String get settingsIndexing => 'इंडेक्सिंग';
  @override
  String get settingsNotifications => 'नोटिफ़िकेशन';
  @override
  String get settingsConnectedAccounts => 'कनेक्ट किए गए अकाउंट';
  @override
  String get settingsPrivacySecurity => 'प्राइवेसी और सुरक्षा';
  @override
  String get settingsSubscription => 'सब्सक्रिप्शन';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'क्लाउड इंटेलिजेंस, अनलिमिटेड कनेक्शन और प्राथमिकता वाली इंडेक्सिंग।';

  @override
  String get back => 'वापस';
  @override
  String get moreActions => 'और विकल्प';
  @override
  String get done => 'हो गया';
  @override
  String get apply => 'लागू करें';
  @override
  String get continueCta => 'आगे बढ़ें';
  @override
  String get searchAction => 'खोजें';
  @override
  String get sortBy => 'क्रम';
  @override
  String get listening => 'सुन रहा है…';
  @override
  String get alwaysOn => 'हमेशा चालू';
  @override
  String get clearDateFilter => 'तारीख़ फ़िल्टर हटाएँ';
  @override
  String get sectionGeneral => 'सामान्य';
  @override
  String get sectionIntelligence => 'इंटेलिजेंस';
  @override
  String get sectionData => 'डेटा';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'आपने जोड़ा';
  @override
  String get addedJustNow =>
      'अभी-अभी जोड़ा गया — JARA इसे खोजने लायक बना रहा है।';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA को आपकी अनुमति चाहिए',
        JaraError.fileUnreadable => 'यह फ़ाइल नहीं खुल रही',
        JaraError.indexingFailed => 'इंडेक्सिंग बीच में रुक गई',
        JaraError.accountDisconnected => 'अकाउंट फिर से कनेक्ट करना होगा',
        JaraError.noConnection => 'आप ऑफ़लाइन हैं',
        JaraError.localModelNotReady => 'अभी तैयारी चल रही है',
        JaraError.storageFull => 'इस डिवाइस पर जगह नहीं बची',
        JaraError.sourceMissing => 'ओरिजिनल अब मौजूद नहीं है',
        JaraError.generic => 'एक बार फिर कोशिश करनी होगी',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'इस स्रोत तक पहुँच दें, यह तुरंत खोजने लायक हो जाएगा।',
        JaraError.fileUnreadable =>
          'हो सकता है फ़ाइल ख़राब हो या ऐसे फ़ॉर्मैट में हो जिसे JARA अभी नहीं पढ़ पाता।',
        JaraError.indexingFailed =>
          'कुछ चीज़ें जुड़ नहीं पाईं। आपकी मौजूदा मेमोरी वैसी ही है।',
        JaraError.accountDisconnected =>
          'फिर से साइन इन करें ताकि इस अकाउंट की चीज़ें अपडेट रहें।',
        JaraError.noConnection =>
          'आपके डिवाइस की मेमोरी काम करती रहेगी। क्लाउड सुविधाएँ अपने आप लौट आएँगी।',
        JaraError.localModelNotReady =>
          'डिवाइस पर खोज की तैयारी पूरी हो रही है। पहली बार इसमें थोड़ा समय लगता है।',
        JaraError.storageFull =>
          'थोड़ी जगह खाली करें, फिर JARA इंडेक्सिंग पूरी कर लेगा।',
        JaraError.sourceMissing =>
          'यह चीज़ अपने असली ऐप में हटा दी गई या कहीं और ले जाई गई।',
        JaraError.generic =>
          'यह पूरा नहीं हो पाया। आपकी मेमोरी सुरक्षित है — फिर कोशिश करें।',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'सेटिंग खोलें',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'फिर कोशिश करें',
        JaraError.accountDisconnected => 'फिर से कनेक्ट करें',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'स्टोरेज मैनेज करें',
        JaraError.sourceMissing => 'मेमोरी से हटाएँ',
        JaraError.generic => 'फिर कोशिश करें',
      };

  @override
  String get needsConnection => 'कनेक्शन चाहिए';

  @override
  String get emptyResultsTitle => 'अभी कुछ नहीं मिला';
  @override
  String get emptyResultsBody =>
      'तारीख़, स्रोत या शब्द बदलकर देखें।';
  @override
  String get emptyResultsAdjust => 'फ़िल्टर बदलें';
  @override
  String get emptyResultsSearchAll => 'पूरी मेमोरी में खोजें';
  @override
  String get emptyMemoryTitle => 'आपकी मेमोरी यहीं से शुरू होती है';
  @override
  String get emptyMemoryBody =>
      'कोई फ़ाइल, स्क्रीनशॉट, लिंक या नोट जोड़ें। JARA उसे खोजने लायक बना देगा।';
  @override
  String get emptyMemoryCta => 'पहली चीज़ जोड़ें';
  @override
  String get offlineLabel => 'ऑफ़लाइन खोज चालू है';
  @override
  String get offlineBody =>
      'आपके डिवाइस की मेमोरी काम करती रहेगी। क्लाउड सुविधाएँ अपने आप लौट आएँगी।';
  @override
  String get errorGenericTitle => 'एक बार फिर कोशिश करनी होगी';
  @override
  String get errorGenericBody =>
      'यह पूरा नहीं हो पाया। आपकी मेमोरी सुरक्षित है — फिर कोशिश करें।';
  @override
  String get retry => 'फिर कोशिश करें';

  @override
  String get shareTitle => 'JARA में सेव करें';
  @override
  String get shareSaveInstantly => 'तुरंत सेव करें';
  @override
  String get shareReview => 'डिटेल देखें';
  @override
  String get shareSaved => 'आपकी मेमोरी में सेव हो गया';

  @override
  String get today => 'आज';
  @override
  String get tomorrow => 'आने वाला कल';
  @override
  String get yesterday => 'बीता कल';
  @override
  String daysAgo(int days) => '$days दिन पहले';
  @override
  String inDays(int days) => '$days दिन में';
  @override
  String minutesAgo(int m) => '$m मिनट पहले';
  @override
  String hoursAgo(int h) => h == 1 ? '1 घंटा पहले' : '$h घंटे पहले';
}
