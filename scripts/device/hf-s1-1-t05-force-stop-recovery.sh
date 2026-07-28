#!/usr/bin/env bash
set -euo pipefail

hf_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$hf_script_dir/hf-s1-common.sh"

# HF-S1.1-T05 — explicit force-stop sonrasında uygulama açılışıyla kurtarma.
hf_evidence_dir="${HOMEFRAME_EVIDENCE_DIR:-docs/reports/assets/S01-1}"
hf_prefix="$hf_evidence_dir/HF-S1.1-T05-${hf_serial}"
hf_log_file="$hf_prefix-recovery.log"
hf_before_xml="$hf_prefix-before.xml"
hf_before_png="$hf_prefix-before.png"
hf_stopped_xml="$hf_prefix-stopped.xml"
hf_stopped_png="$hf_prefix-stopped.png"
hf_after_live_png="$hf_prefix-after-live.png"
hf_after_xml="$hf_prefix-after.xml"
hf_after_png="$hf_prefix-after.png"
hf_device_xml="/sdcard/homeframe-s1-1-t05.xml"

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

hf_read_countdown() {
  local hf_xml="$1"
  sed -nE \
    "s/.*text=\"([0-9]+(:[0-9]{2})+)\" resource-id=\"$hf_package:id\\/countdown\".*/\\1/p" \
    "$hf_xml"
}

hf_dump_launcher() {
  local hf_local_xml="$1"
  local hf_local_png="$2"

  for hf_attempt in 1 2 3; do
    hf_adb_cmd shell input keyevent KEYCODE_BACK
    hf_adb_cmd shell input keyevent KEYCODE_HOME
    sleep 2
    hf_adb_cmd shell rm -f "$hf_device_xml"

    if hf_adb_cmd shell uiautomator dump --compressed "$hf_device_xml" >/dev/null 2>&1 &&
      hf_adb_cmd shell test -s "$hf_device_xml"; then
      hf_adb_cmd pull "$hf_device_xml" "$hf_local_xml" >/dev/null
      hf_adb_cmd exec-out screencap -p >"$hf_local_png"
      return 0
    fi

    # Bazı özel ROM sistem uygulaması crash pencereleri launcher idle durumunu bozar.
    hf_adb_cmd shell am force-stop com.android.camera >/dev/null 2>&1 || true
    sleep 3
  done

  echo "HF-S1.1-T05 başarısız: launcher erişilebilirlik ağacı alınamadı." >&2
  return 1
}

hf_dump_widget() {
  local hf_local_xml="$1"
  local hf_local_png="$2"

  for hf_attempt in 1 2 3; do
    hf_dump_launcher "$hf_local_xml" "$hf_local_png"
    if grep -q "$hf_package:id/countdown" "$hf_local_xml"; then
      return 0
    fi
    sleep 2
  done

  echo "HF-S1.1-T05 başarısız: kurtarılan widget ağacı bulunamadı." >&2
  return 1
}

mkdir -p "$hf_evidence_dir"

# Test başlangıcında paketi stopped durumundan çıkar ve sayacı görünür hale getir.
hf_adb_cmd shell monkey -p "$hf_package" 1 >/dev/null
hf_adb_cmd shell input keyevent KEYCODE_HOME
hf_adb_cmd shell am broadcast \
  -a dev.homeframe.action.RENDER_STATIC_TEST \
  -n "$hf_package/$hf_provider" >/dev/null
hf_dump_widget "$hf_before_xml" "$hf_before_png"
hf_before_value="$(hf_read_countdown "$hf_before_xml")"
hf_before_epoch="$(hf_adb_cmd shell date +%s | tr -d '\r')"

if [[ -z "$hf_before_value" ]]; then
  echo "HF-S1.1-T05 başarısız: force-stop öncesi sayaç okunamadı." >&2
  exit 1
fi

hf_adb_cmd shell am broadcast \
  -a dev.homeframe.action.REFRESH_WIDGET \
  -n "$hf_package/$hf_provider" >/dev/null
