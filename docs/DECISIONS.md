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
| D13 | İlk iki gerçek bağımlılık: **shared_preferences** (onboarding kalıcılığı) + **connectivity_plus** (çevrimdışı durumu) | "Sıfır bağımlılık" bir erdem değil; onboarding'in her açılışta tekrarlaması ve çevrimdışı rozetinin sahte olması ürün hatasıydı. İkisi de birinci parti, üç platformda çalışıyor | KİLİTLİ |
| D14 | Hata durumları **tek katalog**: `JaraError` enum + `errorTitle/errorBody/errorCta` | 9 senaryo ekranlara dağılmış literal metinlerle değil, tek yerden yönetilir; teknik kod asla kullanıcıya çıkmaz (brief kuralı) — dil paritesi derleyici garantili | KİLİTLİ |
| D15 | Dokunma hedefi düzeltmesi **widget seviyesinde**, görsel boyut değişmeden (görünmez hit-box ≥44) | Çağrı yerlerinde tek tek düzeltmek kaçak bırakır; pin ikonu 16px kalmalı ama parmak 44pt bulmalı | KİLİTLİ |
| D16 | Golden testler **görsel iş bittikten sonra** üretilir, 4 imza ekran × 2 tema | Erken alınan snapshot her cila turunda bayatlar ve gürültü yaratır | KİLİTLİ |
| D17 | Horizon imzası ölçekte **döner**: telefon yatay S-kavis, tablet/masaüstü **dikey** kavis (sol 380 dp komut sütunu), saat split'siz | 1440 dp'de yatay kavis düz çizgiye dönüşür ve marka kaybolur; döndürerek aynı geometri her boyutta okunur — "büyütülmüş telefon" hissi olmaz | KİLİTLİ |
| D18 | **Wear OS Flutter ile v1'de; Apple Watch v1.1'de ayrı SwiftUI companion** | Flutter watchOS'a derlenmiyor (motor kısıtı, yapılandırma değil). Saatte ürün vaadi "sesle ara → telefona devret"; bu iki platformda da aynı indirgenmiş kabuk | KİLİTLİ |
| D19 | **20 dil**: en, zh-Hans, zh-Hant, es, ar, hi, pt-BR, ru, ja, de, fr, ko, it, tr, id, vi, th, pl, nl, fa | Mobil pazar büyüklüğü + mevcut site paritesi (9 dil). İki RTL dili (`ar`, `fa`) düzen aynalamasını zorunlu kılıyor | KİLİTLİ |
| D20 | Tipli Dart deck → **ARB + gen_l10n** geçişi | D6 eşiği ("3+ dilde ARB'ye taşınır") 20 dilde net aşıldı; ICU plural desteği İngilizce'ye özgü çoğul kurallarının gömülü kalmasını engeller | KİLİTLİ |
| D21 | Çeviriler yayına hazır üretilir ama **store lansmanı öncesi ana dil gözden geçirmesi** önerilir (özellikle ar/fa/hi/th) | Tipografi ve ton riski en yüksek diller; teknik parite derleyici garantili, kültürel parite değil | AÇIK (Azad kararı) |
