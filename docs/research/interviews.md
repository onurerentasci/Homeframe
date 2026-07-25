# S0 — Geliştirici Görüşmeleri

> Durum: **SENTETİK PERSONA SİMÜLASYONU**
> Hazırlanma tarihi: **26 Temmuz 2026**
> Gerçek görüşme sayısı: **0**

Bu belgedeki `P01`–`P10` katılımcıları gerçek kişiler değildir. Expo ve React Native ekosistemindeki farklı geliştirici profillerinin muhtemel deneyimlerini temsil etmek amacıyla oluşturulmuştur.

Bu cevaplar:

* Soru setini prova etmek,
* Olası kullanım senaryolarını belirlemek,
* Ürün hipotezlerini netleştirmek,
* Gerçek görüşmelerde araştırılacak konuları çıkarmak

için kullanılabilir.

S0 doğrulama kanıtı olarak kullanılamaz.

---

## P01

**Rol:** Bağımsız mobil uygulama geliştiricisi
**Deneyim:** 4 yıl React Native, 3 yıl Expo
**Kanal:** Sentetik simülasyon
**Tarih:** 26 Temmuz 2026 — Sentetik

### 1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Evet. Expo ile geliştirdiğim namaz vakitleri uygulamasına Android widget eklemeye çalıştım. Basit çalışan bir prototip hazırladım ancak üretime çıkaramadım.

### 2. Nerede zorlandın veya neden vazgeçtin?

Expo projesinden native Android projesine geçtikten sonra süreç karmaşıklaştı. `AppWidgetProvider`, XML layout, manifest kayıtları ve widget güncelleme mekanizmasını ayrı ayrı yönetmek gerekti.

Prebuild sonrasında değiştirdiğim dosyaların ileride ezilip ezilmeyeceğinden de emin olamadım.

### 3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet. Kotlin ile widget provider ve veri güncelleme kodu yazmam gerekti. Kotlin deneyimim sınırlı olduğu için çoğunlukla örnek kodları uyarladım.

### 4. Kullandığın çözümün en büyük sınırlaması neydi?

React Native tarafındaki state ile widget verisini senkronize etmek zordu. Paket kurulumu tek başına yeterli değildi; native proje üzerinde manuel değişiklik gerekiyordu.

### 5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet. Namaz vakitlerinin TalkBack tarafından okunabilmesi önemli. Widget’ın yalnızca görsel olarak çizilmiş bir resim olmasını istemem.

### 6. Uygulama kapalıyken ilerleyen canlı sayaç senin için önemli mi? Hangi senaryoda?

**Evet.**

Bir sonraki namaz vaktine kalan sürenin uygulama kapalıyken ilerlemesini isterdim. Kullanıcı widget’a baktığında güncel kalan süreyi görmeli.

### 7. Homeframe’i hangi gerçek projede denemek isterdin?

Namaz vakitleri uygulamamda:

* Sıradaki vakit,
* Vakit saati,
* Kalan süre,
* Günlük ilerleme

gösteren bir widget geliştirmek isterdim.

### 8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

Yaklaşık **20 dakika**. Yarım saati aşarsa mevcut native çözümden çok farklı gelmez.

---

## P02

**Rol:** Mobil uygulama ajansında teknik lider
**Deneyim:** 7 yıl mobil geliştirme, 5 yıl React Native
**Kanal:** Sentetik simülasyon
**Tarih:** 26 Temmuz 2026 — Sentetik

### 1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Evet. Bir kargo takip uygulamasında hem Android hem iOS widget geliştirdik.

### 2. Nerede zorlandın veya neden vazgeçtin?

iOS tarafında App Group kurulumu ve ana uygulamayla widget extension arasında veri paylaşımı zaman aldı.

Android’de ise farklı üreticilerin pil optimizasyonları nedeniyle güncelleme davranışları tutarsızdı. Samsung cihazda çalışan güncelleme Xiaomi cihazda gecikebiliyordu.

### 3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet. Android tarafında Kotlin, iOS tarafında SwiftUI kullandık.

### 4. Kullandığın çözümün en büyük sınırlaması neydi?

