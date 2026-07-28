# Sprint S01 — Native Fizibilite — GO / NO-GO Raporu

> Durum: **PIVOT** · Başlangıç: 2026-07-26 · Karar: 2026-07-28 · Dal:
> `sprint/S1-native-fizibilite`
>
> Karar imzası: Fiziksel cihaz kapısı tamamlandı. Açık `force-stop`
> dayanıklılığı iddiası ve mevcut TalkBack semantiğiyle S2'ye doğrudan
> geçilmeyecek.

| Test | Kanıt | Durum |
| --- | --- | --- |
| HF-S1-T01 | `packages/codegen-android/src/__tests__/feasibility.test.ts` | ✅ PASS |
| HF-S1-T02 | 3× gerçek Expo prebuild; değişen dosya `[]` | ✅ PASS |
| HF-S1-T03 | Robolectric API 35 `RemoteViews.apply()` | ✅ PASS |
| HF-S1-T04 | Pixel Launcher; Metro ve uygulama PID'si yok | ✅ PASS |
| HF-S1-T05 | Force-stop sonrası 60 sn Chronometer | ❌ FAIL |
| HF-S1-T06 | Reboot sonrası mutlak `endAt` restore | ✅ PASS |
| HF-S1-T07 | Pixel Launcher'da iki bağımsız instance | ✅ PASS |
| HF-S1-T08 | EAS production build + Pixel cihaz kurulumu | ✅ PASS |
| HF-S1-T09 | TalkBack okuması | ❌ FAIL |

## Tamamlanan otomatik kanıtlar

| Komut | Sonuç | Not |
| --- | --- | --- |
| `vitest run packages/codegen-android/.../feasibility.test.ts` | PASS | Golden bit-bit eşleşti |
| `vitest run packages/expo-plugin/.../feasibility.test.ts` | PASS | Clean tabandan sonra 3 koşuda native ağaç değişmedi |
| `./gradlew test` | PASS | AGP 9.1.1, Gradle 9.3.1, Robolectric 4.16 / API 35 |
| `examples/basic/android/gradlew :app:assembleDebug` | PASS | 129 MB debug APK üretildi |
| `pnpm coverage:check` | PASS | Toplam satır %87,09; branch %82,5 |
| `scripts/device/hf-s1-t04-rnless-render.sh` | PASS | Metro kapalı, uygulama PID'si yok |
| `scripts/device/hf-s1-t07-multiple-instances.sh` | PASS | `Instance A` ve `Instance B` |
| EAS production build + cihaz kurulumu | PASS | Build `b0934a7f-…`; Pixel 7 Pro API 36 |

İlk `./gradlew test` yeşil koşusu 2 dk 43 sn, ilk Expo
`:app:assembleDebug` koşusu 1 dk 44 sn sürdü. 2026-07-27 kapı koşusunda lint,
typecheck, unit, config-plugin ve Android testleri geçti. 2026-07-28 fiziksel
cihaz koşusunda T06 geçti; T05 ve T09 tekrarlanabilir biçimde başarısız oldu.

## S1 uyumluluk matrisi

| Bileşen | Sürüm / hedef | Sonuç |
| --- | --- | --- |
| Expo | SDK 57.0.8 | prebuild + debug APK PASS |
| React Native | 0.86.0 | debug APK PASS |
| Android | compile/target API 36 | debug APK PASS |
| Runtime spike | min API 26; Robolectric API 35 | unit test PASS |
| Pixel Launcher | Android 16 / API 36 Pixel 7 Pro AVD | T04 ve T07 PASS |
| Fiziksel launcher | Mi Note 10 Lite · Android 16 / API 36 · Pixel Launcher | T05 FAIL, T06 PASS, T09 FAIL |

## Cihaz kanıtları

