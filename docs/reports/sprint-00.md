# Sprint S00 — Ön Doğrulama ve İskelet — Kapı Raporu

| Alan | Değer |
| --- | --- |
| Sprint | S00 |
| Planlanan süre | 3 gün |
| Gerçekleşen süre | < 1 gün |
| Dal | `sprint/S0-iskele` |
| Etiket | `s00-pass` |
| Tarih | 2026-07-26 |
| **Karar** | **PASS-WITH-DEBT** |

> Düz `PASS` verilmedi. Gerçek geliştirici görüşmeleri ve npm ad rezervasyonu
> tamamlanmadı; iki madde K14/K15 uyarınca S1'in ilk işi olarak taşındı.

---

## 1. Kabul testleri

| # | Kabul testi | Test kimliği | Katman | Sonuç | Kanıt |
| --- | --- | --- | --- | --- | --- |
| 1 | Boş test paketinde kapı hata üretmez | HF-S0-T01 | L0 | ✅ | `tests/s0/gate-contract.test.ts` |
| 2 | Kasıtlı bozuk test kırmızı sonuç üretir | HF-S0-T02 | L0 | ✅ | `tests/s0/gate-contract.test.ts` |
| 3 | Tüm workspace TypeScript kontrolünden geçer | HF-S0-T03 | L0 | ✅ | `pnpm typecheck` + GitHub Actions |

## 2. S0 çıktı denetimi

