#!/usr/bin/env bash
set -euo pipefail

hf_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$hf_script_dir/hf-s1-common.sh"

# HF-S1-T06 — reboot sonrası mutlak endAt değerinden kalan süreyi doğrular.
hf_evidence_dir="${HOMEFRAME_EVIDENCE_DIR:-docs/reports/assets/S01}"
hf_log_file="$hf_evidence_dir/HF-S1-T06-${hf_serial}-reboot.log"
hf_before_xml="$hf_evidence_dir/HF-S1-T06-${hf_serial}-before.xml"
hf_before_png="$hf_evidence_dir/HF-S1-T06-${hf_serial}-before.png"
hf_after_xml="$hf_evidence_dir/HF-S1-T06-${hf_serial}-after.xml"
hf_after_png="$hf_evidence_dir/HF-S1-T06-${hf_serial}-after.png"
hf_after_boot_png="$hf_evidence_dir/HF-S1-T06-${hf_serial}-after-boot.png"
hf_device_xml="/sdcard/homeframe-t06.xml"

hf_countdown_seconds() {
  local hf_value="$1"
  local hf_part
  local hf_total=0

  IFS=":" read -r -a hf_parts <<<"$hf_value"
  for hf_part in "${hf_parts[@]}"; do
    hf_total=$((hf_total * 60 + 10#$hf_part))
  done
  printf '%s\n' "$hf_total"
}

hf_dump_static_widget() {
  local hf_local_xml="$1"
  local hf_local_png="$2"

  for hf_attempt in 1 2 3; do
    hf_adb_cmd shell input keyevent KEYCODE_BACK
    hf_adb_cmd shell input keyevent KEYCODE_HOME
    hf_adb_cmd shell am broadcast \
      -a dev.homeframe.action.RENDER_STATIC_TEST \
      -n "$hf_package/$hf_provider" >/dev/null
    sleep 1
    hf_adb_cmd shell rm -f "$hf_device_xml"

    if hf_adb_cmd shell uiautomator dump --compressed "$hf_device_xml" >/dev/null 2>&1 &&
      hf_adb_cmd shell test -s "$hf_device_xml" &&
      hf_adb_cmd shell grep -q "$hf_package:id/countdown" "$hf_device_xml"; then
      break
    fi
    if [[ "$hf_attempt" -eq 3 ]]; then
      echo "HF-S1-T06 başarısız: launcher erişilebilirlik ağacı alınamadı." >&2
      return 1
    fi
    sleep 3
  done

  hf_adb_cmd pull "$hf_device_xml" "$hf_local_xml" >/dev/null
  hf_adb_cmd exec-out screencap -p >"$hf_local_png"
}

hf_read_countdown() {
  local hf_xml="$1"
  sed -nE \
    "s/.*text=\"([0-9]+(:[0-9]{2})+)\" resource-id=\"$hf_package:id\\/countdown\".*/\\1/p" \
    "$hf_xml"
}

mkdir -p "$hf_evidence_dir"

# Force-stop testinden gelindiyse paketin stopped durumunu kaldır.
hf_adb_cmd shell monkey -p "$hf_package" 1 >/dev/null
hf_adb_cmd shell input keyevent KEYCODE_HOME
hf_before_package_state="$(
  hf_adb_cmd shell dumpsys package "$hf_package" |
    grep -m1 "installed=true"
)"
if [[ "$hf_before_package_state" == *"stopped=true"* ]]; then
  echo "HF-S1-T06 başarısız: package reboot öncesinde stopped durumundan çıkarılamadı." >&2
  exit 1
fi

hf_adb_cmd shell am broadcast \
  -a dev.homeframe.action.REFRESH_WIDGET \
  -n "$hf_package/$hf_provider" >/dev/null
sleep 1

hf_dump_static_widget "$hf_before_xml" "$hf_before_png"
hf_before_value="$(hf_read_countdown "$hf_before_xml")"
hf_before_epoch="$(hf_adb_cmd shell date +%s | tr -d '\r')"

if [[ -z "$hf_before_value" ]]; then
  echo "HF-S1-T06 başarısız: reboot öncesi sayaç okunamadı." >&2
  exit 1
fi

# Reboot öncesinde Chronometer'ı yeniden çalışır hale getir.
hf_adb_cmd shell am broadcast \
  -a dev.homeframe.action.REFRESH_WIDGET \
  -n "$hf_package/$hf_provider" >/dev/null
hf_adb_cmd reboot
hf_adb_cmd wait-for-device

until [[ "$(hf_adb_cmd shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" == "1" ]] &&
  hf_adb_cmd shell dumpsys user 2>/dev/null | grep -q "RUNNING_UNLOCKED"; do
  sleep 2
done

hf_adb_cmd shell wm dismiss-keyguard
hf_adb_cmd shell input keyevent KEYCODE_HOME
sleep 10

# Önce boot receiver'ın bıraktığı RemoteViews kaydını al, ardından görünümü
# sabitleyerek erişilebilirlik ağacındaki kalan süreyi güvenilir biçimde oku.
hf_boot_widget_state="$(hf_adb_cmd shell dumpsys appwidget)"
hf_after_package_state="$(
  hf_adb_cmd shell dumpsys package "$hf_package" |
    grep -m1 "installed=true"
)"
hf_adb_cmd exec-out screencap -p >"$hf_after_boot_png"
hf_dump_static_widget "$hf_after_xml" "$hf_after_png"
hf_after_value="$(hf_read_countdown "$hf_after_xml")"
hf_after_epoch="$(hf_adb_cmd shell date +%s | tr -d '\r')"

