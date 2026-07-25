# S0 — Geliştirici Görüşmeleri

> Durum: **SENTETİK ÖN ÇALIŞMA**
> Hedef: En az 10 gerçek görüşme ve canlı sayaç sorusuna en az 6 olumlu yanıt.

Bu bölümdeki `P01`–`P10` yanıtları, farklı geliştirici profillerini temsil eden kurgusal persona yanıtlarıdır. Kişisel veri içermez ancak gerçek kullanıcı araştırmasının yerine geçmez.

---

## P01 — Bağımsız React Native geliştiricisi

**Profil:**
Yaklaşık 4 yıldır React Native kullanıyor. Küçük işletmeler ve bireysel müşteriler için mobil uygulamalar geliştiriyor. Expo managed workflow tercih ediyor ve native projeye mümkün olduğunca dokunmak istemiyor.

1. **Daha önce React Native veya Expo uygulamanıza widget eklediniz mi?**
   Evet. Bir namaz vakitleri uygulamasına Android ana ekran widget'ı eklemeyi denedim.

2. **Hangi platformda ve hangi aşamada zorlandınız?**
   Android tarafında widget verisini uygulamayla senkronize ederken zorlandım. Expo prebuild sonrasında oluşan dosyaların hangilerinin korunacağını anlamak da zordu.

3. **Native Kotlin/Java/Swift kodu yazmak zorunda kaldınız mı?**
   Evet, Kotlin tarafında `AppWidgetProvider` ve veri güncelleme kodu yazdım.

4. **Kullandığınız paketin en önemli sınırlaması neydi?**
   Expo managed workflow ile tamamen uyumlu değildi. Paket kurulsa bile native dosyalarda elle değişiklik yapmak gerekiyordu.

5. **Gerçek native metin ve TalkBack desteği projeniz için önemli mi?**
   Evet. Uygulamanın erişilebilir olmasını ve widget metinlerinin ekran okuyucular tarafından doğru okunmasını isterim.

6. **Uygulama kapalıyken ilerleyen canlı sayaç önemli mi?**
   **Evet.** Namaz vaktine kalan sürenin uygulama kapalıyken de ilerlemesi değerli olurdu.

7. **Homeframe'i hangi somut projede denemek isterdiniz?**
   Namaz vaktine kalan süreyi ve sıradaki vakti gösteren bir ana ekran widget'ında.

8. **Çalışan ilk widget'a ulaşmak için kabul edilebilir kurulum süresi nedir?**
   20–30 dakika. Bir saati geçerse mevcut native çözümlerden çok farklı hissettirmez.

---

## P02 — Kurumsal mobil uygulama geliştiricisi

**Profil:**
Bir finans şirketinde çalışıyor. React Native ile geliştirilen uygulamada güvenlik, bakım maliyeti ve uzun vadeli destek öncelikli.

1. **Daha önce React Native veya Expo uygulamanıza widget eklediniz mi?**
   Hayır. Teknik değerlendirme yaptık ancak projeye eklemedik.

2. **Hangi platformda ve hangi aşamada zorlandınız?**
   iOS WidgetKit ve Android App Widgets için iki ayrı uygulama mimarisi gerektiğini görünce kapsam büyüdü.

3. **Native Kotlin/Java/Swift kodu yazmak zorunda kaldınız mı?**
   Proof of concept aşamasında SwiftUI ve Kotlin kodu yazıldı.

4. **Kullandığınız paketin en önemli sınırlaması neydi?**
   Kurumsal destek ve sürüm garantisi yoktu. Paket bakımının durması ciddi risk oluşturuyordu.

5. **Gerçek native metin ve TalkBack desteği projeniz için önemli mi?**
   Evet, zorunlu. Erişilebilirlik testlerinden geçmeyen bir çözümü yayınlayamayız.

6. **Uygulama kapalıyken ilerleyen canlı sayaç önemli mi?**
   Hayır. Finansal değerlerin belirli aralıklarla yenilenmesi yeterli.

