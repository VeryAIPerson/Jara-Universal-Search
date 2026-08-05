# Karar Kaydı (ADR) — JARA Universal Search

Kısa gerekçeli, bağlayıcı kararlar. Değiştirmek = yeni ADR satırı (üzerine yazma).

| # | Karar | Gerekçe | Durum |
|---|---|---|---|
| D1 | Tasarım dili adı **Lamplight**; yapısal imza **Horizon** (koyu sky + yumuşak surface + S-kavis) | Referans kompozisyonun birebir yapısal çevirisi; lamba markasının "ışık" metaforuna bağlanır; kategori kopyası olmayan ownable imza | KİLİTLİ |
| D2 | Ürün accent'i **#5B7CFA → #836BFF** gradient; altın yalnız marka anları | Aile deseni "ürün = renk"; Voxbridge gök mavisinden ayrışır, prompt'taki öneriyle uyumlu; altın enflasyonu markayı sulandırır | KİLİTLİ |
| D3 | Alt bar: **Search · Memory · [+FAB] · Collections · Profile** | Prompt "maks 4 bölüm + merkez Add" izni; Collections ayrı zihinsel model (raf vs akış); referansın merkez-FAB dengesi | KİLİTLİ |
| D4 | Açık tema = referans neumorfizmi; sky her temada koyu | Split imzası tema değişiminde kaybolmaz; "koyu öncelik" korunur | KİLİTLİ |
| D5 | Tipografi: **Inter variable gömülü**, tüm platformlarda | Marka tutarlılığı iOS/Android'de aynı; `FontVariation('wght')` ile değişken eksen; SF Pro fallback gereksiz | AÇIK (Azad görsel onayı) |
| D6 | Metinler **tipli Dart copy deck** (gen-l10n değil) | 2 dilde derleyici garantili parite, codegen çakışması yok; 3+ dile geçişte ARB'ye taşınır (mekanik iş) | KİLİTLİ (v1.1'de gözden geçir) |
| D7 | State: **Riverpod 2** · Nav: **GoRouter StatefulShellRoute** · veri: local-first repo arayüzü (mock → Isar/Drift) | Prompt'un önerdiği yığın; şube başına state korunur; mock gerçek API imzasıyla değiştirilebilir | KİLİTLİ |
| D8 | Gizlilik kademesi: **Local-only varsayılan, Hybrid opt-in**; üçüncü taraf tracker yok | Güven = ürünün çekirdek vaadi; aile kuralı (site: analytics yok) uygulamada da geçerli | KİLİTLİ |
| D9 | Premium kapısı: yalnız Cloud Intelligence, sınırsız bağlantı, öncelikli indeksleme; **arama asla paywall arkasında değil** | Çekirdek vaat ücretsiz kalmalı; premium "daha akıllı", "daha fazla kaynak" satar | KİLİTLİ |
| D10 | Lansman adı önerisi: **"JARA Recall"** (kısa, ownable); şimdilik her yüzeyde "JARA Universal Search" | İsimler Azad onayıyla kilitleniyor (aile kuralı §2); öneri gerekçesiyle sunuldu, bloklamaz | ÖNERİ (Azad kararı) |
| D11 | Web target'ı yalnız **tasarım doğrulama/demo** için; store hedefi iOS+Android | Ekran görüntüsü + hızlı iterasyon; PWA lansmanı kapsam dışı | KİLİTLİ |
| D12 | Sesli arama UI'ı MVP'de (buton+waveform+demo sorgu), gerçek STT v1.1 | Akış tasarımı bugün doğrulanır; STT motoru ayrı mühendislik işi | KİLİTLİ |
