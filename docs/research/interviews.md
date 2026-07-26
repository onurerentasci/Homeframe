# Homeframe — Problem Görüşmeleri

> Durum: **KULLANICI TARAFINDAN SAĞLANAN GERÇEK GÖRÜŞME KAYITLARI**
> · Tarih: 26 Temmuz 2026 · Katılımcı: 10 · Canlı sayaç: 7 evet / 3 hayır

Katılımcılar anonim kodlarla kaydedilmiştir. Tarih ve görüşme kanalları kullanıcı
tarafından sağlanmış; katılımcı kimlikleri proje deposunda tutulmamış ve Codex
tarafından bağımsız olarak doğrulanmamıştır.




Görüşme 01

Katılımcı kodu: S-01
Rol: Bağımsız mobil uygulama geliştiricisi
Deneyim: 4 yıl React Native, 3 yıl Expo
LinkedIn yazılı görüşme
Tarih: 26.07.2026

1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Evet. Expo ile geliştirdiğim alışkanlık takip uygulamasına Android widget’ı eklemeyi denedim. Temel sürüm çalıştı fakat mağazaya gönderecek seviyeye getiremedim.

2. Nerede zorlandın veya neden vazgeçtin?

Expo projesinin dışında Android klasörüne girip yapılandırma yapmak zorunda kalmam en büyük sorundu. Widget’ın uygulamadaki verilerle senkron kalması da beklediğimden daha karmaşık çıktı.

3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet. Hazır kütüphaneyi kullansam da widget ayarları ve veri güncellemesi için Kotlin koduna dokunmak zorunda kaldım.

4. Kullandığın çözümün en büyük sınırlaması neydi?

React Native bileşenlerini doğrudan kullanamamak. Uygulamadaki tasarım sistemini widget tarafında tekrar oluşturmam gerekti.

5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet. Widget ekran görüntüsü gibi görünmemeli. Yazı boyutunun sistem ayarlarına uyması ve TalkBack desteği önemli.

6. Uygulama kapalıyken ilerleyen canlı sayaç önemli mi? Hangi senaryoda?

Evet. Pomodoro, oruç süresi ve alışkanlık serisinin bir sonraki hedefe kalan süresi için kullanırdım.

7. Homeframe’i hangi gerçek projede denemek isterdin?

Yayınlamayı planladığım alışkanlık ve odaklanma uygulamasında.

8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

Yaklaşık 30 dakika. Bir saati geçerse mevcut yöntemlerden çok farklı hissettirmez.

Görüşme 02

Katılımcı kodu: S-02
Rol: Dijital ajans çalışanı, kıdemli React Native geliştiricisi
Deneyim: 6 yıl React Native, 2 yıl native Android
React Native Discord topluluğu
Tarih: 26.07.2026

1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Evet. Bir spor salonu müşterisi için antrenman ve üyelik widget’ı geliştirdik.

2. Nerede zorlandın veya neden vazgeçtin?

Asıl sorun ilk widget’ı oluşturmak değil, bunu müşterinin değişen taleplerine göre sürdürmekti. React Native geliştiricilerinin native kodu değiştirememesi işleri tek bir Android geliştiricisine bağımlı hâle getirdi.

3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet. Android tarafında Kotlin, iOS tarafında Swift ve SwiftUI kullandık.

4. Kullandığın çözümün en büyük sınırlaması neydi?

Android ve iOS widget sistemlerinin birbirinden çok farklı olması. Aynı özelliği iki ayrı uygulama geliştiriyormuş gibi oluşturduk.

5. Gerçek native metin ve erişilebilirlik önemli mi?

Kesinlikle. Ajans müşterileri tasarım kadar erişilebilirlik ve cihaz uyumluluğu da bekliyor.

6. Uygulama kapalıyken ilerleyen canlı sayaç önemli mi? Hangi senaryoda?

Evet. Antrenman dinlenme süresi, ders başlangıcına kalan süre ve üyelik bitiş geri sayımı için kullanılabilir.

7. Homeframe’i hangi gerçek projede denemek isterdin?

Fitness, etkinlik bileti ve teslimat takibi projelerinde.

8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

Bir saat kabul edilebilir. Ancak ikinci widget’ı eklemek 10–15 dakikadan uzun sürmemeli.

Görüşme 03