if [[ "$hf_boot_widget_state" != *"$hf_provider"* || -z "$hf_after_value" ]]; then
  echo "HF-S1-T06 başarısız: provider veya sayaç reboot sonrasında bulunamadı." >&2
  exit 1
fi

hf_before_seconds="$(hf_countdown_seconds "$hf_before_value")"
hf_after_seconds="$(hf_countdown_seconds "$hf_after_value")"
hf_wall_elapsed=$((hf_after_epoch - hf_before_epoch))
hf_countdown_elapsed=$((hf_before_seconds - hf_after_seconds))
hf_deviation=$((hf_countdown_elapsed - hf_wall_elapsed))
if ((hf_deviation < 0)); then
  hf_deviation=$((-hf_deviation))
fi

{
  echo "HF-S1-T06"
  echo "serial=$hf_serial"
  echo "before_epoch=$hf_before_epoch"
  echo "before_countdown=$hf_before_value"
  echo "after_epoch=$hf_after_epoch"
  echo "after_countdown=$hf_after_value"
  echo "wall_elapsed_seconds=$hf_wall_elapsed"
  echo "countdown_elapsed_seconds=$hf_countdown_elapsed"
  echo "deviation_seconds=$hf_deviation"
  echo "before_package_state=$hf_before_package_state"
  echo "after_package_state=$hf_after_package_state"
  echo "provider=$hf_provider"
  printf '%s\n' "$hf_boot_widget_state"
} >"$hf_log_file"

if [[ "$hf_after_package_state" == *"stopped=true"* ]]; then
  echo "HF-S1-T06 başarısız: package reboot sonrasında stopped durumuna döndü." >&2
  exit 1
fi

if ((hf_deviation > 2)); then
  echo "HF-S1-T06 başarısız: reboot sonrası sayaç sapması ${hf_deviation} sn." >&2
  exit 1
fi

echo "HF-S1-T06 geçti: reboot sonrası sayaç sapması ${hf_deviation} sn."
echo "Kanıt: $hf_log_file"
echo "Kanıt: $hf_before_xml"
echo "Kanıt: $hf_before_png"
echo "Kanıt: $hf_after_xml"
echo "Kanıt: $hf_after_png"
echo "Kanıt: $hf_after_boot_png"