7. **Homeframe'i hangi somut projede denemek isterdiniz?**
   Hesap bakiyesi göstermeden, yaklaşan fatura tarihlerini ve ödeme durumlarını gösteren güvenli bir widget'ta.

8. **Çalışan ilk widget'a ulaşmak için kabul edilebilir kurulum süresi nedir?**
   İlk prototip için 1–2 saat kabul edilebilir. Üretime geçişte dokümantasyon ve test kapsamı daha önemli.

---

## P03 — Startup kurucusu ve full-stack geliştirici

**Profil:**
Teknik kurucu. Ürünü hızlı doğrulamak istiyor ve native geliştirmeye ayıracak zamanı sınırlı.

1. **Daha önce React Native veya Expo uygulamanıza widget eklediniz mi?**
   Hayır. İki kez araştırdım ancak geliştirme maliyeti nedeniyle vazgeçtim.

2. **Hangi platformda ve hangi aşamada zorlandınız?**
   Daha başlamadan zorlandım. Aynı özelliğin Android ve iOS'ta farklı şekilde uygulanması caydırıcıydı.

3. **Native Kotlin/Java/Swift kodu yazmak zorunda kaldınız mı?**
   Hayır, ancak mevcut çözümlerin çoğunun bunu gerektirdiğini gördüm.

4. **Kullandığınız paketin en önemli sınırlaması neydi?**
   Çoğu çözüm yalnızca basit metin ve görsel gösteriyor. Etkileşimli veya zamana bağlı bileşenlerde yetersiz kalıyor.

5. **Gerçek native metin ve TalkBack desteği projeniz için önemli mi?**
   Orta düzeyde önemli. İlk MVP'de engelleyici değil ama ürün büyüdüğünde gerekli olur.

6. **Uygulama kapalıyken ilerleyen canlı sayaç önemli mi?**
   **Evet.** Ürünümüz odaklanma oturumları üzerine olduğu için sayaç temel özellik.

7. **Homeframe'i hangi somut projede denemek isterdiniz?**
   Pomodoro ve derin çalışma oturumlarını gösteren bir widget'ta.

8. **Çalışan ilk widget'a ulaşmak için kabul edilebilir kurulum süresi nedir?**
   En fazla 15 dakika. Ürünün temel vaadi hızlı kurulum olmalı.

---

## P04 — Mobil ajans teknik lideri

**Profil:**
Bir yazılım ajansında farklı müşteri projelerini yönetiyor. Ekipte junior ve mid-level React Native geliştiricileri bulunuyor.

1. **Daha önce React Native veya Expo uygulamanıza widget eklediniz mi?**
   Evet. Hava durumu ve teslimat takip projelerinde widget geliştirdik.

2. **Hangi platformda ve hangi aşamada zorlandınız?**
   iOS tarafında App Group yapılandırması ve uygulama ile widget arasında veri paylaşımı sorun çıkardı. Android üretici farklılıkları da güncelleme davranışını etkiledi.

3. **Native Kotlin/Java/Swift kodu yazmak zorunda kaldınız mı?**
   Evet. Hem Swift hem Kotlin kodu yazıldı.

4. **Kullandığınız paketin en önemli sınırlaması neydi?**
   Tasarım sistemi ile native widget görünümünü eşleştirmek zordu. Ayrıca hata ayıklama süreci yavaştı.

5. **Gerçek native metin ve TalkBack desteği projeniz için önemli mi?**
   Evet. Özellikle kamu ve kurumsal müşterilerde erişilebilirlik gereksinimi var.

6. **Uygulama kapalıyken ilerleyen canlı sayaç önemli mi?**
   **Evet.** Teslimata kalan süre ve kampanya bitiş süreleri için talep geliyor.

7. **Homeframe'i hangi somut projede denemek isterdiniz?**
   Kuryenin tahmini varış süresini gösteren teslimat takip widget'ında.

8. **Çalışan ilk widget'a ulaşmak için kabul edilebilir kurulum süresi nedir?**
   30 dakika ideal. Bir geliştiricinin yarım gününü almamalı.

---

## P05 — Junior Expo geliştiricisi

