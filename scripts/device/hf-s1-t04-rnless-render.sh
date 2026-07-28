#!/usr/bin/env bash
set -euo pipefail

hf_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$hf_script_dir/hf-s1-common.sh"

# HF-S1-T04 — RN/Metro ve uygulama prosesi çalışmadan launcher render doğrulaması.
hf_evidence_dir="${HOMEFRAME_EVIDENCE_DIR:-docs/reports/assets/S01}"
hf_device_dump="/sdcard/homeframe-t04.xml"
hf_local_dump="$hf_evidence_dir/HF-S1-T04-${hf_serial}-launcher.xml"
hf_local_screenshot="$hf_evidence_dir/HF-S1-T04-${hf_serial}-launcher.png"

mkdir -p "$hf_evidence_dir"

if command -v lsof >/dev/null 2>&1; then
  if lsof -nP -iTCP:8081 -sTCP:LISTEN >/dev/null 2>&1; then
    echo "HF-S1-T04 başarısız: Metro localhost:8081 üzerinde çalışıyor." >&2
    exit 1
  fi
elif command -v nc >/dev/null 2>&1; then
  if nc -z 127.0.0.1 8081 >/dev/null 2>&1; then
    echo "HF-S1-T04 başarısız: localhost:8081 üzerinde bir dinleyici var." >&2
    exit 1
  fi
else
  echo "HF-S1-T04 başarısız: Metro portunu denetlemek için lsof veya nc gerekli." >&2
  exit 1
fi

hf_adb_cmd shell input keyevent KEYCODE_HOME
hf_adb_cmd shell am broadcast \
  -a dev.homeframe.action.RENDER_STATIC_TEST \
  -n "$hf_package/$hf_provider" >/dev/null
sleep 1
hf_adb_cmd shell am kill "$hf_package"
sleep 2

if [[ -n "$(hf_adb_cmd shell pidof "$hf_package" | tr -d '\r')" ]]; then
  echo "HF-S1-T04 başarısız: uygulama prosesi process-death sonrasında hâlâ çalışıyor." >&2
  exit 1
fi

hf_adb_cmd shell rm -f "$hf_device_dump"
for hf_attempt in 1 2 3; do
  if hf_adb_cmd shell uiautomator dump --compressed "$hf_device_dump" >/dev/null 2>&1 &&
    hf_adb_cmd shell test -s "$hf_device_dump"; then
    break
  fi
  if [[ "$hf_attempt" -eq 3 ]]; then
    echo "HF-S1-T04 başarısız: launcher erişilebilirlik ağacı alınamadı." >&2
    exit 1
  fi
  sleep 2
done

hf_dump="$(hf_adb_cmd shell cat "$hf_device_dump")"

if [[ "$hf_dump" != *"$hf_expected_title"* ]]; then
  echo "HF-S1-T04 başarısız: widget başlığı launcher görünümünde bulunamadı." >&2
  exit 1
fi

hf_adb_cmd pull "$hf_device_dump" "$hf_local_dump" >/dev/null
hf_adb_cmd exec-out screencap -p >"$hf_local_screenshot"

echo "HF-S1-T04 geçti: uygulama prosesi ve Metro olmadan widget başlığı görünür."
echo "Kanıt: $hf_local_dump"
echo "Kanıt: $hf_local_screenshot"
