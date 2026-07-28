# Sprint S1.1 — PIVOT Düzeltme — Kapı Raporu

| Alan | Değer |
| --- | --- |
| Sprint | S1.1 |
| Dal | `sprint/S1-native-fizibilite` |
| Tarih | 2026-07-29 |
| Kanıt dizini | `docs/reports/assets/S01-1/` |
| **Karar** | **PASS / GO** |

> Karar imzası: Açık `force-stop` ürün kapsamından ayrıştırıldı; uygulama
> yeniden açılışında recovery, reboot restore ve TalkBack fiziksel cihazda
> geçti. **S2 başlangıç kilidi açılmıştır.**

## 1. Çıkış kriterleri ve test eşlemesi

| Test | Kabul ölçütü | Katman | Sonuç | Kanıt |
| --- | --- | --- | --- | --- |
| HF-S1.1-T01 | Başlık + `MM:SS` erişilebilirlik grubu | L2+L4 | ✅ PASS | `RemoteViewsFeasibilityTest`; `event-countdown.xml` golden |
| HF-S1.1-T02 | `HH:MM:SS` doğal saat/dakika/saniye semantiği | L4 | ✅ PASS | `RemoteViewsFeasibilityTest` |
| HF-S1.1-T03 | Bir günü aşan doğal süre semantiği | L4 | ✅ PASS | `RemoteViewsFeasibilityTest` |
| HF-S1.1-T04 | Boş başlık için güvenli fallback | L4 | ✅ PASS | `RemoteViewsFeasibilityTest` |
| HF-S1.1-T05 | Force-stop → yer tutucu → uygulama açılışıyla recovery, ±2 sn | L6 | ✅ PASS | Mi Note 10 Lite: `HF-S1.1-T05-7867b0b7-*`; Pixel: `HF-S1.1-T05-emulator-5554-*` |
| HF-S1.1-T06 | Reboot restore, ±2 sn | L6 | ✅ PASS | Mi Note 10 Lite ve Pixel: `HF-S1-T06-*-reboot.log` |
| HF-S1.1-T07 | İki instance bağımsız başlık ve süre semantiği | L4+L5 | ✅ PASS | Android unit; `HF-S1-T07-emulator-5554-instance-{a,b}.*` |
| HF-S1.1-T08 | TalkBack başlık+süre tek anons; görsel/sesli eşleşme | L7 | ✅ PASS | `HF-S1.1-T08-7867b0b7-talkback-semantic.mp4`; `HF-S1.1-T08-7867b0b7-talkback-semantic-focus.png`; XML ve transkript |

Android unit koşusunda `RemoteViewsFeasibilityTest` 5/5, runner smoke testi
1/1 geçti. T01–T04 ve T07 kalıcı Robolectric regresyon testleridir.

## 2. Ürün sözleşmesi

S1 PIVOT bulgusu aşağıdaki sözleşmeyle kapatıldı:

* **Normal proses ölümü:** Native `Chronometer` launcher içinde çalışmaya
  devam eder.
* **Cihaz reboot:** Widget, saklanan mutlak `endAt` değerinden yeniden kurulur.
* **Kullanıcı tarafından açık `force-stop`:** Android launcher yer tutucu
  gösterebilir; bu sırada canlı sayaç garantisi verilmez.
* **Uygulama yeniden açılışı:** Native recovery provider, React Native
  başlangıcını beklemeden tüm widget instance'larını yeniden render eder.

Config plugin, manifestte export edilmeyen ve uygulama prosesi açılırken çalışan
`HomeframeRecoveryProvider` üretir. AppWidget provider'ın `refresh(Context)`
girişi aynı mutlak `endAt` verisini kullanır.

## 3. TalkBack sonucu

Mi Note 10 Lite üzerinde TalkBack 16.0, fiziksel klavye olarak tanıtılan UHID
odağıyla widget'ın birleşik RemoteViews grubuna taşındı.

* Görsel değer: `S1 feasibility` / `50:02`
* Kaydedilen anons: `S1 feasibility, 50 dakika 2 saniye`
* Anons sonrası 18 saniyede saniyelik tekrar anonsu: **yok**
* XML Chronometer açıklaması: `50 dakika 2 saniye`
* Video: H.264 + Opus, 29,851 sn, 2.134.718 bayt
* Video SHA-256:
  `cc05e558e80ca1a48316dd4fa83169d8ebe76a0d949b7cd5b25bd0d710765a96`

