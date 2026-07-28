# HF-S1-T09 — Mi Note 10 Lite TalkBack kanıtı

- Tarih: 2026-07-28
- Seri: `7867b0b7`
- Cihaz: Xiaomi Mi Note 10 Lite
- İşletim sistemi: Android 16 / API 36
- Launcher: Pixel Launcher (`com.google.android.apps.nexuslauncher`)
- TalkBack: 16.0.0 (`com.google.android.marvin.talkback/.TalkBackService`)
- Sonuç: **FAIL**

## Erişilebilirlik düğümü

Fiziksel klavye odağı widget'a geldiğinde `uiautomator events` şu düğümü
kaydetti:

```text
EventType: TYPE_VIEW_FOCUSED
ClassName: android.widget.FrameLayout
Text: [S1 feasibility, 44:02]
ContentDescription: Homeframe
CurrentItemIndex: 5
PackageName: com.google.android.apps.nexuslauncher
```

## TalkBack gözlemi

TalkBack'in yeşil erişilebilirlik odağı üstteki hava durumu öğesinde kaldı.
Widget üzerindeki beyaz klavye odağı görünür olmasına rağmen TalkBack,
`S1 feasibility` başlığını veya `44:02` değerini seslendirmedi. Kayıtta hava
durumu ve tarih/sıcaklık bilgileri duyuluyor.

Bu sonuç iki kabul maddesini karşılamaz:

1. Widget başlığı anlamlı sırada okunmadı.
2. Görünür geri sayım anlaşılır bir erişilebilirlik açıklamasıyla okunmadı.

## Kanıt dosyaları

- Video: `HF-S1-T09-7867b0b7-talkback.mp4`
- Odak karesi: `HF-S1-T09-7867b0b7-talkback-focus.png`
- Video: H.264 + Opus, 34,811 sn
- Ses seviyesi: ortalama `-26,4 dB`, tepe `-3,0 dB`
- SHA-256:
  `902b7d79a1e9ae7960c59e1ded6ac88024bf3c5f03b9e441dc19f5aed419aeaf`

## Yeniden test koşulu

Widget başlığı ve biçimlendirilmiş kalan süre aynı anlamlı TalkBack anonsunda
duyulmalı; görsel değer ile sesli değer eşleşmelidir.
