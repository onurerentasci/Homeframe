# Homeframe — İş Planı

> Sürüm: 1.0 · Tarih: 2026-07-26 · Sahip: Onur Eren Taşcı (Vespula Studio)
> Durum: **Faz 0 — planlama.** Teknik doğrulama (S1) tamamlanmadan hiçbir ürün taahhüdü kesin değildir.

---

## 1. Yönetici Özeti

Homeframe, Expo ve React Native geliştiricilerinin Android ana ekran widget'larını Kotlin veya XML yazmadan TypeScript ile geliştirmesini sağlayan açık kaynak bir SDK'dır.

Mevcut React Native çözümlerinin önemli bir kısmı uygulama arayüzünü bitmap olarak oluşturup widget içerisinde görüntü olarak gösterir. Bu yaklaşım canlı geri sayım, gerçek metin semantiği, erişilebilirlik, doğal Android bileşenleri ve uygulama çalışmıyorken güncellenen öğeler konusunda sınırlamalar yaratır.

Homeframe, widget tanımlarını gerçek Android `RemoteViews` bileşenlerine dönüştürür. Böylece `TextView`, `ImageView`, `ProgressBar` ve `Chronometer` gibi native bileşenler kullanılabilir; normal proses ölümünde devam eden geri sayımlar, reboot sonrası mutlak `endAt` değerinden kurtarma, TalkBack desteği ve daha güvenilir launcher davranışı sağlanır. Kullanıcının uygulamayı açıkça `force-stop` etmesi bu canlılık garantisinin dışındadır; launcher bu durumda yer tutucu gösterebilir. Uygulama yeniden açıldığında widget doğru kalan süreyle yeniden render edilir.

İlk ürün Android odaklıdır. İkinci aşamada aynı widget tanımını Expo'nun resmî iOS widget altyapısına bağlayan bir adaptör geliştirilecek, böylece tek tanımdan iOS ve Android widget üretilebilecektir.

Homeframe'in ilk hedefi doğrudan yüksek gelir elde etmek değil; teknik güvenilirlik, açık kaynak benimsenmesi ve üretim ortamında doğrulanmış bir geliştirici ürünü oluşturmaktır. Gelir modeli daha sonra kurumsal destek, uyumluluk testleri, görsel test araçları ve premium geliştirici hizmetleri üzerine kurulacaktır.

---

## 2. Problem

React Native ve Expo geliştiricileri uygulamalarına ana ekran widget'ı eklemek istediğinde platforma özel teknolojilerle karşılaşır. Android tarafında geliştiricinin bilmesi gerekenler:

* Kotlin veya Java
* Android XML layout sistemi
* `AppWidgetProvider`
* `RemoteViews`
* Widget yaşam döngüsü
* Deep link ve `PendingIntent`
* Widget instance yönetimi
* Reboot ve saat değişikliği davranışları
* Expo config plugin geliştirme
* Android Manifest ve resource üretimi

Bitmap tabanlı kolaylaştırıcı çözümlerin sınırlamaları:

* Widget içindeki metin gerçek Android metni değildir.
* TalkBack ve erişilebilirlik desteği sınırlıdır.
* Canlı `Chronometer` kullanılamaz.
* Widget, uygulama çalışmadan saniyelik güncellenemez.
* Farklı launcher ölçülerinde kırpılma yaşanabilir.
* Widget'ın tamamı yeniden görüntü olarak üretilmek zorundadır.
* Sistem fontları ve native bileşen davranışları kullanılamaz.

**Sonuç:** RN geliştiricisi *kolay kurulum* ile *gerçek native widget davranışı* arasında seçim yapmak zorunda kalır. Homeframe bu ikilemi ortadan kaldırmayı hedefler.

### 2.1 Doğrulanmış pazar gerçekleri (2026-07-25 itibarıyla)

Bu iki gerçek araştırmayla doğrulandı; S0'da yalnızca sürüm/indirme sayıları tazelenecek, tez yeniden türetilmeyecek:

