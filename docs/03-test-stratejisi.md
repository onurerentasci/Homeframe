# Homeframe — Test Stratejisi

> Bu doküman, [04-sprint-kurallari.md](04-sprint-kurallari.md)'nın teknik dayanağıdır. Kurallar "ne zaman geçilir"i, bu doküman "nasıl kanıtlanır"ı tanımlar.

## 0. Temel ilke

Homeframe bir **derleyicidir**. Derleyicilerde en ucuz ve en değerli test, *aynı girdiden aynı çıktı* garantisidir. Bu yüzden test ağırlığı klasik piramitten farklıdır: golden/anlık görüntü testleri birinci sınıf vatandaştır, ama **cihazda çalıştığını yalnızca cihaz testi kanıtlar** — golden test "XML doğru üretildi" der, "widget çalışıyor" demez.

Bir özellik iki yerde de kanıtlanmadıkça tamamlanmış sayılmaz:
1. **Üretim doğru mu?** (golden/unit)
2. **Cihazda çalışıyor mu?** (instrumented/manuel kanıt)

---

## 1. Test katmanları

| Katman | Ad | Araç | Nerede çalışır | Süre bütçesi |
| --- | --- | --- | --- | ---: |
| **L0** | Statik ve tip testleri | `tsc --noEmit`, `expect-type`, ESLint | CI + lokal | < 60 sn |
| **L1** | Birim testleri (DSL, IR, validasyon) | Vitest | CI + lokal | < 60 sn |
| **L2** | Golden / anlık görüntü (IR → XML) | Vitest snapshot + `__golden__/` | CI + lokal | < 60 sn |
| **L3** | Plugin entegrasyonu (prebuild, paketleme) | Vitest + gerçek `expo prebuild` | CI | < 5 dk |
| **L4** | Android birim | JUnit + Robolectric | CI | < 3 dk |
| **L5** | Instrumented (emülatör) | androidx.test, UiAutomator | CI (emülatör) | < 10 dk |
| **L6** | Fiziksel cihaz / uzun süre | adb script + video/ekran görüntüsü | Manuel, kayıtlı | Sprint başına |
| **L7** | Erişilebilirlik | espresso-accessibility, Accessibility Scanner, TalkBack | CI + manuel | < 3 dk |
| **L8** | Görsel regresyon (V3) | Preview render + piksel karşılaştırma | CI | < 5 dk |

**Kapı kuralı:** `pnpm gate` L0–L5 + L7'yi çalıştırır. L6 otomatikleştirilemez; **kanıt dosyasıyla** (video/ekran görüntüsü/adb log) sprint raporuna eklenir.

---

## 2. Katman katman ne test edilir

### L0 — Statik
Tip hatası bir kullanıcının build'inde değil, bizim CI'ımızda patlamalıdır. `field("targetAt")` bir `WText`'e verilemiyorsa bu **derleme zamanında** kanıtlanır (`expect-type`), runtime testiyle değil.

### L1 — Birim
DSL ayrıştırma, IR üretimi, şema doğrulama, hata kodları ve **hata mesajı metinleri**. Hata mesajı bu projede bir üründür: mesajlar golden dosyayla kilitlenir, sessizce değişemez.

### L2 — Golden
`packages/codegen-android/__golden__/<widget>/<variant>.xml`.
* Golden dosyalar **elle düzenlenmez**; yalnızca `pnpm test -u` ile üretilir ve diff PR'da incelenir.
* Her golden'ın yanında `README` satırı: bu dosya neyi kanıtlıyor.
* Golden diff'i "gürültülü" ise (ID'ler, sıralama) önce codegen determinize edilir, tolerans eklenmez.

### L3 — Plugin entegrasyonu
* `expo prebuild --clean` + 3× `prebuild` → `git diff --exit-code` (idempotency).
* Elle eklenen Manifest satırının korunması (yıkıcı yazma yok).
* `npm pack` ile üretilen tarball'ın temiz ortamda kurulup derlenmesi.
* Expo SDK matrisi: **güncel sürüm ve bir önceki**.

### L4 — Android birim (Robolectric)
`RemoteViews.apply(context, parent)` çağrılıp ortaya çıkan view ağacı doğrulanır. Bu, gerçek launcher olmadan "binding doğru mu" sorusunu ucuza yanıtlar. Veri deposu, migration ve countdown matematiği de burada.

### L5 — Instrumented (emülatör)
Widget host üzerinden gerçek bağlama, güncelleme, deep link, resize, tema değişimi. UiAutomator ile ana ekrana widget yerleştirip metin okuma.

### L6 — Fiziksel cihaz
Aşağıdakiler **yalnızca** burada kanıtlanır:
* `am force-stop` sonrası Chronometer ilerlemesi
* `adb reboot` sonrası restore
* Doze davranışı
* Launcher farklılıkları (Samsung One UI, Xiaomi HyperOS/MIUI, Pixel)
* 24 saatlik sapma ölçümü

**Cihaz matrisi (asgari)**