| Çıktı / kriter | Sonuç | Kanıt / borç |
| --- | --- | --- |
| pnpm monorepo iskeleti | ✅ | `packages/`, `runtime-android/`, `examples/basic/` |
| CI yeşil | ✅ | [GitHub Actions koşusu 30179551832](https://github.com/onurerentasci/Homeframe/actions/runs/30179551832) |
| Teknik README yayımlandı | ✅ | [Public GitHub deposu](https://github.com/onurerentasci/Homeframe) |
| Rakip sürüm ve kullanım verisi güncel | ✅ | `docs/research/competitor-snapshot.md` |
| En az 10 gerçek geliştirici görüşmesi, ≥6 canlı sayaç “evet” | ❌ | [Borç #2](https://github.com/onurerentasci/Homeframe/issues/2) — gerçek görüşme 0/10 |
| `homeframe` npm adı rezerve edildi | ❌ | [Borç #3](https://github.com/onurerentasci/Homeframe/issues/3) — registry kontrolü 404, rezervasyon yok |

## 3. `pnpm gate` çıktısı

Son çalışma: 2026-07-26 02:51 Europe/Istanbul · exit code: `0`

```text
$ pnpm lint && pnpm typecheck && pnpm test:unit && pnpm test:plugin && pnpm test:android && pnpm test:device && pnpm coverage:check
$ eslint . --max-warnings 0 && node scripts/check-test-policy.mjs
Test politikası: skip/only/@Ignore bulunmadı.
$ tsc --noEmit
$ vitest run --passWithNoTests

 RUN  v4.1.10 /Users/tasci/MyCode/Homeframe


 Test Files  1 passed (1)
      Tests  2 passed (2)
   Start at  02:51:58
   Duration  1.05s (transform 11ms, setup 0ms, import 16ms, tests 938ms, environment 0ms)

$ vitest run --passWithNoTests packages/expo-plugin

 RUN  v4.1.10 /Users/tasci/MyCode/Homeframe

No test files found, exiting with code 0

filter: packages/expo-plugin
include: tests/**/*.test.ts, packages/**/*.test.ts
exclude:  **/node_modules/**, **/dist/**, **/build/**, .tmp-homeframe-*/**

$ ./gradlew test
> Task :runtime-android:compileJava NO-SOURCE
> Task :runtime-android:processResources NO-SOURCE
> Task :runtime-android:classes UP-TO-DATE
> Task :runtime-android:compileTestJava UP-TO-DATE
> Task :runtime-android:processTestResources NO-SOURCE
> Task :runtime-android:testClasses UP-TO-DATE
> Task :runtime-android:test UP-TO-DATE
> Task :test UP-TO-DATE

BUILD SUCCESSFUL in 505ms
2 actionable tasks: 2 up-to-date
Consider enabling configuration cache to speed up this build: https://docs.gradle.org/9.3.1/userguide/configuration_cache_enabling.html
$ node scripts/report-unavailable-stage.mjs device
test:device — NOT_APPLICABLE (S0): Android host uygulaması S1 fizibilite sprintinde eklenecek.
$ pnpm coverage
$ vitest run --coverage --passWithNoTests

 RUN  v4.1.10 /Users/tasci/MyCode/Homeframe
      Coverage enabled with v8


 Test Files  1 passed (1)
      Tests  2 passed (2)
   Start at  02:52:01
   Duration  1.35s (transform 22ms, setup 0ms, import 34ms, tests 1.17s, environment 0ms)

 % Coverage report from v8
----------|---------|----------|---------|---------|-------------------
File      | % Stmts | % Branch | % Funcs | % Lines | Uncovered Line #s
----------|---------|----------|---------|---------|-------------------
All files |       0 |        0 |       0 |       0 |
----------|---------|----------|---------|---------|-------------------

=============================== Coverage summary ===============================
Statements   : Unknown% ( 0/0 )
Branches     : Unknown% ( 0/0 )
Functions    : Unknown% ( 0/0 )
Lines        : Unknown% ( 0/0 )
================================================================================
```

| Kontrol | Sonuç |
| --- | --- |
| lint | ✅ |
| typecheck | ✅ |
| test:unit | ✅ (2 test) |
| test:plugin | ✅ (S0'da boş suite) |
| test:android | ✅ (1 JUnit smoke testi) |
| test:device | ➖ `NOT_APPLICABLE` (S1'de başlar) |
| coverage:check | ✅ (S0 üretim kodu yok, 0/0) |

## 4. Kapsam

| Paket | S0 eşiği | Bu sprint | Önceki sprint | Yön |
| --- | ---: | ---: | ---: | --- |
| `@homeframe/core` | Uygulanmaz (S2'de %90) | 0/0 | — | — |
| `@homeframe/codegen-android` | Uygulanmaz (S3'te %85) | 0/0 | — | — |
| `@homeframe/expo-plugin` | Uygulanmaz (S3'te %80) | 0/0 | — | — |
| `runtime-android` | Ürün kodu yok | JUnit smoke ✅ | — | — |

## 5. Cihaz doğrulaması

S0'da Android host uygulaması veya cihaz davranışı bulunmadığı için L5/L6
uygulanmaz. Cihaz kanıtı S1 fizibilite sprintinde başlar.

## 6. Performans bütçeleri

| Ölçüm | Bütçe | Ölçülen | Sonuç |
| --- | ---: | ---: | --- |
| `pnpm gate` toplam | < 10 dk | 8,5 sn | ✅ |
| Gradle test | < 3 dk | 505 ms | ✅ |
| Codegen / widget güncelleme | S0'da uygulanmaz | — | — |

## 7. Bug ve regresyon

Kapatılan ürün bug'ı: **0** · Eklenen kabul testi: **2** · Gradle 9 için açık
JUnit Platform launcher bağımlılığı ilk kırmızı koşuda bulunup aynı geliştirme
oturumunda düzeltildi.

## 8. Borç

| # | Açık madde | Neden kritik değil | Issue | Son tarih |
| --- | --- | --- | --- | --- |
| 1 | 10 gerçek geliştirici görüşmesi ve ≥6 olumlu canlı sayaç sinyali | Teknik iskelet ve test kapısı bağımsız doğrulandı; sentetik veri kanıt sayılmadı | [#2](https://github.com/onurerentasci/Homeframe/issues/2) | S1'in ilk işi |
| 2 | `homeframe` npm ad rezervasyonu | Yerel geliştirme ve native fizibiliteyi teknik olarak engellemiyor | [#3](https://github.com/onurerentasci/Homeframe/issues/3) | S1'in ilk işi |

Borç tavanı: **2 / 2**. Yeni S1 ürün geliştirmesi, bu iki issue kapanmadan
başlayamaz.

## 9. Kural istisnaları

| Kural / kriter | Gerekçe | Telafi planı | Son tarih | Önceden yazıldı mı? |
| --- | --- | --- | --- | :---: |
| S0 kırmızı CI ekran görüntüsü | Kasıtlı kırmızı alt koşu HF-S0-T02 ile her gate çalışmasında otomatik doğrulanıyor; ayrı bir kırmızı uzak CI commit'i tutulmadı | Otomatik sözleşme testi kalıcıdır; CI yeşil koşu bağlantısı rapora eklendi | S0 | ✅, merge öncesi |

## 10. Öğrenilenler ve sonraki sprinte etki

- Sentetik persona simülasyonu canlı sayaç için 7/10 olumlu hipotez üretti,
  fakat gerçek kullanıcı kanıtı olarak sayılmadı.
- Ana risk yalnızca native render değil; prebuild idempotency, yaşam döngüsü ve
  geliştiricinin üretilen native çıktıyı denetleyebilmesi.
- S1 ürün koduna geçmeden önce borç #2 ve #3 kapanacak.

## 11. Kontrol listesi

- [x] Kabul testleri `HF-` kimliğine bağlı
- [x] `pnpm gate` yeşil, tam çıktı eklendi
- [x] Kırmızı / `skip` / `only` test yok
- [x] L6'nın S0'da uygulanmadığı kaydedildi
- [x] S0 kapsam eşiklerinin henüz uygulanmadığı açıklandı
- [x] Kırmızı test sözleşmesi otomatik doğrulandı
- [x] Doküman ve pazar anlık görüntüsü güncel
- [x] Açık borç 2 madde ve S1'in ilk işine bağlı
- [x] Karar yazılı
- [ ] Gerçek görüşme kanıtı tamamlandı — borç #2
- [ ] npm adı rezerve edildi — borç #3

---

**İmza:** Codex (otomatik kapı raporu) · **Tarih:** 2026-07-26
