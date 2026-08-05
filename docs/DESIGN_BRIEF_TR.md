# JARA Universal Search — Tasarım Brief'i v2 (Geliştirilmiş Prompt)

> Orijinal prompt'un eksik/geliştirilebilir noktaları kapatılmış hali.
> Referans UI kompozisyonu (koyu/açık bölünmüş ekran + S-kavis + neumorfik karo grid + merkez dairesel FAB) yapısal imza olarak entegre edildi; JARA marka standardına (lamba, altın wordmark, ürün-accent sistemi) bağlandı.
> Kod tarafındaki tek doğruluk kaynağı: `lib/core/design/` (token'lar) ve `docs/DESIGN_SYSTEM.md`.

---

## 0) v1 → v2 değişiklik listesi (neden güncellendi)

| # | v1'deki boşluk | v2 çözümü |
|---|---|---|
| 1 | Somut bir **layout imzası** yoktu; "benzersiz" isteniyordu ama yapı tarif edilmemişti | Referans kompozisyondan **Horizon düzeni**: koyu "memory sky" + açık "surface" yarıküreleri, aralarında asimetrik S-kavis. Uygulamanın her ana ekranı bu imzayı taşır |
| 2 | Açık tema tarif edilmemişti (yalnız "koyu öncelikli") | Açık tema = referansın kendisi (lavanta-sis neumorfik zemin + koyu sky paneli). Koyu tema = iki tonlu koyu (sky `#0D1220→#080A0F`, surface `#11141C`) |
| 3 | JARA marka ailesiyle bağ kurulmamıştı (lamba, altın wordmark, ürün-renk sistemi) | Accent = **elektrik çivit `#5B7CFA` → menekşe `#836BFF`** (aile deseninde Universal Search'ün rengi). Altın yalnız marka anları: wordmark, Smart Summary mührü, pin, premium. Lamba `assets/brand/lamp.png` |
| 4 | Renkler hex listesiydi, uygulanabilir token değildi | Semantik token seti (`JaraTokens` ThemeExtension): `skyTop/skyBottom`, `surface/tile`, `textOnSky*`, `accent/violet/gold`, neu-gölge çiftleri. Kod = kaynak |
| 5 | Mikro animasyonlar listelenmişti ama **süre/eğri sistemi** yoktu | Motion token'ları: 80/120/200/320/480 ms; `easeOutCubic` standart, `easeOutQuart` giriş, sonuç stagger 40 ms/kart; `Reduce Motion`'da sıfırlanır |
| 6 | Haptik dağınıktı | Haptik haritası: tap=light, chip/gün seçimi=selection, kaydet/pin=medium, silme onayı=heavy |
| 7 | "Share Sheet akışı" UI olarak vardı, **teknik gerçeklik** yoktu | iOS Share Extension + Android `ACTION_SEND` intent filtresi, App Shortcuts/Spotlight donation notları (§14) |
| 8 | Arama gecikme bütçesi yoktu | Bütçe: öneri <50 ms (yerel), ilk sonuç boyaması <300 ms, Smart Summary ayrı akışta gelir (sonuçları asla bekletmez, shimmer'lı) |
| 9 | Gizlilik "ekran" olarak vardı, **ürün kademesi** olarak yoktu | İki kademe: **Local-only** (varsayılan) / **Hybrid** (Cloud Intelligence opt-in). Sky başlığında kalıcı `Local Processing Active` pill'i |
| 10 | Monetizasyon/lansman gereksinimi yoktu | JARA Premium: Cloud Intelligence + sınırsız bağlantı + öncelikli indeksleme. Paywall yalnız Settings > Subscription ve cloud özellik kapılarında; arama asla paywall arkasına konmaz |
| 11 | Navigasyon "maks 4 sekme" idi ama merkez aksiyonla çelişebiliyordu | Karar: **Search · Memory · [+ FAB] · Collections · Profile** — 4 sekme + merkez FAB (referansın 2+FAB dengesinin 4'lü hali). Add bir sekme değil, yükseltilmiş eylem |
| 12 | Kopya deck yoktu | Tüm ekran metinleri EN+TR, kod içinde tipli (`lib/l10n/`); ürün sesi kuralları §13 |
| 13 | Boş/hata/çevrimdışı durumları dağınık listeydi | Tek durum sistemi: `EmptyStateView`/`ErrorStateView`/`OfflineBanner` bileşen sözleşmeleri + metinleri |
| 14 | Widget listesi vardı ama **API sözleşmesi** yoktu | `docs/AGENT_CONTRACTS.md`: her widget'ın constructor imzası; ekranlar yalnız bu API'lerle kurulur |
| 15 | Erişilebilirlik hedefti, **doğrulanabilir çift listesi** yoktu | Kontrast çiftleri tablo halinde (§12); dokunma ≥44 pt; `Semantics` etiketi zorunluluğu bileşen sözleşmesinde |
| 16 | Analitik/izleme kararı yoktu | Aile kuralı devam: **üçüncü taraf tracker yok**. Yalnız cihaz-içi, opt-in, anonim ürün telemetrisi (v1.1'de, ayrı karar) |
| 17 | MVP/v1.1 ayrımı ekran listesiydi | §16: davranış bazlı ayrım (ör. sesli arama UI'ı MVP'de, gerçek STT v1.1) |

---

## 1) Ürün tanımı ve mesaj

**JARA Universal Search** — kullanıcının izin verdiği ve eklediği kişisel içerikleri tek merkezden doğal dille bulduran **kişisel arama işletim sistemi**. Chatbot değil; sonuç ekranına en az dokunuşla ulaştıran bir araç.

Doğru vaat: **"Önemli dosyalarını, fotoğraflarını, notlarını, bağlantılarını ve bağlı hesaplarını tek bir özel arama merkezinde bul."**
Yasak vaat: "Telefonundaki her şeyi tararız." (iOS sandbox gerçeği: WhatsApp/iMessage/Safari geçmişi taranamaz — onboarding ve pazarlama metinleri buna göre yazıldı.)

Kaynaklar: PDF/belge, ekran görüntüsü, fotoğraf, sesli not, JARA sohbetleri, notlar, takvim, hatırlatıcılar, kayıtlı linkler, Share Sheet gelenleri, Gmail/Outlook (opt-in), kişiler/proje kayıtları.

## 2) Görsel kimlik — "Lamplight" tasarım dili

Marka karakteri: akıllı, sessiz, hızlı, güvenli, kişisel, premium.

**Yapısal imza (referanstan):**
- **Horizon düzeni** — her ana ekran iki yarıküre: üstte koyu **memory sky** (komut alanı: selamlama, arama, durum), altta yumuşak **surface** (içerik: karo grid, kartlar). Aralarında asimetrik S-kavis (`JaraWaveClipper`, sol düşüş 44, sağ düşüş 86). Memory ekranı bu düzeni **ters çevirir** (surface üstte, sky + timeline altta) — referanstaki ikinci kompozisyon.
- **Çentikli üst bar** — solda durum aksiyonu (gizlilik pill'i/sync), ortada çentikte asılı avatar, sağda ayarlar.
- **Neumorfik karo grid** — kaynak karoları (Belgeler, Fotoğraflar…): çift yönlü yumuşak gölge, renkli ikon rozeti, etiket + küçük meta (".pdf", "128 kayıt").
- **Merkez dairesel FAB** — Add to JARA; indeksleme sırasında dönen sync'e, başarıda altın halkaya morph olur.
- **Timeline rail** — dikey gün kolonları, seçili gün accent gradient + "15 AUG" (zamanla geri çağırma).
- **MyMemory kartı** — referansın "MyDocs" kartının karşılığı: toplam kayıt, koleksiyon, indeks progress, boş alan, son indeksleme.

**Renk:** koyu öncelikli. Sky her iki temada koyu kalır — split imzası temadan bağımsız yaşar. Accent çivit→menekşe gradient; altın kutsal (marka anları). Neon/kripto görünümü yasak: accent geniş yüzeyde değil, ışık vurgusu olarak kullanılır.

**Tipografi:** Inter variable (gömülü, `wght` ekseni ile). Display 34/700 −0.5 · Title1 28/700 · Title2 22/600 · Headline 17/600 · Body 16/400 · Callout 15/500 · Footnote 13 · Caption/Label 11. Wordmark asla font ile yazılmaz (aile kuralı) — SVG path varlığı kullanılır.

## 3) Bilgi mimarisi ve navigasyon

```
Splash → (ilk açılış) Onboarding ×3 → Shell
Shell:  Search(ana) · Memory · [+ Add FAB] · Collections · Profile
Search → Suggestions(yazarken) → Results → Result Detail → orijinal
Add FAB → Add sheet → (analiz) → Success → "Search it now"
Profile → Connections · Privacy Center · Settings alt sayfaları
Share Sheet (OS) → Share Capture ekranı → 2 dokunuşta kayıt
```

Karar gerekçesi: Collections ayrı sekme çünkü "raflar" (küratörlü) ile "hafıza" (her şey + zaman) farklı zihinsel modeller; Memory karmaşıklaşmaz, referansın grid ekranı Collections'a birebir oturur.

## 4–11) Ekran spesifikasyonları

Ekran-ekran bileşen listesi, durumlar ve metinler `docs/DESIGN_SYSTEM.md` + `lib/features/` içinde yaşar. Kritik kararlar:

- **Search home:** sky'da selamlama (saat bazlı) + `searchTitle` display + JaraSearchField (dönüşümlü 5 placeholder, sesli arama, filtre) + MyMemory kartı; surface'te kaynak karoları 3×2, son aramalar, son kaydedilenler. Chatbot hissi yasak — arama alanı komut merkezi, konuşma balonu yok.
- **Suggestions:** yazarken <50 ms'de yerel öneri (geçmiş, tamamlama, dosya, tür); tek dokunuş = arama.
- **Results:** üstte sorgu + "N sonuç · 0.2 sn" + filtre çipleri; Smart Summary opsiyonel kart (altın mühür, "Based on N saved items", kaynaklara dokunulabilir; sonuçları asla geciktirmez); gruplu sonuçlar (Best match önce), kartlar 40 ms stagger ile girer.
- **Result detail:** önizleme, kaynak/tarih/etiket/kişi/koleksiyon, ilgili kayıtlar, "bu içerik hakkında sor" alanı; alt aksiyon barı (Open original · Share · Pin · Ask JARA).
- **Add:** 10 kaynak tipi grid; ekleme sonrası otomatik başlık/etiket/koleksiyon önerisi düzenlenebilir; başarıda "Saved to your memory" + ışık halkası + Search it now.
- **Memory:** ters Horizon; üstte segmentler (All/Pinned/Recent/Timeline) + kayıt listesi, altta sky içinde TimelineRail + istatistik.
- **Collections:** referans grid'i — kapak renkli neumorfik kartlar, kayıt sayısı, tür ikonları, hızlı arama.
- **Connections:** servis kartları (durum, son sync, izin seviyesi, Disconnect/Re-index); korkutucu değil, sahiplik dili: "Neyi indeksleyeceğini sen seç."
- **Privacy Center:** cihazda kalan / buluta giden iki blok; Local AI / Cloud AI anahtarları; app lock, biometrik, export, delete-all (çift onay + heavy haptic). Tepede büyük durum: `Local Processing Active` ya da `Cloud Intelligence On`.
- **Profile/Settings:** tema, dil (EN/TR), kaynaklar, depolama, bildirim, abonelik (Premium kartı — altın, tek yer).

## 12) Erişilebilirlik (doğrulanabilir)

- Kontrast çiftleri: `#F5F7FF/#080A0F` 17.9:1 · `#A6ADBE/#11141C` 7.4:1 · `#171B2C/#E9ECF5` 13.7:1 · beyaz/`#5B7CFA` 4.6:1 (buton metni) — hepsi AA+.
- Dokunma ≥44 pt (`JaraSize.touchMin`); tüm interaktifler `Semantics` etiketli (bileşen sözleşmesinde zorunlu); Dynamic Type: metinler `Text` scale'e açık, kart yükseklikleri esnek; Reduce Motion: `JaraMotion.of()` tüm animasyonları sıfırlar; durum yalnız renkle anlatılmaz (ikon+metin, ör. bağlantı durumları).

## 13) Ürün sesi

Kısa, sakin, birinci tekil sahiplik ("your memory"). Teknik AI terimleri yasak: embedding/vektör/RAG/index-shard kullanıcı yüzeyinde geçmez ("indeksleme" tek istisna — depolama bağlamında). Hata metinleri suçlamaz, yol gösterir. Örnek deck `lib/l10n/strings_en.dart` + `strings_tr.dart`.

## 14) Platform notları (mühendislik köprüsü)

- **iOS:** Share Extension (küçük native hedef → App Group üzerinden kuyruk), Spotlight `CSSearchableItem` donation (JARA kayıtları sistem aramasında da görünsün), Siri Shortcuts "Search JARA", izinler bağlamsal (`PHPickerViewController` tam kütüphane izni istemez).
- **Android:** `ACTION_SEND`/`ACTION_SEND_MULTIPLE` intent filtresi, App Shortcuts, `WorkManager` ile arka plan indeksleme.
- **Flutter:** Material 3 + `JaraTokens` ThemeExtension; Cupertino sayfa geçişi iOS'ta; Riverpod 2 + GoRouter `StatefulShellRoute`; local-first repo arayüzü (mock → Isar/Drift + platform kanalları).

## 15) Lansman kalite kapıları

1. `flutter analyze` temiz · 2. Widget testleri: arama akışı + pin + tema değişimi · 3. Golden testler: 4 imza ekran ×2 tema · 4. TR/EN dil paritesi (tipli deck derleyici garantisi) · 5. a11y denetimi (VoiceOver/TalkBack turu) · 6. Store varlıkları: ikon (lamba, statik — aile kuralı), ekran görüntüleri Horizon imzasını gösterir · 7. Gizlilik beyanı: App Privacy "Data Not Collected" (local-only varsayılanla).

## 16) MVP → v1.1

**MVP (bu repo):** Splash, Onboarding, Search home/Suggestions/Results, Smart Summary (mock akıl), Result Detail, Add (mock analiz), Share Capture ekranı, Memory, Collections, Connections, Privacy, Settings; EN/TR; koyu+açık tema; mock local-first veri.
**v1.1:** gerçek on-device index (Isar + OCR/STT), Share Extension/intent kablolama, gerçek STT sesli arama, Cloud Intelligence (opt-in) + Premium paywall, Spotlight/Shortcuts donation, telemetri kararı, tablet düzeni.

### 16.1 Cila turu (2026-08-05) — denetimde bulunan ve kapatılan boşluklar

İlk teslimden sonra yapılan doğrulama turu 11 gerçek boşluk buldu (spekülasyon değil; kod taraması + açık tema görsel doğrulaması ile). Hepsi kapatıldı:

| Bulgu | Neydi | Karar |
|---|---|---|
| Çevrimdışı modu ölü | `OfflineBanner`+`offlineProvider` 0 ekranda kullanılıyordu; §16 vaadi karşılıksızdı | `connectivity_plus` ile gerçek bağlantı durumu; iki arama ekranında banner; bulut-özel yüzeyler işaretli (D13) |
| FAB indeksleme morph'u ölü | `JaraFabState.indexing/success` hiç tetiklenmiyordu; "Re-index" sessizdi | Shell `indexStateProvider`'ı dinler; başarıda kısa altın halka |
| Onboarding her açılışta | Kalıcılık katmanı yoktu | `shared_preferences` + `prefs.dart`; splash dallanır (D13) |
| TR paritesi eksik | 14 benzersiz İngilizce literal (26 kullanım) deck dışındaydı | Hepsi tipli deck'e taşındı; parite derleyici garantili |
| Hata durumları | 9 senaryodan yalnız 1'i vardı | `JaraError` kataloğu + `ErrorStateView` (D14) |
| Dokunma hedefleri | Pin ikonu, `NeuIconButton(38)`, `JaraChip` 44pt altındaydı | Görünmez hit-box ≥44, görsel boyut sabit (D15) |
| Dynamic Type | Hiç test edilmemişti | 1.3×/1.5× denetimi + taşma düzeltmeleri |
| Golden test | Yoktu (§15 kapısı) | 4 imza ekran × 2 tema (D16) |
| Profile segment çipleri | Tam genişlik yığılıyordu | Kompakt segment satırı |
| Gelecek tarih metni | `"in 5 d"` garip okunuyordu | `Tomorrow` / `in 5 days` / `5 gün sonra` |
| Kimlik kartı | E-posta kırpılıyordu | Satır dengesi yeniden kuruldu |

**Açık tema ilk kez görsel doğrulandı** (koyu tema teslimde doğrulanmıştı): neumorfik yüzeyler, ters Horizon ve alt bar referansa sadık.