Katılımcı kodu: S-03
Rol: Junior frontend ve React Native geliştiricisi
Deneyim: 1 yıl React Native, çoğunlukla Expo Go
Yerel geliştirici WhatsApp grubu
Tarih: 26.07.2026

1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Hayır. Bir namaz vakti uygulamasında eklemeyi düşündüm ama araştırma aşamasında vazgeçtim.

2. Nerede zorlandın veya neden vazgeçtin?

Expo Go ile yapılamadığını görünce projenin bozulmasından korktum. Prebuild, config plugin, Gradle ve native klasör kavramları fazla geldi.

3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Yazmadım çünkü başlamadan vazgeçtim. Ancak araştırdığım örneklerin çoğunda Kotlin kodu vardı.

4. Kullandığın çözümün en büyük sınırlaması neydi?

Başlangıç seviyesindeki biri için baştan sona çalışan güncel bir örnek bulamamam.

5. Gerçek native metin ve erişilebilirlik önemli mi?

Önemli ama ilk aşamada benim için öncelik widget’ın çalışması olurdu. Sonrasında erişilebilirliği düzeltirdim.

6. Uygulama kapalıyken ilerleyen canlı sayaç önemli mi? Hangi senaryoda?

Hayır. Benim kullanımımda bir sonraki namaz vakti belirli aralıklarla güncellense yeterli olurdu.

7. Homeframe’i hangi gerçek projede denemek isterdin?

Namaz vakti ve günlük hatırlatma uygulamasında.

8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

15–20 dakika. Kurulum çok uzarsa muhtemelen tekrar vazgeçerim.

Görüşme 04

Katılımcı kodu: S-04
Rol: Kıdemli Android geliştiricisi, React Native ekip lideri
Deneyim: 9 yıl Android, 3 yıl React Native
Eski iş arkadaşıyla yazılı görüşme
Tarih: 26.07.2026

1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Evet. RemoteViews ve Jetpack Glance ile birkaç widget geliştirdim.

2. Nerede zorlandın veya neden vazgeçtin?

Widget API’sinin normal Android arayüzlerinden farklı kurallara sahip olması zorlayıcı. Arka plan güncelleme limitleri ve üreticiye göre değişen pil optimizasyonları da sorun çıkarıyor.

3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet, tamamen Kotlin kullandım.

4. Kullandığın çözümün en büyük sınırlaması neydi?

Kullanılabilen bileşenlerin ve etkileşimlerin sınırlı olması. React Native tarafındaki esnekliği bekleyen ekipler hayal kırıklığı yaşayabiliyor.

5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet, özellikle kurumsal uygulamalarda kritik. Görseli bitmap olarak çizmek uzun vadede doğru çözüm değil.

6. Uygulama kapalıyken ilerleyen canlı sayaç önemli mi? Hangi senaryoda?

Evet. Otopark süresi, teslimat tahmini, toplu taşıma kalkış süresi ve sınav geri sayımı gibi alanlarda değerli.

7. Homeframe’i hangi gerçek projede denemek isterdin?

Kargo ve saha operasyonu uygulamasında. Ancak oluşturulan native kodu inceleyebilmek isterdim.

8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

İki saate kadar kabul edilebilir. Benim için hızdan çok üretilen yapının kontrol edilebilir ve güvenilir olması önemli.

Görüşme 05

Katılımcı kodu: S-05
Rol: Freelance React Native geliştiricisi, iOS ağırlıklı
Deneyim: 5 yıl React Native, 4 yıl iOS
LinkedIn yazılı görüşme
Tarih: 26.07.2026

1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Evet. Finansal hedef takip uygulaması için WidgetKit kullandım.

2. Nerede zorlandın veya neden vazgeçtin?

React Native uygulamasıyla widget arasında veri paylaşımı için App Group kurmak ve aynı veri modelini iki tarafta sürdürmek zor oldu.

3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet. WidgetKit için Swift ve SwiftUI yazdım.

4. Kullandığın çözümün en büyük sınırlaması neydi?

Ana uygulamadaki React ve TypeScript mantığını widget tarafında yeniden yazmak. Android sürümünü eklemek de tamamen ayrı bir işti.

5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet. Özellikle Dynamic Type, VoiceOver ve lokalizasyon desteği gerekli.

6. Uygulama kapalıyken ilerleyen canlı sayaç önemli mi? Hangi senaryoda?

Evet. Birikim hedefi tarihine, abonelik yenilenmesine veya borç ödeme tarihine kalan süreyi göstermek için kullanırdım.

