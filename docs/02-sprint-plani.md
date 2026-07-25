# Homeframe — Sprint Planı (S0 → S12)

> Bu doküman [01-is-plani.md](01-is-plani.md)'nin yürütme karşılığıdır.
> **Geçiş kuralı:** Hiçbir sprint, bir öncekinin çıkış kriterleri **yazılı testlerle** kanıtlanmadan başlamaz. Kurallar: [04-sprint-kurallari.md](04-sprint-kurallari.md).

## Sprint takvimi

| Sprint | Süre | Ad | Kapı tipi |
| --- | --- | --- | --- |
| S0 | 3 gün | Ön doğrulama ve iskelet | Süreç kapısı |
| **S1** | **1 hafta** | **Native fizibilite spike'ı** | **GO / NO-GO — proje iptal edilebilir** |
| S2 | 1 hafta | DSL ve IR | Test kapısı |
| S3 | 1 hafta | Android code generation | Test kapısı |
| S4 | 1 hafta | Veri ve runtime | Test kapısı |
| S5 | 1 hafta | Yaşam döngüsü | Test kapısı (cihaz zorunlu) |
| S6 | 1 hafta | Ürün kalitesi | Test kapısı (a11y zorunlu) |
| S7 | 1 hafta | Production dogfood — Vakity | Kanıt kapısı (cihaz zorunlu) |
| S8 | 1 hafta | Beta yayın | Yayın kapısı |
| S9–S10 | Ay 3–4 | Kararlılık | Sürekli |
| S11 | Ay 5–6 | iOS adaptörü | Test kapısı |
| S12 | Ay 7–9 | Preview ve görsel test | Test kapısı |

Test kimliği biçimi: `HF-S<sprint>-T<no>`. Her test dosyası, karşıladığı kimliği başlığında taşır.

---

## S0 — Ön Doğrulama ve İskelet (3 gün)

**Amaç:** Kod yazmadan önce tezi tazelemek ve *testlerin çalışabileceği* bir zemin kurmak.

**Kapsam**
* `expo-widgets` ve `react-native-android-widget` sürüm/indirme sayılarını tazele (tez yeniden türetilmez, bkz. iş planı §2.1).
* npm'de `homeframe` adının hâlâ boş olduğunu doğrula; kaydı al.
* Teknik README ve API taslağını yayınla; RN/Expo topluluklarında geri bildirim topla.
* En az 10 geliştiriciyle kısa görüşme; yanıtları `docs/research/interviews.md` içinde topla.
* pnpm monorepo iskeleti: `packages/core`, `packages/codegen-android`, `packages/expo-plugin`, `packages/cli`, `runtime-android/`, `examples/basic`.
* Test koşucuları ayağa kalksın: Vitest, tsc `--noEmit`, ESLint, Gradle test task, CI iş akışı.
* `pnpm gate` komutu tanımlansın (bkz. kurallar §K3).

**Çıktılar:** monorepo iskeleti · CI yeşil · README taslağı · görüşme notları · npm ad rezervasyonu.

**Yazılacak testler**

| ID | Test | Katman |
| --- | --- | --- |
| HF-S0-T01 | `pnpm gate` sıfır pakette bile hatasız çalışır (boş suite ≠ hata) | L0 |
| HF-S0-T02 | CI, kasıtlı olarak bozulmuş bir testte **kırmızı** olur (kapının gerçekten çalıştığının kanıtı) | L0 |
| HF-S0-T03 | `tsc --noEmit` tüm workspace'te temiz | L0 |

**Çıkış kriterleri**
- [ ] CI, bilerek bozulan bir testte kırmızıya düşüyor ve düzeltilince yeşile dönüyor (ekran görüntüsü kanıt).
- [ ] En az 10 görüşme kaydı var; "canlı sayaç önemli mi?" sorusuna **≥6 evet**.
- [ ] Rakip sürüm bilgileri tazelenmiş ve iş planı §2.1 güncel.

> **Not:** Görüşmelerde "canlı sayaç" talebi 6'nın altında kalırsa S1'e girilir ama konumlandırma S8 öncesinde yeniden yazılır.

---

## S1 — Native Fizibilite Spike'ı (1 hafta) · **GO / NO-GO**

