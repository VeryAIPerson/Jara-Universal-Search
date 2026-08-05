import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsId extends JaraStrings {
  const JaraStringsId();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Semua yang penting. Satu pencarian.';

  @override
  String get onb1Title => 'Semua yang penting.\nSatu pencarian.';
  @override
  String get onb1Body =>
      'Temukan file, foto, catatan, dan tautanmu dalam satu memori pribadi.';
  @override
  String get onb2Title => 'Dirancang untuk privasi';
  @override
  String get onb2Body =>
      'Kontenmu diproses di perangkatmu sebisa mungkin — kendali selalu ada di tanganmu.';
  @override
  String get onb3Title => 'Simpan sekali.\nTemukan kapan saja.';
  @override
  String get onb3Body =>
      'Bagikan dari aplikasi mana pun ke JARA, lalu temukan lagi dengan kata-katamu sendiri.';
  @override
  String get onbPrimaryCta => 'Bangun Memoriku';
  @override
  String get onbSecondaryCta => 'Jelajahi Demo';
  @override
  String get onbSkip => 'Lewati';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Selamat pagi' : 'Selamat pagi, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'Selamat siang' : 'Selamat siang, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'Selamat malam' : 'Selamat malam, $name';
  @override
  String get searchTitle => 'Temukan apa pun\nyang kamu simpan.';
  @override
  List<String> get searchHints => const [
        'Cari dokumen tentang perjalananku ke London',
        'Tampilkan tangkapan layar yang ada detail pembayarannya',
        'Apa yang aku simpan soal harga VoxBridge?',
        'Cari janji temu dokterku',
        'Tampilkan foto yang ada paspornya',
      ];
  @override
  String get filterAll => 'Semua';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Dokumen',
        MemoryType.photo => 'Foto',
        MemoryType.screenshot => 'Tangkapan layar',
        MemoryType.note => 'Catatan',
        MemoryType.link => 'Tautan',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Kalender',
        MemoryType.email => 'Email',
        MemoryType.chat => 'Obrolan',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Dokumen',
        MemoryType.photo => 'Foto',
        MemoryType.screenshot => 'Tangkapan layar',
        MemoryType.note => 'Catatan',
        MemoryType.link => 'Tautan',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Kalender',
        MemoryType.email => 'Email',
        MemoryType.chat => 'Obrolan',
      };

  @override
  String get sourcesSection => 'Memorimu';
  @override
  String get recentSearches => 'Pencarian terbaru';
  @override
  String get recentlySaved => 'Baru disimpan';
  @override
  String get suggestedSearches => 'Coba tanyakan';
  @override
  String get seeAll => 'Lihat semua';
  @override
  String get memoryStatusTitle => 'Memoriku';
  @override
  String memoryStatusItems(int items, int collections) =>
      '$items item · $collections koleksi';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'Diindeks $ago';
  @override
  String newItemsThisWeek(int count) => '+$count minggu ini';

  @override
  String get suggestionsHistory => 'Terbaru';
  @override
  String get suggestionsSmart => 'Saran';

  @override
  String resultsCount(int count, String elapsed) =>
      '$count hasil · $elapsed';
  @override
  String get bestMatch => 'Paling cocok';
  @override
  String get smartSummaryTitle => 'Ringkasan Cerdas';
  @override
  String basedOnItems(int count) => 'Berdasarkan $count item tersimpan';
  @override
  String get viewSources => 'Lihat sumber';
  @override
  String get refineSearch => 'Persempit pencarian';
  @override
  String get saveAnswer => 'Simpan jawaban';
  @override
  String get copied => 'Disalin';
  @override
  String get sortRecent => 'Terbaru';
  @override
  String get sortRelevance => 'Paling cocok';

  @override
  String get actionOpen => 'Buka';
  @override
  String get actionPreview => 'Pratinjau';
  @override
  String get actionShare => 'Bagikan';
  @override
  String get actionPin => 'Sematkan';
  @override
  String get actionUnpin => 'Lepas sematan';
  @override
  String get actionAddTag => 'Tambah tag';
  @override
  String get actionSaveToCollection => 'Simpan ke koleksi';
  @override
  String get actionAskAbout => 'Tanya soal ini';
  @override
  String get actionDelete => 'Hapus dari memori';
  @override
  String get actionOpenOriginal => 'Buka file asli';
  @override
  String get actionAskJara => 'Tanya JARA';

  @override
  String get detailRelated => 'Memori terkait';
  @override
  String get detailInCollection => 'Koleksi';
  @override
  String get detailTags => 'Tag';
  @override
  String get detailPeople => 'Orang';
  @override
  String get detailSource => 'Sumber';
  @override
  String get detailAskPlaceholder => 'Tanyakan soal memori ini…';

  @override
  String get addTitle => 'Tambahkan ke JARA';
  @override
  String get addScanDocument => 'Pindai dokumen';
  @override
  String get addUploadFile => 'Unggah file';
  @override
  String get addPhoto => 'Tambah foto';
  @override
  String get addScreenshot => 'Tambah tangkapan layar';
  @override
  String get addVoiceNote => 'Rekam catatan suara';
  @override
  String get addPasteText => 'Tempel teks';
  @override
  String get addSaveLink => 'Simpan tautan';
  @override
  String get addCreateNote => 'Buat catatan';
  @override
  String get addConnectAccount => 'Hubungkan akun';
  @override
  String get addImportCalendar => 'Impor kalender';
  @override
  String get addSuccessTitle => 'Tersimpan ke memorimu';
  @override
  String get addSuccessSearchNow => 'Cari sekarang';
  @override
  String get addSuggestedTitle => 'Judul yang disarankan';
  @override
  String get addSuggestedTags => 'Tag yang disarankan';
  @override
  String get addCollection => 'Koleksi';
  @override
  String get addSaveInstantly => 'Simpan langsung';
  @override
  String get addSave => 'Simpan';

  @override
  String get memoryTitle => 'Memori';
  @override
  String get memoryAll => 'Semua memori';
  @override
  String get memoryPinned => 'Disematkan';
  @override
  String get memoryRecent => 'Terbaru';
  @override
  String get memoryTimeline => 'Linimasa';
  @override
  String get collectionsTitle => 'Koleksi';
  @override
  String collectionItems(int count) => '$count item';
  @override
  String updatedAgo(String ago) => 'Diperbarui $ago';

  @override
  String get connectionsTitle => 'Koneksi';
  @override
  String get connectionsSubtitle =>
      'Pilih apa yang boleh diindeks JARA. Kamu bisa memutuskannya kapan saja.';
  @override
  String get connectionConnected => 'Terhubung';
  @override
  String get connectionSyncing => 'Menyinkronkan…';
  @override
  String get connectionDisconnected => 'Belum terhubung';
  @override
  String get connectionAttention => 'Perlu perhatian';
  @override
  String get connectionConnect => 'Hubungkan';
  @override
  String get connectionDisconnect => 'Putuskan';
  @override
  String get connectionReindex => 'Indeks ulang';
  @override
  String lastSynced(String ago) => 'Disinkronkan $ago';

  @override
  String get privacyTitle => 'Pusat Privasi';
  @override
  String get privacyLocalActive => 'Pemrosesan Lokal Aktif';
  @override
  String get privacyCloudOff => 'Kecerdasan Cloud Nonaktif';
  @override
  String get privacyCloudOn => 'Kecerdasan Cloud Aktif';
  @override
  String get privacyOnDevice => 'Tetap di perangkat ini';
  @override
  String get privacyOnDeviceBody =>
      'Indeks, pratinjau, dan riwayat pencarianmu disimpan di perangkatmu.';
  @override
  String get privacyCloudSection => 'Dikirim ke cloud';
  @override
  String get privacyCloudBody =>
      'Tidak ada, kecuali kamu mengaktifkan Kecerdasan Cloud untuk jawaban yang lebih lengkap.';
  @override
  String get privacyLocalAi => 'AI di perangkat';
  @override
  String get privacyCloudAi => 'Kecerdasan Cloud';
  @override
  String get privacyAppLock => 'Kunci aplikasi';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Perlindungan konten sensitif';
  @override
  String get privacyExport => 'Ekspor dataku';
  @override
  String get privacyClearHistory => 'Hapus riwayat pencarian';
  @override
  String get privacyDeleteAll => 'Hapus semua data';
  @override
  String get privacyDeleteConfirmTitle => 'Hapus semuanya?';
  @override
  String get privacyDeleteConfirmBody =>
      'Ini menghapus seluruh indeks memorimu dari perangkat ini. File asli di aplikasimu tidak terpengaruh.';
  @override
  String get cancel => 'Batal';
  @override
  String get confirmDelete => 'Hapus';

  @override
  String get settingsTitle => 'Profil';
  @override
  String get settingsTheme => 'Tema';
  @override
  String get settingsThemeDark => 'Gelap';
  @override
  String get settingsThemeLight => 'Terang';
  @override
  String get settingsThemeSystem => 'Sistem';
  @override
  String get settingsLanguage => 'Bahasa';
  @override
  String get settingsSearchSources => 'Sumber pencarian default';
  @override
  String get settingsVoice => 'Pencarian suara';
  @override
  String get settingsStorage => 'Penyimpanan';
  @override
  String get settingsIndexing => 'Pengindeksan';
  @override
  String get settingsNotifications => 'Notifikasi';
  @override
  String get settingsConnectedAccounts => 'Akun terhubung';
  @override
  String get settingsPrivacySecurity => 'Privasi & keamanan';
  @override
  String get settingsSubscription => 'Langganan';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Kecerdasan Cloud, koneksi tanpa batas, dan pengindeksan prioritas.';

  @override
  String get back => 'Kembali';
  @override
  String get moreActions => 'Aksi lainnya';
  @override
  String get done => 'Selesai';
  @override
  String get apply => 'Terapkan';
  @override
  String get continueCta => 'Lanjutkan';
  @override
  String get searchAction => 'Cari';
  @override
  String get sortBy => 'Urutkan';
  @override
  String get listening => 'Mendengarkan…';
  @override
  String get alwaysOn => 'Selalu aktif';
  @override
  String get clearDateFilter => 'Hapus filter tanggal';
  @override
  String get sectionGeneral => 'Umum';
  @override
  String get sectionIntelligence => 'Kecerdasan';
  @override
  String get sectionData => 'Data';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Ditambahkan olehmu';
  @override
  String get addedJustNow =>
      'Baru saja ditambahkan — JARA sedang membuatnya bisa dicari.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA perlu izinmu',
        JaraError.fileUnreadable => 'File ini tidak bisa dibuka',
        JaraError.indexingFailed => 'Pengindeksan terhenti',
        JaraError.accountDisconnected => 'Akun perlu dihubungkan ulang',
        JaraError.noConnection => 'Kamu sedang offline',
        JaraError.localModelNotReady => 'Masih bersiap',
        JaraError.storageFull => 'Tidak ada ruang tersisa di perangkat ini',
        JaraError.sourceMissing => 'File aslinya sudah tidak ada',
        JaraError.generic => 'Perlu dicoba lagi',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Izinkan akses ke sumber ini agar bisa langsung dicari.',
        JaraError.fileUnreadable =>
          'File ini mungkin rusak atau formatnya belum bisa dibaca JARA.',
        JaraError.indexingFailed =>
          'Sebagian item gagal ditambahkan. Memorimu yang sudah ada tidak terpengaruh.',
        JaraError.accountDisconnected =>
          'Masuk lagi agar item dari akun ini tetap terbarui.',
        JaraError.noConnection =>
          'Memori di perangkatmu tetap berfungsi. Fitur cloud akan aktif lagi secara otomatis.',
        JaraError.localModelNotReady =>
          'Pencarian di perangkat sedang menyelesaikan penyiapan. Ini perlu waktu sebentar di awal.',
        JaraError.storageFull =>
          'Kosongkan sedikit ruang, lalu JARA bisa menyelesaikan pengindeksan.',
        JaraError.sourceMissing =>
          'Item ini sudah dipindahkan atau dihapus di aplikasi aslinya.',
        JaraError.generic =>
          'Prosesnya gagal. Memorimu aman — coba lagi.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Buka pengaturan',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Coba lagi',
        JaraError.accountDisconnected => 'Hubungkan ulang',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Kelola penyimpanan',
        JaraError.sourceMissing => 'Hapus dari memori',
        JaraError.generic => 'Coba lagi',
      };

  @override
  String get needsConnection => 'Perlu koneksi';

  @override
  String get emptyResultsTitle => 'Belum ada yang cocok';
  @override
  String get emptyResultsBody =>
      'Coba ubah tanggal, sumber, atau kata pencarian.';
  @override
  String get emptyResultsAdjust => 'Sesuaikan filter';
  @override
  String get emptyResultsSearchAll => 'Cari di semua memori';
  @override
  String get emptyMemoryTitle => 'Memorimu dimulai di sini';
  @override
  String get emptyMemoryBody =>
      'Tambahkan file, tangkapan layar, tautan, atau catatan. JARA akan membuatnya bisa dicari.';
  @override
  String get emptyMemoryCta => 'Tambah Memori Pertama';
  @override
  String get offlineLabel => 'Pencarian offline aktif';
  @override
  String get offlineBody =>
      'Memori di perangkatmu tetap berfungsi. Fitur cloud akan aktif lagi secara otomatis.';
  @override
  String get errorGenericTitle => 'Perlu dicoba lagi';
  @override
  String get errorGenericBody =>
      'Prosesnya gagal. Memorimu aman — coba lagi.';
  @override
  String get retry => 'Coba lagi';

  @override
  String get shareTitle => 'Simpan ke JARA';
  @override
  String get shareSaveInstantly => 'Simpan langsung';
  @override
  String get shareReview => 'Tinjau detail';
  @override
  String get shareSaved => 'Tersimpan ke memorimu';

  @override
  String get today => 'Hari ini';
  @override
  String get tomorrow => 'Besok';
  @override
  String get yesterday => 'Kemarin';
  @override
  String daysAgo(int days) => '$days hari lalu';
  @override
  String inDays(int days) => 'dalam $days hari';
  @override
  String minutesAgo(int m) => '$m menit lalu';
  @override
  String hoursAgo(int h) => '$h jam lalu';
}