7. Homeframe’i hangi gerçek projede denemek isterdin?

Abonelik ve kişisel bütçe takip uygulamasında.

8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

Yaklaşık bir saat. App Group ve veri paylaşımı da otomatikleşiyorsa daha uzun bir ilk kurulum kabul edilebilir.

Görüşme 06

Katılımcı kodu: S-06
Rol: Erken aşama girişim kurucusu ve Expo geliştiricisi
Deneyim: 3 yıl Expo, sınırlı native deneyim
Girişimci geliştirici Slack topluluğu
Tarih: 26.07.2026

1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Hayır. Bir açık artırma uygulamasında planladık ama geliştirme takviminden çıkardık.

2. Nerede zorlandın veya neden vazgeçtin?

Teknik olarak yapılabileceğini gördük fakat küçük ekip için native bağımlılığın bakım maliyeti yüksek görünüyordu. EAS Build sürecini bozma riskini almak istemedik.

3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Hayır, uygulamaya başlamadık. Fakat mevcut çözümlerin çoğu native düzenleme gerektiriyordu.

4. Kullandığın çözümün en büyük sınırlaması neydi?

Kurulumdan sonra çıkabilecek sorunların kimin tarafından çözüleceğinin belirsiz olması.

5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet. Ürünü mağazaya koyuyorsak geçici veya görsel tabanlı bir çözüm kullanmak istemem.

6. Uygulama kapalıyken ilerleyen canlı sayaç önemli mi? Hangi senaryoda?

Evet. Açık artırmanın bitmesine kalan süre bizim için temel kullanım senaryosu.

7. Homeframe’i hangi gerçek projede denemek isterdin?

Açık artırma ve sınırlı süreli kampanya uygulamasında.

8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

20–30 dakika. Ayrıca kurulumun CI/CD üzerinde ekstra manuel adım istememesi gerekir.

Görüşme 07

Katılımcı kodu: S-07
Rol: Ajans çalışanı, orta seviye React Native geliştiricisi
Deneyim: 2,5 yıl React Native ve Expo
Expo Discord topluluğu
Tarih: 26.07.2026

1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Denedim. Bir restoran uygulamasına günlük menü widget’ı eklemek istedik fakat üretim sürümüne ulaşamadık.

2. Nerede zorlandın veya neden vazgeçtin?

Örnek proje çalışıyordu ama mevcut Expo projemize eklediğimizde Gradle ve paket sürümü hataları aldık. Her hata başka bir GitHub yorumuna yönlendiriyordu.

3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Doğrudan Kotlin yazmadım. Fakat AndroidManifest, Gradle ve config plugin dosyalarını değiştirmek zorunda kaldım.

4. Kullandığın çözümün en büyük sınırlaması neydi?

Expo ve React Native sürümleri değiştikçe çözümün çalışmaya devam edip etmeyeceğinin belirsiz olması.

5. Gerçek native metin ve erişilebilirlik önemli mi?

Önemli. Ancak müşterilerin ilk talebi genellikle tasarımın uygulamayla aynı görünmesi oluyor.

6. Uygulama kapalıyken ilerleyen canlı sayaç önemli mi? Hangi senaryoda?

Hayır. Günlük menü, kampanya ve rezervasyon bilgisi için periyodik güncelleme yeterli.

7. Homeframe’i hangi gerçek projede denemek isterdin?

Restoran menüsü ve sadakat puanı uygulamasında.

8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

En fazla 30 dakika. Dokümantasyonda Expo SDK sürümlerinin açıkça belirtilmesi gerekir.

Görüşme 08

Katılımcı kodu: S-08
Rol: React Native altyapı geliştiricisi ve açık kaynak katkıcısı
Deneyim: 7 yıl React Native, Android ve iOS native modül deneyimi
GitHub tartışması sonrası yazılı görüşme
Tarih: 26.07.2026

1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Evet. Hem Android hem de iOS için uygulamaya özel bir widget altyapısı geliştirdim.

2. Nerede zorlandın veya neden vazgeçtin?

En zor kısım UI değildi. Uygulama, widget ve arka plan görevleri arasında güvenilir veri senkronizasyonu kurmaktı.

3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet. Kotlin, Swift ve biraz Objective-C kullandım.

4. Kullandığın çözümün en büyük sınırlaması neydi?

Her widget için veri serileştirme, depolama, güncelleme planlama ve hata yönetiminin tekrar edilmesi.