| Rol | Cihaz sınıfı | Launcher | API |
| --- | --- | --- | ---: |
| Referans | Pixel (fiziksel veya emülatör-fiziksel çift) | Pixel Launcher | güncel |
| Aykırı 1 | Samsung | One UI | 33+ |
| Aykırı 2 | Xiaomi | HyperOS / MIUI | 31+ |
| Alt sınır | Herhangi | — | 26 |

Kural: **bir davranış emülatörde geçse bile en az bir fiziksel cihazda tekrarlanmadan "geçti" sayılmaz** (bkz. kurallar §K8).

### L7 — Erişilebilirlik
`contentDescription` üretimi codegen seviyesinde zorunludur: üretmeyen primitive **build hatası** verir. Ek olarak espresso-accessibility ihlali sıfır olmalı ve TalkBack okuması sprint başına bir kez kayda alınmalıdır.

### L8 — Görsel regresyon (S12)
Preview render'ı ile cihaz ekran görüntüsü arasındaki fark ≤ %2 piksel. Baseline güncellemesi otomatik değil, PR incelemeli.

---

## 3. Kapsam eşikleri

| Paket | Satır kapsamı | Not |
| --- | ---: | --- |
| `@homeframe/core` | ≥ %90 | DSL ve IR — projenin kalbi |
| `@homeframe/codegen-android` | ≥ %85 | Golden testler kapsamı doğal olarak yükseltir |
| `@homeframe/expo-plugin` | ≥ %80 | Dosya sistemi yolları mock'lanır |
| `@homeframe/cli` | ≥ %70 | İnce katman |
| `runtime-android` (Kotlin) | ≥ %70 | UI dışı sınıflar; RemoteViews binding hariç |

**Ratchet kuralı:** Eşikler yalnızca yukarı gider. Bir PR kapsamı düşürüyorsa CI kırmızıdır; eşik düşürmek için ayrı bir PR ve gerekçe gerekir.

Kapsam yüzdesi tek başına yeterli sayılmaz — kritik yollar (countdown matematiği, epoch zinciri, migration, idempotency) için **kapsam değil, senaryo listesi** takip edilir.

---

## 4. Test isimlendirme ve izlenebilirlik

Her test, sprint planındaki kimliği taşır:

```ts
// HF-S2-T04 — bilinmeyen alan HF1001 ile, dosya+satır bilgisiyle raporlanır
it("HF-S2-T04: bilinmeyen field için HF1001 fırlatır", () => { ... })
```

```kotlin
// HF-S4-T02
@Test fun `HF-S4-T02 iki instance bagimsiz veri tutar`() { ... }
```

Böylece sprint kapısında "hangi kriterin testi nerede" sorusu `grep -r "HF-S4-T02"` ile yanıtlanır. Kimliği olmayan test yazılabilir; ama **kimliği testi olmayan çıkış kriteri kabul edilmez.**

---

## 5. `pnpm gate`

```
pnpm gate
├── lint            (L0)
├── typecheck       (L0)
├── test:unit       (L1, L2)
├── test:plugin     (L3)
├── test:android    (L4, L7)
├── test:device     (L5, emülatör)
└── coverage:check  (eşik + ratchet)
```

Kurallar:
* `gate` yeşil değilse merge yok, sürüm yok, sonraki sprint yok.
* Toplam süre bütçesi **10 dakika**; aşarsa testler paralelleştirilir, **silinmez**.
* `it.skip`, `it.only`, `@Ignore` yasaktır; ESLint ve CI grep'i ile engellenir. Geçici devre dışı bırakma gerekiyorsa test silinmez, **başarısız bırakılır ve issue açılır**.

---

## 6. Kanıt (evidence) formatı

Otomatikleştirilemeyen her doğrulama için sprint raporuna eklenir:

```
docs/reports/assets/S05/
  HF-S5-T01-pixel8-forcestop.mp4
  HF-S5-T02-samsung-s21-reboot.mp4
  HF-S5-T02-adb.log
```

Kanıt kabul koşulları: cihaz modeli ve Android sürümü görünür/kayıtlı · zaman damgası okunabilir · ölçülen değer (sapma, süre) rapor tablosunda yazılı · ham log dosyası ekli.

"Denedim, çalışıyor" bir kanıt değildir.

---

## 7. Regresyon politikası

1. Bug bulunur.
2. **Önce** bug'ı gösteren başarısız test yazılır (kimlik: `HF-BUG-<issue#>`).
3. Fix yazılır, test yeşile döner.
4. Test kalıcıdır; silinmez.

Kapatılan bug sayısı ile regresyon testi sayısı sprint raporunda karşılaştırılır. Eşit değilse fark gerekçelendirilir.

---

## 8. Performans bütçeleri

| Ölçüm | Bütçe | Nerede ölçülür |
| --- | ---: | --- |
| Widget güncelleme (medyan) | < 150 ms | L5 |
| `expo prebuild` ek süresi | < 8 sn | L3 |
| Codegen (10 widget) | < 2 sn | L1 |
| `pnpm gate` toplam | < 10 dk | CI |
| Sıfırdan çalışan widget'a süre | < 30 dk (hedef < 10) | L6, S8-T01 |

Bütçe aşımı bug muamelesi görür: issue açılır, sprint raporuna yazılır.