**Amaç:** İş planı §13'teki 10 maddeyi kanıtlamak. Bu sprintte üretilen kod **atılabilir**; amaç ürün değil kanıttır.

**Kapsam**
* Elle yazılmış bir Expo development build içinde `AppWidgetProvider` + `RemoteViews` çalıştır.
* `Chronometer` ile geri sayım; `am force-stop` sonrası davranışı ölç.
* Reboot sonrası mutlak `endAt` epoch değerinden sayacı yeniden kur.
* İki widget instance'ına farklı veri bas.
* EAS release build al.
* En basit haliyle: elle yazılmış bir IR JSON'dan XML üreten 50 satırlık script (2. maddenin kanıtı).
* Config plugin'i 3 kez üst üste çalıştır, diff'i ölç.

**Yazılacak testler**

| ID | Test | Katman |
| --- | --- | --- |
| HF-S1-T01 | IR JSON → XML dönüşümü golden dosyayla eşleşir | L2 |
| HF-S1-T02 | `expo prebuild` 3 kez çalıştırıldıktan sonra `git diff --exit-code` temiz | L3 |
| HF-S1-T03 | `RemoteViews.apply()` sonucu beklenen view ağacını üretir (Robolectric) | L4 |
| HF-S1-T04 | Widget, RN paketleyicisi kapalıyken render ediliyor (instrumented) | L5 |
| HF-S1-T05 | `adb shell am force-stop` sonrası 60 sn'de Chronometer değeri **60 sn ilerlemiş** (scripted, ekran kaydı) | L6 |
| HF-S1-T06 | `adb reboot` sonrası sayaç doğru değerden devam ediyor (±2 sn) | L6 |
| HF-S1-T07 | İki instance farklı `title` gösteriyor (UiAutomator) | L5 |
| HF-S1-T08 | EAS production build başarılı + cihazda widget çalışıyor | L6 |
| HF-S1-T09 | TalkBack widget metnini sesli okuyor (kayıt) | L7 |

**Çıkış kriterleri — GO/NO-GO**
- [ ] **T01, T02, T03, T04 geçti.** (Kritik dörtlü — biri bile başarısızsa **proje iptal**.)
- [ ] T05 ve T06 geçti → tez korunur. Geçmezse konumlandırma "canlı geri sayım" iddiasından arındırılıp iş planı §1/§6 yeniden yazılmadan S2'ye geçilmez.
- [ ] T07, T08, T09 sonuçları raporda kayıtlı (başarısızlık S1'i bloke etmez, backlog'a düşer).
- [ ] `docs/reports/sprint-01-go-no-go.md` yazılı ve karar (GO / PIVOT / NO-GO) imzalı.

---

## S2 — DSL ve Ara Temsil (1 hafta)

**Amaç:** `defineWidget` ve `field` ile yazılan tanımın, deterministik ve doğrulanmış bir IR'ye dönüşmesi.

**Kapsam**
* `defineWidget`, `field`, veri şeması (`string`, `number`, `timestamp`, `boolean`, `image`).
* Primitive'ler: `WColumn`, `WRow`, `WText`, `WImage`, `WSpacer`, `WProgress`, `WCountdown`, `WLink`, `WConditional`.
* IR şeması (JSON Schema ile versiyonlu, `irVersion`).
* Statik analiz: bilinmeyen alan, tip uyuşmazlığı, desteklenmeyen iç içe yapı, `WLink` içinde `WLink`.
* İnsan tarafından okunabilir hata mesajları (kod + dosya/satır + öneri).

**Yazılacak testler**

| ID | Test | Katman |
| --- | --- | --- |
| HF-S2-T01 | Her primitive için tanım → IR anlık görüntüsü (9 golden) | L1 |
| HF-S2-T02 | IR çıktısı, JSON Schema doğrulamasından geçer | L1 |
| HF-S2-T03 | Aynı girdi 100 kez derlenince **bit-bit aynı** IR üretir (determinizm) | L1 |
| HF-S2-T04 | `field("yok")` → `HF1001` hata kodu, dosya+satır bilgisiyle | L1 |
| HF-S2-T05 | `WText value={field("targetAt")}` gibi tip uyuşmazlığı derleme zamanında yakalanır | L0 (`expect-type`) |
| HF-S2-T06 | Desteklenmeyen JSX (ör. `<div>`, `.map()`) net hata verir, sessizce yutulmaz | L1 |
| HF-S2-T07 | Hata mesajlarının tamamı golden dosyayla kilitli (mesaj kalitesi regresyona kapalı) | L1 |