Tek bir React Native API’si üzerinden iki platformda tutarlı davranış elde edemedik. Her platform için farklı hata ayıklama ve test süreci gerekti.

### 5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet. Özellikle kurumsal müşteriler erişilebilirlik kontrolü talep ediyor. Metinlerin ekran okuyucu tarafından anlamlı sırayla okunması gerekir.

### 6. Uygulama kapalıyken ilerleyen canlı sayaç senin için önemli mi? Hangi senaryoda?

**Evet.**

Kuryenin tahmini varış süresini veya teslimata kalan zamanı göstermek için kullanırdık.

Ancak bunun işletim sistemi tarafından ne ölçüde desteklendiğinin açıkça anlatılması gerekir.

### 7. Homeframe’i hangi gerçek projede denemek isterdin?

Bir yemek teslimatı uygulamasında:

* Sipariş durumu,
* Kurye konumu özeti,
* Tahmini teslimat süresi,
* Teslimata kalan süre

gösteren bir widget üzerinde denerdim.

### 8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

En fazla **30 dakika**. Örnek proje varsa bir saate kadar kabul edilebilir.

---

## P03

**Rol:** Junior Expo geliştiricisi
**Deneyim:** 1,5 yıl JavaScript ve Expo
**Kanal:** Sentetik simülasyon
**Tarih:** 26 Temmuz 2026 — Sentetik

### 1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Eklemeyi denedim ancak çalışan bir sonuç elde edemedim.

### 2. Nerede zorlandın veya neden vazgeçtin?

Android Studio açıldıktan sonra hangi dosyanın ne işe yaradığını anlayamadım. Manifest, XML layout ve Kotlin dosyaları bir anda çok fazla yeni kavram oluşturdu.

Expo kullanmamın nedeni native detaylarla uğraşmamak olduğu için özelliği erteledim.

### 3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Tutorial’da Kotlin kodu yazılması gerekiyordu. Kodları kopyaladım ancak hata aldığımda nasıl düzelteceğimi bilemedim.

### 4. Kullandığın çözümün en büyük sınırlaması neydi?

Dokümantasyon Expo kullanan junior bir geliştirici için yeterince açık değildi. Mevcut paketler native Android bilgisi varmış gibi anlatıyordu.

### 5. Gerçek native metin ve erişilebilirlik önemli mi?

Önemli. Özellikle yapılacaklar listesinin TalkBack tarafından okunabilmesini isterim.

Ancak erişilebilirliği nasıl test edeceğime dair örneğe de ihtiyaç duyarım.

### 6. Uygulama kapalıyken ilerleyen canlı sayaç senin için önemli mi? Hangi senaryoda?

**Evet.**

Pomodoro uygulamamda çalışma oturumunun kalan süresini widget üzerinde göstermek isterim.

### 7. Homeframe’i hangi gerçek projede denemek isterdin?

Kişisel Pomodoro uygulamamda:

* Aktif oturum,
* Kalan süre,
* Bugünkü tamamlanan oturum sayısı,
* Duraklatma veya yeni oturum başlatma

özellikleriyle denerdim.

### 8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

Yaklaşık **10 dakika**. Paket kurulumu ve config dosyasıyla çalışması ideal olur.

---

## P04

**Rol:** Native Android geçmişi olan React Native geliştiricisi
**Deneyim:** 5 yıl Android, 3 yıl React Native
**Kanal:** Sentetik simülasyon
**Tarih:** 26 Temmuz 2026 — Sentetik

### 1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Evet. Spor sonuçları ve kripto fiyatları gösteren iki farklı uygulamada Android widget geliştirdim.

### 2. Nerede zorlandın veya neden vazgeçtin?

Widget’ın kendisini yapmak çok zor değildi. Asıl sorun arka plan güncellemeleri ve cihaz üreticilerinin uygulamayı sonlandırmasıydı.

Kullanıcı her dakika güncel veri bekliyordu ancak sistem bu kadar sık güncellemeye izin vermiyordu.

