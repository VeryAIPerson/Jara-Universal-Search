import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsTr extends JaraStrings {
  const JaraStringsTr();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Önemli olan her şey. Tek arama.';

  @override
  String get onb1Title => 'Önemli olan her şey.\nTek arama.';
  @override
  String get onb1Body =>
      'Dosyalarını, fotoğraflarını, notlarını ve bağlantılarını tek bir kişisel hafızada bul.';
  @override
  String get onb2Title => 'Tasarımı gereği özel';
  @override
  String get onb2Body =>
      'İçeriklerin mümkün olduğunca cihazında işlenir — kontrol her zaman sende kalır.';
  @override
  String get onb3Title => 'Bir kez kaydet.\nHer zaman bul.';
  @override
  String get onb3Body =>
      'Herhangi bir uygulamadan JARA’ya paylaş; sonra kendi cümlelerinle ara.';
  @override
  String get onbPrimaryCta => 'Hafızamı Kur';
  @override
  String get onbSecondaryCta => 'Demoyu Keşfet';
  @override
  String get onbSkip => 'Geç';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Günaydın' : 'Günaydın, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'İyi günler' : 'İyi günler, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'İyi akşamlar' : 'İyi akşamlar, $name';
  @override
  String get searchTitle => 'Kaydettiğin\nher şeyi bul.';
  @override
  List<String> get searchHints => const [
        'Londra gezisiyle ilgili belgeyi bul',
        'Ödeme bilgisi içeren ekran görüntülerini göster',
        'VoxBridge fiyatlandırması için ne kaydetmiştim?',
        'Doktor randevumu bul',
        'Pasaport içeren fotoğrafları göster',
      ];
  @override
  String get filterAll => 'Tümü';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Belge',
        MemoryType.photo => 'Fotoğraf',
        MemoryType.screenshot => 'Ekran görüntüsü',
        MemoryType.note => 'Not',
        MemoryType.link => 'Bağlantı',
        MemoryType.audio => 'Ses',
        MemoryType.calendar => 'Takvim',
        MemoryType.email => 'E-posta',
        MemoryType.chat => 'Sohbet',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Belgeler',
        MemoryType.photo => 'Fotoğraflar',
        MemoryType.screenshot => 'Ekran görüntüleri',
        MemoryType.note => 'Notlar',
        MemoryType.link => 'Bağlantılar',
        MemoryType.audio => 'Sesler',
        MemoryType.calendar => 'Takvim',
        MemoryType.email => 'E-postalar',
        MemoryType.chat => 'Sohbetler',
      };

  @override
  String get sourcesSection => 'Hafızan';
  @override
  String get recentSearches => 'Son aramalar';
  @override
  String get recentlySaved => 'Son kaydedilenler';
  @override
  String get suggestedSearches => 'Şunu sor';
  @override
  String get seeAll => 'Tümünü gör';
  @override
  String get memoryStatusTitle => 'Hafızam';
  @override
  String memoryStatusItems(int items, int collections) =>
      '$items kayıt · $collections koleksiyon';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => '$ago indekslendi';
  @override
  String newItemsThisWeek(int count) => 'Bu hafta +$count';

  @override
  String get suggestionsHistory => 'Son';
  @override
  String get suggestionsSmart => 'Öneriler';

  @override
  String resultsCount(int count, String elapsed) =>
      '$count sonuç · $elapsed';
  @override
  String get bestMatch => 'En iyi eşleşme';
  @override
  String get smartSummaryTitle => 'Akıllı Özet';
  @override
  String basedOnItems(int count) => '$count kayda dayanıyor';
  @override
  String get viewSources => 'Kaynakları gör';
  @override
  String get refineSearch => 'Aramayı daralt';
  @override
  String get saveAnswer => 'Yanıtı kaydet';
  @override
  String get copied => 'Kopyalandı';
  @override
  String get sortRecent => 'En yeni';
  @override
  String get sortRelevance => 'En iyi eşleşme';

  @override
  String get actionOpen => 'Aç';
  @override
  String get actionPreview => 'Önizle';
  @override
  String get actionShare => 'Paylaş';
  @override
  String get actionPin => 'Sabitle';
  @override
  String get actionUnpin => 'Sabitlemeyi kaldır';
  @override
  String get actionAddTag => 'Etiket ekle';
  @override
  String get actionSaveToCollection => 'Koleksiyona kaydet';
  @override
  String get actionAskAbout => 'Bunu sor';
  @override
  String get actionDelete => 'Hafızadan sil';
  @override
  String get actionOpenOriginal => 'Orijinali aç';
  @override
  String get actionAskJara => 'JARA’ya sor';

  @override
  String get detailRelated => 'İlgili kayıtlar';
  @override
  String get detailInCollection => 'Koleksiyon';
  @override
  String get detailTags => 'Etiketler';
  @override
  String get detailPeople => 'Kişiler';
  @override
  String get detailSource => 'Kaynak';
  @override
  String get detailAskPlaceholder => 'Bu kayıt hakkında sor…';

  @override
  String get addTitle => 'JARA’ya Ekle';
  @override
  String get addScanDocument => 'Belge tara';
  @override
  String get addUploadFile => 'Dosya yükle';
  @override
  String get addPhoto => 'Fotoğraf ekle';
  @override
  String get addScreenshot => 'Ekran görüntüsü ekle';
  @override
  String get addVoiceNote => 'Sesli not kaydet';
  @override
  String get addPasteText => 'Metin yapıştır';
  @override
  String get addSaveLink => 'Bağlantı kaydet';
  @override
  String get addCreateNote => 'Not oluştur';
  @override
  String get addConnectAccount => 'Hesap bağla';
  @override
  String get addImportCalendar => 'Takvim aktar';
  @override
  String get addSuccessTitle => 'Hafızana kaydedildi';
  @override
  String get addSuccessSearchNow => 'Hemen ara';
  @override
  String get addSuggestedTitle => 'Önerilen başlık';
  @override
  String get addSuggestedTags => 'Önerilen etiketler';
  @override
  String get addCollection => 'Koleksiyon';
  @override
  String get addSaveInstantly => 'Anında kaydet';
  @override
  String get addSave => 'Kaydet';

  @override
  String get memoryTitle => 'Hafıza';
  @override
  String get memoryAll => 'Tüm kayıtlar';
  @override
  String get memoryPinned => 'Sabitlenenler';
  @override
  String get memoryRecent => 'Son eklenenler';
  @override
  String get memoryTimeline => 'Zaman çizgisi';
  @override
  String get collectionsTitle => 'Koleksiyonlar';
  @override
  String collectionItems(int count) => '$count kayıt';
  @override
  String updatedAgo(String ago) => '$ago güncellendi';

  @override
  String get connectionsTitle => 'Bağlantılar';
  @override
  String get connectionsSubtitle =>
      'JARA’nın neyi indeksleyeceğini sen seç. İstediğin an bağlantıyı kes.';
  @override
  String get connectionConnected => 'Bağlı';
  @override
  String get connectionSyncing => 'Eşitleniyor…';
  @override
  String get connectionDisconnected => 'Bağlı değil';
  @override
  String get connectionAttention => 'İlgi gerekiyor';
  @override
  String get connectionConnect => 'Bağla';
  @override
  String get connectionDisconnect => 'Bağlantıyı kes';
  @override
  String get connectionReindex => 'Yeniden indeksle';
  @override
  String lastSynced(String ago) => '$ago eşitlendi';

  @override
  String get privacyTitle => 'Gizlilik Merkezi';
  @override
  String get privacyLocalActive => 'Yerel İşleme Aktif';
  @override
  String get privacyCloudOff => 'Bulut Zekâsı Kapalı';
  @override
  String get privacyCloudOn => 'Bulut Zekâsı Açık';
  @override
  String get privacyOnDevice => 'Bu cihazda kalır';
  @override
  String get privacyOnDeviceBody =>
      'İndeksin, önizlemeler ve arama geçmişin cihazında saklanır.';
  @override
  String get privacyCloudSection => 'Buluta gönderilen';
  @override
  String get privacyCloudBody =>
      'Hiçbir şey — sen Bulut Zekâsı’nı açmadıkça.';
  @override
  String get privacyLocalAi => 'Cihaz içi yapay zekâ';
  @override
  String get privacyCloudAi => 'Bulut Zekâsı';
  @override
  String get privacyAppLock => 'Uygulama kilidi';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Hassas içerik koruması';
  @override
  String get privacyExport => 'Verimi dışa aktar';
  @override
  String get privacyClearHistory => 'Arama geçmişini temizle';
  @override
  String get privacyDeleteAll => 'Tüm verileri sil';
  @override
  String get privacyDeleteConfirmTitle => 'Her şey silinsin mi?';
  @override
  String get privacyDeleteConfirmBody =>
      'Bu işlem hafıza indeksini bu cihazdan kaldırır. Uygulamalarındaki orijinaller etkilenmez.';
  @override
  String get cancel => 'Vazgeç';
  @override
  String get confirmDelete => 'Sil';

  @override
  String get settingsTitle => 'Profil';
  @override
  String get settingsTheme => 'Tema';
  @override
  String get settingsThemeDark => 'Koyu';
  @override
  String get settingsThemeLight => 'Açık';
  @override
  String get settingsThemeSystem => 'Sistem';
  @override
  String get settingsLanguage => 'Dil';
  @override
  String get settingsSearchSources => 'Varsayılan arama kaynakları';
  @override
  String get settingsVoice => 'Sesli arama';
  @override
  String get settingsStorage => 'Depolama';
  @override
  String get settingsIndexing => 'İndeksleme';
  @override
  String get settingsNotifications => 'Bildirimler';
  @override
  String get settingsConnectedAccounts => 'Bağlı hesaplar';
  @override
  String get settingsPrivacySecurity => 'Gizlilik ve güvenlik';
  @override
  String get settingsSubscription => 'Abonelik';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Bulut Zekâsı, sınırsız bağlantı ve öncelikli indeksleme.';

  @override
  String get back => 'Geri';
  @override
  String get moreActions => 'Diğer işlemler';
  @override
  String get done => 'Bitti';
  @override
  String get apply => 'Uygula';
  @override
  String get continueCta => 'Devam';
  @override
  String get searchAction => 'Ara';
  @override
  String get sortBy => 'Sırala';
  @override
  String get listening => 'Dinliyor…';
  @override
  String get alwaysOn => 'Her zaman açık';
  @override
  String get clearDateFilter => 'Tarih filtresini kaldır';
  @override
  String get sectionGeneral => 'Genel';
  @override
  String get sectionIntelligence => 'Zekâ';
  @override
  String get sectionData => 'Veri';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Senin eklediğin';
  @override
  String get addedJustNow =>
      'Az önce eklendi — JARA bunu aranabilir hale getiriyor.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA’nın onayına ihtiyacı var',
        JaraError.fileUnreadable => 'Bu dosya açılmıyor',
        JaraError.indexingFailed => 'İndeksleme yarıda kaldı',
        JaraError.accountDisconnected => 'Hesabın yeniden bağlanmalı',
        JaraError.noConnection => 'Çevrimdışısın',
        JaraError.localModelNotReady => 'Hazırlık sürüyor',
        JaraError.storageFull => 'Cihazda yer kalmadı',
        JaraError.sourceMissing => 'Orijinal içerik yok',
        JaraError.generic => 'Tekrar denemek gerek',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Bu kaynağa erişime izin ver; anında aranabilir olsun.',
        JaraError.fileUnreadable =>
          'Dosya bozuk olabilir ya da JARA’nın henüz okuyamadığı bir biçimde.',
        JaraError.indexingFailed =>
          'Bazı kayıtlar eklenemedi. Mevcut hafızan olduğu gibi duruyor.',
        JaraError.accountDisconnected =>
          'Bu hesabın kayıtları güncel kalsın diye yeniden giriş yap.',
        JaraError.noConnection =>
          'Cihazındaki hafıza çalışmaya devam ediyor. Bulut özellikleri otomatik dönecek.',
        JaraError.localModelNotReady =>
          'Cihaz içi arama kurulumunu tamamlıyor. İlk açılışta biraz sürer.',
        JaraError.storageFull =>
          'Biraz yer aç; JARA indekslemeyi tamamlasın.',
        JaraError.sourceMissing =>
          'Bu kayıt kendi uygulamasında taşınmış ya da silinmiş.',
        JaraError.generic =>
          'İşlem tamamlanamadı. Hafızan güvende — yeniden dene.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Ayarları aç',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Tekrar dene',
        JaraError.accountDisconnected => 'Yeniden bağla',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Depolamayı yönet',
        JaraError.sourceMissing => 'Hafızadan kaldır',
        JaraError.generic => 'Tekrar dene',
      };

  @override
  String get needsConnection => 'Bağlantı gerekir';

  @override
  String get emptyResultsTitle => 'Henüz eşleşme yok';
  @override
  String get emptyResultsBody =>
      'Tarihi, kaynağı veya ifadeyi değiştirmeyi dene.';
  @override
  String get emptyResultsAdjust => 'Filtreleri düzenle';
  @override
  String get emptyResultsSearchAll => 'Tüm hafızada ara';
  @override
  String get emptyMemoryTitle => 'Hafızan burada başlıyor';
  @override
  String get emptyMemoryBody =>
      'Bir dosya, ekran görüntüsü, bağlantı ya da not ekle. JARA aranabilir yapsın.';
  @override
  String get emptyMemoryCta => 'İlk Kaydı Ekle';
  @override
  String get offlineLabel => 'Çevrimdışı arama aktif';
  @override
  String get offlineBody =>
      'Cihazındaki hafıza çalışmaya devam ediyor. Bulut özellikleri otomatik dönecek.';
  @override
  String get errorGenericTitle => 'Tekrar denemek gerek';
  @override
  String get errorGenericBody =>
      'İşlem tamamlanamadı. Hafızan güvende — yeniden dene.';
  @override
  String get retry => 'Tekrar dene';

  @override
  String get shareTitle => 'JARA’ya Kaydet';
  @override
  String get shareSaveInstantly => 'Anında kaydet';
  @override
  String get shareReview => 'Detayları düzenle';
  @override
  String get shareSaved => 'Hafızana kaydedildi';

  @override
  String get today => 'Bugün';
  @override
  String get tomorrow => 'Yarın';
  @override
  String get yesterday => 'Dün';
  @override
  String daysAgo(int days) => '$days g önce';
  @override
  String inDays(int days) => '$days gün sonra';
  @override
  String minutesAgo(int m) => '$m dk önce';
  @override
  String hoursAgo(int h) => '$h sa önce';
}