Statik `Homeframe` açıklaması RemoteViews kökünden kaldırıldı. Kök
`importantForAccessibility="yes"` ve `screenReaderFocusable="true"` üretir;
başlık native `TextView`, süre ise Android'in yerelleştirilmiş ve zamanla
güncellenen native `Chronometer` semantiğini korur.

## 4. `pnpm gate`

Son tam koşu: `npx pnpm@11.17.0 gate` — **PASS**. Ham çıktı:
[`assets/S01-1/pnpm-gate.log`](assets/S01-1/pnpm-gate.log).

| Kontrol | Sonuç |
| --- | --- |
| lint + test politikası | ✅ PASS; `skip` / `only` / `@Ignore` yok |
| typecheck | ✅ PASS |
| test:unit | ✅ PASS; 3 dosya / 4 test |
| test:plugin | ✅ PASS; gerçek Expo prebuild işlemleri seri çalıştı |
| test:android | ✅ PASS; 6 test |
| test:device | ✅ PASS; kanıt dosyaları içerik doğrulamalı |
| coverage:check | ✅ PASS |

Coverage sonucu: statements `%87,50`, branches `%82,50`, functions `%94,11`,
lines `%87,09`. Mevcut eşikler düşürülmedi.

## 5. Cihaz ve emülatör kanıtları

| Senaryo | Pixel 7 Pro AVD · API 36 | Mi Note 10 Lite · API 36 · Pixel Launcher |
| --- | --- | --- |
| Metro/app prosesi olmadan render | ✅ PASS | Önceki S1 kanıtı |
| Normal `am kill` | ✅ PASS | Önceki S1 kanıtı |
| Force-stop yer tutucu + açılış recovery | ✅ PASS · sapma `1 sn` | ✅ PASS · sapma `0 sn` |
| İki bağımsız instance | ✅ PASS | Kod + fiziksel tek-instance semantiği |
| Reboot restore | ✅ PASS · sapma `0 sn` | ✅ PASS · sapma `1 sn` |
| Dinamik erişilebilirlik ağacı | ✅ PASS | ✅ PASS |
| TalkBack sesli doğrulama | — | ✅ PASS |

Fiziksel kurulumda kullanılan arm64 debug APK SHA-256 değeri:
`e698d28fb555b0340b36034650e63b6db2fff0d2dc487623692485ab1d3e048c`.

## 6. Regresyon ve operasyon notları

* Pixel Launcher, uygulama açıkça force-stop edildiğinde beklenen yer tutucuyu
  gösterdi; uygulama açılınca `RemoteViews` otomatik geri geldi.
* Pixel emülatör reboot testinin ilk denemesinde launcher erişilebilirlik kökü
  geçici olarak `null` döndü. Launcher yeniden başlatıldıktan sonra aynı test
  `0 sn` sapmayla geçti; ürün kodu hatası gözlenmedi.
* `uiautomator`, canlı `Chronometer` her saniye değişirken idle olamadığından
  canlı recovery önce `dumpsys appwidget` ve ekran görüntüsüyle kanıtlandı;
  aynı `endAt` daha sonra yalnızca XML okumak için sabitlendi.
* Fiziksel test sonunda TalkBack, geçici izinler ve erişilebilirlik ses düzeyi
  önceki durumuna döndürüldü; test yardımcısı kaldırıldı.

## 7. Kontrol listesi

- [x] T01–T08 test kimliklerine ve kanıtlara bağlı
- [x] `pnpm gate` yeşil; ham çıktı rapora bağlı
- [x] Kırmızı / `skip` / `only` test yok
- [x] L6/L7 kanıtları `assets/S01-1/` altında
- [x] Force-stop recovery, reboot ve TalkBack fiziksel cihazda geçti
- [x] Coverage eşikleri düşmedi
- [x] Golden ve seri prebuild idempotency testleri geçti
- [x] Ürün kapsamı ve sprint/test belgeleri güncellendi
- [x] Kritik borç yok

---

**İmza:** Homeframe S1.1 kapısı · **Karar:** **PASS / GO** ·
**Tarih:** 2026-07-29
