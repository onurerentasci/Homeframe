#!/usr/bin/env bash
set -euo pipefail

hf_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$hf_script_dir/hf-s1-common.sh"

# HF-S1-T07 — iki widget instance'ının farklı başlıklarını doğrular.
hf_first_title="${HOMEFRAME_FIRST_TITLE:-Instance A}"
hf_second_title="${HOMEFRAME_SECOND_TITLE:-Instance B}"
hf_evidence_dir="${HOMEFRAME_EVIDENCE_DIR:-docs/reports/assets/S01}"
hf_device_dump_a="/sdcard/homeframe-t07-a.xml"
hf_device_dump_b="/sdcard/homeframe-t07-b.xml"
hf_local_dump_a="$hf_evidence_dir/HF-S1-T07-${hf_serial}-instance-a.xml"
hf_local_dump_b="$hf_evidence_dir/HF-S1-T07-${hf_serial}-instance-b.xml"
hf_local_screenshot_a="$hf_evidence_dir/HF-S1-T07-${hf_serial}-instance-a.png"
hf_local_screenshot_b="$hf_evidence_dir/HF-S1-T07-${hf_serial}-instance-b.png"

hf_dump_page() {
  local hf_output="$1"
  hf_adb_cmd shell rm -f "$hf_output"

  for hf_attempt in 1 2 3; do
    if hf_adb_cmd shell uiautomator dump --compressed "$hf_output" >/dev/null 2>&1 &&
      hf_adb_cmd shell test -s "$hf_output"; then
      return 0
    fi
    sleep 2
  done

  return 1
}

mkdir -p "$hf_evidence_dir"
hf_adb_cmd shell input keyevent KEYCODE_HOME
# Launcher, HOME tuşundan sonra son kullanılan sayfayı koruyabilir. İlk kanıtı
# deterministik olarak sol sayfadan başlat.
hf_adb_cmd shell input swipe 200 1500 1200 1500 600
sleep 2
hf_adb_cmd shell am broadcast \
  -a dev.homeframe.action.RENDER_STATIC_TEST \
  -n "$hf_package/$hf_provider" >/dev/null
sleep 1
hf_adb_cmd shell am kill "$hf_package"
sleep 2

if ! hf_dump_page "$hf_device_dump_a"; then
  echo "HF-S1-T07 başarısız: ilk launcher sayfası alınamadı." >&2
  exit 1
fi
hf_dump_a="$(hf_adb_cmd shell cat "$hf_device_dump_a")"
hf_adb_cmd exec-out screencap -p >"$hf_local_screenshot_a"

hf_adb_cmd shell input swipe 1200 1500 200 1500 600
sleep 2
if ! hf_dump_page "$hf_device_dump_b"; then
  echo "HF-S1-T07 başarısız: ikinci launcher sayfası alınamadı." >&2
  exit 1
fi
hf_dump_b="$(hf_adb_cmd shell cat "$hf_device_dump_b")"
hf_adb_cmd exec-out screencap -p >"$hf_local_screenshot_b"

if [[ "$hf_dump_a$hf_dump_b" != *"$hf_first_title"* ||
  "$hf_dump_a$hf_dump_b" != *"$hf_second_title"* ]]; then
  echo "HF-S1-T07 başarısız: iki bağımsız instance başlığı birlikte bulunamadı." >&2
  exit 1
fi

hf_adb_cmd pull "$hf_device_dump_a" "$hf_local_dump_a" >/dev/null
hf_adb_cmd pull "$hf_device_dump_b" "$hf_local_dump_b" >/dev/null
hf_adb_cmd shell input keyevent KEYCODE_HOME

echo "HF-S1-T07 geçti: iki instance farklı veri gösteriyor."
echo "Kanıt: $hf_local_dump_a"
echo "Kanıt: $hf_local_screenshot_a"
echo "Kanıt: $hf_local_dump_b"
echo "Kanıt: $hf_local_screenshot_b"
