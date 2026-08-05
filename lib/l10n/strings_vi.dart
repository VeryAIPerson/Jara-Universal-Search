import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsVi extends JaraStrings {
  const JaraStringsVi();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Mọi thứ quan trọng. Chỉ một lần tìm kiếm.';

  @override
  String get onb1Title => 'Mọi thứ quan trọng.\nChỉ một lần tìm kiếm.';
  @override
  String get onb1Body =>
      'Tìm tệp, ảnh, ghi chú và liên kết của bạn trong một bộ nhớ cá nhân duy nhất.';
  @override
  String get onb2Title => 'Riêng tư theo thiết kế';
  @override
  String get onb2Body =>
      'Nội dung của bạn được xử lý trên thiết bị bất cứ khi nào có thể — quyền kiểm soát luôn thuộc về bạn.';
  @override
  String get onb3Title => 'Lưu một lần.\nTìm mọi lúc.';
  @override
  String get onb3Body =>
      'Chia sẻ từ bất kỳ ứng dụng nào vào JARA, rồi tìm lại bằng chính lời của bạn.';
  @override
  String get onbPrimaryCta => 'Xây dựng bộ nhớ của tôi';
  @override
  String get onbSecondaryCta => 'Khám phá bản demo';
  @override
  String get onbSkip => 'Bỏ qua';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Chào buổi sáng' : 'Chào buổi sáng, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'Chào buổi chiều' : 'Chào buổi chiều, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'Chào buổi tối' : 'Chào buổi tối, $name';
  @override
  String get searchTitle => 'Tìm mọi thứ\nbạn đã lưu.';
  @override
  List<String> get searchHints => const [
        'Tìm tài liệu về chuyến đi London của tôi',
        'Hiện ảnh chụp màn hình có thông tin thanh toán',
        'Tôi đã lưu gì về giá VoxBridge?',
        'Tìm lịch hẹn bác sĩ của tôi',
        'Hiện ảnh có hộ chiếu trong đó',
      ];
  @override
  String get filterAll => 'Tất cả';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Tài liệu',
        MemoryType.photo => 'Ảnh',
        MemoryType.screenshot => 'Ảnh chụp màn hình',
        MemoryType.note => 'Ghi chú',
        MemoryType.link => 'Liên kết',
        MemoryType.audio => 'Âm thanh',
        MemoryType.calendar => 'Lịch',
        MemoryType.email => 'Email',
        MemoryType.chat => 'Trò chuyện',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Tài liệu',
        MemoryType.photo => 'Ảnh',
        MemoryType.screenshot => 'Ảnh chụp màn hình',
        MemoryType.note => 'Ghi chú',
        MemoryType.link => 'Liên kết',
        MemoryType.audio => 'Âm thanh',
        MemoryType.calendar => 'Lịch',
        MemoryType.email => 'Email',
        MemoryType.chat => 'Trò chuyện',
      };

  @override
  String get sourcesSection => 'Bộ nhớ của bạn';
  @override
  String get recentSearches => 'Tìm kiếm gần đây';
  @override
  String get recentlySaved => 'Đã lưu gần đây';
  @override
  String get suggestedSearches => 'Thử hỏi';
  @override
  String get seeAll => 'Xem tất cả';
  @override
  String get memoryStatusTitle => 'Bộ nhớ của tôi';
  @override
  String memoryStatusItems(int items, int collections) =>
      '$items mục · $collections bộ sưu tập';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'Đã lập chỉ mục $ago';
  @override
  String newItemsThisWeek(int count) => '+$count mục tuần này';

  @override
  String get suggestionsHistory => 'Gần đây';
  @override
  String get suggestionsSmart => 'Gợi ý';

  @override
  String resultsCount(int count, String elapsed) =>
      '$count kết quả · $elapsed';
  @override
  String get bestMatch => 'Phù hợp nhất';
  @override
  String get smartSummaryTitle => 'Tóm tắt thông minh';
  @override
  String basedOnItems(int count) => 'Dựa trên $count mục đã lưu';
  @override
  String get viewSources => 'Xem nguồn';
  @override
  String get refineSearch => 'Tinh chỉnh tìm kiếm';
  @override
  String get saveAnswer => 'Lưu câu trả lời';
  @override
  String get copied => 'Đã sao chép';
  @override
  String get sortRecent => 'Mới nhất';
  @override
  String get sortRelevance => 'Phù hợp nhất';

  @override
  String get actionOpen => 'Mở';
  @override
  String get actionPreview => 'Xem trước';
  @override
  String get actionShare => 'Chia sẻ';
  @override
  String get actionPin => 'Ghim';
  @override
  String get actionUnpin => 'Bỏ ghim';
  @override
  String get actionAddTag => 'Thêm thẻ';
  @override
  String get actionSaveToCollection => 'Lưu vào bộ sưu tập';
  @override
  String get actionAskAbout => 'Hỏi về mục này';
  @override
  String get actionDelete => 'Xóa khỏi bộ nhớ';
  @override
  String get actionOpenOriginal => 'Mở bản gốc';
  @override
  String get actionAskJara => 'Hỏi JARA';

  @override
  String get detailRelated => 'Mục liên quan';
  @override
  String get detailInCollection => 'Bộ sưu tập';
  @override
  String get detailTags => 'Thẻ';
  @override
  String get detailPeople => 'Mọi người';
  @override
  String get detailSource => 'Nguồn';
  @override
  String get detailAskPlaceholder => 'Đặt câu hỏi về mục này…';

  @override
  String get addTitle => 'Thêm vào JARA';
  @override
  String get addScanDocument => 'Quét tài liệu';
  @override
  String get addUploadFile => 'Tải tệp lên';
  @override
  String get addPhoto => 'Thêm ảnh';
  @override
  String get addScreenshot => 'Thêm ảnh chụp màn hình';
  @override
  String get addVoiceNote => 'Tạo ghi chú thoại';
  @override
  String get addPasteText => 'Dán văn bản';
  @override
  String get addSaveLink => 'Lưu liên kết';
  @override
  String get addCreateNote => 'Tạo ghi chú';
  @override
  String get addConnectAccount => 'Kết nối tài khoản';
  @override
  String get addImportCalendar => 'Nhập lịch';
  @override
  String get addSuccessTitle => 'Đã lưu vào bộ nhớ của bạn';
  @override
  String get addSuccessSearchNow => 'Tìm ngay';
  @override
  String get addSuggestedTitle => 'Tiêu đề gợi ý';
  @override
  String get addSuggestedTags => 'Thẻ gợi ý';
  @override
  String get addCollection => 'Bộ sưu tập';
  @override
  String get addSaveInstantly => 'Lưu ngay lập tức';
  @override
  String get addSave => 'Lưu';

  @override
  String get memoryTitle => 'Bộ nhớ';
  @override
  String get memoryAll => 'Tất cả mục';
  @override
  String get memoryPinned => 'Đã ghim';
  @override
  String get memoryRecent => 'Gần đây';
  @override
  String get memoryTimeline => 'Dòng thời gian';
  @override
  String get collectionsTitle => 'Bộ sưu tập';
  @override
  String collectionItems(int count) => '$count mục';
  @override
  String updatedAgo(String ago) => 'Đã cập nhật $ago';

  @override
  String get connectionsTitle => 'Kết nối';
  @override
  String get connectionsSubtitle =>
      'Chọn những gì JARA có thể lập chỉ mục. Bạn có thể ngắt kết nối bất cứ lúc nào.';
  @override
  String get connectionConnected => 'Đã kết nối';
  @override
  String get connectionSyncing => 'Đang đồng bộ…';
  @override
  String get connectionDisconnected => 'Chưa kết nối';
  @override
  String get connectionAttention => 'Cần chú ý';
  @override
  String get connectionConnect => 'Kết nối';
  @override
  String get connectionDisconnect => 'Ngắt kết nối';
  @override
  String get connectionReindex => 'Lập chỉ mục lại';
  @override
  String lastSynced(String ago) => 'Đã đồng bộ $ago';

  @override
  String get privacyTitle => 'Trung tâm quyền riêng tư';
  @override
  String get privacyLocalActive => 'Đang xử lý trên thiết bị';
  @override
  String get privacyCloudOff => 'Trí tuệ đám mây đang tắt';
  @override
  String get privacyCloudOn => 'Trí tuệ đám mây đang bật';
  @override
  String get privacyOnDevice => 'Lưu trên thiết bị này';
  @override
  String get privacyOnDeviceBody =>
      'Chỉ mục, bản xem trước và lịch sử tìm kiếm của bạn được lưu trên thiết bị.';
  @override
  String get privacyCloudSection => 'Gửi lên đám mây';
  @override
  String get privacyCloudBody =>
      'Không có gì, trừ khi bạn bật Trí tuệ đám mây để có câu trả lời đầy đủ hơn.';
  @override
  String get privacyLocalAi => 'AI trên thiết bị';
  @override
  String get privacyCloudAi => 'Trí tuệ đám mây';
  @override
  String get privacyAppLock => 'Khóa ứng dụng';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Bảo vệ nội dung nhạy cảm';
  @override
  String get privacyExport => 'Xuất dữ liệu của tôi';
  @override
  String get privacyClearHistory => 'Xóa lịch sử tìm kiếm';
  @override
  String get privacyDeleteAll => 'Xóa toàn bộ dữ liệu';
  @override
  String get privacyDeleteConfirmTitle => 'Xóa tất cả?';
  @override
  String get privacyDeleteConfirmBody =>
      'Xóa toàn bộ chỉ mục bộ nhớ khỏi thiết bị này. Các bản gốc trong ứng dụng của bạn không bị ảnh hưởng.';
  @override
  String get cancel => 'Hủy';
  @override
  String get confirmDelete => 'Xóa';

  @override
  String get settingsTitle => 'Hồ sơ';
  @override
  String get settingsTheme => 'Giao diện';
  @override
  String get settingsThemeDark => 'Tối';
  @override
  String get settingsThemeLight => 'Sáng';
  @override
  String get settingsThemeSystem => 'Hệ thống';
  @override
  String get settingsLanguage => 'Ngôn ngữ';
  @override
  String get settingsSearchSources => 'Nguồn tìm kiếm mặc định';
  @override
  String get settingsVoice => 'Tìm kiếm bằng giọng nói';
  @override
  String get settingsStorage => 'Dung lượng lưu trữ';
  @override
  String get settingsIndexing => 'Lập chỉ mục';
  @override
  String get settingsNotifications => 'Thông báo';
  @override
  String get settingsConnectedAccounts => 'Tài khoản đã kết nối';
  @override
  String get settingsPrivacySecurity => 'Quyền riêng tư & bảo mật';
  @override
  String get settingsSubscription => 'Gói đăng ký';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Trí tuệ đám mây, kết nối không giới hạn và lập chỉ mục ưu tiên.';

  @override
  String get paywallTitle => 'Vươn xa hơn khi bạn cần';
  @override
  String get paywallSubtitle =>
      'Premium bổ sung ba điều cho JARA. Việc tìm kiếm vẫn giữ nguyên như '
      'cũ.';
  @override
  String get paywallFeatCloudTitle => 'Trí tuệ đám mây';
  @override
  String get paywallFeatCloudBody =>
      'Câu trả lời đầy đủ hơn khi bạn chọn đám mây. Tính năng này tắt cho '
      'đến khi bạn bật, và quyền quyết định luôn thuộc về bạn.';
  @override
  String get paywallFeatConnectionsTitle => 'Kết nối không giới hạn';
  @override
  String get paywallFeatConnectionsBody =>
      'Gói miễn phí giữ kết nối một số nguồn nhất định. Premium kết nối mọi '
      'tài khoản bạn dùng.';
  @override
  String get paywallFeatIndexingTitle => 'Lập chỉ mục ưu tiên';
  @override
  String get paywallFeatIndexingBody =>
      'Những gì vừa lưu sẽ tìm kiếm được trước, ngay cả khi một lần nhập lớn '
      'đang chạy.';
  @override
  String get paywallMonthly => 'Hằng tháng';
  @override
  String get paywallYearly => 'Hằng năm';
  @override
  String get paywallYearlyBadge => 'Đáng giá nhất';
  @override
  String get paywallPriceNote =>
      'Giá hiển thị khi thanh toán, theo đơn vị tiền tệ của khu vực bạn.';
  @override
  String get paywallCta => 'Bắt đầu với Premium';
  @override
  String get paywallRestore => 'Khôi phục giao dịch mua';
  @override
  String get paywallTerms => 'Điều khoản';
  @override
  String get paywallSearchFree =>
      'Tìm trong bộ nhớ của riêng bạn luôn miễn phí. Premium không bao giờ '
      'khóa những gì bạn đã có.';
  @override
  String get paywallNotWiredNote =>
      'Tính năng mua sẽ có trong bản phát hành trên cửa hàng.';

  @override
  String get back => 'Quay lại';
  @override
  String get moreActions => 'Thao tác khác';
  @override
  String get done => 'Xong';
  @override
  String get apply => 'Áp dụng';
  @override
  String get continueCta => 'Tiếp tục';
  @override
  String get searchAction => 'Tìm kiếm';
  @override
  String get sortBy => 'Sắp xếp theo';
  @override
  String get listening => 'Đang nghe…';
  @override
  String get alwaysOn => 'Luôn bật';
  @override
  String get clearDateFilter => 'Xóa bộ lọc ngày';
  @override
  String get sectionGeneral => 'Chung';
  @override
  String get sectionIntelligence => 'Trí tuệ';
  @override
  String get sectionData => 'Dữ liệu';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Do bạn thêm vào';
  @override
  String get addedJustNow =>
      'Vừa mới thêm — JARA đang làm cho mục này có thể tìm kiếm được.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA cần bạn cho phép',
        JaraError.fileUnreadable => 'Không thể mở tệp này',
        JaraError.indexingFailed => 'Quá trình lập chỉ mục bị dừng giữa chừng',
        JaraError.accountDisconnected => 'Tài khoản cần kết nối lại',
        JaraError.noConnection => 'Bạn đang ngoại tuyến',
        JaraError.localModelNotReady => 'Vẫn đang chuẩn bị',
        JaraError.storageFull => 'Thiết bị đã hết dung lượng',
        JaraError.sourceMissing => 'Bản gốc không còn tồn tại',
        JaraError.generic => 'Cần thử lại',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Cho phép truy cập vào nguồn này để nội dung có thể tìm kiếm được ngay.',
        JaraError.fileUnreadable =>
          'Tệp có thể bị hỏng hoặc ở định dạng mà JARA chưa đọc được.',
        JaraError.indexingFailed =>
          'Một số mục chưa được thêm vào. Bộ nhớ hiện có của bạn không bị ảnh hưởng.',
        JaraError.accountDisconnected =>
          'Đăng nhập lại để các mục từ tài khoản này luôn được cập nhật.',
        JaraError.noConnection =>
          'Bộ nhớ trên thiết bị vẫn hoạt động bình thường. Các tính năng đám mây sẽ tự động khôi phục.',
        JaraError.localModelNotReady =>
          'Tìm kiếm trên thiết bị đang hoàn tất thiết lập. Việc này mất chút thời gian ở lần chạy đầu.',
        JaraError.storageFull =>
          'Giải phóng bớt dung lượng để JARA có thể hoàn tất việc lập chỉ mục.',
        JaraError.sourceMissing =>
          'Mục này đã bị di chuyển hoặc xóa trong ứng dụng gốc.',
        JaraError.generic =>
          'Thao tác chưa thành công. Bộ nhớ của bạn vẫn an toàn — hãy thử lại.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Mở cài đặt',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Thử lại',
        JaraError.accountDisconnected => 'Kết nối lại',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Quản lý dung lượng',
        JaraError.sourceMissing => 'Gỡ khỏi bộ nhớ',
        JaraError.generic => 'Thử lại',
      };

  @override
  String get needsConnection => 'Cần kết nối';

  @override
  String get emptyResultsTitle => 'Chưa có kết quả phù hợp';
  @override
  String get emptyResultsBody =>
      'Hãy thử đổi ngày, nguồn hoặc cách diễn đạt.';
  @override
  String get emptyResultsAdjust => 'Điều chỉnh bộ lọc';
  @override
  String get emptyResultsSearchAll => 'Tìm trong tất cả bộ nhớ';
  @override
  String get emptyMemoryTitle => 'Bộ nhớ của bạn bắt đầu từ đây';
  @override
  String get emptyMemoryBody =>
      'Thêm tệp, ảnh chụp màn hình, liên kết hoặc ghi chú — JARA sẽ làm nó có thể tìm kiếm được.';
  @override
  String get emptyMemoryCta => 'Thêm mục đầu tiên';
  @override
  String get offlineLabel => 'Tìm kiếm ngoại tuyến đang hoạt động';
  @override
  String get offlineBody =>
      'Bộ nhớ trên thiết bị vẫn hoạt động bình thường. Các tính năng đám mây sẽ tự động khôi phục.';
  @override
  String get errorGenericTitle => 'Cần thử lại';
  @override
  String get errorGenericBody =>
      'Thao tác chưa thành công. Bộ nhớ của bạn vẫn an toàn — hãy thử lại.';
  @override
  String get retry => 'Thử lại';

  @override
  String get shareTitle => 'Lưu vào JARA';
  @override
  String get shareSaveInstantly => 'Lưu ngay lập tức';
  @override
  String get shareReview => 'Xem lại chi tiết';
  @override
  String get shareSaved => 'Đã lưu vào bộ nhớ của bạn';

  @override
  String get today => 'Hôm nay';
  @override
  String get tomorrow => 'Ngày mai';
  @override
  String get yesterday => 'Hôm qua';
  @override
  String daysAgo(int days) => '$days ngày trước';
  @override
  String inDays(int days) => 'trong $days ngày';
  @override
  String minutesAgo(int m) => '$m phút trước';
  @override
  String hoursAgo(int h) => '$h giờ trước';
}
