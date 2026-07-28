#!/usr/bin/env bash
set -euo pipefail

hf_adb="${ANDROID_HOME:-}/platform-tools/adb"
if [[ ! -x "$hf_adb" ]]; then
  hf_adb="$(command -v adb || true)"
fi

if [[ -z "$hf_adb" || ! -x "$hf_adb" ]]; then
  echo "adb bulunamadı. ANDROID_HOME veya PATH yapılandırılmalı." >&2
  exit 1
fi

hf_serial="${ANDROID_SERIAL:-}"
if [[ -z "$hf_serial" ]]; then
  hf_devices=()
  while IFS= read -r hf_device; do
    if [[ -n "$hf_device" ]]; then
      hf_devices+=("$hf_device")
    fi
  done < <("$hf_adb" devices | awk 'NR > 1 && $2 == "device" { print $1 }')

  if [[ "${#hf_devices[@]}" -ne 1 ]]; then
    echo "Tam olarak bir Android cihaz/emülatör gerekli; bulunan: ${#hf_devices[@]}." >&2
    exit 1
  fi
  hf_serial="${hf_devices[0]}"
fi

hf_package="${HOMEFRAME_PACKAGE:-dev.homeframe.basic}"
hf_provider="${HOMEFRAME_PROVIDER:-dev.homeframe.basic.widget.HomeframeWidgetProvider}"
hf_expected_title="${HOMEFRAME_EXPECTED_TITLE:-S1 feasibility}"

hf_adb_cmd() {
  "$hf_adb" -s "$hf_serial" "$@"
}
