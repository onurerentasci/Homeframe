# HF-S1-T09 — TalkBack manuel kanıt kontrol listesi

- [x] Fiziksel cihaz modeli ve Android sürümü kaydedildi.
- [x] TalkBack etkinleştirildi.
- [ ] Widget başlığı anlamlı sırada okundu. — **FAIL**
- [ ] Geri sayım değeri anlaşılır bir `contentDescription` ile okundu. — **FAIL**
- [ ] Görsel metin ile sesli okuma aynı anlamı taşıyor. — **FAIL**
- [x] Video `docs/reports/assets/S01/HF-S1-T09-<cihaz>-talkback.mp4` altında.
- [x] Sonuç ve bilinen sınırlamalar `sprint-01-go-no-go.md` raporuna işlendi.

Bu kontrol listesi ve video olmadan HF-S1-T09 `PASS` sayılamaz.

Sonuç: **FAIL**. Widget düğümü görsel başlık ve süreyi taşısa da TalkBack
erişilebilirlik odağı widget'a geçmedi ve `ContentDescription` yalnızca
`Homeframe` değerini içerdi.