1. **`expo-widgets` artık resmî Expo paketidir** (SDK 57, ~103k haftalık indirme). JSX ile WidgetKit + Live Activities üretir; extension target, App Group ve bundle id işini config plugin halleder. **Yalnızca iOS.** Yani "Expo widget desteklemiyor" tezi geçersizdir — boşluk *Android* tarafındadır.
2. **`react-native-android-widget`** (~890★, ~42k haftalık indirme) React view'larını **bitmap'e render edip** widget'ta görüntü olarak gösterir (kendi Limitations sayfasında belgelidir). Bu nedenle native `Chronometer` kullanamaz → **canlı geri sayım Android'de mümkün değildir** ve belgelenmiş launcher crop sorunları vardır.

Projenin tezi tam olarak buradadır ve **"cross-platform" değil, "native rendering, bitmap değil"** olarak konumlanır. Gerekçe: bu iddia nesnel olarak gösterilebilir (yan yana GIF: biri sayıyor, diğeri donmuş) ve Expo ileride Android widget desteği eklerse muhtemelen Glance/RemoteViews kullanacağı için tezi yok etmez.

---

## 3. Çözüm

Homeframe, kısıtlı ve **statik olarak analiz edilebilir** bir TypeScript API'sini native Android widget kaynaklarına derler.

```tsx
export default defineWidget({
  name: "EventCountdown",

  data: {
    title: "string",
    targetAt: "timestamp",
  },

  view: (
    <WColumn padding={16}>
      <WText value={field("title")} />
      <WCountdown endAt={field("targetAt")} />
    </WColumn>
  ),
});
```

Bu tanımdan üretilenler:

* Android XML layout dosyaları
* `AppWidgetProvider` yapılandırması
* Manifest girdileri
* Native resource kimlikleri
* Veri bağlama manifesti
* Expo config plugin çıktıları
* Kotlin tabanlı widget runtime'ı

Widget, çalışma zamanında React Native görünümünü görüntüye dönüştürmez; gerçek Android bileşenleri oluşturur.

**Temel değer önerisi:** Expo için bitmap olmayan, gerçek native Android widget'ları.
**Uzun vadeli değer önerisi:** Tek bir TypeScript widget tanımından native Android ve iOS ana ekran widget'ları üretmek.

### 3.1 Mimari akış

```
defineWidget (TSX)
   → statik analiz / validasyon
   → Homeframe IR (JSON, platformdan bağımsız)
   → [Android backend]  XML + Manifest + Provider + resource map
   → [iOS backend (V2)] expo-widgets / SwiftUI adaptörü
   → Expo config plugin (idempotent prebuild)
   → Kotlin runtime: veri deposu → RemoteViews binding → AppWidgetManager
```

IR, projenin uzun vadeli savunma hattıdır: preview, görsel test, migration ve cross-platform üretim hep IR üzerinden çalışır.

---

## 4. Ürün Özellikleri

### 4.1 Homeframe V1 — yalnızca Android

Desteklenen primitive'ler: `WColumn`, `WRow`, `WText`, `WImage`, `WSpacer`, `WProgress`, `WCountdown`, `WLink`, `WConditional`.

Özellikler:

* Expo config plugin desteği
* Native `RemoteViews` üretimi
* TypeScript ile widget tanımlama
* Uygulama çalışmadan devam eden geri sayım
* Deep link desteği
* Açık ve koyu tema
* Widget boyutlarına göre farklı layout
* Birden fazla widget instance'ı ve instance bazlı veri saklama
* Reboot sonrası durumun yeniden oluşturulması
* Saat ve saat dilimi değişikliklerine uyum
* TalkBack için native ve dinamik erişilebilirlik semantiği
* Android development ve release (EAS) build desteği

### 4.2 Homeframe V2 — iOS adaptörü