### 3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet, Kotlin yazdım. Android tarafında sorun değildi ancak iOS eşdeğerini geliştirecek Swift deneyimim yoktu.

### 4. Kullandığın çözümün en büyük sınırlaması neydi?

Platform kısıtlarını yeterince açıklamamasıydı. Paket, güncelleme fonksiyonunu sağlıyordu ancak gerçek cihazda güncellemenin ne zaman gerçekleşeceğini garanti etmiyordu.

### 5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet. Metnin gerçek Android view olarak oluşturulması gerekir. Canvas üzerine çizilmiş bir arayüz yeterli olmaz.

### 6. Uygulama kapalıyken ilerleyen canlı sayaç senin için önemli mi? Hangi senaryoda?

**Evet.**

Maç başlamadan önce geri sayım veya aktif maçta geçen süre gibi senaryolarda önemli olur.

Ancak saniye saniye güncelleme yerine sistemin desteklediği timer yaklaşımının kullanılması gerekir.

### 7. Homeframe’i hangi gerçek projede denemek isterdin?

Canlı skor uygulamasında:

* Sonraki maça kalan süre,
* Aktif maçın skoru,
* Maç dakikası,
* Favori takım bilgisi

gösteren widget geliştirirdim.

### 8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

**20–30 dakika.**

Ayrıca üretilen Kotlin kodunu inceleyebilmek isterim.

---

## P05

**Rol:** iOS ağırlıklı kıdemli mobil geliştirici
**Deneyim:** 8 yıl Swift, 2 yıl React Native
**Kanal:** Sentetik simülasyon
**Tarih:** 26 Temmuz 2026 — Sentetik

### 1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Evet. WidgetKit ile uçuş takibi, takvim ve alışkanlık takibi widget’ları geliştirdim.

### 2. Nerede zorlandın veya neden vazgeçtin?

React Native uygulamasındaki veriyi WidgetKit timeline yapısına aktarmak zaman aldı. JavaScript tarafındaki gerçek zamanlı state mantığı widget yaşam döngüsüne doğrudan uymuyor.

### 3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet, SwiftUI ve Swift kullandım. Benim için sorun değildi.

### 4. Kullandığın çözümün en büyük sınırlaması neydi?

React Native paketleri WidgetKit’in tüm özelliklerini desteklemiyordu. Timeline, deep link ve farklı widget boyutları üzerinde yeterli kontrol vermiyordu.

### 5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet. VoiceOver, Dynamic Type ve localization desteği üretim seviyesinde bir çözüm için zorunlu.

### 6. Uygulama kapalıyken ilerleyen canlı sayaç senin için önemli mi? Hangi senaryoda?

**Hayır, temel önceliğim değil.**

Bir sonraki uçuşa kalan süre yararlı olabilir ancak sistemin timeline mekanizmasıyla çözülebilir. Gerçek zamanlı sayaç vaadine temkinli yaklaşırım.

### 7. Homeframe’i hangi gerçek projede denemek isterdin?

Uçuş takip uygulamasında:

* Kalkış saati,
* Kapı numarası,
* Uçuş durumu,
* Havalimanına kalan süre

gösteren widget geliştirmeyi denerdim.

### 8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

Yaklaşık **45 dakika**.

Benim için hızdan çok oluşturulan native yapının denetlenebilir olması önemlidir.

---

## P06

**Rol:** Startup kurucusu ve full-stack geliştirici
**Deneyim:** 3 yıl Expo, sınırlı native deneyim
**Kanal:** Sentetik simülasyon
**Tarih:** 26 Temmuz 2026 — Sentetik

### 1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Hayır. İki kez araştırdım ancak işin büyüklüğünü görünce vazgeçtim.

### 2. Nerede zorlandın veya neden vazgeçtin?

Aynı özelliğin Android ve iOS için ayrı geliştirilmesi gerekiyordu. MVP aşamasında bunun için birkaç gün ayırmak istemedim.

Ayrıca EAS Build ve native extension süreçlerinin nasıl birlikte çalıştığını tam anlayamadım.

### 3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Yazmadım. Native kod yazmam gerekiyorsa widget özelliğini sonraki sürüme bırakmayı tercih ederim.

