# Sprint S00 — Ön Doğrulama ve İskelet — Kapı Raporu

| Alan | Değer |
| --- | --- |
| Sprint | S00 |
| Planlanan süre | 3 gün |
| Gerçekleşen süre | < 1 gün |
| Dal | `sprint/S0-iskele` |
| Etiket | `s00-pass` |
| Tarih | 2026-07-26 |
| **Karar** | **PASS** |

> Tüm S0 çıkış kriterleri karşılandı. Gerçek geliştirici görüşmesi eşiği
> kullanıcı tarafından sağlanan 10 anonim kayıtla geçti. npm kullanılabilirliği
> kimliği doğrulanmış oturumdan kontrol edildi; npm politikası gereği işlevsiz
> rezervasyon paketi yayımlanmadı.

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
| En az 10 gerçek geliştirici görüşmesi, ≥6 canlı sayaç “evet” | ✅ | `docs/research/interviews.md` — 10 anonim kayıt, 7 evet / 3 hayır |
| `homeframe` npm kullanılabilirliği ve yayın politikası | ✅ | `npm whoami` doğrulandı, registry 404; işlevsiz paket yayımlanmadı. [Karar kaydı](../research/competitor-snapshot.md) |

## 3. `pnpm gate` çıktısı

Son çalışma: 2026-07-26 03:41 Europe/Istanbul · exit code: `0`

```text
$ pnpm lint && pnpm typecheck && pnpm test:unit && pnpm test:plugin && pnpm test:android && pnpm test:device && pnpm coverage:check
$ eslint . --max-warnings 0 && node scripts/check-test-policy.mjs
Test politikası: skip/only/@Ignore bulunmadı.
$ tsc --noEmit
$ vitest run --passWithNoTests

 RUN  v4.1.10 /Users/tasci/MyCode/Homeframe


 Test Files  1 passed (1)
      Tests  2 passed (2)
   Start at  03:41:55
   Duration  1.06s (transform 11ms, setup 0ms, import 16ms, tests 942ms, environment 0ms)

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

BUILD SUCCESSFUL in 458ms
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
   Start at  03:41:58
   Duration  1.10s (transform 8ms, setup 0ms, import 14ms, tests 987ms, environment 0ms)

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
| Gradle test | < 3 dk | 458 ms | ✅ |
| Codegen / widget güncelleme | S0'da uygulanmaz | — | — |

## 7. Bug ve regresyon

Kapatılan ürün bug'ı: **0** · Eklenen kabul testi: **2** · Gradle 9 için açık
JUnit Platform launcher bağımlılığı ilk kırmızı koşuda bulunup aynı geliştirme
oturumunda düzeltildi.

## 8. Borç

Açık S0 borcu yoktur.

- Görüşme borcu #2: 10 anonim kayıt ve 7/10 olumlu canlı sayaç sinyaliyle
  tamamlandı.
- npm rezervasyon borcu #3: npm isim işgali politikasıyla çeliştiği için
  `not planned`; yerine kimliği doğrulanmış oturumdan kullanılabilirlik kontrolü
  ve yayın politikası kararı kaydedildi.

## 9. Kural istisnaları

| Kural / kriter | Gerekçe | Telafi planı | Son tarih | Önceden yazıldı mı? |
| --- | --- | --- | --- | :---: |
| S0 kırmızı CI ekran görüntüsü | Kasıtlı kırmızı alt koşu HF-S0-T02 ile her gate çalışmasında otomatik doğrulanıyor; ayrı bir kırmızı uzak CI commit'i tutulmadı | Otomatik sözleşme testi kalıcıdır; CI yeşil koşu bağlantısı rapora eklendi | S0 | ✅, merge öncesi |

## 10. Öğrenilenler ve sonraki sprinte etki

- Kullanıcı tarafından sağlanan 10 anonim gerçek görüşme kaydında canlı sayaç
  sinyali 7/10; S0'ın ≥6 eşiği karşılandı.
- Sentetik persona simülasyonu ayrı bir arşiv belgesine taşındı ve gerçek
  görüşme kanıtına karıştırılmadı.
- npm hesabı ve ad kullanılabilirliği doğrulandı; işlevsiz bir placeholder
  yayımlamanın npm politikasıyla çeliştiği kayıt altına alındı.
- Ana risk yalnızca native render değil; prebuild idempotency, yaşam döngüsü ve
  geliştiricinin üretilen native çıktıyı denetleyebilmesi.
- S1 fizibilite sprintinin başlamasını engelleyen S0 borcu kalmadı.

## 11. Kontrol listesi

- [x] Kabul testleri `HF-` kimliğine bağlı
- [x] `pnpm gate` yeşil, tam çıktı eklendi
- [x] Kırmızı / `skip` / `only` test yok
- [x] L6'nın S0'da uygulanmadığı kaydedildi
- [x] S0 kapsam eşiklerinin henüz uygulanmadığı açıklandı
- [x] Kırmızı test sözleşmesi otomatik doğrulandı
- [x] Doküman ve pazar anlık görüntüsü güncel
- [x] Açık S0 borcu yok
- [x] Karar yazılı
- [x] Gerçek görüşme kayıtları tamamlandı — 10 kayıt, 7 olumlu sinyal
- [x] npm oturumu ve ad kullanılabilirliği doğrulandı; placeholder yayımlanmadı

---

**İmza:** Codex (otomatik kapı raporu) · **Tarih:** 2026-07-26