Aynı Homeframe tanımını iki hedefe çevirir: Android `RemoteViews`, iOS WidgetKit/SwiftUI (Expo'nun resmî altyapısı üzerinden). Bu aşamada ana mesaj cross-platform widget geliştirmeye döner.

### 4.3 Homeframe V3 — preview ve görsel test

Tarayıcı tabanlı önizleme aracı: iOS/Android widget boyutları, açık/koyu tema, canlı veri düzenleme, geri sayım simülasyonu, uzun metin testi, lokalizasyon testi, ekran görüntüsü üretimi, platform uyumluluk uyarıları, CI görsel karşılaştırma.

---

## 5. Hedef Kitle

**Birincil:** Expo kullanan bağımsız geliştiriciler, RN uygulama ekipleri, mobil ajanslar, küçük SaaS/tüketici ekipleri, native Android bilgisi sınırlı JS geliştiricileri.

**Kullanım alanları:** namaz ve etkinlik geri sayımları, alışkanlık/seri takibi, fitness, takvim ve görev, finans/portföy özeti, sipariş ve teslimat takibi, spor skorları, hava durumu, eğitim, sayaç/zamanlayıcı, günlük hedef göstergeleri.

**İkincil (sonraki dönem):** kurumsal mobil ekipler, white-label ajanslar, çok uygulamalı ürün şirketleri, Expo/RN araç ekipleri.

---

## 6. Rekabet ve Konumlandırma

| Özellik | Bitmap tabanlı çözüm | Native kod tabanlı çözüm | Homeframe |
| --- | ---: | ---: | ---: |
| TypeScript API | Evet | Hayır | Evet |
| Gerçek native Android bileşenleri | Hayır | Evet | Evet |
| Canlı Chronometer | Hayır | Evet | Evet |
| Kotlin/XML yazma zorunluluğu | Hayır | Evet | Hayır |
| TalkBack desteği | Sınırlı | Evet | Evet |
| Expo config plugin | Değişken | Değişken | Evet |
| Gelecekte cross-platform | Sınırlı | Hayır | Evet |
| Ortak preview sistemi | Hayır | Hayır | Planlanıyor |

**Stratejik pozisyon:** Native widget kalitesini JavaScript geliştirici deneyimiyle birleştiren Expo altyapısı.

---

## 7. İş Modeli

Core SDK **MIT lisanslı ve ücretsiz** olacaktır. İlk aşamada ücretli core, benimsenmeyi yavaşlatır.

**Ücretsiz katman:** Homeframe Core, Android renderer, Expo config plugin, temel CLI, örnek uygulamalar, dokümantasyon, standart primitive'ler.
Amaç: GitHub görünürlüğü, topluluk, gerçek üretim kullanım örnekleri, dış katkıcılar, teknik güven.

**Gelir modeli 1 — Kurumsal destek**

| Paket | İçerik | Tahmini fiyat |
| --- | --- | ---: |
| Başlangıç desteği | Kurulum ve tek widget entegrasyonu | 15.000–30.000 TL |
| Proje desteği | Birden fazla widget + production hazırlığı | 40.000–90.000 TL |
| Kurumsal destek | SLA, migration, özel geliştirme | Teklif bazlı |

Bu rakamlar **varsayımdır**; müşteri görüşmeleriyle doğrulanmalıdır.

**Gelir modeli 2 — Homeframe Cloud:** cihaz ekran görüntüsü testleri, görsel regression, launcher matrisi, Expo SDK uyumluluk raporları, CI entegrasyonu, preview paylaşımı, ekip yönetimi.

| Plan | Hedef | Aylık |
| --- | --- | ---: |
| Free | Bireysel / açık kaynak | 0 TL |
| Pro | Bağımsız geliştirici | 499–999 TL |
| Team | Küçük ürün ekibi | 2.500–5.000 TL |
| Enterprise | Kurumsal | Teklif bazlı |

**Gelir modeli 3 — Premium şablonlar:** etkinlik geri sayımı, namaz vakti, fitness streak, günlük görev, hava durumu, finans özeti, teslimat takibi, abonelik kalan süre.

**Gelir modeli 4 — Danışmanlık kazanımı:** SDK; RN/Expo, native Android, config plugin, compiler/codegen, widget yaşam döngüsü, açık kaynak bakım ve production mimari yetkinliklerini kanıtlar. Bu kanıt daha yüksek bütçeli projelere dönüşebilir.

---

## 8. Pazara Giriş

**Ön doğrulama (kod öncesi):** teknik README, basit API örnekleri, RN/Expo topluluklarından geri bildirim, en çok istenen özelliklerin toplanması, **en az 10 geliştiriciyle görüşme.**

Görüşme soruları: Daha önce RN uygulamanıza widget eklediniz mi? Hangi platformda zorlandınız? Native kod yazmak zorunda kaldınız mı? Mevcut paketlerde hangi sorunları yaşadınız? Gerçek native metin veya canlı sayaç sizin için önemli mi? Böyle bir SDK'yı hangi projede kullanırdınız?

**Kanallar:** GitHub, npm, r/reactnative, Expo Discord, React Native Discord, Hacker News, This Week in React, React Native Newsletter, LinkedIn, X, Dev.to, Medium, YouTube demo.

**Lansman içeriği — karşılaştırmalı demo:**
Sol: bitmap widget, donmuş geri sayım, uygulama kapanınca güncellenmeyen değer.
Sağ: Homeframe native widget, canlı `Chronometer`, normal proses ölümünde devam eden sayaç, reboot ve uygulama yeniden açılışında kurtarma, TalkBack ile okunan metin.

**Ana mesaj:** *Build real Android widgets for Expo — without Kotlin, XML or bitmap rendering.*

---

## 9. Yol Haritası (özet)

Ayrıntılı sprint dökümü: [02-sprint-plani.md](02-sprint-plani.md).

| Dönem | Odak |
| --- | --- |
| Hafta 0 | Ön doğrulama, repo ve test iskeleti |
| Hafta 1 | Teknik doğrulama — **Go/No-Go kapısı** |
| Hafta 2 | DSL ve ara temsil (IR) |
| Hafta 3 | Android code generation |
| Hafta 4 | Veri ve runtime |
| Hafta 5 | Yaşam döngüsü |
| Hafta 6 | Ürün kalitesi (a11y, tema, resize, uyumluluk) |
| Hafta 7 | Production dogfood — Vakity |
| Hafta 8 | Beta yayın |
| Ay 3–4 | Kararlılık, Expo SDK uyumluluğu, dış katkılar |
| Ay 5–6 | iOS adaptörü |
| Ay 7–9 | Preview ve görsel test araçları |

---

## 10. Teknik Riskler

**R1 — Statik DSL'in fazla sınırlı olması.** Geliştiriciler normal React bekleyebilir; arbitrary JS desteklemek codegen'i patlatır.
*Önlem:* API açıkça "React-style widget DSL" olarak konumlanır, desteklenmeyen kullanımda net hata mesajı verilir, sık davranışlar özel primitive olur, kontrollü escape hatch sunulur.

**R2 — Expo SDK güncellemeleri.** Config plugin kırılabilir.
*Önlem:* uyumluluk matrisi, otomatik prebuild testleri, çoklu SDK sürümüne karşı CI, beta sürümlerin erken denenmesi.

**R3 — Android launcher farklılıkları.** Samsung/Xiaomi/Pixel farklı davranır.
*Önlem:* gerçek cihaz havuzu, topluluk uyumluluk raporları, bilinen sorunlar dokümanı, ileride ücretli cihaz testi.

**R4 — Kapsam kayması.** Live Activities, lock-screen, listeler, interaktif butonlar V1'i geciktirir.
*Önlem:* V1 **yalnızca** temel Android ana ekran widget'ı. V1 dışı: Live Activities, lock-screen widget, collection/liste widget'ları, drag-and-drop editor, arbitrary RN bileşenleri, widget içinde doğrudan ağ isteği, görsel SaaS paneli.

**R5 — Expo'nun Android widget desteği çıkarması.**
*Önlem:* Homeframe sadece kurulum paketi olmamalı. Kalıcı farklılaşma: ortak IR, ortak veri API'si, preview, görsel test, migration araçları, countdown/tarih abstraction'ları, platform uyumluluk raporları.

---

## 11. Başarı Metrikleri

GitHub yıldızı **tek** ölçüt değildir.

**İlk 30 gün:** 100 yıldız · 10 gerçek kullanıcı projesi · 5 doğrulanmış production/test build'i · 3 dış katkıcı veya issue yazarı · en az 2 farklı launcher'da doğrulama · Vakity dogfood.

**İlk 3 ay:** 500 haftalık npm indirmesi · 3 production showcase · 250–500 yıldız · en az bir topluluk bülteni · iki Expo SDK sürümü desteği · kritik issue'lara ort. <72 saat dönüş.

**İlk 12 ay:** 2.500 haftalık indirme · 10 production uygulaması · 800–2.000 yıldız (hedef, garanti değil) · 5 düzenli dış katkıcı · ilk ücretli destek müşterisi · iOS adaptörü yayını · preview aracı betası.

**Ürün kalitesi:** crash-free widget session oranı · başarılı prebuild oranı · reboot sonrası doğru state oranı · Expo SDK uyumluluk süresi · açık kritik bug sayısı · ilk kurulum süresi.

**Ana ürün metriği:** *Bir geliştirici boş bir Expo projesinden çalışan native Android widget'a kaç dakikada ulaşıyor?* İlk hedef **30 dakika**, uzun vadeli hedef **<10 dakika**.

---

## 12. Kaynak ve Bütçe

Tek geliştirici, part-time.

| Gider | İlk 6 ay |
| --- | ---: |
| Alan adı ve dokümantasyon | 1.000–3.000 TL |
| Test cihazları | 15.000–40.000 TL |
| Tasarım ve marka materyalleri | 0–10.000 TL |
| CI ve hosting | 0–5.000 TL |
| Demo ve içerik üretimi | 0–5.000 TL |
| Hukuk ve marka araştırması | 5.000–15.000 TL |
| **Toplam** | **21.000–78.000 TL** |

Mevcut cihazlar ve ücretsiz OSS servisleri kullanılırsa bütçe alt sınıra yaklaşır.

**Zaman:** haftada 15–20 saat × 8 hafta → 120–160 saat geliştirme + 20–30 saat dokümantasyon + 10–20 saat lansman + 10–20 saat kullanıcı görüşmesi ≈ **160–230 saat**.

---

## 13. Go/No-Go Kararı

Sprint **S1** sonunda aşağıdaki maddeler kanıtlanmalıdır:

| # | Koşul | Kritik |
| --- | --- | :---: |
| 1 | TypeScript widget tanımı statik bir ara temsile dönüştürülebiliyor | ✅ |
| 2 | Ara temsilden native Android XML üretilebiliyor | ✅ |
| 3 | Expo config plugin tekrar tekrar çalıştırıldığında projeyi bozmuyor | ✅ |
| 4 | Widget, React Native runtime çalışmadan render edilebiliyor | ✅ |
| 5 | Native `Chronometer` normal proses ölümünde ilerliyor; açık `force-stop` sonrasında uygulama yeniden açılınca mutlak `endAt` değerinden kurtarılıyor | |
| 6 | Reboot sonrası mutlak bitiş tarihinden sayaç yeniden oluşturuluyor | |
| 7 | Birden fazla widget instance'ı farklı veri gösterebiliyor | |
| 8 | EAS production build başarılı | |
| 9 | TalkBack widget içeriğini okuyabiliyor | |
| 10 | Vakity widget'ı Homeframe primitive'leriyle yeniden oluşturulabiliyor | |

**Kritik işaretli ilk dört madde başarısız olursa proje SDK olarak sürdürülebilir değildir ve iptal edilir.**
5. ve 6. maddeler ürün tezinin kalbidir; normal proses ölümü, açık `force-stop` sonrası yeniden açılışla kurtarma veya reboot restore başarısız olursa konumlandırma yeniden yazılmalıdır.

Karar kaydı: `docs/reports/sprint-01-go-no-go.md`.

---

## 14. Sonuç

Kısa vadeli amaç RN ekosistemindeki tüm widget problemlerini çözmek değildir. İlk hedef nettir:

> Expo geliştiricilerinin TypeScript kullanarak gerçek native Android widget'ları oluşturmasını sağlamak.

Başarı, geniş özellik sayısından değil şu dar vaadin güvenilir biçimde gerçekleşmesinden gelecektir: bitmap değil native rendering; uygulama çalışmadan devam eden sayaçlar; Kotlin/XML gerektirmeyen geliştirici deneyimi; güvenilir Expo entegrasyonu; production ortamında doğrulanmış kullanım.

İlk sürüm Vakity üzerinde kullanılacak ve gerçek cihazlarda doğrulanacaktır. Android ürünü kararlı hâle geldikten sonra iOS adaptörü ve preview aracı eklenecektir.