**Profil:**
Yaklaşık 1 yıldır mobil geliştirme yapıyor. JavaScript ve TypeScript biliyor ancak native mobil geliştirme deneyimi yok.

1. **Daha önce React Native veya Expo uygulamanıza widget eklediniz mi?**
   Denedim ancak tamamlayamadım.

2. **Hangi platformda ve hangi aşamada zorlandınız?**
   Android Studio projesi açıldıktan sonra hangi dosyayı değiştirmem gerektiğini anlayamadım. Manifest ve XML dosyaları karışık geldi.

3. **Native Kotlin/Java/Swift kodu yazmak zorunda kaldınız mı?**
   Eğitimlerde Kotlin kodu yazılması gerekiyordu. Kodları kopyaladım ancak hata çıktığında ilerleyemedim.

4. **Kullandığınız paketin en önemli sınırlaması neydi?**
   Dokümantasyon deneyimli native geliştiriciler için yazılmış gibiydi. Expo kullanan yeni geliştiriciler için yeterli değildi.

5. **Gerçek native metin ve TalkBack desteği projeniz için önemli mi?**
   Evet, fakat bunu kendim nasıl test edeceğimi de öğrenmem gerekir.

6. **Uygulama kapalıyken ilerleyen canlı sayaç önemli mi?**
   **Evet.** Alışkanlık takip uygulamamda günün tamamlanmasına kalan süreyi göstermek isterdim.

7. **Homeframe'i hangi somut projede denemek isterdiniz?**
   Günlük su içme hedefini ve sıradaki hatırlatma süresini gösteren widget'ta.

8. **Çalışan ilk widget'a ulaşmak için kabul edilebilir kurulum süresi nedir?**
   10–15 dakika. Tercihen yalnızca paket kurulumu ve bir config dosyasıyla çalışmalı.

---

## P06 — Deneyimli iOS geliştiricisi

**Profil:**
Swift ve SwiftUI geçmişi güçlü. Son iki yıldır hibrit projelerde React Native kullanıyor. Native koddan kaçınmıyor ancak soyutlamaların kontrol kaybı yaratmasından çekiniyor.

1. **Daha önce React Native veya Expo uygulamanıza widget eklediniz mi?**
   Evet. WidgetKit ile birkaç farklı widget geliştirdim.

2. **Hangi platformda ve hangi aşamada zorlandınız?**
   React Native ile WidgetKit arasındaki veri modelini tutarlı tutmak zaman aldı. Widget zaman çizelgesinin ne zaman yenileneceği de dikkat gerektiriyor.

3. **Native Kotlin/Java/Swift kodu yazmak zorunda kaldınız mı?**
   Evet, SwiftUI kullandım. Benim için sorun değildi.

4. **Kullandığınız paketin en önemli sınırlaması neydi?**
   Soyutlamalar WidgetKit'in tüm yeteneklerini açmıyordu. Gelişmiş görünüm ve timeline kontrolü sınırlıydı.

5. **Gerçek native metin ve TalkBack desteği projeniz için önemli mi?**
   Native metin ve VoiceOver desteği önemli. Android tarafında TalkBack de aynı kalite düzeyinde olmalı.

6. **Uygulama kapalıyken ilerleyen canlı sayaç önemli mi?**
   Hayır. iOS'un güncelleme ve timeline kısıtları nedeniyle gerçek zamanlı sayaç vaadine temkinli yaklaşırım.

7. **Homeframe'i hangi somut projede denemek isterdiniz?**
   Bir seyahat uygulamasında yaklaşan uçuşu, kapı bilgisini ve kalkış saatini gösteren widget'ta.

8. **Çalışan ilk widget'a ulaşmak için kabul edilebilir kurulum süresi nedir?**
   30–45 dakika. Hızdan çok üretilen native kodun denetlenebilir olması önemli.

---

## P07 — Android ağırlıklı React Native geliştiricisi

**Profil:**
Geçmişte native Android geliştirmiş, son yıllarda React Native'e geçmiş. Android widget mimarisine hâkim.