### 4. Kullandığın çözümün en büyük sınırlaması neydi?

Gerçek anlamda managed Expo deneyimi sunmamasıydı. Bir noktada Xcode veya Android Studio açılması gerekiyordu.

### 5. Gerçek native metin ve erişilebilirlik önemli mi?

İlk MVP için kritik değil ancak uzun vadede önemli. Ürün büyüdüğünde sonradan yeniden widget yazmak istemem.

### 6. Uygulama kapalıyken ilerleyen canlı sayaç senin için önemli mi? Hangi senaryoda?

**Evet.**

Odaklanma uygulamamızda aktif çalışma oturumunun kalan süresini ana ekranda göstermek temel özellik olabilir.

### 7. Homeframe’i hangi gerçek projede denemek isterdin?

Ekipler için geliştirdiğimiz odaklanma uygulamasında:

* Aktif odak oturumu,
* Kalan süre,
* Günlük hedef,
* Ekipte aktif çalışan kişi sayısı

gösteren widget geliştirirdim.

### 8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

En fazla **15 dakika**.

Ürünün değerini ilk yarım saat içinde görmem gerekir.

---

## P07

**Rol:** Eğitim teknolojileri geliştiricisi
**Deneyim:** 4 yıl React Native
**Kanal:** Sentetik simülasyon
**Tarih:** 26 Temmuz 2026 — Sentetik

### 1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Bir ders planlama uygulamasında prototip olarak ekledik.

### 2. Nerede zorlandın veya neden vazgeçtin?

Widget görsel olarak doğru görünüyordu ancak ekran okuyucu içerikleri beklediğimiz sırayla okumuyordu.

Erişilebilirlik etiketleri ve odak sırası için native kod eklemek gerekti.

### 3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet. Android’de content description, iOS’ta accessibility label düzenlemeleri yaptık.

### 4. Kullandığın çözümün en büyük sınırlaması neydi?

Paketin erişilebilirliği hiç dokümante etmemesiydi. Görsel çıktıya odaklanıyor ancak semantik yapı konusunda kontrol vermiyordu.

### 5. Gerçek native metin ve erişilebilirlik önemli mi?

Kesinlikle önemli.

Gerçek native metin, ekran okuyucu sırası ve erişilebilirlik açıklamaları olmadan kullanamayız.

### 6. Uygulama kapalıyken ilerleyen canlı sayaç senin için önemli mi? Hangi senaryoda?

**Evet.**

Sınav başlangıcına kalan süre, ders süresi veya mola sayacı için kullanılabilir.

### 7. Homeframe’i hangi gerçek projede denemek isterdin?

Öğrenci planlama uygulamasında:

* Sıradaki ders,
* Derse kalan süre,
* Teslim edilecek ödev,
* Günlük çalışma hedefi

gösteren erişilebilir bir widget geliştirirdim.

### 8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

Yaklaşık **30 dakika**.

TalkBack ve VoiceOver test örneklerinin de sağlanması gerekir.

---

## P08

**Rol:** E-ticaret şirketinde React Native geliştiricisi
**Deneyim:** 5 yıl React Native, bare workflow
**Kanal:** Sentetik simülasyon
**Tarih:** 26 Temmuz 2026 — Sentetik

### 1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Hayır. Kampanya widget’ı fikri konuşuldu ancak geliştirmeye alınmadı.

### 2. Nerede zorlandın veya neden vazgeçtin?

Widget’ın kullanıcıya gerçek değer sağlayıp sağlamayacağından emin değildik. Ayrıca sürekli fiyat ve kampanya verisi güncellemenin pil ve ağ tüketimi riski vardı.

### 3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Proof of concept sırasında Kotlin yazılması gerekti. iOS tarafı için de SwiftUI gerekecekti.

### 4. Kullandığın çözümün en büyük sınırlaması neydi?

Sunucu verisinin ne sıklıkla güncellenebileceğinin belirsiz olmasıydı. Pazarlama ekibi anlık kampanya sayacı istiyordu ancak sistem kısıtları buna uymuyordu.

