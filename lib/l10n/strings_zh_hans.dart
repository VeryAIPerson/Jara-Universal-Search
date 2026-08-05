import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsZhHans extends JaraStrings {
  const JaraStringsZhHans();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => '重要的一切。一次搜索。';

  @override
  String get onb1Title => '重要的一切。\n一次搜索。';
  @override
  String get onb1Body => '在专属于你的个人记忆中，找到文件、照片、笔记和链接。';
  @override
  String get onb2Title => '设计即隐私';
  @override
  String get onb2Body =>
      '只要条件允许，你的内容都会在本地处理——掌控权始终在你手中。';
  @override
  String get onb3Title => '保存一次。\n随时可寻。';
  @override
  String get onb3Body => '从任意应用分享到 JARA，之后用自己的话就能找到它。';
  @override
  String get onbPrimaryCta => '建立我的记忆';
  @override
  String get onbSecondaryCta => '体验演示';
  @override
  String get onbSkip => '跳过';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? '早上好' : '早上好，$name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? '下午好' : '下午好，$name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? '晚上好' : '晚上好，$name';
  @override
  String get searchTitle => '查找你保存过的\n任何内容。';
  @override
  List<String> get searchHints => const [
        '找一下关于伦敦之行的文件',
        '显示有支付信息的截图',
        '我保存过哪些 VoxBridge 定价的内容？',
        '找一下我的医生预约',
        '显示带护照的照片',
      ];
  @override
  String get filterAll => '全部';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => '文档',
        MemoryType.photo => '照片',
        MemoryType.screenshot => '截图',
        MemoryType.note => '笔记',
        MemoryType.link => '链接',
        MemoryType.audio => '音频',
        MemoryType.calendar => '日历',
        MemoryType.email => '邮件',
        MemoryType.chat => '聊天',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => '文档',
        MemoryType.photo => '照片',
        MemoryType.screenshot => '截图',
        MemoryType.note => '笔记',
        MemoryType.link => '链接',
        MemoryType.audio => '音频',
        MemoryType.calendar => '日历',
        MemoryType.email => '邮件',
        MemoryType.chat => '聊天',
      };

  @override
  String get sourcesSection => '你的记忆';
  @override
  String get recentSearches => '最近搜索';
  @override
  String get recentlySaved => '最近保存';
  @override
  String get suggestedSearches => '试着问问';
  @override
  String get seeAll => '查看全部';
  @override
  String get memoryStatusTitle => '我的记忆';
  @override
  String memoryStatusItems(int items, int collections) =>
      '$items 条 · $collections 个收藏集';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => '$ago完成索引';
  @override
  String newItemsThisWeek(int count) => '本周新增 $count 条';

  @override
  String get suggestionsHistory => '最近';
  @override
  String get suggestionsSmart => '推荐';

  @override
  String resultsCount(int count, String elapsed) =>
      '$count 条结果 · $elapsed';
  @override
  String get bestMatch => '最佳匹配';
  @override
  String get smartSummaryTitle => '智能摘要';
  @override
  String basedOnItems(int count) => '基于 $count 条已保存内容';
  @override
  String get viewSources => '查看来源';
  @override
  String get refineSearch => '优化搜索';
  @override
  String get saveAnswer => '保存答案';
  @override
  String get copied => '已复制';
  @override
  String get sortRecent => '最新';
  @override
  String get sortRelevance => '最佳匹配';

  @override
  String get actionOpen => '打开';
  @override
  String get actionPreview => '预览';
  @override
  String get actionShare => '分享';
  @override
  String get actionPin => '置顶';
  @override
  String get actionUnpin => '取消置顶';
  @override
  String get actionAddTag => '添加标签';
  @override
  String get actionSaveToCollection => '保存到收藏集';
  @override
  String get actionAskAbout => '询问相关内容';
  @override
  String get actionDelete => '从记忆中删除';
  @override
  String get actionOpenOriginal => '打开原始文件';
  @override
  String get actionAskJara => '询问 JARA';

  @override
  String get detailRelated => '相关记忆';
  @override
  String get detailInCollection => '收藏集';
  @override
  String get detailTags => '标签';
  @override
  String get detailPeople => '相关人物';
  @override
  String get detailSource => '来源';
  @override
  String get detailAskPlaceholder => '询问这条记忆…';

  @override
  String get addTitle => '添加到 JARA';
  @override
  String get addScanDocument => '扫描文档';
  @override
  String get addUploadFile => '上传文件';
  @override
  String get addPhoto => '添加照片';
  @override
  String get addScreenshot => '添加截图';
  @override
  String get addVoiceNote => '录制语音笔记';
  @override
  String get addPasteText => '粘贴文本';
  @override
  String get addSaveLink => '保存链接';
  @override
  String get addCreateNote => '创建笔记';
  @override
  String get addConnectAccount => '连接账户';
  @override
  String get addImportCalendar => '导入日历';
  @override
  String get addSuccessTitle => '已保存到你的记忆';
  @override
  String get addSuccessSearchNow => '立即搜索';
  @override
  String get addSuggestedTitle => '建议标题';
  @override
  String get addSuggestedTags => '建议标签';
  @override
  String get addCollection => '收藏集';
  @override
  String get addSaveInstantly => '立即保存';
  @override
  String get addSave => '保存';

  @override
  String get memoryTitle => '记忆';
  @override
  String get memoryAll => '全部记忆';
  @override
  String get memoryPinned => '已置顶';
  @override
  String get memoryRecent => '最近';
  @override
  String get memoryTimeline => '时间线';
  @override
  String get collectionsTitle => '收藏集';
  @override
  String collectionItems(int count) => '$count 条';
  @override
  String updatedAgo(String ago) => '$ago更新';

  @override
  String get connectionsTitle => '连接';
  @override
  String get connectionsSubtitle => '选择 JARA 可以索引的来源，你可以随时断开连接。';
  @override
  String get connectionConnected => '已连接';
  @override
  String get connectionSyncing => '同步中…';
  @override
  String get connectionDisconnected => '未连接';
  @override
  String get connectionAttention => '需要处理';
  @override
  String get connectionConnect => '连接';
  @override
  String get connectionDisconnect => '断开连接';
  @override
  String get connectionReindex => '重新索引';
  @override
  String lastSynced(String ago) => '$ago同步';

  @override
  String get privacyTitle => '隐私中心';
  @override
  String get privacyLocalActive => '本地处理已启用';
  @override
  String get privacyCloudOff => '云端智能已关闭';
  @override
  String get privacyCloudOn => '云端智能已开启';
  @override
  String get privacyOnDevice => '仅保留在本地';
  @override
  String get privacyOnDeviceBody => '你的索引、预览内容和搜索记录都保存在本地。';
  @override
  String get privacyCloudSection => '发送到云端的内容';
  @override
  String get privacyCloudBody => '默认不发送任何内容，除非你开启云端智能以获得更丰富的答案。';
  @override
  String get privacyLocalAi => '本地人工智能';
  @override
  String get privacyCloudAi => '云端智能';
  @override
  String get privacyAppLock => '应用锁';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => '敏感内容保护';
  @override
  String get privacyExport => '导出我的数据';
  @override
  String get privacyClearHistory => '清除搜索记录';
  @override
  String get privacyDeleteAll => '删除所有数据';
  @override
  String get privacyDeleteConfirmTitle => '确定删除全部内容？';
  @override
  String get privacyDeleteConfirmBody =>
      '这将从本地删除你的整个记忆索引，但不会影响你各应用中的原始内容。';
  @override
  String get cancel => '取消';
  @override
  String get confirmDelete => '删除';

  @override
  String get settingsTitle => '个人资料';
  @override
  String get settingsTheme => '外观';
  @override
  String get settingsThemeDark => '深色';
  @override
  String get settingsThemeLight => '浅色';
  @override
  String get settingsThemeSystem => '跟随系统';
  @override
  String get settingsLanguage => '语言';
  @override
  String get settingsSearchSources => '默认搜索来源';
  @override
  String get settingsVoice => '语音搜索';
  @override
  String get settingsStorage => '存储空间';
  @override
  String get settingsIndexing => '索引';
  @override
  String get settingsNotifications => '通知';
  @override
  String get settingsConnectedAccounts => '已连接的账户';
  @override
  String get settingsPrivacySecurity => '隐私与安全';
  @override
  String get settingsSubscription => '订阅';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody => '云端智能、无限连接数与优先索引处理。';

  @override
  String get back => '返回';
  @override
  String get moreActions => '更多操作';
  @override
  String get done => '完成';
  @override
  String get apply => '应用';
  @override
  String get continueCta => '继续';
  @override
  String get searchAction => '搜索';
  @override
  String get sortBy => '排序方式';
  @override
  String get listening => '正在聆听…';
  @override
  String get alwaysOn => '始终开启';
  @override
  String get clearDateFilter => '清除日期筛选';
  @override
  String get sectionGeneral => '通用';
  @override
  String get sectionIntelligence => '智能';
  @override
  String get sectionData => '数据';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => '你手动添加';
  @override
  String get addedJustNow => '刚刚添加——JARA 正在使其可被搜索。';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => '需要你的授权',
        JaraError.fileUnreadable => '这个文件无法打开',
        JaraError.indexingFailed => '索引中途停止',
        JaraError.accountDisconnected => '账户需要重新连接',
        JaraError.noConnection => '你当前离线',
        JaraError.localModelNotReady => '仍在准备中',
        JaraError.storageFull => '本地存储空间已满',
        JaraError.sourceMissing => '原始内容已不存在',
        JaraError.generic => '需要重试一下',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied => '允许访问这个来源，即可立即开始搜索。',
        JaraError.fileUnreadable => '文件可能已损坏，或格式暂不支持。',
        JaraError.indexingFailed => '部分内容未能添加，你现有的记忆不受影响。',
        JaraError.accountDisconnected => '重新登录，让该账户的内容保持最新。',
        JaraError.noConnection => '本地记忆仍可正常使用，云端功能会自动恢复。',
        JaraError.localModelNotReady =>
          '本地搜索正在完成设置，首次启动需要一点时间。',
        JaraError.storageFull => '请先清理一些存储空间，JARA 才能完成索引。',
        JaraError.sourceMissing => '这项内容已在原应用中被移动或删除。',
        JaraError.generic => '操作未能完成。你的记忆很安全——请重试。',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => '打开设置',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => '重试',
        JaraError.accountDisconnected => '重新连接',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => '管理存储空间',
        JaraError.sourceMissing => '从记忆中移除',
        JaraError.generic => '重试',
      };

  @override
  String get needsConnection => '需要联网';

  @override
  String get emptyResultsTitle => '暂无匹配结果';
  @override
  String get emptyResultsBody => '试着调整日期、来源或搜索用词。';
  @override
  String get emptyResultsAdjust => '调整筛选条件';
  @override
  String get emptyResultsSearchAll => '搜索全部记忆';
  @override
  String get emptyMemoryTitle => '你的记忆从这里开始';
  @override
  String get emptyMemoryBody => '添加文件、截图、链接或笔记，JARA 会让它变得可被搜索。';
  @override
  String get emptyMemoryCta => '添加第一条记忆';
  @override
  String get offlineLabel => '离线搜索已启用';
  @override
  String get offlineBody => '本地记忆仍可正常使用，云端功能会自动恢复。';
  @override
  String get errorGenericTitle => '需要重试一下';
  @override
  String get errorGenericBody => '操作未能完成。你的记忆很安全——请重试。';
  @override
  String get retry => '重试';

  @override
  String get shareTitle => '保存到 JARA';
  @override
  String get shareSaveInstantly => '立即保存';
  @override
  String get shareReview => '查看详情';
  @override
  String get shareSaved => '已保存到你的记忆';

  @override
  String get today => '今天';
  @override
  String get tomorrow => '明天';
  @override
  String get yesterday => '昨天';
  @override
  String daysAgo(int days) => '$days天前';
  @override
  String inDays(int days) => '$days天后';
  @override
  String minutesAgo(int m) => '$m分钟前';
  @override
  String hoursAgo(int h) => '$h小时前';
}
