import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsKo extends JaraStrings {
  const JaraStringsKo();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => '중요한 모든 것을, 검색 한 번으로.';

  @override
  String get onb1Title => '중요한 모든 것을,\n검색 한 번으로.';
  @override
  String get onb1Body => '나만의 기억 속에서 파일, 사진, 메모, 링크를 찾아보세요.';
  @override
  String get onb2Title => '프라이버시를 기본으로';
  @override
  String get onb2Body =>
      '가능한 한 콘텐츠는 기기에서 직접 처리돼요. 제어권은 언제나 당신에게 있어요.';
  @override
  String get onb3Title => '한 번 저장하면,\n언제든 찾을 수 있어요.';
  @override
  String get onb3Body =>
      '어떤 앱에서든 JARA로 공유하면, 나중에 내 말로 다시 찾을 수 있어요.';
  @override
  String get onbPrimaryCta => '내 기억 만들기';
  @override
  String get onbSecondaryCta => '데모 둘러보기';
  @override
  String get onbSkip => '건너뛰기';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? '좋은 아침이에요' : '$name님, 좋은 아침이에요';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? '좋은 오후예요' : '$name님, 좋은 오후예요';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? '좋은 저녁이에요' : '$name님, 좋은 저녁이에요';
  @override
  String get searchTitle => '저장한 건 뭐든\n찾을 수 있어요.';
  @override
  List<String> get searchHints => const [
        '런던 여행 관련 문서 찾아줘',
        '결제 정보 있는 스크린샷 보여줘',
        'VoxBridge 요금제 관련해서 저장한 거 뭐였지?',
        '병원 예약 찾아줘',
        '여권 나온 사진 보여줘',
      ];
  @override
  String get filterAll => '전체';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => '문서',
        MemoryType.photo => '사진',
        MemoryType.screenshot => '스크린샷',
        MemoryType.note => '메모',
        MemoryType.link => '링크',
        MemoryType.audio => '오디오',
        MemoryType.calendar => '캘린더',
        MemoryType.email => '이메일',
        MemoryType.chat => '채팅',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => '문서',
        MemoryType.photo => '사진',
        MemoryType.screenshot => '스크린샷',
        MemoryType.note => '메모',
        MemoryType.link => '링크',
        MemoryType.audio => '오디오',
        MemoryType.calendar => '캘린더',
        MemoryType.email => '이메일',
        MemoryType.chat => '채팅',
      };

  @override
  String get sourcesSection => '내 기억';
  @override
  String get recentSearches => '최근 검색';
  @override
  String get recentlySaved => '최근 저장한 항목';
  @override
  String get suggestedSearches => '이렇게 물어보세요';
  @override
  String get seeAll => '전체 보기';
  @override
  String get memoryStatusTitle => '내 기억';
  @override
  String memoryStatusItems(int items, int collections) =>
      '항목 $items개 · 컬렉션 $collections개';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => '$ago 색인됨';
  @override
  String newItemsThisWeek(int count) => '이번 주 +$count개';

  @override
  String get suggestionsHistory => '최근';
  @override
  String get suggestionsSmart => '추천';

  @override
  String resultsCount(int count, String elapsed) =>
      '결과 $count개 · $elapsed';
  @override
  String get bestMatch => '베스트 매치';
  @override
  String get smartSummaryTitle => '스마트 요약';
  @override
  String basedOnItems(int count) => '저장된 항목 $count개를 기반으로';
  @override
  String get viewSources => '출처 보기';
  @override
  String get refineSearch => '검색 다듬기';
  @override
  String get saveAnswer => '답변 저장';
  @override
  String get copied => '복사됨';
  @override
  String get sortRecent => '최신순';
  @override
  String get sortRelevance => '베스트 매치';

  @override
  String get actionOpen => '열기';
  @override
  String get actionPreview => '미리보기';
  @override
  String get actionShare => '공유';
  @override
  String get actionPin => '고정';
  @override
  String get actionUnpin => '고정 해제';
  @override
  String get actionAddTag => '태그 추가';
  @override
  String get actionSaveToCollection => '컬렉션에 저장';
  @override
  String get actionAskAbout => '이것에 대해 물어보기';
  @override
  String get actionDelete => '기억에서 삭제';
  @override
  String get actionOpenOriginal => '원본 열기';
  @override
  String get actionAskJara => 'JARA에게 물어보기';

  @override
  String get detailRelated => '관련 기억';
  @override
  String get detailInCollection => '컬렉션';
  @override
  String get detailTags => '태그';
  @override
  String get detailPeople => '관련 인물';
  @override
  String get detailSource => '출처';
  @override
  String get detailAskPlaceholder => '이 기억에 대해 물어보세요…';

  @override
  String get addTitle => 'JARA에 추가';
  @override
  String get addScanDocument => '문서 스캔';
  @override
  String get addUploadFile => '파일 업로드';
  @override
  String get addPhoto => '사진 추가';
  @override
  String get addScreenshot => '스크린샷 추가';
  @override
  String get addVoiceNote => '음성 메모 녹음';
  @override
  String get addPasteText => '텍스트 붙여넣기';
  @override
  String get addSaveLink => '링크 저장';
  @override
  String get addCreateNote => '메모 작성';
  @override
  String get addConnectAccount => '계정 연결';
  @override
  String get addImportCalendar => '캘린더 가져오기';
  @override
  String get addSuccessTitle => '내 기억에 저장했어요';
  @override
  String get addSuccessSearchNow => '지금 검색하기';
  @override
  String get addSuggestedTitle => '추천 제목';
  @override
  String get addSuggestedTags => '추천 태그';
  @override
  String get addCollection => '컬렉션';
  @override
  String get addSaveInstantly => '즉시 저장';
  @override
  String get addSave => '저장';

  @override
  String get memoryTitle => '기억';
  @override
  String get memoryAll => '전체 기억';
  @override
  String get memoryPinned => '고정됨';
  @override
  String get memoryRecent => '최근';
  @override
  String get memoryTimeline => '타임라인';
  @override
  String get collectionsTitle => '컬렉션';
  @override
  String collectionItems(int count) => '항목 $count개';
  @override
  String updatedAgo(String ago) => '$ago 업데이트됨';

  @override
  String get connectionsTitle => '연결';
  @override
  String get connectionsSubtitle => 'JARA가 색인할 소스를 선택하세요. 언제든지 연결을 해제할 수 있어요.';
  @override
  String get connectionConnected => '연결됨';
  @override
  String get connectionSyncing => '동기화 중…';
  @override
  String get connectionDisconnected => '연결 안 됨';
  @override
  String get connectionAttention => '확인 필요';
  @override
  String get connectionConnect => '연결';
  @override
  String get connectionDisconnect => '연결 해제';
  @override
  String get connectionReindex => '다시 색인';
  @override
  String lastSynced(String ago) => '$ago 동기화됨';

  @override
  String get privacyTitle => '개인정보 보호 센터';
  @override
  String get privacyLocalActive => '로컬 처리 활성화됨';
  @override
  String get privacyCloudOff => '클라우드 인텔리전스 꺼짐';
  @override
  String get privacyCloudOn => '클라우드 인텔리전스 켜짐';
  @override
  String get privacyOnDevice => '이 기기에만 저장돼요';
  @override
  String get privacyOnDeviceBody => '색인, 미리보기, 검색 기록은 모두 이 기기에 저장돼요.';
  @override
  String get privacyCloudSection => '클라우드로 전송되는 항목';
  @override
  String get privacyCloudBody =>
      '아무것도 전송되지 않아요. 더 풍부한 답변을 원할 때만 클라우드 인텔리전스를 켜면 돼요.';
  @override
  String get privacyLocalAi => '온디바이스 AI';
  @override
  String get privacyCloudAi => '클라우드 인텔리전스';
  @override
  String get privacyAppLock => '앱 잠금';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => '민감한 콘텐츠 보호';
  @override
  String get privacyExport => '내 데이터 내보내기';
  @override
  String get privacyClearHistory => '검색 기록 삭제';
  @override
  String get privacyDeleteAll => '모든 데이터 삭제';
  @override
  String get privacyDeleteConfirmTitle => '전부 삭제할까요?';
  @override
  String get privacyDeleteConfirmBody =>
      '이 기기에서 기억 색인 전체가 삭제돼요. 각 앱에 있는 원본은 영향을 받지 않아요.';
  @override
  String get cancel => '취소';
  @override
  String get confirmDelete => '삭제';

  @override
  String get settingsTitle => '프로필';
  @override
  String get settingsTheme => '테마';
  @override
  String get settingsThemeDark => '다크';
  @override
  String get settingsThemeLight => '라이트';
  @override
  String get settingsThemeSystem => '시스템';
  @override
  String get settingsLanguage => '언어';
  @override
  String get settingsSearchSources => '기본 검색 소스';
  @override
  String get settingsVoice => '음성 검색';
  @override
  String get settingsStorage => '저장 공간';
  @override
  String get settingsIndexing => '색인';
  @override
  String get settingsNotifications => '알림';
  @override
  String get settingsConnectedAccounts => '연결된 계정';
  @override
  String get settingsPrivacySecurity => '개인정보 보호 및 보안';
  @override
  String get settingsSubscription => '구독';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody => '클라우드 인텔리전스, 무제한 연결, 우선 색인 처리를 제공해요.';

  @override
  String get paywallTitle => '필요할 때 더 멀리';
  @override
  String get paywallSubtitle => 'Premium은 JARA에 세 가지를 더해요. 검색은 지금 그대로예요.';
  @override
  String get paywallFeatCloudTitle => '클라우드 인텔리전스';
  @override
  String get paywallFeatCloudBody =>
      '클라우드를 선택하면 더 자세한 답을 받아요. 켜기 전까지는 꺼져 있고, 켤지 말지는 언제나 직접 정해요.';
  @override
  String get paywallFeatConnectionsTitle => '무제한 연결';
  @override
  String get paywallFeatConnectionsBody =>
      '무료 플랜에서는 연결할 수 있는 소스 수가 제한돼요. Premium에서는 사용하는 모든 계정을 연결할 수 있어요.';
  @override
  String get paywallFeatIndexingTitle => '우선 색인 처리';
  @override
  String get paywallFeatIndexingBody =>
      '새로 저장한 항목부터 먼저 검색할 수 있어요. 큰 가져오기가 진행 중일 때도 마찬가지예요.';
  @override
  String get paywallMonthly => '월간';
  @override
  String get paywallYearly => '연간';
  @override
  String get paywallYearlyBadge => '가장 알뜰한 선택';
  @override
  String get paywallPriceNote => '가격은 결제 화면에서 사용 지역의 통화로 표시돼요.';
  @override
  String get paywallCta => 'Premium 시작하기';
  @override
  String get paywallRestore => '구매 복원';
  @override
  String get paywallTerms => '약관';
  @override
  String get paywallSearchFree =>
      '내 기억을 검색하는 건 언제나 무료예요. 이미 가진 것을 Premium이 잠그는 일은 없어요.';
  @override
  String get paywallNotWiredNote => '구매 기능은 스토어 버전에서 제공돼요.';

  @override
  String get back => '뒤로';
  @override
  String get moreActions => '더보기';
  @override
  String get done => '완료';
  @override
  String get apply => '적용';
  @override
  String get continueCta => '계속';
  @override
  String get searchAction => '검색';
  @override
  String get sortBy => '정렬 기준';
  @override
  String get listening => '듣는 중…';
  @override
  String get alwaysOn => '항상 켜짐';
  @override
  String get clearDateFilter => '날짜 필터 지우기';
  @override
  String get sectionGeneral => '일반';
  @override
  String get sectionIntelligence => '인텔리전스';
  @override
  String get sectionData => '데이터';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => '직접 추가함';
  @override
  String get addedJustNow => '방금 추가됨 — JARA가 검색 가능하게 만들고 있어요.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA에 권한이 필요해요',
        JaraError.fileUnreadable => '이 파일은 열 수 없어요',
        JaraError.indexingFailed => '색인이 도중에 중단됐어요',
        JaraError.accountDisconnected => '계정을 다시 연결해야 해요',
        JaraError.noConnection => '오프라인 상태예요',
        JaraError.localModelNotReady => '아직 준비 중이에요',
        JaraError.storageFull => '기기 저장 공간이 부족해요',
        JaraError.sourceMissing => '원본을 찾을 수 없어요',
        JaraError.generic => '다시 시도해야 해요',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied => '이 소스에 대한 접근을 허용하면 바로 검색할 수 있어요.',
        JaraError.fileUnreadable =>
          '파일이 손상되었거나 JARA가 아직 지원하지 않는 형식일 수 있어요.',
        JaraError.indexingFailed => '일부 항목이 추가되지 않았어요. 기존 기억은 영향을 받지 않아요.',
        JaraError.accountDisconnected =>
          '다시 로그인하면 이 계정의 항목을 최신 상태로 유지할 수 있어요.',
        JaraError.noConnection =>
          '기기에 저장된 기억은 계속 작동해요. 클라우드 기능은 자동으로 다시 시작돼요.',
        JaraError.localModelNotReady =>
          '온디바이스 검색 설정을 마무리하는 중이에요. 처음 실행할 때는 잠시 시간이 걸려요.',
        JaraError.storageFull => '공간을 좀 확보하면 JARA가 색인을 마칠 수 있어요.',
        JaraError.sourceMissing => '이 항목은 원본 앱에서 이동되었거나 삭제됐어요.',
        JaraError.generic => '처리가 완료되지 않았어요. 기억은 안전해요 — 다시 시도해 주세요.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => '설정 열기',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => '다시 시도',
        JaraError.accountDisconnected => '다시 연결',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => '저장 공간 관리',
        JaraError.sourceMissing => '기억에서 제거',
        JaraError.generic => '다시 시도',
      };

  @override
  String get needsConnection => '연결 필요';

  @override
  String get emptyResultsTitle => '아직 일치하는 결과가 없어요';
  @override
  String get emptyResultsBody => '날짜, 소스, 검색어를 바꿔서 다시 시도해 보세요.';
  @override
  String get emptyResultsAdjust => '필터 조정';
  @override
  String get emptyResultsSearchAll => '전체 기억 검색';
  @override
  String get emptyMemoryTitle => '내 기억이 여기서 시작돼요';
  @override
  String get emptyMemoryBody =>
      '파일, 스크린샷, 링크, 메모를 추가해 보세요. JARA가 검색 가능하게 만들어 줄게요.';
  @override
  String get emptyMemoryCta => '첫 기억 추가하기';
  @override
  String get offlineLabel => '오프라인 검색이 활성화됐어요';
  @override
  String get offlineBody => '기기에 저장된 기억은 계속 작동해요. 클라우드 기능은 자동으로 다시 시작돼요.';
  @override
  String get errorGenericTitle => '다시 시도해야 해요';
  @override
  String get errorGenericBody => '처리가 완료되지 않았어요. 기억은 안전해요 — 다시 시도해 주세요.';
  @override
  String get retry => '다시 시도';

  @override
  String get shareTitle => 'JARA에 저장';
  @override
  String get shareSaveInstantly => '즉시 저장';
  @override
  String get shareReview => '세부 정보 확인';
  @override
  String get shareSaved => '내 기억에 저장했어요';

  @override
  String get today => '오늘';
  @override
  String get tomorrow => '내일';
  @override
  String get yesterday => '어제';
  @override
  String daysAgo(int days) => '$days일 전';
  @override
  String inDays(int days) => '$days일 후';
  @override
  String minutesAgo(int m) => '$m분 전';
  @override
  String hoursAgo(int h) => '$h시간 전';
}
