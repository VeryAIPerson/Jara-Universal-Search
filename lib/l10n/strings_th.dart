import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsTh extends JaraStrings {
  const JaraStringsTh();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'ทุกสิ่งสำคัญ ในการค้นหาเดียว';

  @override
  String get onb1Title => 'ทุกสิ่งสำคัญ\nในการค้นหาเดียว';
  @override
  String get onb1Body =>
      'ค้นหาไฟล์ รูปภาพ โน้ต และลิงก์ของคุณได้ในความทรงจำส่วนตัวเดียว';
  @override
  String get onb2Title => 'ออกแบบมาให้เป็นส่วนตัว';
  @override
  String get onb2Body =>
      'เนื้อหาของคุณจะประมวลผลบนเครื่องของคุณเองเท่าที่ทำได้ — การควบคุมอยู่ที่คุณเสมอ';
  @override
  String get onb3Title => 'บันทึกครั้งเดียว\nค้นเจอได้ตลอด';
  @override
  String get onb3Body =>
      'แชร์จากแอปไหนก็ได้มาที่ JARA แล้วค้นหาด้วยคำพูดของคุณเองในภายหลัง';
  @override
  String get onbPrimaryCta => 'สร้างความทรงจำของฉัน';
  @override
  String get onbSecondaryCta => 'สำรวจเดโม';
  @override
  String get onbSkip => 'ข้าม';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'อรุณสวัสดิ์' : 'อรุณสวัสดิ์ $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'สวัสดีตอนบ่าย' : 'สวัสดีตอนบ่าย $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'สวัสดีตอนเย็น' : 'สวัสดีตอนเย็น $name';
  @override
  String get searchTitle => 'ค้นหาทุกสิ่ง\nที่คุณบันทึกไว้';
  @override
  List<String> get searchHints => const [
        'หาเอกสารเกี่ยวกับทริปลอนดอนของฉัน',
        'แสดงภาพหน้าจอที่มีรายละเอียดการชำระเงิน',
        'ฉันบันทึกอะไรไว้เกี่ยวกับราคาของ VoxBridge',
        'หานัดหมายกับหมอของฉัน',
        'แสดงรูปที่มีหนังสือเดินทาง',
      ];
  @override
  String get filterAll => 'ทั้งหมด';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'เอกสาร',
        MemoryType.photo => 'รูปภาพ',
        MemoryType.screenshot => 'ภาพหน้าจอ',
        MemoryType.note => 'โน้ต',
        MemoryType.link => 'ลิงก์',
        MemoryType.audio => 'เสียง',
        MemoryType.calendar => 'ปฏิทิน',
        MemoryType.email => 'อีเมล',
        MemoryType.chat => 'แชท',
      };

  // Thai nouns do not inflect for number, so the plural labels are
  // identical to the singular ones by design.
  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'เอกสาร',
        MemoryType.photo => 'รูปภาพ',
        MemoryType.screenshot => 'ภาพหน้าจอ',
        MemoryType.note => 'โน้ต',
        MemoryType.link => 'ลิงก์',
        MemoryType.audio => 'เสียง',
        MemoryType.calendar => 'ปฏิทิน',
        MemoryType.email => 'อีเมล',
        MemoryType.chat => 'แชท',
      };

  @override
  String get sourcesSection => 'ความทรงจำของคุณ';
  @override
  String get recentSearches => 'ค้นหาล่าสุด';
  @override
  String get recentlySaved => 'บันทึกล่าสุด';
  @override
  String get suggestedSearches => 'ลองถามดู';
  @override
  String get seeAll => 'ดูทั้งหมด';
  @override
  String get memoryStatusTitle => 'ความทรงจำของฉัน';
  @override
  String memoryStatusItems(int items, int collections) =>
      '$items รายการ · $collections คอลเลกชัน';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'จัดทำดัชนี $ago';
  @override
  String newItemsThisWeek(int count) => '+$count สัปดาห์นี้';

  @override
  String get suggestionsHistory => 'ล่าสุด';
  @override
  String get suggestionsSmart => 'คำแนะนำ';

  @override
  String resultsCount(int count, String elapsed) =>
      '$count ผลลัพธ์ · $elapsed';
  @override
  String get bestMatch => 'ตรงที่สุด';
  @override
  String get smartSummaryTitle => 'สรุปอัจฉริยะ';
  @override
  String basedOnItems(int count) => 'อ้างอิงจาก $count รายการที่บันทึกไว้';
  @override
  String get viewSources => 'ดูแหล่งที่มา';
  @override
  String get refineSearch => 'ปรับการค้นหา';
  @override
  String get saveAnswer => 'บันทึกคำตอบ';
  @override
  String get copied => 'คัดลอกแล้ว';
  @override
  String get sortRecent => 'ล่าสุด';
  @override
  String get sortRelevance => 'ตรงที่สุด';

  @override
  String get actionOpen => 'เปิด';
  @override
  String get actionPreview => 'ดูตัวอย่าง';
  @override
  String get actionShare => 'แชร์';
  @override
  String get actionPin => 'ปักหมุด';
  @override
  String get actionUnpin => 'เลิกปักหมุด';
  @override
  String get actionAddTag => 'เพิ่มแท็ก';
  @override
  String get actionSaveToCollection => 'บันทึกลงคอลเลกชัน';
  @override
  String get actionAskAbout => 'ถามเกี่ยวกับสิ่งนี้';
  @override
  String get actionDelete => 'ลบออกจากความทรงจำ';
  @override
  String get actionOpenOriginal => 'เปิดต้นฉบับ';
  @override
  String get actionAskJara => 'ถาม JARA';

  @override
  String get detailRelated => 'สิ่งที่เกี่ยวข้อง';
  @override
  String get detailInCollection => 'คอลเลกชัน';
  @override
  String get detailTags => 'แท็ก';
  @override
  String get detailPeople => 'บุคคล';
  @override
  String get detailSource => 'แหล่งที่มา';
  @override
  String get detailAskPlaceholder => 'ถามเกี่ยวกับรายการนี้…';

  @override
  String get addTitle => 'เพิ่มไปยัง JARA';
  @override
  String get addScanDocument => 'สแกนเอกสาร';
  @override
  String get addUploadFile => 'อัปโหลดไฟล์';
  @override
  String get addPhoto => 'เพิ่มรูปภาพ';
  @override
  String get addScreenshot => 'เพิ่มภาพหน้าจอ';
  @override
  String get addVoiceNote => 'อัดบันทึกเสียง';
  @override
  String get addPasteText => 'วางข้อความ';
  @override
  String get addSaveLink => 'บันทึกลิงก์';
  @override
  String get addCreateNote => 'สร้างโน้ต';
  @override
  String get addConnectAccount => 'เชื่อมต่อบัญชี';
  @override
  String get addImportCalendar => 'นำเข้าปฏิทิน';
  @override
  String get addSuccessTitle => 'บันทึกลงความทรงจำของคุณแล้ว';
  @override
  String get addSuccessSearchNow => 'ค้นหาเลย';
  @override
  String get addSuggestedTitle => 'ชื่อที่แนะนำ';
  @override
  String get addSuggestedTags => 'แท็กที่แนะนำ';
  @override
  String get addCollection => 'คอลเลกชัน';
  @override
  String get addSaveInstantly => 'บันทึกทันที';
  @override
  String get addSave => 'บันทึก';

  @override
  String get memoryTitle => 'ความทรงจำ';
  @override
  String get memoryAll => 'ความทรงจำทั้งหมด';
  @override
  String get memoryPinned => 'ปักหมุดไว้';
  @override
  String get memoryRecent => 'ล่าสุด';
  @override
  String get memoryTimeline => 'ไทม์ไลน์';
  @override
  String get collectionsTitle => 'คอลเลกชัน';
  @override
  String collectionItems(int count) => '$count รายการ';
  @override
  String updatedAgo(String ago) => 'อัปเดต $ago';

  @override
  String get connectionsTitle => 'การเชื่อมต่อ';
  @override
  String get connectionsSubtitle =>
      'เลือกว่าจะให้ JARA จัดทำดัชนีอะไรบ้าง คุณยกเลิกการเชื่อมต่อได้ทุกเมื่อ';
  @override
  String get connectionConnected => 'เชื่อมต่อแล้ว';
  @override
  String get connectionSyncing => 'กำลังซิงค์…';
  @override
  String get connectionDisconnected => 'ยังไม่เชื่อมต่อ';
  @override
  String get connectionAttention => 'ต้องตรวจสอบ';
  @override
  String get connectionConnect => 'เชื่อมต่อ';
  @override
  String get connectionDisconnect => 'ยกเลิกการเชื่อมต่อ';
  @override
  String get connectionReindex => 'จัดทำดัชนีใหม่';
  @override
  String lastSynced(String ago) => 'ซิงค์ $ago';

  @override
  String get privacyTitle => 'ศูนย์ความเป็นส่วนตัว';
  @override
  String get privacyLocalActive => 'กำลังประมวลผลบนเครื่อง';
  @override
  String get privacyCloudOff => 'ปิดระบบอัจฉริยะบนคลาวด์';
  @override
  String get privacyCloudOn => 'เปิดระบบอัจฉริยะบนคลาวด์';
  @override
  String get privacyOnDevice => 'อยู่บนเครื่องนี้';
  @override
  String get privacyOnDeviceBody =>
      'ดัชนี ตัวอย่าง และประวัติการค้นหาของคุณถูกเก็บไว้บนเครื่องของคุณ';
  @override
  String get privacyCloudSection => 'สิ่งที่ส่งขึ้นคลาวด์';
  @override
  String get privacyCloudBody =>
      'ไม่มีเลย เว้นแต่คุณจะเปิดระบบอัจฉริยะบนคลาวด์เพื่อคำตอบที่ละเอียดขึ้น';
  @override
  String get privacyLocalAi => 'AI บนเครื่อง';
  @override
  String get privacyCloudAi => 'ระบบอัจฉริยะบนคลาวด์';
  @override
  String get privacyAppLock => 'ล็อกแอป';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'การปกป้องเนื้อหาที่ละเอียดอ่อน';
  @override
  String get privacyExport => 'ส่งออกข้อมูลของฉัน';
  @override
  String get privacyClearHistory => 'ล้างประวัติการค้นหา';
  @override
  String get privacyDeleteAll => 'ลบข้อมูลทั้งหมด';
  @override
  String get privacyDeleteConfirmTitle => 'ลบทั้งหมดไหม';
  @override
  String get privacyDeleteConfirmBody =>
      'การทำเช่นนี้จะลบดัชนีความทรงจำทั้งหมดออกจากเครื่องนี้ ไฟล์ต้นฉบับในแอปของคุณจะไม่ได้รับผลกระทบ';
  @override
  String get privacyDeleted =>
      'ลบความทรงจำออกจากอุปกรณ์นี้แล้ว';
  @override
  String get cancel => 'ยกเลิก';
  @override
  String get confirmDelete => 'ลบ';

  @override
  String get settingsTitle => 'โปรไฟล์';
  @override
  String get settingsTheme => 'ธีม';
  @override
  String get settingsThemeDark => 'มืด';
  @override
  String get settingsThemeLight => 'สว่าง';
  @override
  String get settingsThemeSystem => 'ตามระบบ';
  @override
  String get settingsLanguage => 'ภาษา';
  @override
  String get settingsSearchSources => 'แหล่งค้นหาเริ่มต้น';
  @override
  String get settingsVoice => 'ค้นหาด้วยเสียง';
  @override
  String get settingsStorage => 'พื้นที่จัดเก็บ';
  @override
  String get settingsIndexing => 'การจัดทำดัชนี';
  @override
  String get settingsNotifications => 'การแจ้งเตือน';
  @override
  String get settingsConnectedAccounts => 'บัญชีที่เชื่อมต่อ';
  @override
  String get settingsPrivacySecurity => 'ความเป็นส่วนตัวและความปลอดภัย';
  @override
  String get settingsSubscription => 'การสมัครสมาชิก';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'ระบบอัจฉริยะบนคลาวด์ การเชื่อมต่อไม่จำกัด และการจัดทำดัชนีแบบมีลำดับความสำคัญ';

  @override
  String get paywallTitle => 'เข้าถึงได้มากขึ้นเมื่อคุณต้องการ';
  @override
  String get paywallSubtitle =>
      'Premium เพิ่มสามอย่างให้ JARA ส่วนการค้นหายังคงเหมือนเดิม';
  @override
  String get paywallFeatCloudTitle => 'ระบบอัจฉริยะบนคลาวด์';
  @override
  String get paywallFeatCloudBody =>
      'คำตอบที่ละเอียดขึ้นเมื่อคุณเลือกใช้คลาวด์ ระบบจะปิดอยู่จนกว่าคุณจะเปิดเอง '
      'และการตัดสินใจเป็นของคุณเสมอ';
  @override
  String get paywallFeatConnectionsTitle => 'การเชื่อมต่อไม่จำกัด';
  @override
  String get paywallFeatConnectionsBody =>
      'แผนฟรีเชื่อมต่อแหล่งข้อมูลได้จำนวนจำกัด ส่วน Premium เชื่อมต่อได้ทุกบัญชีที่คุณใช้';
  @override
  String get paywallFeatIndexingTitle => 'การจัดทำดัชนีแบบมีลำดับความสำคัญ';
  @override
  String get paywallFeatIndexingBody =>
      'สิ่งที่บันทึกใหม่จะค้นหาได้ก่อน แม้ระหว่างที่กำลังนำเข้าข้อมูลจำนวนมาก';
  @override
  String get paywallMonthly => 'รายเดือน';
  @override
  String get paywallYearly => 'รายปี';
  @override
  String get paywallYearlyBadge => 'คุ้มค่าที่สุด';
  @override
  String get paywallPriceNote =>
      'ราคาจะแสดงตอนชำระเงิน ในสกุลเงินของภูมิภาคคุณ';
  @override
  String get paywallCta => 'เริ่มใช้ Premium';
  @override
  String get paywallRestore => 'กู้คืนการซื้อ';
  @override
  String get paywallTerms => 'ข้อกำหนด';
  @override
  String get paywallSearchFree =>
      'การค้นหาในความทรงจำของคุณเองฟรีเสมอ Premium ไม่เคยล็อกสิ่งที่คุณมีอยู่แล้ว';
  @override
  String get paywallNotWiredNote => 'การซื้อจะมาพร้อมเวอร์ชันบนสโตร์';

  @override
  String get back => 'กลับ';
  @override
  String get moreActions => 'ตัวเลือกเพิ่มเติม';
  @override
  String get done => 'เสร็จสิ้น';
  @override
  String get apply => 'ใช้';
  @override
  String get continueCta => 'ต่อไป';
  @override
  String get searchAction => 'ค้นหา';
  @override
  String get sortBy => 'เรียงตาม';
  @override
  String get listening => 'กำลังฟัง…';
  @override
  String get alwaysOn => 'เปิดตลอด';
  @override
  String get clearDateFilter => 'ล้างตัวกรองวันที่';
  @override
  String get sectionGeneral => 'ทั่วไป';
  @override
  String get sectionIntelligence => 'ความอัจฉริยะ';
  @override
  String get sectionData => 'ข้อมูล';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'คุณเพิ่มเอง';
  @override
  String get addedJustNow => 'เพิ่งเพิ่มไป — JARA กำลังทำให้ค้นหาได้';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA ต้องขออนุญาตจากคุณ',
        JaraError.fileUnreadable => 'ไฟล์นี้เปิดไม่ได้',
        JaraError.indexingFailed => 'การจัดทำดัชนีหยุดกลางคัน',
        JaraError.accountDisconnected => 'บัญชีต้องเชื่อมต่อใหม่',
        JaraError.noConnection => 'คุณออฟไลน์อยู่',
        JaraError.localModelNotReady => 'กำลังเตรียมพร้อม',
        JaraError.storageFull => 'พื้นที่บนเครื่องนี้เต็มแล้ว',
        JaraError.sourceMissing => 'ไม่พบไฟล์ต้นฉบับแล้ว',
        JaraError.generic => 'ต้องลองอีกครั้ง',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'อนุญาตให้เข้าถึงแหล่งนี้ แล้วจะค้นหาได้ทันที',
        JaraError.fileUnreadable =>
          'ไฟล์อาจเสียหาย หรืออยู่ในรูปแบบที่ JARA ยังอ่านไม่ได้',
        JaraError.indexingFailed =>
          'บางรายการยังไม่ถูกเพิ่ม ความทรงจำเดิมของคุณยังอยู่ครบ',
        JaraError.accountDisconnected =>
          'ลงชื่อเข้าใช้อีกครั้ง เพื่อให้รายการของบัญชีนี้เป็นปัจจุบัน',
        JaraError.noConnection =>
          'ความทรงจำบนเครื่องของคุณยังทำงานอยู่ ฟีเจอร์บนคลาวด์จะกลับมาเองอัตโนมัติ',
        JaraError.localModelNotReady =>
          'การค้นหาบนเครื่องกำลังตั้งค่าให้เสร็จ ครั้งแรกจะใช้เวลาสักครู่',
        JaraError.storageFull =>
          'เพิ่มพื้นที่ว่างสักหน่อย แล้ว JARA จะจัดทำดัชนีต่อจนเสร็จ',
        JaraError.sourceMissing =>
          'รายการนี้ถูกย้ายหรือลบไปจากแอปต้นทางแล้ว',
        JaraError.generic =>
          'ทำรายการไม่สำเร็จ ความทรงจำของคุณยังปลอดภัย — ลองอีกครั้ง',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'เปิดการตั้งค่า',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'ลองอีกครั้ง',
        JaraError.accountDisconnected => 'เชื่อมต่อใหม่',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'จัดการพื้นที่',
        JaraError.sourceMissing => 'นำออกจากความทรงจำ',
        JaraError.generic => 'ลองอีกครั้ง',
      };

  @override
  String get needsConnection => 'ต้องเชื่อมต่ออินเทอร์เน็ต';

  @override
  String get emptyResultsTitle => 'ยังไม่พบสิ่งที่ตรงกัน';
  @override
  String get emptyResultsBody =>
      'ลองเปลี่ยนวันที่ แหล่งที่มา หรือคำที่ใช้ค้น';
  @override
  String get emptyResultsAdjust => 'ปรับตัวกรอง';
  @override
  String get emptyResultsSearchAll => 'ค้นทั้งความทรงจำ';
  @override
  String get emptyMemoryTitle => 'ความทรงจำของคุณเริ่มต้นที่นี่';
  @override
  String get emptyMemoryBody =>
      'เพิ่มไฟล์ ภาพหน้าจอ ลิงก์ หรือโน้ต แล้ว JARA จะทำให้ค้นหาได้';
  @override
  String get emptyMemoryCta => 'เพิ่มรายการแรก';
  @override
  String get offlineLabel => 'การค้นหาแบบออฟไลน์ทำงานอยู่';
  @override
  String get offlineBody =>
      'ความทรงจำบนเครื่องของคุณยังทำงานอยู่ ฟีเจอร์บนคลาวด์จะกลับมาเองอัตโนมัติ';
  @override
  String get errorGenericTitle => 'ต้องลองอีกครั้ง';
  @override
  String get errorGenericBody =>
      'ทำรายการไม่สำเร็จ ความทรงจำของคุณยังปลอดภัย — ลองอีกครั้ง';
  @override
  String get retry => 'ลองใหม่';

  @override
  String get shareTitle => 'บันทึกลง JARA';
  @override
  String get shareSaveInstantly => 'บันทึกทันที';
  @override
  String get shareReview => 'ตรวจดูรายละเอียด';
  @override
  String get shareSaved => 'บันทึกลงความทรงจำของคุณแล้ว';

  @override
  String get today => 'วันนี้';
  @override
  String get tomorrow => 'พรุ่งนี้';
  @override
  String get yesterday => 'เมื่อวาน';
  @override
  String daysAgo(int days) => '$days วันที่แล้ว';
  @override
  String inDays(int days) => 'อีก $days วัน';
  @override
  String minutesAgo(int m) => '$m นาทีที่แล้ว';
  @override
  String hoursAgo(int h) => '$h ชั่วโมงที่แล้ว';
}
