# Homeframe

> Build real Android widgets for Expo — without Kotlin, XML or bitmap rendering.

Homeframe, Expo ve React Native geliştiricilerinin Android ana ekran widget'larını **Kotlin veya XML yazmadan**, TypeScript ile geliştirmesini sağlayan açık kaynak bir SDK'dır.

Mevcut RN çözümlerinin bir kısmı uygulama arayüzünü **bitmap** olarak render edip widget'ta görüntü olarak gösterir. Homeframe bunun yerine widget tanımını gerçek Android **`RemoteViews`** ağacına derler: `TextView`, `ImageView`, `ProgressBar`, `Chronometer`. Sonuç: uygulama prosesi kapalıyken bile ilerleyen canlı geri sayım, gerçek metin semantiği, TalkBack desteği ve öngörülebilir launcher davranışı.

```tsx
export default defineWidget({
  name: "EventCountdown",
  data: { title: "string", targetAt: "timestamp" },
  view: (
    <WColumn padding={16}>
      <WText value={field("title")} />
      <WCountdown endAt={field("targetAt")} />
    </WColumn>
  ),
});
```

## Durum

**S0 — ön doğrulama ve iskelet devam ediyor.** Monorepo ve kalite kapısı
kurulmuştur. Ürün koduna geçiş, `docs/02-sprint-plani.md` içindeki S0 çıkış
kriterleri tamamlandıktan sonra; ürün taahhüdü ise **S1 fizibilite kapısı**
geçildikten sonra yapılır.

## Geliştirme

Gereksinimler:

- Node.js 24 veya üzeri
- Java 17
- pnpm 11.17.0 (`npx pnpm@11.17.0` ile de çalıştırılabilir)

```sh
npx pnpm@11.17.0 install
npx pnpm@11.17.0 gate
```

`gate`; lint, TypeScript, birim/golden, plugin, Gradle, cihaz aşaması ve kapsam
kontrollerini tek sırada çalıştırır. Henüz uygulanmayan S0-sonrası aşamalar
başarılıymış gibi raporlanmaz; komut çıktısında açıkça `NOT_APPLICABLE` görünür.

## Doküman haritası

| Doküman | İçerik |
| --- | --- |
| [docs/01-is-plani.md](docs/01-is-plani.md) | Problem, çözüm, pazar, iş modeli, riskler, metrikler, bütçe, Go/No-Go |
| [docs/02-sprint-plani.md](docs/02-sprint-plani.md) | S0–S12 sprint dökümü: kapsam, çıktı, test artefaktı, çıkış kriteri |
| [docs/03-test-stratejisi.md](docs/03-test-stratejisi.md) | Test katmanları (L0–L8), araçlar, kapsam eşikleri, cihaz matrisi |
| [docs/04-sprint-kurallari.md](docs/04-sprint-kurallari.md) | **Sprint geçiş kuralları** — testle onaylanmadan sonraki sprinte geçilmez |
| [docs/templates/sprint-raporu-sablonu.md](docs/templates/sprint-raporu-sablonu.md) | Her sprint kapısında doldurulan kanıt raporu şablonu |
| [docs/reports/](docs/reports/) | Tamamlanan sprintlerin imzalı kapı raporları |
| [docs/research/competitor-snapshot.md](docs/research/competitor-snapshot.md) | S0 rakip ve paket verisi doğrulaması |
| [docs/research/interviews.md](docs/research/interviews.md) | Kullanıcı tarafından sağlanan gerçek geliştirici görüşmeleri |
| [docs/research/persona-simulation.md](docs/research/persona-simulation.md) | Gerçek araştırma öncesindeki sentetik persona simülasyonu |

## Lisans

MIT (planlanan).