5. Gerçek native metin ve erişilebilirlik önemli mi?

Kritik. Bir widget kütüphanesinin bitmap veya WebView tabanlı olması benim için kullanmama sebebi olur.

6. Uygulama kapalıyken ilerleyen canlı sayaç önemli mi? Hangi senaryoda?

Evet. Toplu taşıma aracının kalkışına, rezervasyonun başlamasına veya bir teslimat penceresinin kapanmasına kalan süre için önemli.

7. Homeframe’i hangi gerçek projede denemek isterdin?

Toplu taşıma ve seyahat planlama uygulamasında. Özellikle üretilen native kaynakların projede kalmasını isterdim.

8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

Bir saat. Karşılığında veri katmanı ve güncelleme mekanizması da çözülüyorsa oldukça iyi.

Görüşme 09

Katılımcı kodu: S-09
Rol: Fintech şirketinde ürün geliştiricisi
Deneyim: 4 yıl React Native, sınırlı native deneyim
İş arkadaşıyla yazılı görüşme
Tarih: 26.07.2026

1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Hayır. Bakiye ve harcama özeti için değerlendirildi fakat güvenlik ve gizlilik nedeniyle rafa kaldırıldı.

2. Nerede zorlandın veya neden vazgeçtin?

Widget’ta hangi finansal verilerin gösterilebileceği konusunda ürün, güvenlik ve hukuk ekipleri anlaşamadı. Teknik efor da karar vermeyi zorlaştırdı.

3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Hayır. Teknik prototipe geçmedik.

4. Kullandığın çözümün en büyük sınırlaması neydi?

Widget içeriğinin cihaz kilitliyken görülebilmesi ve kullanıcı bazlı gizlilik seçeneklerinin yönetilmesi.

5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet, kurumsal erişilebilirlik standartları nedeniyle zorunlu olurdu.

6. Uygulama kapalıyken ilerleyen canlı sayaç önemli mi? Hangi senaryoda?

Hayır. Finansal veriler için gerçek zamanlı sayaçtan çok güvenli ve kontrollü yenileme önemli.

7. Homeframe’i hangi gerçek projede denemek isterdin?

Finans uygulamasında değil, şirket içi operasyon veya görev takip uygulamasında deneyebilirdim.

8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

45–60 dakika. Ancak güvenlik seçeneklerinin dokümante edilmesi gerekir.

Görüşme 10

Katılımcı kodu: S-10
Rol: Bağımsız eğitim uygulaması geliştiricisi
Deneyim: 4 yıl Expo ve React Native
LinkedIn yazılı görüşme
Tarih: 26.07.2026

1. Daha önce uygulamana ana ekran widget’ı ekledin mi?

Evet. Ders çalışma serisini ve günlük hedefi gösteren basit bir Android widget geliştirdim.

2. Nerede zorlandın veya neden vazgeçtin?

Uygulama kapatıldıktan sonra widget verisinin güncel kalması sorun oldu. Lokalizasyon ve farklı widget boyutları da beklediğimden fazla iş çıkardı.

3. Kotlin/Java/Swift yazmak zorunda kaldın mı?

Evet. Kotlin ile widget provider ve güncelleme kodu yazdım.

4. Kullandığın çözümün en büyük sınırlaması neydi?

Uygulamadaki TypeScript modelini widget tarafında tekrar tanımlamam ve iki kod tabanını eş zamanlı değiştirmem.

5. Gerçek native metin ve erişilebilirlik önemli mi?

Evet. Eğitim uygulamasında büyük yazı desteği ve ekran okuyucu uyumluluğu önemli.

6. Uygulama kapalıyken ilerleyen canlı sayaç önemli mi? Hangi senaryoda?

Evet. Ders çalışma süresi, sınava kalan zaman ve günlük hedefin sıfırlanmasına kalan süre için kullanırdım.

7. Homeframe’i hangi gerçek projede denemek isterdin?

Ders çalışma ve sınav hazırlık uygulamasında.

8. İlk çalışan widget’a ulaşmak için kabul edilebilir kurulum süresi nedir?

30 dakika. Hazır şablonla ikinci widget’ı birkaç dakikada oluşturabilmeliyim.



