# Sprint S<nn> — <Sprint Adı> — Kapı Raporu

| Alan | Değer |
| --- | --- |
| Sprint | S<nn> |
| Planlanan süre | <x> gün |
| Gerçekleşen süre | <x> gün (sapma: %<y>) |
| Dal | `sprint/S<nn>-<kisa-ad>` |
| Etiket | `s<nn>-pass` |
| Tarih | YYYY-AA-GG |
| **Karar** | **PASS / PASS-WITH-DEBT / FAIL** |

---

## 1. Çıkış kriterleri ↔ test eşlemesi

| # | Çıkış kriteri | Test kimliği | Katman | Sonuç | Kanıt |
| --- | --- | --- | --- | --- | --- |
| 1 | <kriter> | HF-S<nn>-T01 | L1 | ✅ / ❌ | `packages/core/src/__tests__/x.test.ts` |
| 2 | <kriter> | HF-S<nn>-T02 | L6 | ✅ / ❌ | `assets/S<nn>/HF-S<nn>-T02-pixel8.mp4` |

> Test kimliğine bağlanmamış çıkış kriteri kabul edilmez (K4).

## 2. `pnpm gate` çıktısı

```
<komut çıktısı buraya yapıştırılır — özetlenmez>
```

| Kontrol | Sonuç |
| --- | --- |
| lint | ✅ / ❌ |
| typecheck | ✅ / ❌ |
| test:unit | ✅ / ❌ (x test) |
| test:plugin | ✅ / ❌ |
| test:android | ✅ / ❌ |
| test:device | ✅ / ❌ |
| coverage:check | ✅ / ❌ |

## 3. Kapsam

| Paket | Eşik | Bu sprint | Önceki sprint | Yön |
| --- | ---: | ---: | ---: | --- |
| `@homeframe/core` | %90 | | | ↑ / = / ↓ |
| `@homeframe/codegen-android` | %85 | | | |
| `@homeframe/expo-plugin` | %80 | | | |
| `runtime-android` | %70 | | | |

> ↓ varsa K10 ihlali — karar FAIL.

## 4. Cihaz doğrulaması (L6)

| Test | Cihaz | Android | Launcher | Ölçüm | Sonuç | Kanıt dosyası |
| --- | --- | ---: | --- | --- | --- | --- |
| HF-S<nn>-T0x | Pixel 8 | 15 | Pixel | sapma 1.2 sn | ✅ | `assets/S<nn>/...mp4` |
| HF-S<nn>-T0x | Galaxy S21 | 14 | One UI | | | |

## 5. Performans bütçeleri

| Ölçüm | Bütçe | Ölçülen | Sonuç |
| --- | ---: | ---: | --- |
| Widget güncelleme (medyan) | 150 ms | | |
| `expo prebuild` ek süresi | 8 sn | | |
| `pnpm gate` toplam | 10 dk | | |

## 6. Bug ve regresyon

| Issue | Açıklama | Regresyon testi | Durum |
| --- | --- | --- | --- |
| #12 | | HF-BUG-12 | kapandı |

Kapatılan bug: <x> · Eklenen regresyon testi: <y> · Fark gerekçesi: <...>

## 7. Borç (PASS-WITH-DEBT ise)

| # | Açık madde | Neden kritik değil | Issue | Son tarih (≤2 sprint) |
| --- | --- | --- | --- | --- |
| 1 | | | #.. | S<nn+1> |

> Tavan: 2 madde / 2 sprint (K15). Erişilebilirlik, idempotency, kapsam eşiği ve Go/No-Go kritik maddeleri borç olamaz.

## 8. Kural istisnaları (K21)

| Kural | Gerekçe | Telafi planı | Son tarih | Önceden yazıldı mı? |
| --- | --- | --- | --- | --- |
| — | — | — | — | — |

> Sonradan yazılan istisna geçersizdir → karar otomatik FAIL.

## 9. Öğrenilenler ve sonraki sprinte etki

* <plan değişikliği gerektiren bulgu>
* <iş planına yansıtılması gereken madde>

## 10. Kontrol listesi

- [ ] Tüm çıkış kriterleri `HF-` kimliğine bağlı
- [ ] `pnpm gate` yeşil, çıktı yapıştırıldı
- [ ] Kırmızı / `skip` / `only` test yok
- [ ] L6 kanıtları `assets/S<nn>/` altında
- [ ] Cihaz doğrulaması gerekenler fiziksel cihazda tekrarlandı
- [ ] Kapsam eşikleri düşmedi
- [ ] Golden diff'leri incelendi
- [ ] Prebuild idempotency testi koştu
- [ ] Bug'lar regresyon testiyle kapandı
- [ ] Doküman + uyumluluk matrisi güncel
- [ ] Borç ≤ 2 madde, ≤ 2 sprint
- [ ] Karar yazılı

---

**İmza:** <ad> · **Tarih:** YYYY-AA-GG
