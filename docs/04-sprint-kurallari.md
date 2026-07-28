# Homeframe — Sprint Geçiş Kuralları

> **Tek cümlelik anayasa:** Bir sprintte yapılan her iş, o sprinte ait yazılı testlerle kanıtlanmadan bir sonraki sprint **başlamaz**.

Bu kurallar tek geliştiricili bir projede bile bağlayıcıdır; amaç disiplin tiyatrosu değil, ileride "acaba bu gerçekten çalışıyor muydu?" sorusunu ortadan kaldırmaktır. Kurallar `docs/reports/sprint-XX.md` kapı raporu ile denetlenir.

---

## A. Sprint yaşam döngüsü

### K1 — Sprint sırası kilitlidir
Sprintler [02-sprint-plani.md](02-sprint-plani.md)'deki sırayla yürür. Sprint atlanamaz, paralel iki sprint açılamaz. Bir sonraki sprintin işine "hazırlık" adıyla başlanamaz.

### K2 — Definition of Ready (sprint başlamadan)
Bir sprint ancak şunlar hazırsa başlar:
1. Bir önceki sprintin kapı raporu yazılmış ve **PASS** olarak imzalanmış.
2. Sprintin çıkış kriterleri, her biri en az bir `HF-S<n>-T<no>` kimliğine bağlanmış hâlde listelenmiş.
3. Sprint dalı açılmış: `sprint/S<n>-<kisa-ad>`.
4. Ana dal (`main`) yeşil.

### K3 — Kabul testleri sprintin **başında** yazılır
Sprintin çıkış kriterlerine karşılık gelen testler, ilgili özellik kodlanmadan önce yazılır ve **kırmızı** olarak commit'lenir (`test: HF-S3-T04 kırmızı`). Sprint, bu testlerin kırmızıdan yeşile dönmesiyle biter. Özelliği yazdıktan sonra testi ona uydurmak kural ihlalidir.

### K4 — Definition of Done (bir madde için)
Bir çıkış kriteri şu üçü sağlanınca tamamdır:
1. En az bir **otomatik** test (`HF-` kimlikli) yeşil, **veya** otomatikleştirilemiyorsa (L6) kanıt dosyası ekli manuel kontrol listesi maddesi.
2. Kod ve doküman aynı PR'da güncel — dokümansız özellik yoktur.
3. `pnpm gate` yeşil.

### K5 — Kapı prosedürü (sprint sonu)
Sıra ile:
1. `pnpm gate` çalıştırılır, çıktısı rapora yapıştırılır.
2. Sprint raporu [şablondan](templates/sprint-raporu-sablonu.md) doldurulur: her çıkış kriteri ↔ test kimliği ↔ sonuç.
3. L6 kanıtları `docs/reports/assets/S<nn>/` altına konur.
4. Karar yazılır: **PASS / PASS-WITH-DEBT / FAIL**.
5. Sprint dalı `main`'e merge edilir ve `s<nn>-pass` etiketi atılır.

Rapor yoksa sprint bitmemiştir — kod merge edilmiş olsa bile.

---

## B. Test kuralları

### K6 — Önce başarısız test (bug ve regresyon)
Her bug için önce onu gösteren başarısız test yazılır (`HF-BUG-<issue#>`), sonra fix. Test kalıcıdır, silinmez. Kapatılan bug sayısı ile eklenen regresyon testi sayısı raporda karşılaştırılır.

### K7 — Kırmızı testle merge yok, `skip`/`only` yok
`it.only`, `it.skip`, `@Ignore`, `xit`, yorum satırına alınmış test → merge engeli. Bir test geçici olarak tutulamıyorsa **silinmez**; başarısız bırakılır, issue açılır ve kapı raporunda **borç** olarak görünür.

### K8 — Cihaz kuralı
Yaşam döngüsü, geri sayım, launcher ve restore davranışları emülatörde geçse bile **en az bir fiziksel cihazda** tekrarlanmadan "geçti" sayılmaz. S5 ve S7'de bu **iki farklı üreticinin cihazı** olmak zorundadır. Commit mesajında `(CİHAZDA doğrulandı)` ibaresi ve rapora video/log eklenir.

### K9 — Erişilebilirlik pazarlık konusu değildir
Her primitive doğru erişilebilirlik semantiğini üretir. Native metin ve `Chronometer` semantiği statik `contentDescription` ile ezilmez; metin olmayan erişilebilir primitive açıklama üretmezse **build hatası** verir. Erişilebilirlik ihlali borç olarak taşınamaz; PASS-WITH-DEBT kapsamına giremez.

### K10 — Kapsam ratchet
Kapsam eşikleri ([03-test-stratejisi.md §3](03-test-stratejisi.md)) yalnızca yükselir. Eşiği düşüren PR kırmızıdır. Eşik düşürmek ayrı bir PR, ayrı bir gerekçe ve rapora not gerektirir.

### K11 — Golden dosyalar elle düzenlenmez
Yalnızca `pnpm test -u` ile üretilir; diff **satır satır** gözden geçirilir. Anlaşılmayan bir golden diff'i onaylanamaz. Gürültülü diff'in çözümü tolerans değil, codegen'i determinize etmektir.

