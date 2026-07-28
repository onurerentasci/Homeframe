#!/usr/bin/env bash
set -euo pipefail

hf_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$hf_script_dir/hf-s1-common.sh"

# HF-S1-T05 — 65 saniyelik ekran kaydı fiziksel cihaz kanıtı üretir.
hf_evidence_dir="${HOMEFRAME_EVIDENCE_DIR:-docs/reports/assets/S01}"
hf_device_file="/sdcard/HF-S1-T05-force-stop.mp4"
hf_local_file="$hf_evidence_dir/HF-S1-T05-${hf_serial}-force-stop.mp4"

mkdir -p "$hf_evidence_dir"
hf_adb_cmd shell am force-stop "$hf_package"
hf_adb_cmd shell screenrecord --time-limit 65 "$hf_device_file"
hf_adb_cmd pull "$hf_device_file" "$hf_local_file" >/dev/null
hf_adb_cmd shell rm "$hf_device_file"

echo "HF-S1-T05 kanıtı oluşturuldu: $hf_local_file"
echo "PASS için videoda Chronometer değerinin 60±2 saniye ilerlediği rapora yazılmalı."