| Test | Ortam | Sonuç | Kanıt |
| --- | --- | --- | --- |
| HF-S1-T04 | Pixel 7 Pro AVD · Android 16 · Pixel Launcher | PASS | `assets/S01/HF-S1-T04-emulator-5554-launcher.{xml,png}` |
| HF-S1-T07 | Pixel 7 Pro AVD · Android 16 · Pixel Launcher | PASS | `assets/S01/HF-S1-T07-emulator-5554-instance-{a,b}.{xml,png}` |
| HF-S1-T08 | Temiz Pixel 7 Pro AVD · EAS production APK | PASS | `assets/S01/HF-S1-T08-eas-production.md`; `assets/S01/HF-S1-T04-emulator-5556-launcher.{xml,png}` |
| HF-S1-T05 | Mi Note 10 Lite · Android 16 / API 36 · Pixel Launcher · `7867b0b7` | FAIL | `assets/S01/HF-S1-T05-7867b0b7-before.png`; `assets/S01/HF-S1-T05-7867b0b7-force-stop.mp4` |
| HF-S1-T06 | Mi Note 10 Lite · Android 16 / API 36 · Pixel Launcher · `7867b0b7` | PASS | `assets/S01/HF-S1-T06-7867b0b7-{before,after}.{xml,png}`; `assets/S01/HF-S1-T06-7867b0b7-after-boot.png`; `assets/S01/HF-S1-T06-7867b0b7-reboot.log` |
| HF-S1-T09 | Mi Note 10 Lite · Android 16 / API 36 · Pixel Launcher · TalkBack 16.0 | FAIL | `assets/S01/HF-S1-T09-7867b0b7-talkback.md`; `assets/S01/HF-S1-T09-7867b0b7-talkback.mp4`; `assets/S01/HF-S1-T09-7867b0b7-talkback-focus.png` |

T04 sırasında hostta `localhost:8081` dinleyicisi yoktu. Provider test görünümünü
güncelledikten sonra uygulama prosesi `am kill` ile sonlandırıldı; doğrulama
anında `pidof dev.homeframe.basic` boştu.

### HF-S1-T05 — açık force-stop dayanıklılığı

`am force-stop dev.homeframe.basic` sonrasında Pixel Launcher, Homeframe
`RemoteViews` ağacını Android simgeli koyu bir yer tutucuyla değiştirdi.
64,9 saniyelik kaydın ilk ve son karesi aynıydı; Chronometer görünür değildi.
Emülatördeki ön bulgu fiziksel cihazda da tekrarlandı. Bu nedenle ürün,
uygulamanın kullanıcı veya sistem tarafından açıkça `force-stop` edilmesinden
sonra canlı geri sayım göstereceğini taahhüt edemez.

### HF-S1-T06 — reboot restore

Reboot öncesi `50:33`, reboot sonrası `49:37` okundu. Duvar saati 58 saniye,
geri sayım 56 saniye ilerledi; mutlak sapma 2 saniyeydi ve kabul sınırını
karşıladı. Paket reboot öncesinde ve sonrasında `stopped=false` kaldı.

### HF-S1-T09 — TalkBack

Erişilebilirlik olayında widget düğümü `Text: [S1 feasibility, 44:02]` ve
`ContentDescription: Homeframe` olarak bulundu. Buna karşın TalkBack'in yeşil
erişilebilirlik odağı hava durumu öğesinde kaldı; widget başlığı ile geri sayım
seslendirilmedi. Görsel klavye odağının widget'a gelmesi bu sonucu değiştirmedi.
Başlık ve biçimlendirilmiş sürenin tek, anlamlı bir erişilebilirlik anonsu
olarak doğrulanması gerektiğinden T09 başarısızdır.

## Karar ve kapsam değişikliği

S1 kararı **PIVOT** olarak imzalanmıştır. T01–T04, T06–T08 sonuçları; native
üretim hattının, normal proses ölümü ve reboot senaryolarının uygulanabilir
olduğunu gösterir. PIVOT iki değişiklik gerektirir:

1. Ürün vaadinden açık `force-stop` sonrası kesintisiz canlı sayaç garantisi
   çıkarılmalı; stopped paket durumu yeniden açılış/kurtarma akışı olarak ele
   alınmalıdır.
2. Widget erişilebilirlik açıklaması başlık ve görünür kalan süreyi birlikte
   okutacak şekilde düzeltilmeli, TalkBack odağıyla T09 yeniden çalıştırılmalıdır.

EAS projesi `@onurerentasci/homeframe-s1`, proje kimliği
`b8ff173c-b91b-4cc1-9c40-676eebe33fc4`; başarılı production build
`b0934a7f-af6e-4a26-b4d8-ef3066bc8455`.

S2, bu PIVOT kapsamı kabul edilip S1 takip işi tanımlanmadan başlatılmaz.

> Takip sonucu: S1.1 düzeltme sprinti 2026-07-29 tarihinde **PASS / GO**
> olarak kapandı. Force-stop recovery ve TalkBack açığı
> [`sprint-01-1-pivot-fix.md`](sprint-01-1-pivot-fix.md) raporundaki kanıtlarla
> kapatıldı; S2 geçiş kilidi açıldı.
