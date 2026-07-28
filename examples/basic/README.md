# Basic example

Bu Expo SDK 57 uygulaması, S1 native fizibilite kapısının atılabilir test
host'udur. Homeframe config plugin'i Android widget provider, manifest ve
resource dosyalarını `expo prebuild` sırasında üretir.

```sh
npx pnpm@11.17.0 install
npx pnpm@11.17.0 --dir examples/basic prebuild --clean --no-install
npx pnpm@11.17.0 --dir examples/basic android
```

Widget launcher'a elle eklendikten sonra cihaz kabul scriptleri repo kökünden
çalıştırılır.
