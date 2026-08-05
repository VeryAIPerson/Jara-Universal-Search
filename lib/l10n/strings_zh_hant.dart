import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsZhHant extends JaraStrings {
  const JaraStringsZhHant();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => '重要的一切。一次搜尋。';

  @override
  String get onb1Title => '重要的一切。\n一次搜尋。';
  @override
  String get onb1Body => '在專屬於你的個人記憶中，找到檔案、照片、筆記和連結。';
  @override
  String get onb2Title => '設計即隱私';
  @override
  String get onb2Body =>
      '只要條件允許，你的內容都會在本機處理——掌控權始終在你手中。';
  @override
  String get onb3Title => '儲存一次。\n隨時可尋。';
  @override
  String get onb3Body => '從任何應用程式分享到 JARA，之後用自己的話就能找到它。';
  @override
  String get onbPrimaryCta => '建立我的記憶';
  @override
  String get onbSecondaryCta => '體驗展示';
  @override
  String get onbSkip => '略過';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? '早安' : '早安，$name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? '午安' : '午安，$name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? '晚上好' : '晚上好，$name';
  @override
  String get searchTitle => '尋找你儲存過的\n任何內容。';
  @override
  List<String> get searchHints => const [
        '找一下關於倫敦之旅的文件',
        '顯示有付款資訊的截圖',
        '我存過哪些 VoxBridge 定價的內容？',
        '找一下我的醫生預約',
        '顯示有護照的照片',
      ];
  @override
  String get filterAll => '全部';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => '文件',
        MemoryType.photo => '照片',
        MemoryType.screenshot => '截圖',
        MemoryType.note => '筆記',
        MemoryType.link => '連結',
        MemoryType.audio => '音訊',
        MemoryType.calendar => '行事曆',
        MemoryType.email => '郵件',
        MemoryType.chat => '聊天',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => '文件',
        MemoryType.photo => '照片',
        MemoryType.screenshot => '截圖',
        MemoryType.note => '筆記',
        MemoryType.link => '連結',
        MemoryType.audio => '音訊',
        MemoryType.calendar => '行事曆',
        MemoryType.email => '郵件',
        MemoryType.chat => '聊天',
      };

  @override
  String get sourcesSection => '你的記憶';
  @override
  String get recentSearches => '最近搜尋';
  @override
  String get recentlySaved => '最近儲存';
  @override
  String get suggestedSearches => '試著問問';
  @override
  String get seeAll => '查看全部';
  @override
  String get memoryStatusTitle => '我的記憶';
  @override
  String memoryStatusItems(int items, int collections) =>
      '$items 筆 · $collections 個收藏集';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => '$ago完成索引';
  @override
  String newItemsThisWeek(int count) => '本週新增 $count 筆';

  @override
  String get suggestionsHistory => '最近';
  @override
  String get suggestionsSmart => '推薦';

  @override
  String resultsCount(int count, String elapsed) =>
      '$count 筆結果 · $elapsed';
  @override
  String get bestMatch => '最佳匹配';
  @override
  String get smartSummaryTitle => '智慧摘要';
  @override
  String basedOnItems(int count) => '根據 $count 筆已儲存內容';
  @override
  String get viewSources => '查看來源';
  @override
  String get refineSearch => '優化搜尋';
  @override
  String get saveAnswer => '儲存答案';
  @override
  String get copied => '已複製';
  @override
  String get sortRecent => '最新';
  @override
  String get sortRelevance => '最佳匹配';

  @override
  String get actionOpen => '開啟';
  @override
  String get actionPreview => '預覽';
  @override
  String get actionShare => '分享';
  @override
  String get actionPin => '置頂';
  @override
  String get actionUnpin => '取消置頂';
  @override
  String get actionAddTag => '新增標籤';
  @override
  String get actionSaveToCollection => '儲存到收藏集';
  @override
  String get actionAskAbout => '詢問相關內容';
  @override
  String get actionDelete => '從記憶中刪除';
  @override
  String get actionOpenOriginal => '開啟原始檔案';
  @override
  String get actionAskJara => '詢問 JARA';

  @override
  String get detailRelated => '相關記憶';
  @override
  String get detailInCollection => '收藏集';
  @override
  String get detailTags => '標籤';
  @override
  String get detailPeople => '相關人物';
  @override
  String get detailSource => '來源';
  @override
  String get detailAskPlaceholder => '詢問這則記憶…';

  @override
  String get addTitle => '新增到 JARA';
  @override
  String get addScanDocument => '掃描文件';
  @override
  String get addUploadFile => '上傳檔案';
  @override
  String get addPhoto => '新增照片';
  @override
  String get addScreenshot => '新增截圖';
  @override
  String get addVoiceNote => '錄製語音筆記';
  @override
  String get addPasteText => '貼上文字';
  @override
  String get addSaveLink => '儲存連結';
  @override
  String get addCreateNote => '建立筆記';
  @override
  String get addConnectAccount => '連接帳戶';
  @override
  String get addImportCalendar => '匯入行事曆';
  @override
  String get addSuccessTitle => '已儲存到你的記憶';
  @override
  String get addSuccessSearchNow => '立即搜尋';
  @override
  String get addSuggestedTitle => '建議標題';
  @override
  String get addSuggestedTags => '建議標籤';
  @override
  String get addCollection => '收藏集';
  @override
  String get addSaveInstantly => '立即儲存';
  @override
  String get addSave => '儲存';

  @override
  String get memoryTitle => '記憶';
  @override
  String get memoryAll => '全部記憶';
  @override
  String get memoryPinned => '已置頂';
  @override
  String get memoryRecent => '最近';
  @override
  String get memoryTimeline => '時間軸';
  @override
  String get collectionsTitle => '收藏集';
  @override
  String collectionItems(int count) => '$count 筆';
  @override
  String updatedAgo(String ago) => '$ago更新';

  @override
  String get connectionsTitle => '連接';
  @override
  String get connectionsSubtitle => '選擇 JARA 可以索引的來源，你可以隨時中斷連接。';
  @override
  String get connectionConnected => '已連接';
  @override
  String get connectionSyncing => '同步中…';
  @override
  String get connectionDisconnected => '未連接';
  @override
  String get connectionAttention => '需要處理';
  @override
  String get connectionConnect => '連接';
  @override
  String get connectionDisconnect => '中斷連接';
  @override
  String get connectionReindex => '重新索引';
  @override
  String lastSynced(String ago) => '$ago同步';

  @override
  String get privacyTitle => '隱私中心';
  @override
  String get privacyLocalActive => '本機處理已啟用';
  @override
  String get privacyCloudOff => '雲端智慧已關閉';
  @override
  String get privacyCloudOn => '雲端智慧已開啟';
  @override
  String get privacyOnDevice => '僅保留在本機';
  @override
  String get privacyOnDeviceBody => '你的索引、預覽內容和搜尋紀錄都保存在本機。';
  @override
  String get privacyCloudSection => '傳送到雲端的內容';
  @override
  String get privacyCloudBody => '預設不傳送任何內容，除非你開啟雲端智慧以取得更完整的答案。';
  @override
  String get privacyLocalAi => '本機人工智慧';
  @override
  String get privacyCloudAi => '雲端智慧';
  @override
  String get privacyAppLock => '應用程式鎖定';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => '敏感內容保護';
  @override
  String get privacyExport => '匯出我的資料';
  @override
  String get privacyClearHistory => '清除搜尋紀錄';
  @override
  String get privacyDeleteAll => '刪除所有資料';
  @override
  String get privacyDeleteConfirmTitle => '確定刪除全部內容？';
  @override
  String get privacyDeleteConfirmBody =>
      '這會從本機刪除你整個記憶索引，但不會影響你各應用程式中的原始內容。';
  @override
  String get privacyDeleted =>
      '記憶已從此裝置刪除。';
  @override
  String get cancel => '取消';
  @override
  String get confirmDelete => '刪除';

  @override
  String get settingsTitle => '個人資料';
  @override
  String get settingsTheme => '主題';
  @override
  String get settingsThemeDark => '深色';
  @override
  String get settingsThemeLight => '淺色';
  @override
  String get settingsThemeSystem => '跟隨系統';
  @override
  String get settingsLanguage => '語言';
  @override
  String get settingsSearchSources => '預設搜尋來源';
  @override
  String get settingsVoice => '語音搜尋';
  @override
  String get settingsStorage => '儲存空間';
  @override
  String get settingsIndexing => '索引';
  @override
  String get settingsNotifications => '通知';
  @override
  String get settingsConnectedAccounts => '已連接的帳戶';
  @override
  String get settingsPrivacySecurity => '隱私與安全';
  @override
  String get settingsSubscription => '訂閱';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody => '雲端智慧、無限連接數與優先索引處理。';

  @override
  String get paywallTitle => '需要時，走得更遠';
  @override
  String get paywallSubtitle => 'Premium 為 JARA 增加三項能力，搜尋維持原樣。';
  @override
  String get paywallFeatCloudTitle => '雲端智慧';
  @override
  String get paywallFeatCloudBody => '當你選擇雲端時，回答會更完整。在你開啟之前它一直關閉，選擇權始終在你手中。';
  @override
  String get paywallFeatConnectionsTitle => '無限連接數';
  @override
  String get paywallFeatConnectionsBody =>
      '免費方案可連接的來源數量有限，Premium 可連接你使用的每一個帳戶。';
  @override
  String get paywallFeatIndexingTitle => '優先索引處理';
  @override
  String get paywallFeatIndexingBody => '新儲存的內容會優先變得可搜尋，即使正在進行大量匯入。';
  @override
  String get paywallMonthly => '按月';
  @override
  String get paywallYearly => '按年';
  @override
  String get paywallYearlyBadge => '最超值';
  @override
  String get paywallPriceNote => '價格會在結帳時以你所在地區的貨幣顯示。';
  @override
  String get paywallCta => '開始使用 Premium';
  @override
  String get paywallRestore => '回復購買';
  @override
  String get paywallTerms => '條款';
  @override
  String get paywallSearchFree => '搜尋你自己的記憶永遠免費，Premium 從不鎖住你已經擁有的內容。';
  @override
  String get paywallNotWiredNote => '購買功能將隨商店版本推出。';

  @override
  String get back => '返回';
  @override
  String get moreActions => '更多操作';
  @override
  String get done => '完成';
  @override
  String get apply => '套用';
  @override
  String get continueCta => '繼續';
  @override
  String get searchAction => '搜尋';
  @override
  String get sortBy => '排序方式';
  @override
  String get listening => '正在聆聽…';
  @override
  String get alwaysOn => '始終開啟';
  @override
  String get clearDateFilter => '清除日期篩選';
  @override
  String get sectionGeneral => '一般';
  @override
  String get sectionIntelligence => '智慧';
  @override
  String get sectionData => '資料';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => '你手動新增';
  @override
  String get addedJustNow => '剛剛新增——JARA 正在讓它可以被搜尋。';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => '需要你的授權',
        JaraError.fileUnreadable => '這個檔案無法開啟',
        JaraError.indexingFailed => '索引中途停止',
        JaraError.accountDisconnected => '帳戶需要重新連接',
        JaraError.noConnection => '你目前離線',
        JaraError.localModelNotReady => '仍在準備中',
        JaraError.storageFull => '本機儲存空間已滿',
        JaraError.sourceMissing => '原始內容已不存在',
        JaraError.generic => '需要重試一下',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied => '允許存取這個來源，即可立即開始搜尋。',
        JaraError.fileUnreadable => '檔案可能已損壞，或格式目前尚未支援。',
        JaraError.indexingFailed => '部分內容未能新增，你現有的記憶不受影響。',
        JaraError.accountDisconnected => '重新登入，讓這個帳戶的內容保持最新。',
        JaraError.noConnection => '本機記憶仍可正常運作，雲端功能會自動恢復。',
        JaraError.localModelNotReady =>
          '本機搜尋正在完成設定，第一次啟動需要一點時間。',
        JaraError.storageFull => '請先清出一些儲存空間，JARA 才能完成索引。',
        JaraError.sourceMissing => '這項內容已在原本的應用程式中被移動或刪除。',
        JaraError.generic => '操作未能完成。你的記憶很安全——請重試。',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => '開啟設定',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => '重試',
        JaraError.accountDisconnected => '重新連接',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => '管理儲存空間',
        JaraError.sourceMissing => '從記憶中移除',
        JaraError.generic => '重試',
      };

  @override
  String get needsConnection => '需要連線';

  @override
  String get emptyResultsTitle => '暫無符合的結果';
  @override
  String get emptyResultsBody => '試著調整日期、來源或搜尋用詞。';
  @override
  String get emptyResultsAdjust => '調整篩選條件';
  @override
  String get emptyResultsSearchAll => '搜尋全部記憶';
  @override
  String get emptyMemoryTitle => '你的記憶從這裡開始';
  @override
  String get emptyMemoryBody => '新增檔案、截圖、連結或筆記，JARA 會讓它變得可以被搜尋。';
  @override
  String get emptyMemoryCta => '新增第一則記憶';
  @override
  String get offlineLabel => '離線搜尋已啟用';
  @override
  String get offlineBody => '本機記憶仍可正常運作，雲端功能會自動恢復。';
  @override
  String get errorGenericTitle => '需要重試一下';
  @override
  String get errorGenericBody => '操作未能完成。你的記憶很安全——請重試。';
  @override
  String get retry => '重試';

  @override
  String get shareTitle => '儲存到 JARA';
  @override
  String get shareSaveInstantly => '立即儲存';
  @override
  String get shareReview => '查看詳細資訊';
  @override
  String get shareSaved => '已儲存到你的記憶';

  @override
  String get today => '今天';
  @override
  String get tomorrow => '明天';
  @override
  String get yesterday => '昨天';
  @override
  String daysAgo(int days) => '$days天前';
  @override
  String inDays(int days) => '$days天後';
  @override
  String minutesAgo(int m) => '$m分鐘前';
  @override
  String hoursAgo(int h) => '$h小時前';
}
