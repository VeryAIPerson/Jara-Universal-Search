import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsJa extends JaraStrings {
  const JaraStringsJa();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => '大切なものすべてを、ひとつの検索で。';

  @override
  String get onb1Title => '大切なものすべてを、\nひとつの検索で。';
  @override
  String get onb1Body =>
      'ファイル、写真、メモ、リンクを、あなただけの記憶の中から見つけられます。';
  @override
  String get onb2Title => 'プライバシーを、設計から。';
  @override
  String get onb2Body =>
      '可能な限り、コンテンツはお使いの端末上で処理されます。コントロールは常にあなたの手の中に。';
  @override
  String get onb3Title => '一度保存すれば、\nいつでも見つかる。';
  @override
  String get onb3Body =>
      'どのアプリからでもJARAに共有すれば、あとは自分の言葉で探せます。';
  @override
  String get onbPrimaryCta => '記憶を作り始める';
  @override
  String get onbSecondaryCta => 'デモを試す';
  @override
  String get onbSkip => 'スキップ';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'おはようございます' : '$nameさん、おはようございます';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'こんにちは' : '$nameさん、こんにちは';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'こんばんは' : '$nameさん、こんばんは';
  @override
  String get searchTitle => '保存したものは、\nなんでも見つかる。';
  @override
  List<String> get searchHints => const [
        'ロンドン旅行の資料を探して',
        '支払い情報が写ってるスクリーンショットを見せて',
        'VoxBridgeの料金について保存した内容は？',
        '病院の予約を探して',
        'パスポートが写ってる写真を見せて',
      ];
  @override
  String get filterAll => 'すべて';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => '書類',
        MemoryType.photo => '写真',
        MemoryType.screenshot => 'スクリーンショット',
        MemoryType.note => 'メモ',
        MemoryType.link => 'リンク',
        MemoryType.audio => '音声',
        MemoryType.calendar => 'カレンダー',
        MemoryType.email => 'メール',
        MemoryType.chat => 'チャット',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => '書類',
        MemoryType.photo => '写真',
        MemoryType.screenshot => 'スクリーンショット',
        MemoryType.note => 'メモ',
        MemoryType.link => 'リンク',
        MemoryType.audio => '音声',
        MemoryType.calendar => 'カレンダー',
        MemoryType.email => 'メール',
        MemoryType.chat => 'チャット',
      };

  @override
  String get sourcesSection => 'あなたの記憶';
  @override
  String get recentSearches => '最近の検索';
  @override
  String get recentlySaved => '最近保存したもの';
  @override
  String get suggestedSearches => 'こう聞いてみましょう';
  @override
  String get seeAll => 'すべて見る';
  @override
  String get memoryStatusTitle => '私の記憶';
  @override
  String memoryStatusItems(int items, int collections) =>
      '$items件 · $collections個のコレクション';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => '$agoにインデックス済み';
  @override
  String newItemsThisWeek(int count) => '今週 +$count件';

  @override
  String get suggestionsHistory => '最近';
  @override
  String get suggestionsSmart => 'おすすめ';

  @override
  String resultsCount(int count, String elapsed) =>
      '$count件の結果 · $elapsed';
  @override
  String get bestMatch => 'ベストマッチ';
  @override
  String get smartSummaryTitle => 'スマート要約';
  @override
  String basedOnItems(int count) => '$count件の保存データをもとに作成';
  @override
  String get viewSources => 'ソースを見る';
  @override
  String get refineSearch => '検索を絞り込む';
  @override
  String get saveAnswer => '回答を保存';
  @override
  String get copied => 'コピーしました';
  @override
  String get sortRecent => '新しい順';
  @override
  String get sortRelevance => 'ベストマッチ';

  @override
  String get actionOpen => '開く';
  @override
  String get actionPreview => 'プレビュー';
  @override
  String get actionShare => '共有';
  @override
  String get actionPin => 'ピン留め';
  @override
  String get actionUnpin => 'ピン留め解除';
  @override
  String get actionAddTag => 'タグを追加';
  @override
  String get actionSaveToCollection => 'コレクションに保存';
  @override
  String get actionAskAbout => 'これについて聞く';
  @override
  String get actionDelete => '記憶から削除';
  @override
  String get actionOpenOriginal => '元のファイルを開く';
  @override
  String get actionAskJara => 'JARAに聞く';

  @override
  String get detailRelated => '関連する記憶';
  @override
  String get detailInCollection => 'コレクション';
  @override
  String get detailTags => 'タグ';
  @override
  String get detailPeople => '関連する人物';
  @override
  String get detailSource => 'ソース';
  @override
  String get detailAskPlaceholder => 'この記憶について聞く…';

  @override
  String get addTitle => 'JARAに追加';
  @override
  String get addScanDocument => '書類をスキャン';
  @override
  String get addUploadFile => 'ファイルをアップロード';
  @override
  String get addPhoto => '写真を追加';
  @override
  String get addScreenshot => 'スクリーンショットを追加';
  @override
  String get addVoiceNote => 'ボイスメモを録音';
  @override
  String get addPasteText => 'テキストを貼り付け';
  @override
  String get addSaveLink => 'リンクを保存';
  @override
  String get addCreateNote => 'メモを作成';
  @override
  String get addConnectAccount => 'アカウントを連携';
  @override
  String get addImportCalendar => 'カレンダーをインポート';
  @override
  String get addSuccessTitle => 'あなたの記憶に保存しました';
  @override
  String get addSuccessSearchNow => '今すぐ検索';
  @override
  String get addSuggestedTitle => 'おすすめのタイトル';
  @override
  String get addSuggestedTags => 'おすすめのタグ';
  @override
  String get addCollection => 'コレクション';
  @override
  String get addSaveInstantly => 'すぐに保存';
  @override
  String get addSave => '保存';

  @override
  String get memoryTitle => '記憶';
  @override
  String get memoryAll => 'すべての記憶';
  @override
  String get memoryPinned => 'ピン留め済み';
  @override
  String get memoryRecent => '最近';
  @override
  String get memoryTimeline => 'タイムライン';
  @override
  String get collectionsTitle => 'コレクション';
  @override
  String collectionItems(int count) => '$count件';
  @override
  String updatedAgo(String ago) => '$agoに更新';

  @override
  String get connectionsTitle => '連携';
  @override
  String get connectionsSubtitle =>
      'JARAがインデックスする対象を選べます。いつでも連携を解除できます。';
  @override
  String get connectionConnected => '連携済み';
  @override
  String get connectionSyncing => '同期中…';
  @override
  String get connectionDisconnected => '未連携';
  @override
  String get connectionAttention => '要確認';
  @override
  String get connectionConnect => '連携する';
  @override
  String get connectionDisconnect => '連携を解除';
  @override
  String get connectionReindex => '再インデックス';
  @override
  String lastSynced(String ago) => '$agoに同期';

  @override
  String get privacyTitle => 'プライバシーセンター';
  @override
  String get privacyLocalActive => 'ローカル処理が有効';
  @override
  String get privacyCloudOff => 'クラウドインテリジェンスがオフ';
  @override
  String get privacyCloudOn => 'クラウドインテリジェンスがオン';
  @override
  String get privacyOnDevice => 'この端末内に保存';
  @override
  String get privacyOnDeviceBody =>
      'インデックス、プレビュー、検索履歴は、すべてお使いの端末に保存されます。';
  @override
  String get privacyCloudSection => 'クラウドに送信される内容';
  @override
  String get privacyCloudBody =>
      '何も送信されません。より詳しい回答が必要な場合のみ、クラウドインテリジェンスをオンにしてください。';
  @override
  String get privacyLocalAi => 'オンデバイスAI';
  @override
  String get privacyCloudAi => 'クラウドインテリジェンス';
  @override
  String get privacyAppLock => 'アプリロック';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => '機密コンテンツの保護';
  @override
  String get privacyExport => 'データをエクスポート';
  @override
  String get privacyClearHistory => '検索履歴を削除';
  @override
  String get privacyDeleteAll => 'すべてのデータを削除';
  @override
  String get privacyDeleteConfirmTitle => 'すべて削除しますか？';
  @override
  String get privacyDeleteConfirmBody =>
      '端末上の記憶インデックスがすべて削除されます。各アプリ内の元データには影響しません。';
  @override
  String get privacyDeleted =>
      'この端末から記憶を削除しました。';
  @override
  String get cancel => 'キャンセル';
  @override
  String get confirmDelete => '削除';

  @override
  String get settingsTitle => 'プロフィール';
  @override
  String get settingsTheme => 'テーマ';
  @override
  String get settingsThemeDark => 'ダーク';
  @override
  String get settingsThemeLight => 'ライト';
  @override
  String get settingsThemeSystem => 'システム';
  @override
  String get settingsLanguage => '言語';
  @override
  String get settingsSearchSources => 'デフォルトの検索対象';
  @override
  String get settingsVoice => '音声検索';
  @override
  String get settingsStorage => 'ストレージ';
  @override
  String get settingsIndexing => 'インデックス作成';
  @override
  String get settingsNotifications => '通知';
  @override
  String get settingsConnectedAccounts => '連携済みアカウント';
  @override
  String get settingsPrivacySecurity => 'プライバシーとセキュリティ';
  @override
  String get settingsSubscription => 'サブスクリプション';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'クラウドインテリジェンス、無制限の連携、優先インデックス作成。';

  @override
  String get paywallTitle => '必要なときに、もう一歩先へ';
  @override
  String get paywallSubtitle => 'PremiumはJARAに3つの機能を加えます。検索はこれまでどおりです。';
  @override
  String get paywallFeatCloudTitle => 'クラウドインテリジェンス';
  @override
  String get paywallFeatCloudBody =>
      'クラウドを選んだときに、より詳しい回答が返ります。オンにするまではオフのままで、選ぶのはいつでもあなたです。';
  @override
  String get paywallFeatConnectionsTitle => '無制限の連携';
  @override
  String get paywallFeatConnectionsBody =>
      '無料プランでは連携できるソースの数に上限があります。Premiumなら、使っているアカウントをすべて連携できます。';
  @override
  String get paywallFeatIndexingTitle => '優先インデックス作成';
  @override
  String get paywallFeatIndexingBody =>
      '新しく保存したものから先に検索できるようになります。大きな取り込みの途中でも変わりません。';
  @override
  String get paywallMonthly => '月額';
  @override
  String get paywallYearly => '年額';
  @override
  String get paywallYearlyBadge => 'いちばんお得';
  @override
  String get paywallPriceNote => '価格はお支払いの画面で、お住まいの地域の通貨で表示されます。';
  @override
  String get paywallCta => 'Premiumをはじめる';
  @override
  String get paywallRestore => '購入を復元';
  @override
  String get paywallTerms => '利用規約';
  @override
  String get paywallSearchFree =>
      '自分の記憶を検索する機能は、ずっと無料です。すでに持っているものにPremiumが鍵をかけることはありません。';
  @override
  String get paywallNotWiredNote => '購入機能はストア版で提供予定です。';

  @override
  String get back => '戻る';
  @override
  String get moreActions => 'その他の操作';
  @override
  String get done => '完了';
  @override
  String get apply => '適用';
  @override
  String get continueCta => '続ける';
  @override
  String get searchAction => '検索';
  @override
  String get sortBy => '並べ替え';
  @override
  String get listening => '聞いています…';
  @override
  String get alwaysOn => '常時オン';
  @override
  String get clearDateFilter => '日付フィルターを解除';
  @override
  String get sectionGeneral => '一般';
  @override
  String get sectionIntelligence => 'インテリジェンス';
  @override
  String get sectionData => 'データ';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'あなたが追加';
  @override
  String get addedJustNow =>
      'たった今追加されました。JARAが検索できるようにしています。';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARAに許可が必要です',
        JaraError.fileUnreadable => 'このファイルは開けません',
        JaraError.indexingFailed => 'インデックス作成が途中で止まりました',
        JaraError.accountDisconnected => 'アカウントの再連携が必要です',
        JaraError.noConnection => 'オフラインです',
        JaraError.localModelNotReady => 'まだ準備中です',
        JaraError.storageFull => 'この端末の空き容量がありません',
        JaraError.sourceMissing => '元のデータが見つかりません',
        JaraError.generic => 'もう一度お試しください',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'このソースへのアクセスを許可すると、すぐに検索できるようになります。',
        JaraError.fileUnreadable =>
          'ファイルが破損しているか、JARAがまだ対応していない形式の可能性があります。',
        JaraError.indexingFailed =>
          '一部のアイテムを追加できませんでした。既存の記憶には影響ありません。',
        JaraError.accountDisconnected =>
          'もう一度サインインすると、このアカウントの内容を最新に保てます。',
        JaraError.noConnection =>
          '端末内の記憶は引き続き利用できます。クラウド機能は自動的に再開します。',
        JaraError.localModelNotReady =>
          '端末内検索のセットアップを完了しています。初回起動時は少し時間がかかります。',
        JaraError.storageFull =>
          '空き容量を増やすと、JARAがインデックス作成を完了できます。',
        JaraError.sourceMissing => 'このアイテムは元のアプリで移動または削除されました。',
        JaraError.generic =>
          '処理が完了しませんでした。記憶は安全です。もう一度お試しください。',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => '設定を開く',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => '再試行',
        JaraError.accountDisconnected => '再連携',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'ストレージを管理',
        JaraError.sourceMissing => '記憶から削除',
        JaraError.generic => '再試行',
      };

  @override
  String get needsConnection => '接続が必要';

  @override
  String get emptyResultsTitle => 'まだ一致する結果がありません';
  @override
  String get emptyResultsBody => '日付や検索対象、言葉を変えてみてください。';
  @override
  String get emptyResultsAdjust => 'フィルターを調整';
  @override
  String get emptyResultsSearchAll => 'すべての記憶を検索';
  @override
  String get emptyMemoryTitle => 'あなたの記憶はここから始まります';
  @override
  String get emptyMemoryBody =>
      'ファイル、スクリーンショット、リンク、メモを追加すると、JARAが検索できるようにします。';
  @override
  String get emptyMemoryCta => '最初の記憶を追加';
  @override
  String get offlineLabel => 'オフライン検索が有効です';
  @override
  String get offlineBody =>
      '端末内の記憶は引き続き利用できます。クラウド機能は自動的に再開します。';
  @override
  String get errorGenericTitle => 'もう一度お試しください';
  @override
  String get errorGenericBody =>
      '処理が完了しませんでした。記憶は安全です。もう一度お試しください。';
  @override
  String get retry => '再試行';

  @override
  String get shareTitle => 'JARAに保存';
  @override
  String get shareSaveInstantly => 'すぐに保存';
  @override
  String get shareReview => '詳細を確認';
  @override
  String get shareSaved => 'あなたの記憶に保存しました';

  @override
  String get today => '今日';
  @override
  String get tomorrow => '明日';
  @override
  String get yesterday => '昨日';
  @override
  String daysAgo(int days) => '$days日前';
  @override
  String inDays(int days) => '$days日後';
  @override
  String minutesAgo(int m) => '$m分前';
  @override
  String hoursAgo(int h) => '$h時間前';
}
