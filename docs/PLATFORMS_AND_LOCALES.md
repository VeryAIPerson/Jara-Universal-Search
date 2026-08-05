# Platformlar ve Diller — uygulama planı

Bu belge iki gereksinimi bağlar: **her ekran ölçüsünde çalışan tek uygulama** ve **20 dilde global dağıtım**.
Karar kaydı: `DECISIONS.md` D17–D21. Token'lar: `lib/core/design/breakpoints.dart`.

---

## 1) Platform gerçeği — neyin mümkün olduğu

| Hedef | Durum | Not |
|---|---|---|
| iOS (iPhone) | ✅ kurulu | Teslim edilen tasarım |
| Android (telefon) | ✅ kurulu | |
| iPadOS | ✅ Flutter destekli | Tablet düzeni gerekiyor (aşağıda) |
| Android tablet / foldable | ✅ | Aynı düzen sistemi |
| macOS | ✅ hedef eklendi | `macos/` oluşturuldu |
| Windows | ✅ hedef eklendi | `windows/` oluşturuldu |
| Linux | ✅ hedef eklendi | Bonus; store hedefi değil |
| Web | ✅ kurulu | Tasarım demo (D11) |
| **Wear OS** (Android saat) | ✅ Flutter destekli | Ayrı, indirgenmiş kabuk gerekiyor |
| **watchOS** (Apple Watch) | ❌ **Flutter desteklemiyor** | Aşağıya bak — dürüst kısıt |

### Apple Watch kısıtı (önemli)

**Flutter watchOS'a derlenmiyor.** Bu bir yapılandırma eksiği değil, motorun desteklemediği bir platform.
Apple Watch istiyorsak tek yol **ayrı bir SwiftUI/WatchKit hedefi** yazmak ve iPhone uygulamasıyla
`WatchConnectivity` üzerinden konuşturmak. Bu, Flutter kod tabanının dışında ayrı bir mühendislik işi.

**Kararım (D18):** v1'de **Wear OS Flutter ile yapılır**, Apple Watch **v1.1'e alınır** ve
küçük bir SwiftUI companion olarak planlanır (yalnız: sesli arama → sonuç listesi → telefonda aç).
Sebep: saat, uygulamanın ana vaadini taşımaz — "kaydettiğini bul" akışının bileğe sığan kısmı
sesle arayıp sonucu telefona devretmektir. Bunu iki platformda da bu şekilde tasarlıyoruz.

---

## 2) Ekran ölçüsü sistemi

Material 3 pencere sınıflarını temel alıyoruz, altına `watch` sınıfı ekliyoruz:

| Sınıf | Genişlik | Cihaz | Navigasyon | Horizon |
|---|---|---|---|---|
| `watch` | < 320 | Wear OS | yok (tek ekran) | **yok** |
| `compact` | < 600 | telefon dikey | alt bar + merkez FAB | **yatay** (mevcut) |
| `medium` | 600–839 | küçük tablet, telefon yatay, açık foldable | ikon rayı | **dikey** |
| `expanded` | 840–1199 | tablet, yarım masaüstü pencere | ikon rayı + iki pano | **dikey** |
| `large` | ≥ 1200 | masaüstü | etiketli kenar çubuğu + iki pano | **dikey** |

### Horizon imzası ölçekte nasıl yaşar (D17)

S-kavis 390 dp dikey telefon için tasarlandı. 1440 dp masaüstünde tam genişlik bir S-kavis
düz bir çizgiye dönüşür ve marka imzası kaybolur. Çözüm: **kavis döner.**

- **Telefon:** koyu memory-sky üstte, yumuşak yüzey altta, kavis yatay. (Değişmiyor — onaylanan düzen.)
- **Tablet/masaüstü:** sky, solda **380 dp komut sütunu** olur (selamlama, arama, durum, filtreler);
  S-kavis bu sütunun sağ kenarından **dikey** akar; içerik sağdaki yüzeyde.
- **Saat:** iki yarıküre 200 dp'ye sığmaz — split tamamen kalkar, tek koyu zemin kalır.

Böylece marka aynı geometriyle her boyutta okunur; ölçeklenmiş bir telefon ekranı gibi durmaz.

### Diğer uyarlamalar

- **İki pano** (`expanded`+): solda sonuç/hafıza listesi, sağda detay. Detay artık ayrı sayfaya
  itmez; seçili kayıt sağda açılır. Telefonda push davranışı korunur.
- **Grid sütunları:** 3 (telefon) → 4 → 5 → 6 (masaüstü). Kartlar büyümez, sayıları artar.
- **Okuma genişliği:** detay/ayarlar panoları 680 dp'de sabitlenir — geniş ekranda satır uzunluğu
  değil kenar boşluğu artar.
- **Masaüstü kabuğu:** `Cmd/Ctrl+K` aramaya odaklanır, `Cmd/Ctrl+N` ekleme, `Esc` kapatır;
  hover durumları, sağ tık menüleri, minimum pencere 420×640 (altında telefon düzenine düşer).
- **Saat kabuğu:** tek ekran — büyük mikrofon, son aramalar, sonuç listesi; sonuç açılınca
  "telefonda aç". Alt bar/FAB/karo grid yok.

---

## 3) Diller — 20 pazar (D19)

Site zaten 9 dilde (EN/TR/FR/ES/DE/IT/JA/ZH/AR). Uygulama bunu 20'ye çıkarır; seçim
mobil uygulama pazarı büyüklüğü + mevcut site paritesi ile yapıldı:

| # | Dil | Kod | Neden |
|---|---|---|---|
| 1 | English | `en` | Kaynak dil |
| 2 | 简体中文 | `zh-Hans` | En büyük mobil pazar |
| 3 | Español | `es` | ~500M konuşur, LatAm + İspanya |
| 4 | العربية | `ar` | **RTL** · MENA |
| 5 | हिन्दी | `hi` | Hindistan ölçeği |
| 6 | Português (BR) | `pt-BR` | Brezilya |
| 7 | Русский | `ru` | |
| 8 | 日本語 | `ja` | Yüksek ARPU |
| 9 | Deutsch | `de` | Yüksek ARPU |
| 10 | Français | `fr` | |
| 11 | 한국어 | `ko` | Yüksek ARPU |
| 12 | Italiano | `it` | |
| 13 | Türkçe | `tr` | Ana pazar |
| 14 | Bahasa Indonesia | `id` | Büyüyen SEA |
| 15 | Tiếng Việt | `vi` | Büyüyen SEA |
| 16 | ไทย | `th` | SEA |
| 17 | Polski | `pl` | |
| 18 | Nederlands | `nl` | Yüksek ARPU |
| 19 | 繁體中文 | `zh-Hant` | Tayvan/HK App Store |
| 20 | فارسی | `fa` | **RTL** |

**İki RTL dili var** (`ar`, `fa`) — bu yalnız metin yönü değil, düzen aynalaması demektir:
S-kavis asimetrik (sol 44, sağ 86) ve RTL'de aynalanmalı; tüm `EdgeInsets` yönlü hale gelmeli.

### Teknik geçiş (D20)

Mevcut tipli Dart deck 2 dil için doğru karardı (D6) ve o karar zaten geçiş eşiğini yazmıştı:
**3+ dilde ARB'ye taşınır.** 20 dil o eşiği net aşıyor.

- `lib/l10n/app_en.arb` … ×20 + `flutter gen-l10n` (`AppLocalizations`).
- `l10n.yaml` + `pubspec` `generate: true`.
- Anahtar sayısı ~200 → 20 dil = ~4.000 dize. Diller ajanlara bölünerek çevrilir.
- **Kalite notu:** çeviriler yayına hazır kalitede üretilir ama **store lansmanından önce
  ana dil konuşuru gözden geçirmesi** önerilir; özellikle `ar/fa/hi/th` tipografi ve ton.
- Çoğul/cinsiyet: ICU `plural` sözdizimi kullanılır (`{count, plural, ...}`) — "3 items" gibi
  yerlerde İngilizce'ye özgü kurallar gömülü kalmaz.

---

## 4) Uygulama durumu (2026-08-05 — tamamlandı)

1. ✅ Masaüstü hedefleri (macos/windows/linux) + `breakpoints.dart`
2. ✅ Adaptif navigasyon: alt bar (telefon) ↔ 88dp ikon rayı (600+) ↔ 232dp
   etiketli kenar çubuğu (1200+); iki pano (840+, `/item/:id` tek rota,
   bariyersiz saydam sunum); ⌘/Ctrl+K·N·1-4·Esc; pencere başlığı + 420×640
   minimum; hover durumları (yalnız işaretçi)
3. ✅ Horizon dönüşü: eksen kararı **scaffold'un kendi genişliğinden**
   (`horizonVerticalMin` 700) — iki panolu dal telefon düzenine düşer,
   380dp sütun dar panoyu boğmaz. RTL'de kavis + tüm yönlü inset'ler
   aynalanır (dört boyutta görsel doğrulandı)
4. ✅ 20 dil: tipli deck ×20 (D20b), kayıt `lib/l10n/locales.dart`
   (endonim adlar, dil-etiketi fallback'i), 124 parite testi
5. ✅ Wear OS kabuğu (`lib/features/watch/`, `main_watch.dart`) + `wear`
   product flavour (D22)
6. ⏳ v1.1: Apple Watch SwiftUI companion (D18)

Doğrulama kanıtı: `flutter analyze` temiz · 144 test (8 golden dahil,
Linux-raster, CI Flutter 3.44.8'e sabit) · görsel turlar: 390 koyu+açık,
834 ray+dikey Horizon, 1440 kenar çubuğu+iki pano, 390/834 Arapça RTL,
gerçek tarayıcıda 1440 (0 sayfa hatası).

### Cihazda kalan QA (bu ortamda kanıtlanamayanlar — dürüst liste)

- **Gradle/flavour build:** ortamda Android SDK yok; `flutter build
  appbundle --flavor wear -t lib/main_watch.dart` ve telefon build'i ilk
  gerçek makinede koşulmalı. Dart tarafı `flutter build bundle` ile uçtan
  uca derleniyor.
- **RTL glif şekillendirme cihaz fontuyla:** test ortamında sistem fontu
  olmadığından Arapça/Farsça glifler kutu çizildi; yapısal aynalama
  doğrulandı, dizelerin bidi/şekillendirmesi L4'te UBA ile makine-doğrulandı.
  Gerçek cihazda platform fallback'i (Noto/Geeza) devrede — bir kez gözle
  doğrula.
- **D21 ana dil gözden geçirmesi** (özellikle ar/fa/hi/th) store metinleriyle
  birlikte.
