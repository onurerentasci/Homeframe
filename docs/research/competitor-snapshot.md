# S0 — Rakip ve Paket Doğrulaması

> Kontrol tarihi: 2026-07-26 · Veriler zaman damgalı bir S0 anlık görüntüsüdür.

## Sonuç

| Kontrol | Sonuç | Kaynak |
| --- | --- | --- |
| `expo-widgets` güncel sürüm | `57.0.6` | [npm paketi](https://www.npmjs.com/package/expo-widgets) |
| `expo-widgets` haftalık indirme | 102.819 (2026-07-18–24) | [npm downloads API](https://api.npmjs.org/downloads/point/2026-07-18:2026-07-24/expo-widgets) |
| Platform kapsamı | iOS ana ekran widget'ları ve Live Activities | [Expo dokümantasyonu](https://docs.expo.dev/versions/latest/sdk/widgets/) |
| `react-native-android-widget` güncel sürüm | `0.21.0` | [npm paketi](https://www.npmjs.com/package/react-native-android-widget) |
| `react-native-android-widget` haftalık indirme | 42.110 (2026-07-18–24) | [npm downloads API](https://api.npmjs.org/downloads/point/2026-07-18:2026-07-24/react-native-android-widget) |
| GitHub yıldızı | 890 | [GitHub deposu](https://github.com/sAleksovski/react-native-android-widget) |
| Render sınırlaması | RN görünümü görüntüye çevrilip widget'ta gösteriliyor; bazı launcher'larda boyut/crop farkı var | [Resmî limitations sayfası](https://saleksovski.github.io/react-native-android-widget/docs/limitations) |
| `homeframe` npm adı | Registry isteği `404 Not Found`; kontrol anında paket görünmüyor | [npm registry](https://registry.npmjs.org/homeframe) |

## Değerlendirme

İş planı §2.1'deki iki temel pazar varsayımı güncel verilerle korunuyor:

1. Expo'nun resmî widget paketi mevcut ve güncel belgelerde yalnızca iOS
   kapsamını gösteriyor.
2. Başlıca Android alternatifi kendi dokümantasyonunda bitmap tabanlı render ve
   launcher boyutlandırma sınırlamasını açıkça belirtiyor.

`homeframe` adının boş görünmesi rezervasyon değildir. S0 çıkış kriteri için adın
paket sahibinin npm hesabından ayrıca rezerve edilmesi gerekir.