**Çıkış kriterleri**
- [ ] 9 primitive'in tamamının IR golden'ı var.
- [ ] Hata kataloğu (`HF1xxx`) dokümante ve testli; **kodsuz hata fırlatılmıyor**.
- [ ] `@homeframe/core` satır kapsamı **≥ %90**.
- [ ] Determinizm testi (T03) yeşil — codegen'in golden testleri buna bağımlı.

---

## S3 — Android Code Generation (1 hafta)

**Amaç:** IR → derlenebilir Android kaynakları; ve idempotent Expo prebuild.

**Kapsam**
* XML layout üretimi (RemoteViews-uyumlu alt küme; `ConstraintLayout` yok).
* `AppWidgetProvider` sınıfı ve `appwidget-provider` XML'i.
* AndroidManifest girdileri (idempotent merge).
* Resource ID yönetimi ve isim çakışma stratejisi.
* Boyut varyantları (`targetCellWidth/Height`, `sizes` → farklı layout).
* Expo config plugin: dosya yazımı, tekrar çalıştırılabilirlik, kısmi hata durumunda geri alma.

**Yazılacak testler**

| ID | Test | Katman |
| --- | --- | --- |
| HF-S3-T01 | IR → XML golden karşılaştırması (tüm primitive'ler + 3 kompozit widget) | L2 |
| HF-S3-T02 | Üretilen XML gerçekten **derleniyor** (`gradlew :app:assembleDebug`) | L4 |
| HF-S3-T03 | Üretilen her view tipi `RemoteViews` beyaz listesinde (yasak view testi) | L2 |
| HF-S3-T04 | `expo prebuild --clean` ardından 3× `prebuild` → `git diff --exit-code` temiz | L3 |
| HF-S3-T05 | Elle değiştirilmiş Manifest satırı prebuild'de **korunuyor** (yıkıcı yazma yok) | L3 |
| HF-S3-T06 | İki widget aynı resource adını isterse deterministik ek alıyor, çakışma yok | L2 |
| HF-S3-T07 | Codegen ortasında hata → yarım dosya bırakmıyor (atomiklik) | L1 |
| HF-S3-T08 | Boyut varyantı: 2×1 ve 4×2 için farklı layout üretiliyor | L2 |

**Çıkış kriterleri**
- [ ] Örnek uygulama `assembleDebug` **ve** `assembleRelease` ile derleniyor.
- [ ] Idempotency testi (T04) CI'da her koşuda çalışıyor.
- [ ] `@homeframe/codegen-android` kapsamı **≥ %85**, `@homeframe/expo-plugin` **≥ %80**.
- [ ] Golden dosyalar yalnızca `pnpm test -u` ile güncellenmiş ve diff PR'da gözden geçirilmiş.

---

## S4 — Veri ve Runtime (1 hafta)

**Amaç:** JS tarafından widget'a veri akışı, instance bazlı state, deep link.

**Kapsam**
* JS API: `updateWidget(name, data, { instanceId? })`, `getInstances(name)`.
* Kotlin runtime: veri deposu (SharedPreferences/DataStore), IR binding manifesti okuma, `AppWidgetManager.updateAppWidget`.
* Instance bazlı state ve instance silinince temizlik (`onDeleted`).
* Runtime veri doğrulama: şemaya uymayan veri → net hata, widget bozulmaz.
* State migration: şema değişince eski veriyi taşı veya güvenli varsayılana düş.
* Deep link: `WLink` → `PendingIntent` → uygulama içi rota.

**Yazılacak testler**

| ID | Test | Katman |
| --- | --- | --- |
| HF-S4-T01 | `updateWidget` çağrısı sonrası widget metni değişiyor (instrumented) | L5 |
| HF-S4-T02 | İki instance bağımsız veri tutuyor; birini güncellemek diğerini bozmuyor | L5 |
| HF-S4-T03 | Instance silinince deposundaki kayıt temizleniyor (sızıntı yok) | L4 |
| HF-S4-T04 | Şemaya uymayan veri `HF2001` fırlatıyor, widget son geçerli durumda kalıyor | L1+L4 |
| HF-S4-T05 | v1 şemasıyla yazılmış veri v2 runtime'da migrate ediliyor | L4 |
| HF-S4-T06 | `WLink` dokunuşu doğru deep link'i açıyor (UiAutomator) | L5 |
| HF-S4-T07 | Uygulama hiç açılmamışken widget "empty state" gösteriyor, çökmüyor | L5 |
| HF-S4-T08 | 50 ardışık güncelleme sonrası TransactionTooLarge/ANR yok | L5 |

**Çıkış kriterleri**
- [ ] T01–T07 yeşil; T08 performans bütçesiyle birlikte raporlu.
- [ ] Widget güncelleme süresi **< 150 ms** (orta segment cihaz, medyan).
- [ ] Runtime hata kataloğu (`HF2xxx`) dokümante.

---

## S5 — Yaşam Döngüsü (1 hafta) · cihaz testi zorunlu

**Amaç:** Widget'ın "unutulmaması". Bu sprint ürünün güvenilirlik tezini taşır.

**Kapsam**
* Process death sonrası davranış.
* Doze ve App Standby.
* Reboot sonrası restore (`BOOT_COMPLETED`).
* Saat ve saat dilimi değişimi (`TIME_SET`, `TIMEZONE_CHANGED`).
* Widget restore (yedekten geri yükleme, launcher yeniden başlatma).
* Epoch zinciri: sonraki güncelleme zamanının mutlak epoch olarak saklanması (Vakity referans çözümü).

**Yazılacak testler**

| ID | Test | Katman |
| --- | --- | --- |
| HF-S5-T01 | `am force-stop` sonrası Chronometer ilerlemeye devam ediyor | L6 |
| HF-S5-T02 | `adb reboot` sonrası sayaç mutlak `endAt`'ten doğru kuruluyor (±2 sn) | L6 |
| HF-S5-T03 | `adb shell dumpsys deviceidle force-idle` altında widget donmuyor | L6 |
| HF-S5-T04 | Saat dilimi değişince gösterilen zaman yeni dilime göre düzeliyor | L5 |
| HF-S5-T05 | Sistem saati ileri alınınca yanlış negatif geri sayım oluşmuyor | L5 |
| HF-S5-T06 | Launcher yeniden başlatılınca (`am force-stop <launcher>`) widget geri geliyor | L6 |
| HF-S5-T07 | Süresi dolmuş countdown "bitti" durumuna geçiyor, negatife sarmıyor | L4 |
| HF-S5-T08 | 24 saat boyunca bırakılan widget hâlâ doğru (uzun süre koşusu, günlük kayıt) | L6 |

**Çıkış kriterleri**
- [ ] T01, T02, T06 **en az iki farklı fiziksel cihazda** ve farklı launcher'larda doğrulandı (video kanıt).
- [ ] T08 en az bir kez 24 saat koşturuldu, sapma < 5 sn.
- [ ] Bulunan her yaşam döngüsü hatası için **önce başarısız test** yazıldı (kural §K6).

---

## S6 — Ürün Kalitesi (1 hafta) · a11y zorunlu

**Amaç:** SDK'yı "demo" olmaktan çıkarıp yayınlanabilir yapmak.

**Kapsam**
* TalkBack ve `contentDescription` her primitive'de.
* Açık/koyu tema, dinamik renk (Material You) uyumu.
* Widget resize davranışı.
* Error ve empty state primitive'leri.
* Android API uyumluluğu (min 26 → hedef güncel).
* Test altyapısının derlenip toparlanması, `pnpm gate` tam kapsam.

**Yazılacak testler**

| ID | Test | Katman |
| --- | --- | --- |
| HF-S6-T01 | Her primitive `contentDescription` üretiyor; üretmeyen primitive **build hatası** | L2 |
| HF-S6-T02 | Accessibility Scanner / espresso-accessibility ihlali sıfır | L7 |
| HF-S6-T03 | Koyu temada kontrast oranı ≥ 4.5:1 (üretilen renkler üzerinden hesap) | L2 |
| HF-S6-T04 | Tema değişince widget yeniden renkleniyor (instrumented) | L5 |
| HF-S6-T05 | Resize sonrası doğru boyut varyantı bağlanıyor | L5 |
| HF-S6-T06 | API 26 / 30 / 34 / 35 emülatörlerinde smoke test yeşil | L6 |
| HF-S6-T07 | Uzun metin (200 karakter) ve RTL dilde taşma/kırpılma yok (görsel kontrol + golden) | L2+L6 |
| HF-S6-T08 | Veri yokken empty state, hatalı veride error state render ediliyor | L5 |

**Çıkış kriterleri**
- [ ] Erişilebilirlik ihlali **sıfır** — istisna kabul edilmez (kural §K9).
- [ ] API matrisi CI'da koşuyor.
- [ ] Kapsam eşikleri (§K5) tüm paketlerde sağlanıyor ve düşmüyor.
- [ ] `pnpm gate` tek komutla L0–L5'i çalıştırıyor, süre < 10 dk.

---

## S7 — Production Dogfood: Vakity (1 hafta)

**Amaç:** Homeframe'i gerçek bir üründe kullanmak; SDK'nın ürün karşısında ne kadar dayandığını ölçmek.

**Kapsam**
* Vakity'nin mevcut Android namaz vakti widget'ı Homeframe primitive'leriyle yeniden yazılır.
* Mevcut native uygulama referans kabul edilir; **davranış eşitliği** aranır.

**Ölçülecek veriler** (rapora zorunlu): native kod satırı farkı · geliştirme süresi · build sorunları · crash oranı · countdown doğruluğu · cihaz uyumluluğu · reboot davranışı.

**Yazılacak testler**

| ID | Test | Katman |
| --- | --- | --- |
| HF-S7-T01 | Homeframe widget'ı ile mevcut native widget aynı vakitte aynı değeri gösteriyor (24 saat karşılaştırma) | L6 |
| HF-S7-T02 | Vakit geçişi anında (ör. ikindi→akşam) widget doğru vakte atlıyor | L5 |
| HF-S7-T03 | Reboot sonrası Vakity widget'ı doğru vakti ve doğru kalan süreyi gösteriyor | L6 |
| HF-S7-T04 | Vakity EAS production build'i Homeframe ile başarılı | L6 |
| HF-S7-T05 | Homeframe sürümünde crash raporu **sıfır** (7 gün, gerçek kullanım) | L6 |

**Çıkış kriterleri**
- [ ] T01–T04 **fiziksel cihazda** doğrulandı (Vakity'nin "CİHAZDA doğrulandı" commit kuralı geçerli).
- [ ] Yazılan native kod satırı **≥ %80 azaldı**; azalmadıysa değer önerisi raporda yeniden değerlendirildi.
- [ ] Dogfood sırasında bulunan her eksik primitive için ya S8 öncesi eklendi ya da bilinen sınırlama olarak dokümante edildi.

---

## S8 — Beta Yayın (1 hafta)

**Amaç:** `0.1.0-beta` npm'de, repo herkese açık, lansman içeriği hazır.

**Kapsam:** npm beta sürümü · GitHub repo (issue şablonları, CONTRIBUTING, CODE_OF_CONDUCT) · dokümantasyon sitesi · örnek Expo uygulaması · karşılaştırmalı demo videosu · uyumluluk tablosu · topluluk lansmanı.

**Yazılacak testler**

| ID | Test | Katman |
| --- | --- | --- |
| HF-S8-T01 | **Sıfırdan kurulum testi:** boş Expo projesi → çalışan widget, script ile ölçülüyor | L6 |
| HF-S8-T02 | Yayınlanan tarball, temiz makinede kurulup derleniyor (`npm pack` + smoke) | L3 |
| HF-S8-T03 | README'deki her kod bloğu derleniyor (doküman testi) | L1 |
| HF-S8-T04 | İki Expo SDK sürümüne karşı CI matrisi yeşil | L3 |
| HF-S8-T05 | Örnek uygulama, 2 farklı launcher'da doğrulandı | L6 |

**Çıkış kriterleri**
- [ ] T01 süresi **< 30 dakika** (ana ürün metriği). Aşarsa yayın ertelenir veya kurulum sadeleştirilir.
- [ ] Dokümantasyondaki hiçbir örnek kırık değil (T03).
- [ ] Bilinen sınırlamalar sayfası yayında; bitmap karşılaştırma demosu yayında.

---

## S9–S10 — Kararlılık (Ay 3–4)

**Amaç:** İlk kullanıcı temasından sağ çıkmak.

**Kapsam:** kullanıcı issue'ları · Expo SDK uyumluluğu · launcher testleri · dış katkı süreci · primitive genişletmeleri · ilk showcase'ler.

**Kalıcı kurallar**
* Her bug raporu → **önce başarısız regresyon testi**, sonra fix (§K6).
* Kritik issue'ya ilk yanıt < 72 saat.
* Uyumluluk matrisi her Expo SDK sürümünde güncellenir.
* Sürüm çıkışı `pnpm gate` + release checklist olmadan yapılmaz.

**Çıkış kriterleri**
- [ ] Açık kritik bug sayısı 0.
- [ ] Regresyon test sayısı, kapatılan bug sayısına eşit veya fazla.
- [ ] 3 production showcase yayında.

---

## S11 — iOS Adaptörü (Ay 5–6)

**Amaç:** Aynı IR'den `expo-widgets` üzerinden iOS widget üretmek.

**Kapsam:** `expo-widgets` adaptörü · ortak API uyumu · ortak veri modeli · platforma özel escape hatch · cross-platform örnek uygulama.

**Yazılacak testler**

| ID | Test | Katman |
| --- | --- | --- |
| HF-S11-T01 | Aynı IR → hem Android XML hem iOS çıktısı üretiliyor (çift golden) | L2 |
| HF-S11-T02 | iOS'ta desteklenmeyen primitive derleme zamanında **net hata** veriyor, sessizce düşmüyor | L1 |
| HF-S11-T03 | Ortak `updateWidget` API'si iki platformda da aynı davranıyor | L5 |
| HF-S11-T04 | iOS simülatörde widget render ediliyor, geri sayım ilerliyor | L6 |
| HF-S11-T05 | Platform escape hatch kullanımı IR'yi bozmuyor | L1 |

**Çıkış kriterleri**
- [ ] Tek tanımdan iki platform widget'ı üreten örnek uygulama yayında.
- [ ] Platform yetenek matrisi dokümante (hangi primitive nerede tam/kısmi/yok).
- [ ] Android testlerinin hiçbiri regresyona uğramadı.

---

## S12 — Preview ve Görsel Test (Ay 7–9)

**Amaç:** IR'yi tarayıcıda görselleştirip görsel regresyonu otomatikleştirmek.

**Kapsam:** browser preview · cihaz boyutları · tema preview · time travel (geri sayım simülasyonu) · screenshot · CI görsel testleri · uzun metin ve lokalizasyon testi.

**Yazılacak testler**

| ID | Test | Katman |
| --- | --- | --- |
| HF-S12-T01 | Preview render'ı, cihaz ekran görüntüsüyle **piksel toleransı ≤ %2** içinde | L8 |
| HF-S12-T02 | Time travel: t+1sa simülasyonu cihazdaki gerçek değerle uyuşuyor | L8 |
| HF-S12-T03 | Görsel regresyon testi, kasıtlı 4px padding değişimini yakalıyor | L8 |
| HF-S12-T04 | 5 dilde ve uzun metinde taşma raporlanıyor | L8 |

**Çıkış kriterleri**
- [ ] Görsel regresyon CI'da; baseline güncellemesi PR incelemesi gerektiriyor.
- [ ] Preview ile cihaz arasındaki sapma bilinen ve dokümante.

---

## Kapsam kilidi (V1 dışı)

Aşağıdakiler **hiçbir sprintte** kapsama alınmaz; talep gelirse backlog'a yazılır:
Live Activities · lock-screen widget · collection/liste widget'ları · drag-and-drop editor · arbitrary React Native bileşenleri · widget içinde doğrudan ağ isteği · görsel SaaS paneli.