hf_adb_cmd shell am force-stop "$hf_package"
sleep 2
hf_dump_launcher "$hf_stopped_xml" "$hf_stopped_png"
hf_stopped_package_state="$(
  hf_adb_cmd shell dumpsys package "$hf_package" |
    grep -m1 "installed=true"
)"

if [[ "$hf_stopped_package_state" != *"stopped=true"* ]]; then
  echo "HF-S1.1-T05 başarısız: paket force-stop sonrasında stopped değil." >&2
  exit 1
fi

if grep -q "$hf_package:id/countdown" "$hf_stopped_xml"; then
  echo "HF-S1.1-T05 başarısız: force-stop yer tutucusu yerine eski sayaç bulundu." >&2
  exit 1
fi

# Uygulama prosesi yeniden başlayınca HomeframeRecoveryProvider otomatik yeniler.
hf_adb_cmd shell monkey -p "$hf_package" 1 >/dev/null
sleep 3
hf_adb_cmd shell input keyevent KEYCODE_HOME
sleep 2
hf_after_live_widget_state="$(hf_adb_cmd shell dumpsys appwidget)"
hf_adb_cmd exec-out screencap -p >"$hf_after_live_png"

if [[ "$hf_after_live_widget_state" != *"$hf_provider"* ||
  "$hf_after_live_widget_state" != *"views=android.widget.RemoteViews"* ]]; then
  echo "HF-S1.1-T05 başarısız: uygulama açılışı canlı RemoteViews üretmedi." >&2
  exit 1
fi

# Canlı Chronometer her saniye değiştiği için UIAutomator idle olamaz. Kurtarma
# kanıtı alındıktan sonra aynı endAt değeri sabitlenip erişilebilirlik ağacı okunur.
hf_adb_cmd shell am broadcast \
  -a dev.homeframe.action.RENDER_STATIC_TEST \
  -n "$hf_package/$hf_provider" >/dev/null
hf_dump_widget "$hf_after_xml" "$hf_after_png"
hf_after_value="$(hf_read_countdown "$hf_after_xml")"
hf_after_epoch="$(hf_adb_cmd shell date +%s | tr -d '\r')"
hf_after_package_state="$(
  hf_adb_cmd shell dumpsys package "$hf_package" |
    grep -m1 "installed=true"
)"

if [[ -z "$hf_after_value" ]]; then
  echo "HF-S1.1-T05 başarısız: uygulama açılışı sonrası sayaç okunamadı." >&2
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
  echo "HF-S1.1-T05"
  echo "serial=$hf_serial"
  echo "before_epoch=$hf_before_epoch"
  echo "before_countdown=$hf_before_value"
  echo "after_epoch=$hf_after_epoch"
  echo "after_countdown=$hf_after_value"
  echo "wall_elapsed_seconds=$hf_wall_elapsed"
  echo "countdown_elapsed_seconds=$hf_countdown_elapsed"
  echo "deviation_seconds=$hf_deviation"
  echo "stopped_package_state=$hf_stopped_package_state"
  echo "after_package_state=$hf_after_package_state"
  printf '%s\n' "$hf_after_live_widget_state"
} >"$hf_log_file"

if [[ "$hf_after_package_state" == *"stopped=true"* ]]; then
  echo "HF-S1.1-T05 başarısız: uygulama açılışı paketin stopped durumunu kaldırmadı." >&2
  exit 1
fi

if ((hf_deviation > 2)); then
  echo "HF-S1.1-T05 başarısız: kurtarılan sayaç sapması ${hf_deviation} sn." >&2
  exit 1
fi

echo "HF-S1.1-T05 geçti: force-stop sonrası kurtarma sapması ${hf_deviation} sn."
echo "Kanıt: $hf_log_file"
echo "Kanıt: $hf_before_xml"
echo "Kanıt: $hf_before_png"
echo "Kanıt: $hf_stopped_xml"
echo "Kanıt: $hf_stopped_png"
echo "Kanıt: $hf_after_live_png"
echo "Kanıt: $hf_after_xml"
echo "Kanıt: $hf_after_png"