### 5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet. Fiyatların, indirim oranlarının ve butonların erişilebilir olması gerekir.

### 6. Uygulama kapalıyken ilerleyen canlı sayaç senin için önemli mi? Hangi senaryoda?

**Hayır.**

Kampanyanın bitiş saati gösterilebilir ancak saniyelik geri sayım gerekli değil. Dakika veya saat düzeyinde güncelleme yeterli olur.

### 7. Homeframe’i hangi gerçek projede denemek isterdin?

Favoriye alınan ürünlerde:

* Fiyat düşüşü,
* Stok durumu,
* Kampanya bitiş zamanı,
* Sepete dönme bağlantısı

gösteren bir widget üzerinde denerdim.

### 8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

İlk prototip için **1 saat** kabul edilebilir.

Üretim kullanımı için performans ve analytics desteğini de incelemek isterim.

---

## P09

**Rol:** Açık kaynak React Native paket geliştiricisi
**Deneyim:** 6 yıl React Native, Kotlin ve Swift deneyimli
**Kanal:** Sentetik simülasyon
**Tarih:** 26 Temmuz 2026 — Sentetik

### 1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Evet. Kendi demo uygulamamda hem Android hem iOS widget geliştirdim.

### 2. Nerede zorlandın veya neden vazgeçtin?

En zor bölüm ortak bir JavaScript API’sini iki farklı platform modeline uyarlamaktı.

Android RemoteViews ile iOS WidgetKit aynı yetenekleri ve yaşam döngüsünü sunmuyor.

### 3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet. Kotlin, Swift ve native module köprü kodu yazdım.

### 4. Kullandığın çözümün en büyük sınırlaması neydi?

Platform farklarını fazla gizlemesiydi. Desteklenmeyen özelliklerde açık hata vermek yerine bazı durumlarda sessizce başarısız oluyordu.

### 5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet. Ayrıca semantik özelliklerin geliştirici tarafından özelleştirilebilmesi gerekir.

### 6. Uygulama kapalıyken ilerleyen canlı sayaç senin için önemli mi? Hangi senaryoda?

**Hayır.**

Timer özelliği yararlı olabilir ancak ürünün ana vaadi olmamalı. İşletim sistemi sınırlamaları yanlış beklenti oluşturabilir.

### 7. Homeframe’i hangi gerçek projede denemek isterdin?

Açık kaynak bir örnek uygulamada:

* Yapılacaklar listesi,
* Takvim,
* Alışkanlık takibi,
* Zamanlayıcı

widget’ları geliştirerek API kapsamını test etmek isterdim.

### 8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

**20–30 dakika.**

Tip güvenliği, hata mesajları ve üretilen native kodun görülebilmesi kurulum süresinden daha önemli olabilir.

---

## P10

**Rol:** Freelance etkinlik ve bilet uygulamaları geliştiricisi
**Deneyim:** 3 yıl Expo, 1 yıl React Native bare workflow
**Kanal:** Sentetik simülasyon
**Tarih:** 26 Temmuz 2026 — Sentetik

### 1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Hayır. Bir konser uygulaması için istendi ancak teklif süresini ve maliyetini artıracağı için kapsamdan çıkardık.

### 2. Nerede zorlandın veya neden vazgeçtin?

Apple tarafında extension, App Group ve provisioning ayarları karmaşık geldi.

Android tarafı daha anlaşılır görünüyordu ancak iki platformu da desteklemek gerektiği için başlamadım.

### 3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Araştırdığım çözümlerde Kotlin ve Swift kodu gerekiyordu. Native kod yazmadım ve özelliği kaldırdım.

### 4. Kullandığın çözümün en büyük sınırlaması neydi?

Expo projesinde tek komutla çalışmamasıydı. Native klasörlere manuel müdahale gerekiyordu.

### 5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet. Etkinlik adı, mekan ve saat gibi bilgilerin ekran okuyucu tarafından okunabilmesi gerekir.

### 6. Uygulama kapalıyken ilerleyen canlı sayaç senin için önemli mi? Hangi senaryoda?

**Evet.**

