# Proje Devir Teslim Raporu — JARA Universal Search

**Tarih:** 2026-08-09 · **Durum:** v1 tamamlandı ve doğrulandı, teslime hazır
**Branch:** `claude/jara-universal-search-design-sm3l77` (iki repo'da da aynı isim)
**Repo:** `VeryAIPerson/Jara-Universal-Search` (ürün kodu) + `VeryAIPerson/jara-premium-prototype` (showcase board + şirket geneli HANDOFF.md)

Bu belge projeyi devralan herkesin (Azad dahil) sıfırdan okuyup 30 dakikada
"nerede ne var, nasıl çalıştırılır, ne bitti, ne bekliyor" sorularına cevap
bulabilmesi için yazıldı. Detay için ilgili bölümde referans verilen
`docs/*` dosyalarına in.

---

## 1) Proje nedir

**JARA Universal Search** — kullanıcının kaydettiği her şeyi (not, ekran
görüntüsü, bağlantı, sesli not, dosya) doğal dille arayan, kişisel dijital
hafıza uygulaması. Marka ailesi: JARA (sihirli lamba metaforu). Konum:
"Everything important. One search."

- **7 platform:** iOS, Android, iPadOS/tablet, macOS, Windows, Linux, Wear OS
  (+ web = yalnızca tasarım demo, D11). Apple Watch v1.1'e ertelendi (§6).
- **20 dil:** 2 RTL (Arapça, Farsça) dahil — bkz. §5.
- **Tasarım dili:** *Lamplight* — koyu "memory sky" + yumuşak neumorfik
  "surface" yarıküreleri arasında asimetrik S-kavis (*Horizon* imzası),
  merkezde Add FAB, elektrik çivit→menekşe accent, altın yalnız marka anları
  (Smart Summary mührü, pin, Premium).
- **Gizlilik duruşu:** local-only varsayılan, hybrid (bulut zekâsı) opt-in;
  arama **hiçbir zaman** paywall arkasında değil (D9).

---

## 2) Mimari özeti

| Katman | Seçim | Neden (kısaca) |
|---|---|---|
| Framework | Flutter (Dart ^3.5.0) | Tek kod tabanından 7 platform |
| State | Riverpod 2 | Şube başına state korunumu, test edilebilirlik |
| Navigasyon | GoRouter `StatefulShellRoute.indexedStack` | Alt bar/ray/kenar çubuğu arasında tek rota ağacı |
| Veri | Local-first repo arayüzü, şu an mock (`MockMemoryRepository`) | Gerçek indeksleyici/Isar-Drift'e arayüz değişmeden geçilebilir |
| Kalıcılık | `shared_preferences` (tipli `JaraPrefs` sarmalayıcı) | Tema/dil/son aramalar/pin'ler cihaz kapansa da kalır |
| Çevrimdışı algısı | `connectivity_plus` | Gerçek ağ durumu — sahte rozet yok |
| Dil sistemi | Tipli Dart deck (ARB **değil** — D20b) | Eksik anahtar derleme hatası olur; 20 dilde asıl garanti bu |
| Test | `flutter_test` + golden (byte-karşılaştırmalı) | Davranış + görsel regresyon |

Saat kabuğu ayrı giriş noktasından derlenir (`lib/main_watch.dart`), aynı
tasarım token'larını ve aynı `bootstrapThemeAndLocale` /
`bootstrapMemoryPersistence` çağrılarını paylaşır — telefonla aynı kalıcılık
sözleşmesi.

---

## 3) Klasör haritası

```
lib/
  core/design/       tokens, tema, tipografi, motion, haptics, breakpoints
  core/widgets/       Horizon scaffold, adaptif nav (bar/ray/sidebar/iki-pano),
                      arama alanı, sonuç kartları, chip'ler, boş/hata durumları
  core/models/        MemoryItem, Collection, SearchOutcome, MemoryType, …
  core/data/          mock repo (injectable clock ile), Riverpod providers,
                      prefs sarmalayıcı, connectivity servisi, share intake
  core/router/        GoRouter shell — Search·Memory·[+]·Collections·Profile
  features/<x>/       ekranlar, feature-first klasörleme:
                      add, collections, connections, detail, memory,
                      onboarding, privacy, search, settings, share, splash,
                      watch (Wear OS kabuğu)
  l10n/               strings.dart (soyut sözleşme, 173+ üye) +
                      strings_XX.dart × 20 (somut deck'ler) + locales.dart
                      (kayıt/çözümleme)
  main.dart            telefon/tablet/masaüstü giriş noktası
  main_watch.dart       Wear OS giriş noktası

test/
  golden_test.dart      8 golden PNG (4 imza ekran × 2 tema, sabit saat)
  locales_test.dart     124+ dil-parite testi (20 dil × çoğul/interpolasyon/…)
  persistence_test.dart 17 test — kalıcılık bootstrap doğrulaması
  share_intake_test.dart paylaşım payload decode testleri
  design_system_test.dart davranış + erişilebilirlik testleri

docs/
  DESIGN_BRIEF_TR.md      geliştirilmiş tasarım prompt'u (v2) + gerekçeler
  DESIGN_SYSTEM.md        mühendislik spesifikasyonu (EN)
  DECISIONS.md            ADR kaydı — D1–D24 (bkz. §7)
  AGENT_CONTRACTS.md      ekran-implementasyon sözleşmesi (paralel ajan turu)
  PLATFORMS_AND_LOCALES.md platform + dil uygulama planı ve kanıtları
  SHARE_INTAKE.md         paylaşım alımı mimarisi + cihazda kalan QA listesi
  STORE_LISTING.md        mağaza metni taslakları
  HANDOVER_TR.md          bu belge

android/                telefon + wear product flavour (D22)
ios/                     Runner + ShareExtension hedefi (Swift, App Group)
macos/ windows/ linux/   masaüstü hedefleri
web/                     tasarım demo hedefi
assets/brand/            ikon master'ları (lamp-indigo.png, app_icon_1024.png)
```

---

## 4) Platform desteği

| Platform | Durum | Not |
|---|---|---|
| iOS (iPhone) | ✅ kod tamam | Teslim edilen ana tasarım |
| Android (telefon) | ✅ kod tamam | |
| iPadOS / Android tablet | ✅ kod tamam | Dikey Horizon + iki pano (§ aşağıda) |
| macOS | ✅ hedef + kod tamam | `macos/` |
| Windows | ✅ hedef + kod tamam | `windows/` |
| Linux | ✅ hedef + kod tamam | Bonus, mağaza hedefi değil |
| Web | ✅ kod tamam | Yalnız tasarım demo (D11), store hedefi değil |
| Wear OS | ✅ kod tamam | Ayrı kabuk (`main_watch.dart`) + `wear` flavour (D22) |
| **Apple Watch** | ❌ v1.1'e ertelendi | Flutter watchOS'a derlenmiyor — motor kısıtı. Plan: ayrı SwiftUI/WatchKit hedefi, `WatchConnectivity` ile telefonla konuşur (D18) |

**Horizon imzası ölçekte (D17):** telefonda değişmeyen yatay S-kavis; tablet/
masaüstünde sol 380dp komut sütunu + dikey kavis; saatte split tamamen
kalkar. Eksen kararı **scaffold'un kendi genişliğinden** verilir
(`horizonVerticalMin = 700`), pencerenin genelinden değil — böylece dar bir
iki-pano detay sütunu geniş pencerede bile telefon düzenine düşer (gerçek
bug'dı, düzeltildi — bkz. §8).

**Masaüstü kısayolları:** `Cmd/Ctrl+K` arama odağı, `Cmd/Ctrl+N` ekleme,
`Esc` kapatma; minimum pencere 420×640 (altında telefon düzeni).

---

## 5) Diller — 20 pazar (D19)

`en, zh-Hans, zh-Hant, es, ar, hi, pt-BR, ru, ja, de, fr, ko, it, tr, id, vi,
th, pl, nl, fa` — 2'si RTL (`ar`, `fa`). Seçim kriteri: mobil pazar
büyüklüğü + mevcut sitenin 9 dilli paritesi. Tam gerekçe tablosu:
`docs/PLATFORMS_AND_LOCALES.md` §3.

**Teknik yaklaşım (D20b):** ARB/gen-l10n değil, dil başına bir Dart sınıfı
(`strings_XX.dart`, 173+ üye). Sebep: 20 dilde asıl risk eksik anahtar — ARB'de
sessizce kaynak dile düşer, tipli deck'te **derleme hatası** olur. Çoğullar
her dilin kendi gramer mantığıyla yazılı (ru/pl üç form, Arapça altı form
CLDR'ye karşı doğrulanmış, Hintçe `कल` belirsizliği D23 ile çözülmüş).

**124+ parite testi** derleyicinin göremediğini yakalar: boş dize, kaybolan
interpolasyon, çevrilmiş marka adı, sızan teknik terim (`embedding`, `vector
database`, `RAG`).

---

## 6) Kararlar kaydı (D1–D24) — özet

Tam gerekçeler `docs/DECISIONS.md`'de. **KİLİTLİ** olmayanlar:

| # | Konu | Durum |
|---|---|---|
| D5 | Inter variable font, tüm platformlarda gömülü | AÇIK — Azad görsel onayı bekliyor |
| D6 | Tipli copy deck (2 dilde alınan ilk karar) | KİLİTLİ, v1.1'de gözden geçir |
| D10 | Lansman adı önerisi: **"JARA Recall"** (şimdilik her yerde "JARA Universal Search") | ÖNERİ — Azad kararı bekliyor |
| D21 | Store lansmanından önce ana dil gözden geçirmesi (özellikle ar/fa/hi/th) | AÇIK — Azad kararı |

Geri kalan 20 karar (**KİLİTLİ**) mimariyi, tasarım sistemini, gizlilik
duruşunu, platform/dil stratejisini ve build detaylarını bağlar — değiştirmek
isteyen yeni bir ADR satırı ekler, üzerine yazmaz.

---

## 7) Kalite kapıları — bu ortamda doğrulanan

```
flutter analyze     → 0 sorun
flutter test        → 138 test yeşil (8 golden + 124 dil-parite + davranış)
node tools/check.mjs (premium repo, showcase board) → 31/31 PASS
```

Golden testler sabit saat (`DateTime(2026, 8, 15, 9, 30)`) ve gerçek gömülü
Inter + SDK MaterialIcons fontuyla üretildi (test-stub fontu Inter'den ~2×
geniş render eder, sahte overflow raporu üretir — bu tuzağa birden fazla kez
düşüldü, artık her golden/screenshot turu gerçek fontu `FontLoader` ile
yüklüyor). CI Flutter sürümü 3.44.8'e sabitlendi (goldenlerin raster motoruyla
eşleşsin diye).

**Görsel turlar (ekran görüntüsüyle doğrulandı):** 390dp koyu+açık tema,
834dp ray+dikey Horizon, 1440dp kenar çubuğu+iki pano, 390/834dp Arapça RTL,
gerçek tarayıcıda 1440dp (0 konsol hatası), paywall EN + aynalanmış AR.

---

## 8) Bu oturumda çözülen gerçek bug'lar (referans için)

Devralan biri "neden böyle yazılmış" diye sorarsa:

- **`HorizonScaffold` eksen kararı** başta `context.windowClass` (tüm
  pencere) baz alıyordu; iki-panolu detay görünümünde dar bir dal geniş
  pencerede bile 380dp dikey sütuna zorlanıyor, metin harf harf sarıyordu.
  Düzeltme: `LayoutBuilder` + `horizonVerticalMin`.
- **`result_cards.dart` meta satırı**, uzun `matchReason` ile taşıyordu
  (tablet komut sütunu kartları daraltınca ortaya çıktı) — `Expanded` +
  `Flexible`-sarmalı chip ile düzeltildi.
- **Rusça/Lehçe çoğul hatası** (gerçek, kendi parite testimle yakalandı):
  "one" gramer formu 21/31/41'e de uyduğu halde metinde `'1 ...'` sabit
  yazılmıştı → `newItemsThisWeek(41)` "+1" gösteriyordu. Tüm sayı taşıyan
  dizelerde düzeltildi.
- **`JaraSearchField`**, yalnız `hero:true` yolunda kendi `Material`
  sarmalayıcısını sağlıyordu → golden testte "No Material widget found"
  çökmesi. Her yolda sarmalayacak şekilde düzeltildi.

Tüm liste ve gerekçeler: `docs/DECISIONS.md`, `docs/PLATFORMS_AND_LOCALES.md`.

---

## 9) Nasıl çalıştırılır

```bash
flutter pub get

flutter run                                    # telefon/tablet/masaüstü, bağlı cihaz/simülatör
flutter run -d web-server --web-port 8090      # tasarım demo (D11)
flutter run -t lib/main_watch.dart             # Wear OS kabuğu

flutter analyze && flutter test                # kalite kapıları
flutter test --update-goldens                  # yalnız görsel değişiklik kasıtlıysa
```

Demo verisi `lib/core/data/mock_memory_repository.dart`'ta — arama, öneriler
ve Smart Summary gerçek davranışla çalışır ("VoxBridge tts", "london",
"passport" sorgularını dene).

---

## 10) Cihazda kalan QA — bu ortamda kanıtlanamayanlar (dürüst liste)

Bu geliştirme ortamında Android SDK / gerçek iOS-macOS makinesi yok; aşağıdaki
adımlar yalnızca gerçek cihaz/Xcode/Android Studio ile tamamlanabilir:

1. **Gradle/flavour build:** `flutter build appbundle --flavor wear -t
   lib/main_watch.dart` ve telefon build'i ilk gerçek makinede koşulmalı.
   Dart tarafı `flutter build bundle` ile uçtan uca derleniyor, sorun yok.
2. **iOS ShareExtension:** `ios/ShareExtension/ShareViewController.swift`
   yazılı ama Xcode'da hedef olarak eklenip App Group entitlement'ı
   (Runner + ShareExtension) verilmesi gerekiyor —
   `ios/Runner/Runner.entitlements` dosyası bu adımdan önce yok, Xcode
   capability eklenince oluşturuyor. Adım adım liste: `docs/SHARE_INTAKE.md`.
3. **RTL glif şekillendirme, gerçek cihaz fontuyla:** test ortamında sistem
   fontu olmadığından Arapça/Farsça glifler kutu çizildi; yapısal aynalama ve
   dizelerin bidi/şekillendirmesi doğrulandı ama gerçek cihazda (Noto/Geeza
   fallback) bir kez gözle teyit önerilir.
4. **D21 ana dil gözden geçirmesi** — özellikle ar/fa/hi/th, store metinleriyle
   birlikte (paywall'un 17 anahtarı + `privacyDeleted` dahil).
5. **Paylaşım alımının cihaz turu** — Chrome/Fotoğraflar/Notlar'dan
   soğuk+sıcak paylaşım testi. Kontrol listesi: `docs/SHARE_INTAKE.md`.

---

## 11) Azad'ın (kullanıcı) tarafında kalanlar

**Makineye bağlı adımlar** (yukarıdaki §10 ile aynı liste, kısaca):
Xcode/Android Studio'da gerçek build + ShareExtension hedefi, RTL glif son
kontrolü, cihazda paylaşım testi.

**Mağaza/iş tarafı:**
- App Store Connect + Google Play Console hesapları, bundle ID/paket adı
  kaydı, imzalama sertifikaları.
- Bölgesel fiyatlandırma — paywall kasıtlı olarak fiyat içermiyor (em-dash +
  "fiyat ödeme ekranında belirlenir" notu), global marka için uydurma fiyat
  yazılmadı.
- Mağaza ekran görüntüleri (gerçek cihazdan) + `docs/STORE_LISTING.md`
  taslağının incelenmesi.

**Açık kararlar** (yukarıdaki §6 tablosu): D5 (font görsel onayı), D10
(lansman adı — "JARA Recall" önerisi), D21 (ana dil gözden geçirmesi).

**v1.1 kapsamı:** Apple Watch SwiftUI companion (D18), gerçek STT motoru
(D12'de UI hazır, motor ayrı iş), gerçek indeksleyici/veritabanı (mock repo →
Isar/Drift, arayüz değişmeden).

---

## 12) İkinci repo: jara-premium-prototype

Bu depo şirketin genel showcase/prototip sitesi — Jara Universal Search'ün
kendisi değil. Bu proje kapsamında yalnız iki dosya eklendi:

- `_universal-search.html` — Claude Design showcase board (6 telefon
  mockup'ı, token'lar, kurallar), `node tools/check.mjs` ile 31/31 PASS
  doğrulandı.
- `HANDOFF.md` — bu repo'nun kendi genel ilerleme kaydı; Universal Search
  bölümleri bu proje ile ilgili girişleri taşıyor (repo'nun geri kalanı
  başka slotlar/projeler içeriyor, bu zip'e dahil edilmedi).

Bu iki dosya ayrı bir alt klasörde zip'e eklendi (`premium-prototype-ekler/`)
— tüm 74MB'lık şirket sitesini değil, yalnız bu projeyle ilgili kısmı.

---

## 13) Git geçmişi

İki repo da `claude/jara-universal-search-design-sm3l77` branch'inde,
origin ile senkron, çalışma ağacı temiz. Jara-Universal-Search'te 35 commit
— ilk iskeletten bu devir teslim belgesine kadar kronolojik iz.
`git log --oneline` ile tamamı okunabilir; zip'teki `.git` klasörü tam
geçmişi taşıyor.