1. **Daha önce React Native veya Expo uygulamanıza widget eklediniz mi?**
   Evet. Spor skoru ve kargo takip uygulamalarında ekledim.

2. **Hangi platformda ve hangi aşamada zorlandınız?**
   Android'de arka plan güncellemeleri, pil optimizasyonları ve farklı üreticilerin süreçleri sonlandırması sorun oluşturdu.

3. **Native Kotlin/Java/Swift kodu yazmak zorunda kaldınız mı?**
   Evet, Kotlin yazdım. iOS tarafında başka bir ekip üyesi çalıştı.

4. **Kullandığınız paketin en önemli sınırlaması neydi?**
   Arka plan güncellemelerinin güvenilir olmaması ve widget tıklama aksiyonlarının sınırlı olması.

5. **Gerçek native metin ve TalkBack desteği projeniz için önemli mi?**
   Evet. Widget içeriğinin yalnızca görsel bir katman olarak çizilmesini istemem.

6. **Uygulama kapalıyken ilerleyen canlı sayaç önemli mi?**
   **Evet.** Maç başlangıcına veya teslimata kalan süre için güçlü bir özellik.

7. **Homeframe'i hangi somut projede denemek isterdiniz?**
   Canlı maç başlangıç saatini ve maç başladığında geçen süreyi gösteren spor widget'ında.

8. **Çalışan ilk widget'a ulaşmak için kabul edilebilir kurulum süresi nedir?**
   20 dakika. Ancak arka plan davranışlarını anlamak için iyi bir debug ekranı da olmalı.

---

## P08 — Erişilebilirlik odaklı ürün geliştiricisi

**Profil:**
Eğitim teknolojileri alanında çalışıyor. Görme engelli ve motor beceri kısıtlı kullanıcılar için erişilebilirlik standartlarına önem veriyor.

1. **Daha önce React Native veya Expo uygulamanıza widget eklediniz mi?**
   Evet, bir eğitim planlama uygulamasında prototip geliştirdik.

2. **Hangi platformda ve hangi aşamada zorlandınız?**
   Widget içerikleri görsel olarak doğru görünmesine rağmen ekran okuyucularında anlamsız sırayla okunuyordu.

3. **Native Kotlin/Java/Swift kodu yazmak zorunda kaldınız mı?**
   Evet. Erişilebilirlik etiketlerini ve odak sırasını düzeltmek için native kod gerekti.

4. **Kullandığınız paketin en önemli sınırlaması neydi?**
   Erişilebilirlik özellikleri dokümante edilmemişti. Paket yalnızca görsel sonucu hedefliyordu.

5. **Gerçek native metin ve TalkBack desteği projeniz için önemli mi?**
   Kesinlikle önemli. Bu destek yoksa ürünü kullanmam.

6. **Uygulama kapalıyken ilerleyen canlı sayaç önemli mi?**
   **Evet.** Sınav süresi, ders başlangıcı veya odaklanma oturumu için erişilebilir sayaç kullanılabilir.

7. **Homeframe'i hangi somut projede denemek isterdiniz?**
   Öğrencinin sıradaki dersini ve derse kalan süreyi erişilebilir biçimde gösteren bir widget'ta.

8. **Çalışan ilk widget'a ulaşmak için kabul edilebilir kurulum süresi nedir?**
   30 dakika kabul edilebilir. Erişilebilirlik testi örnekleri de sağlanmalı.

---

## P09 — No-code/low-code odaklı ürün geliştiricisi

**Profil:**
Expo, Supabase ve hazır servislerle hızlı MVP geliştiriyor. Native araç zincirlerine hâkim değil.

1. **Daha önce React Native veya Expo uygulamanıza widget eklediniz mi?**
   Hayır. Teknik olarak çok karmaşık göründüğü için kapsamdan çıkardım.

2. **Hangi platformda ve hangi aşamada zorlandınız?**
   Apple Developer tarafında extension, entitlement ve App Group kavramlarını anlamakta zorlandım.