Konser veya etkinlik başlangıcına kalan süreyi göstermek için doğrudan kullanırdım.

### 7. Homeframe’i hangi gerçek projede denemek isterdin?

Etkinlik bileti uygulamasında:

* Etkinlik adı,
* Başlangıca kalan süre,
* Mekan bilgisi,
* Bileti açma düğmesi

gösteren widget geliştirirdim.

### 8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

Yaklaşık **10–15 dakika**.

EAS Build ile uyumlu olması gerekir.

---

# Sentetik sonuç tablosu

| Katılımcı | Rol / deneyim                            | Önceki widget deneyimi         | En büyük sorun                      | Canlı sayaç | Deneme senaryosu            | Kurulum beklentisi |
| --------- | ---------------------------------------- | ------------------------------ | ----------------------------------- | :---------: | --------------------------- | ------------------ |
| P01       | Bağımsız Expo geliştiricisi              | Android prototipi geliştirdi   | Expo ve native veri senkronizasyonu |     Evet    | Namaz vaktine kalan süre    | 20 dk              |
| P02       | Ajans teknik lideri                      | Android ve iOS geliştirdi      | App Group ve cihaz farklılıkları    |     Evet    | Teslimata kalan süre        | 30 dk              |
| P03       | Junior Expo geliştiricisi                | Denedi, tamamlayamadı          | Native proje karmaşıklığı           |     Evet    | Pomodoro sayacı             | 10 dk              |
| P04       | Native Android geçmişli RN geliştiricisi | Birden fazla widget geliştirdi | Arka plan ve güncelleme kısıtları   |     Evet    | Maça kalan süre             | 20–30 dk           |
| P05       | Kıdemli iOS geliştiricisi                | WidgetKit deneyimli            | Timeline ve sınırlı RN kontrolü     |    Hayır    | Uçuş bilgisi                | 45 dk              |
| P06       | Startup kurucusu                         | Araştırdı, vazgeçti            | İki platform için ayrı geliştirme   |     Evet    | Odaklanma sayacı            | 15 dk              |
| P07       | Eğitim teknolojileri geliştiricisi       | Erişilebilir widget prototipi  | TalkBack ve VoiceOver semantiği     |     Evet    | Derse kalan süre            | 30 dk              |
| P08       | E-ticaret RN geliştiricisi               | Proof of concept yaptı         | Veri yenileme sıklığı               |    Hayır    | Fiyat ve stok takibi        | 60 dk              |
| P09       | Açık kaynak paket geliştiricisi          | Android ve iOS geliştirdi      | Platform farklarının gizlenmesi     |    Hayır    | Görev ve zamanlayıcı demosu | 20–30 dk           |
| P10       | Freelance Expo geliştiricisi             | Araştırdı, kapsamdan çıkardı   | Extension ve native kurulum         |     Evet    | Etkinliğe kalan süre        | 10–15 dk           |

---

# Sentetik sinyaller

## Canlı sayaç

* Sentetik “evet”: **7 / 10**
* Sentetik “hayır”: **3 / 10**
* Hedeflenen eşik: **6 / 10**

Canlı sayaca olumlu yaklaşan personalar bunu şu senaryolarla ilişkilendirdi:

1. Namaz vaktine kalan süre
2. Teslimata kalan süre
3. Pomodoro sayacı
4. Maça kalan süre
5. Odaklanma oturumu
6. Derse veya sınava kalan süre
7. Etkinlik başlangıcına kalan süre

Deneyimli native geliştiriciler, işletim sistemi kısıtları nedeniyle “canlı” veya “gerçek zamanlı” ifadelerinin dikkatli kullanılmasını bekliyor.

## Native kod ihtiyacı

* Native kod yazmış veya yazması gerekmiş persona: **8 / 10**
* Native kod nedeniyle vazgeçen persona: **3 / 10**
* Xcode veya Android Studio’ya dokunmak istemeyen persona: **3 / 10**

## Erişilebilirlik

* Native metin ve erişilebilirliği önemli gören: **10 / 10**
* Erişilebilirliği ürün seçiminde zorunlu gören: **3 / 10**

