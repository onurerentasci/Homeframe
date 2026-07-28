import { existsSync, readFileSync, statSync } from "node:fs";

const stage = process.argv[2];

if (stage === undefined || stage !== "device") {
  console.error(`Bilinmeyen kapı aşaması: ${stage ?? "<boş>"}`);
  process.exitCode = 1;
} else {
  const evidenceRoot = "docs/reports/assets/S01-1";
  const recoveryPath = `${evidenceRoot}/HF-S1.1-T05-7867b0b7-recovery.log`;
  const rebootPath = `${evidenceRoot}/HF-S1-T06-7867b0b7-reboot.log`;
  const accessibilityPath =
    `${evidenceRoot}/HF-S1.1-T08-7867b0b7-accessibility.xml`;
  const transcriptPath =
    `${evidenceRoot}/HF-S1.1-T08-7867b0b7-talkback-transcript.txt`;
  const videoPath =
    `${evidenceRoot}/HF-S1.1-T08-7867b0b7-talkback-semantic.mp4`;
  const requiredPaths = [
    recoveryPath,
    rebootPath,
    accessibilityPath,
    transcriptPath,
    videoPath,
  ];
  const missingPaths = requiredPaths.filter((path) => !existsSync(path));

  if (missingPaths.length > 0) {
    console.error(
      `test:device — FAIL (S1.1): kanıt bulunamadı: ${missingPaths.join(", ")}`,
    );
    process.exitCode = 1;
  } else {
    const recovery = readFileSync(recoveryPath, "utf8");
    const reboot = readFileSync(rebootPath, "utf8");
    const accessibility = readFileSync(accessibilityPath, "utf8");
    const transcript = readFileSync(transcriptPath, "utf8");
    const recoveryDeviation = Number(
      recovery.match(/^deviation_seconds=(\d+)$/m)?.[1],
    );
    const rebootDeviation = Number(
      reboot.match(/^deviation_seconds=(\d+)$/m)?.[1],
    );
    const failures = [];

    if (
      !Number.isFinite(recoveryDeviation) ||
      recoveryDeviation > 2 ||
      !recovery.includes("stopped=true") ||
      !recovery.includes("after_package_state=") ||
      !recovery.includes("stopped=false")
    ) {
      failures.push("HF-S1.1-T05 force-stop recovery");
    }

    if (!Number.isFinite(rebootDeviation) || rebootDeviation > 2) {
      failures.push("HF-S1.1-T06 reboot restore");
    }

    if (
      !accessibility.includes('text="S1 feasibility"') ||
      !/content-desc="[^"]*(?:gün|saat|dakika|saniye)[^"]*"/u.test(
        accessibility,
      ) ||
      !/(?:gün|saat|dakika|saniye)/u.test(transcript) ||
      statSync(videoPath).size === 0
    ) {
      failures.push("HF-S1.1-T08 TalkBack");
    }

    if (failures.length > 0) {
      console.error(
        `test:device — FAIL (S1.1): ${failures.join(", ")}`,
      );
      process.exitCode = 1;
    } else {
      console.log(
        `test:device — PASS (S1.1): force-stop recovery ${recoveryDeviation} sn, reboot ${rebootDeviation} sn, TalkBack başlık+süre kanıtlandı.`,
      );
    }
  }
}