Katılımcı dağılımı
Profil	Sayı
Bağımsız geliştirici / freelancer	3
Ajans çalışanı	2
Girişim kurucusu	1
Junior geliştirici	1
Native deneyimli kıdemli geliştirici	2
Kurumsal ürün geliştiricisi	1
Toplam	10
Deneyim sonuçları
Bulgular	Sonuç
Daha önce çalışan veya kısmen çalışan widget geliştirmiş	6/10
Widget’ı araştırmış ancak karmaşıklık nedeniyle başlamamış/vazgeçmiş	4/10
Kotlin, Java veya Swift yazmak zorunda kalmış	6/10
Native metin ve erişilebilirliği önemli gören	9/10
Uygulama kapalıyken ilerleyen canlı sayacı önemli gören	7/10
Canlı sayacı gerekli görmeyen	3/10
Kabul edilebilir kurulum süresi

Verilen tahmini süreler:

30 dakika
60 dakika
15–20 dakika
120 dakika
60 dakika
20–30 dakika
30 dakika
60 dakika
45–60 dakika
30 dakika

Yaklaşık medyan kabul edilebilir kurulum süresi 35–45 dakika aralığındadır.

Junior ve Expo ağırlıklı geliştiriciler 15–30 dakika beklerken, native deneyimli geliştiriciler güvenilir ve kontrol edilebilir bir altyapı karşılığında 1–2 saatlik kurulumu kabul etmektedir.

Tekrarlanan sorunlar
1. Native proje yapılandırması

En sık bahsedilen sorunlar:

Expo prebuild sürecine geçmek
AndroidManifest ve Gradle dosyalarını değiştirmek
Config plugin hazırlamak
App Group veya paylaşılan depolama kurmak
Native klasörleri sürdürmek
2. Veri senkronizasyonu

Katılımcıların çoğu widget arayüzünden çok şu konularda zorlanmaktadır:

Uygulama kapalıyken veriyi güncel tutmak
Widget ile React Native uygulaması arasında veri paylaşmak
Arka plan güncelleme sınırlarını yönetmek
Kullanıcı çıkış yaptığında eski veriyi temizlemek
Güncelleme hatalarını izlemek
3. İki ayrı kod tabanı

React Native geliştiricileri aynı iş kurallarını TypeScript ile native tarafta tekrar yazmak istememektedir. Android ve iOS desteğinin ayrı uygulanması bakım maliyetini yükseltmektedir.

4. Kütüphane ve Expo sürüm uyumluluğu

Özellikle daha az deneyimli geliştiriciler için şu belirsizlikler vazgeçme sebebidir:

Hangi Expo SDK sürümlerinin desteklendiği
EAS Build ile uyumluluk
Managed workflow desteği
Güncel ve baştan sona çalışan örnek eksikliği
Kütüphane güncellenmezse projenin ne olacağı
5. Native çıktı beklentisi

Deneyimli geliştiriciler Homeframe’in yalnızca soyut bir araç olmasını değil, oluşturduğu native kaynakların görülebilir ve düzenlenebilir olmasını beklemektedir.

Canlı sayaç kullanım senaryoları

Canlı sayaç isteyen katılımcıların verdiği senaryolar:

Pomodoro ve çalışma süresi
Antrenman ve dinlenme süresi
Açık artırmanın bitişi
Sınava kalan süre
Rezervasyon başlangıcı
Toplu taşıma kalkış zamanı
Teslimat penceresi
Otopark süresi
Abonelik veya hedef tarihi
Oruç süresi

Bu soruda “canlı sayaç” kavramının görüşmelerde daha net tanımlanması gerekir. Katılımcıya aşağıdaki ayrım ayrıca sorulabilir:

Uygulama kapalıyken sistem tarafından görsel olarak ilerletilen geri sayım yeterli mi, yoksa widget verisinin her saniye arka planda yeniden hesaplanması mı gerekiyor?

Homeframe için öne çıkan ürün gereksinimleri

görüşmelere göre Homeframe’in güçlü bir ilk sürümü şunları sağlamalıdır:

Expo config plugin ile tekrarlanabilir kurulum
EAS Build desteği
React/TypeScript benzeri tanımlama modeli
Gerçek native metin ve erişilebilirlik
Uygulama ile widget arasında hazır veri paylaşım katmanı
Uygulama kapalıyken çalışan geri sayım bileşeni
Farklı widget boyutları için responsive yerleşim
Üretilen Kotlin/native kaynaklarını inceleme ve düzenleme imkânı
Açık Expo SDK uyumluluk tablosu
Çalışan örnek projeler ve hata ayıklama ekranı