### K12 — Idempotency her koşuda test edilir
`expo prebuild` 3 kez çalıştırılıp `git diff --exit-code` temiz olmadıkça hiçbir codegen/plugin değişikliği merge edilmez. Bu test CI'dan çıkarılamaz.

### K13 — Determinizm
Aynı girdi, aynı IR ve aynı XML'i üretir. Zaman damgası, rastgele ID, `Date.now()`, `Math.random()` ve nesne anahtar sırasına bağımlılık üretilen çıktıda yasaktır.

---

## C. Kapı kararları

### K14 — Üç karar tipi
| Karar | Anlamı | Sonuç |
| --- | --- | --- |
| **PASS** | Tüm çıkış kriterleri kanıtlandı | Sonraki sprint başlar |
| **PASS-WITH-DEBT** | Kritik olmayan en fazla **2** madde açık | Borç issue'ları açılır, **sonraki sprintin ilk işi** olur |
| **FAIL** | Kritik madde açık | Sprint uzatılır; sonraki sprint başlamaz |

### K15 — Borç tavanı
Aynı anda taşınabilir toplam borç **2 maddedir** ve **2 sprintten uzun** taşınamaz. Tavan aşılırsa yeni özellik geliştirmesi durur, borç kapatma sprinti açılır.

Borç olamayacak maddeler: erişilebilirlik (K9), idempotency (K12), kapsam eşiği (K10), Go/No-Go kritik dörtlüsü, cihaz doğrulaması gereken yaşam döngüsü maddeleri.

### K16 — S1 özel kuralı: proje iptal edilebilir
İş planı §13'teki **kritik dörtlü** (statik IR · IR→XML · idempotent prebuild · RN'siz render) başarısız olursa proje SDK olarak sürdürülemez; **NO-GO** verilir ve karar `docs/reports/sprint-01-go-no-go.md` içine gerekçesiyle yazılır. Bu karar "biraz daha deneyelim" ile ertelenemez; erteleme ancak yazılı yeni bir hipotez ve zaman kutusu ile mümkündür.

Normal proses ölümü ve açık `force-stop` sonrası yeniden açılışla kurtarma (madde 5) veya reboot restore (madde 6) başarısız olursa proje devam eder ama **konumlandırma yeniden yazılmadan** S2'ye geçilmez.

---

## D. Kapsam ve süreç

### K17 — Kapsam kilidi
V1 dışı listesi ([02-sprint-plani.md](02-sprint-plani.md) sonu) hiçbir sprintte açılmaz. Sprint ortasında gelen her yeni fikir backlog'a yazılır, o sprintte uygulanmaz. "Küçük bir ekleme" diye başlayan iş sprint kapsamına giremez.

### K18 — Zaman kutusu
Bir sprint planlanan süresini **%50'den fazla** aşarsa durdurulur; kapsam bölünür ve kalan kısım yeni sprint olur. Süresiz uzayan sprint yoktur.

### K19 — Dokümantasyon eşzamanlıdır
Özellik PR'ı, ilgili doküman değişikliğini içermek zorundadır. Ayrıca her sprint sonunda uyumluluk matrisi (Expo SDK / Android API / launcher) güncellenir. README'deki kod blokları test edilir (HF-S8-T03) — kırık örnek, kırık üründür.

### K20 — Sürüm çıkarma
`pnpm gate` yeşil + kapı raporu PASS + CHANGELOG girdisi olmadan npm'e hiçbir sürüm (beta dâhil) yayınlanmaz. Yayınlanan tarball temiz bir ortamda kurulup derlenmeden `latest` etiketi verilmez.

### K21 — İstisna süreci
Bir kural çiğnenecekse, çiğnenmeden **önce** kapı raporuna yazılır: hangi kural, neden, hangi tarihe kadar, telafi planı ne. Sonradan yazılan istisna geçersizdir ve o sprintin kararı otomatik olarak FAIL'dır.

---

## E. Hızlı kontrol listesi (her sprint sonu)

- [ ] Tüm çıkış kriterleri bir `HF-` test kimliğine bağlı mı?
- [ ] `pnpm gate` yeşil mi, çıktısı rapora eklendi mi?
- [ ] Kırmızı/atlanmış/`only` test var mı? (olmamalı)
- [ ] L6 kanıtları (video/log) `assets/S<nn>/` altında mı?
- [ ] Cihaz doğrulaması gereken maddeler fiziksel cihazda tekrarlandı mı?
- [ ] Kapsam eşikleri düştü mü? (düşmemeli)
- [ ] Golden diff'leri satır satır incelendi mi?
- [ ] Prebuild idempotency testi koştu mu?
- [ ] Yeni bug'ların hepsi regresyon testiyle kapandı mı?
- [ ] Doküman ve uyumluluk matrisi güncel mi?
- [ ] Açık borç ≤ 2 ve ≤ 2 sprint mi?
- [ ] Karar (PASS / PASS-WITH-DEBT / FAIL) yazılı ve imzalı mı?