3. **Native Kotlin/Java/Swift kodu yazmak zorunda kaldınız mı?**
   Henüz yazmadım. Native kod zorunluysa özelliği eklememeyi tercih ederim.

4. **Kullandığınız paketin en önemli sınırlaması neydi?**
   Gerçek anlamda “Expo uyumlu” olmaması. Bir noktada Xcode ve Android Studio açmak gerekiyor.

5. **Gerçek native metin ve TalkBack desteği projeniz için önemli mi?**
   Evet, ancak otomatik olarak sağlanmasını beklerim.

6. **Uygulama kapalıyken ilerleyen canlı sayaç önemli mi?**
   **Evet.** Etkinlik bilet uygulamamda etkinliğe kalan süreyi göstermek isterdim.

7. **Homeframe'i hangi somut projede denemek isterdiniz?**
   Konser veya etkinlik başlangıcına kalan zamanı ve QR bilete erişim düğmesini gösteren widget'ta.

8. **Çalışan ilk widget'a ulaşmak için kabul edilebilir kurulum süresi nedir?**
   5–10 dakika. Expo config plugin üzerinden otomatik kurulmalı.

---

## P10 — Açık kaynak paket geliştiricisi

**Profil:**
React Native ekosisteminde açık kaynak paketler geliştiriyor. API tasarımı, platform uyumluluğu ve bakım maliyetiyle ilgileniyor.

1. **Daha önce React Native veya Expo uygulamanıza widget eklediniz mi?**
   Evet. Kendi uygulamamda ve bir açık kaynak denemesinde widget geliştirdim.

2. **Hangi platformda ve hangi aşamada zorlandınız?**
   Ortak bir JavaScript API'sini iki platformun farklı yaşam döngülerine uyarlamak zordu.

3. **Native Kotlin/Java/Swift kodu yazmak zorunda kaldınız mı?**
   Evet. Kotlin, Swift ve bir miktar Objective-C köprü kodu kullandım.

4. **Kullandığınız paketin en önemli sınırlaması neydi?**
   Platform farklarını fazla gizliyordu. Desteklenmeyen özelliklerde sessizce başarısız oluyordu.

5. **Gerçek native metin ve TalkBack desteği projeniz için önemli mi?**
   Evet. Ayrıca üretilen semantik yapının geliştirici tarafından özelleştirilebilmesi gerekir.

6. **Uygulama kapalıyken ilerleyen canlı sayaç önemli mi?**
   Hayır. İşletim sistemi kısıtları açıkça anlatılmadığı sürece böyle bir özelliği ürün vaadinin merkezine koymam.

7. **Homeframe'i hangi somut projede denemek isterdiniz?**
   Açık kaynak bir demo uygulamasında görev listesi, takvim ve zamanlayıcı widget'ları oluşturarak API yüzeyini test etmek isterdim.

8. **Çalışan ilk widget'a ulaşmak için kabul edilebilir kurulum süresi nedir?**
   20–30 dakika. Bunun yanında örnek proje, tip güvenliği ve hata mesajları önemli.

---

# Sonuçlar

