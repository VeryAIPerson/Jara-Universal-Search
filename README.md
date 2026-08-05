# JARA Universal Search

Everything important. One search. — Kişisel dijital hafızanı tek merkezden,
doğal dille arayan premium uygulama. **7 platform** (iOS · Android ·
iPadOS/tablet · macOS · Windows · Linux · Wear OS; web = tasarım demo),
**20 dil** (2 RTL dahil), adaptif Horizon düzeni (telefonda yatay S-kavis,
tablet/masaüstünde dikey komut sütunu + iki pano, saatte tek akış).

**Tasarım dili:** Lamplight — koyu "memory sky" + yumuşak neumorfik
"surface" yarıküreleri, aralarında S-kavis Horizon; merkez Add FAB;
elektrik çivit → menekşe accent, altın yalnız marka anları.

## Repo haritası

```
lib/
  core/design/     tokens, theme, typography, motion, haptics
  core/widgets/    Horizon/NeuTile/JaraSearchField/FAB/kart seti
  core/models/     MemoryItem, Collection, SearchOutcome, …
  core/data/       mock local-first repo + Riverpod providers
  core/router/     GoRouter shell (Search·Memory·[+]·Collections·Profile)
  features/<x>/    ekranlar (feature-first)
  l10n/            tipli EN/TR copy deck
docs/
  DESIGN_BRIEF_TR.md   geliştirilmiş tasarım prompt'u (v2) + karar gerekçeleri
  DESIGN_SYSTEM.md     mühendislik spesifikasyonu (EN)
  DECISIONS.md         ADR kaydı
  AGENT_CONTRACTS.md   ekran-implementasyon sözleşmesi
```

## Çalıştırma

```bash
flutter pub get
flutter run                      # cihaz/simülatör
flutter run -d web-server --web-port 8090   # tasarım demo
flutter analyze && flutter test
```

Demo verisi mock repodadır (`core/data/`); arama, öneriler ve Smart
Summary gerçek davranışla çalışır ("VoxBridge tts", "london", "passport"
sorgularını dene).

## Kalite kapıları

`flutter analyze` temiz · **138 test**: davranış + 124 dil-parite testi
(20 dil, çoğul/interpolasyon/marka korunumu) + 8 golden (4 imza ekran ×
2 tema, sabitlenmiş saat, Linux-raster — CI Flutter sürümü sabit) ·
Reduce Motion + Semantics denetimi. Saat kabuğu: `flutter run -t
lib/main_watch.dart`. Ayrıntı: docs/DESIGN_BRIEF_TR.md §15 ve
docs/PLATFORMS_AND_LOCALES.md §4.
