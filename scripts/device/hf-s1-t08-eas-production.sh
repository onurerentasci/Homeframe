#!/usr/bin/env bash
set -euo pipefail

# HF-S1-T08 — EAS production build URL'si üretir; cihaz kurulumu ayrıca kaydedilir.
hf_project_root="${HOMEFRAME_EXPO_PROJECT:-examples/basic}"

if ! command -v eas >/dev/null 2>&1; then
  echo "eas CLI bulunamadı." >&2
  exit 1
fi

(
  cd "$hf_project_root"
  eas build --platform android --profile production --non-interactive --wait
)