| Katılımcı | Rol / deneyim                      | Widget deneyimi                  | En büyük sorun                               | Canlı sayaç | Deneme senaryosu            | Tarih    |
| --------- | ---------------------------------- | -------------------------------- | -------------------------------------------- | :---------: | --------------------------- | -------- |
| P01       | Bağımsız RN geliştiricisi, 4 yıl   | Android widget geliştirdi        | Expo dışına çıkma ve veri senkronizasyonu    |     Evet    | Namaz vaktine kalan süre    | Sentetik |
| P02       | Kurumsal finans geliştiricisi      | Teknik değerlendirme yaptı       | Çift platform maliyeti ve bakım riski        |    Hayır    | Yaklaşan faturalar          | Sentetik |
| P03       | Startup teknik kurucusu            | Araştırdı, uygulamadı            | Native geliştirme maliyeti                   |     Evet    | Pomodoro sayacı             | Sentetik |
| P04       | Mobil ajans teknik lideri          | iOS ve Android widget geliştirdi | App Group, veri paylaşımı ve hata ayıklama   |     Evet    | Teslimata kalan süre        | Sentetik |
| P05       | Junior Expo geliştiricisi          | Denedi, tamamlayamadı            | Native proje yapısının karmaşıklığı          |     Evet    | Su hedefi ve hatırlatma     | Sentetik |
| P06       | Deneyimli iOS geliştiricisi        | WidgetKit deneyimli              | Timeline kontrolü ve sınırlı soyutlama       |    Hayır    | Yaklaşan uçuş bilgisi       | Sentetik |
| P07       | Android ağırlıklı RN geliştiricisi | Birden fazla widget geliştirdi   | Pil optimizasyonu ve arka plan güncellemesi  |     Evet    | Maça kalan süre             | Sentetik |
| P08       | Erişilebilirlik odaklı geliştirici | Eğitim widget'ı prototipi        | Ekran okuyucu ve odak sırası                 |     Evet    | Derse kalan süre            | Sentetik |
| P09       | Low-code Expo geliştiricisi        | Deneyimi yok                     | Xcode, entitlement ve App Group karmaşıklığı |     Evet    | Etkinliğe kalan süre        | Sentetik |
| P10       | Açık kaynak paket geliştiricisi    | İki platformda deneyimli         | Platform farklarının gizlenmesi              |    Hayır    | Görev ve zamanlayıcı demosu | Sentetik |

## Sentetik sinyal özeti

* Canlı sayaç yanıtı: **7 evet / 3 hayır**
* Native kod yazan veya yazmak zorunda kalan: **7 / 10**
* Expo/native entegrasyonunu temel sorun olarak belirten: **6 / 10**
* Erişilebilirliği önemli veya zorunlu gören: **10 / 10**
* 30 dakika veya altında ilk kurulum bekleyen: **8 / 10**
* Native araçlara hiç dokunmak istemeyen: **2 / 10**

## Öne çıkan ürün sinyalleri

1. **Canlı sayaç ilgi çekiyor ancak teknik beklenti yönetimi gerekiyor.**
   Sentetik katılımcıların yedisi bu özelliği somut bir kullanım senaryosuyla ilişkilendirdi. Deneyimli geliştiriciler ise işletim sistemi sınırlamaları nedeniyle “gerçek zamanlı” ifadesine temkinli yaklaştı.

2. **Temel problem yalnızca widget çizmek değil, native proje yönetimi.**
   App Group, entitlement, Android manifest, background task ve prebuild sonrası dosya yönetimi tekrar eden sorunlar olarak öne çıktı.

3. **Expo uyumluluğu güçlü bir farklılaşma noktası olabilir.**
   Özellikle junior, bağımsız ve hızlı MVP geliştiren kullanıcılar Xcode veya Android Studio'ya geçmeden ilerlemek istiyor.

4. **Erişilebilirlik ikincil bir özellik olarak görülmemeli.**
   Tüm personalar gerçek native metin ve ekran okuyucu desteğini en azından uzun vadede önemli gördü.

5. **İlk değer süresi 30 dakikanın altında olmalı.**
   Çoğu persona ilk çalışan widget'ın 10–30 dakika içinde oluşturulmasını bekliyor.

6. **İleri seviye geliştiriciler kaçış kapısı istiyor.**
   Deneyimli native ve açık kaynak geliştiricileri, oluşturulan native kodun görülebilmesini ve gerektiğinde özelleştirilebilmesini önemsiyor.

## S0 kapı özeti

* Sentetik persona yanıtı: **10 / 10**
* Sentetik canlı sayaç “evet”: **7 / 6**
* Gerçek tamamlanan görüşme: **0 / 10**
* Gerçek canlı sayaç “evet”: **0 / 6**
* Kapı durumu: **AÇIK — gerçek görüşme kanıtı bekleniyor**

> Bu çalışma soru setinin prova edilmesini ve hipotezlerin belirlenmesini sağlar. S0 kapısının kapanması için yanıtların gerçek geliştirici görüşmelerinden toplanması gerekir.