Özellikle şu ihtiyaçlar tekrarlandı:

* TalkBack ve VoiceOver desteği
* Anlamlı okuma sırası
* Gerçek native metin
* Erişilebilirlik etiketleri
* Dynamic Type
* Geliştirici tarafından özelleştirilebilir semantik yapı

## Kurulum süresi

* 15 dakika veya altında bekleyen: **3 / 10**
* 30 dakika veya altında bekleyen: **8 / 10**
* 45–60 dakikayı kabul eden: **2 / 10**

Medyan kabul edilebilir kurulum süresi yaklaşık **25 dakika**.

---

# Sentetik ürün çıkarımları

## 1. Homeframe’in ana rakibi başka bir paket değil, vazgeçme kararıdır

Personalardan dördü widget fikrini araştırmış ancak geliştirme maliyeti veya native karmaşıklık nedeniyle tamamlamamıştır.

Bu nedenle ürün mesajı yalnızca:

> React Native ile widget geliştirin.

olmamalıdır.

Daha güçlü bir mesaj:

> Expo veya React Native uygulamanızda native widget’a, ayrı bir native özellik projesi yürütmeden ulaşın.

olabilir.

## 2. İlk değer süresi 30 dakikanın altında olmalıdır

Çoğu persona ilk çalışan widget’ı yaklaşık 10–30 dakika içinde görmek istemektedir.

İdeal başlangıç akışı:

1. Paketi yükle
2. Config plugin’i ekle
3. Widget bileşenini tanımla
4. Örnek veri gönder
5. EAS veya local build al
6. Widget’ı cihazda gör

şeklinde olmalıdır.

## 3. Canlı sayaç güçlü bir giriş özelliği olabilir

Sentetik personaların yedisi canlı sayaç için somut bir kullanım senaryosu üretebilmiştir.

Ancak pazarlama dili teknik olarak sınırlandırılmalıdır. Örneğin:

> Uygulama kapalıyken sistem destekli zaman göstergeleri oluşturun.

ifadesi, “saniye saniye gerçek zamanlı güncelleme” vaadinden daha güvenli olabilir.

## 4. Erişilebilirlik temel mimari özelliği olmalıdır

Native metin ve erişilebilirlik desteği sonradan eklenen bir özellik değil, renderer tasarımının parçası olmalıdır.

İlk API tasarımında en azından şu alanlar bulunmalıdır:

```ts
<Text
  accessibilityLabel="Etkinliğin başlamasına 2 saat kaldı"
  accessibilityRole="text"
>
  2 saat kaldı
</Text>
```

## 5. İleri seviye kullanıcılar kontrol kaybetmek istememektedir

Junior ve Expo odaklı geliştiriciler native detayların gizlenmesini isterken, deneyimli geliştiriciler oluşturulan native kodu incelemek istemektedir.

Bu nedenle iki kullanım seviyesi değerlendirilebilir:

* Basit deklaratif API
* Native çıktıyı özelleştirme veya genişletme katmanı

## 6. En güçlü başlangıç kullanım alanları zaman tabanlı ürünlerdir

Sentetik görüşmelerde en sık tekrar eden alanlar:

* Pomodoro ve odaklanma
* Etkinlik ve bilet
* Namaz ve günlük zaman planlama
* Eğitim ve ders takibi
* Teslimat
* Spor
* Uçuş ve seyahat

---

# S0 kapı özeti

* Sentetik persona simülasyonu: **10 / 10**
* Sentetik canlı sayaç “evet”: **7 / 6 gerekli**
* Gerçek tamamlanan görüşme: **0 / 10**
* Gerçek canlı sayaç “evet”: **0 / 6**
* Gerçek görüşme kanıtı: **Yok**
* Kapı durumu: **AÇIK — gerçek geliştirici yanıtları bekleniyor**

> Sentetik cevaplar ürün yönü ve görüşme hazırlığı için kullanılabilir. S0 kapısının kapanması için gerçek Expo veya React Native geliştiricilerinden toplanmış, tarih ve kanal bilgisi bulunan yanıtlar gerekir.
