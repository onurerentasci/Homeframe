import { readFile } from "node:fs/promises";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";
import { runPrebuildIdempotencyCheck } from "../spike/verify-prebuild-idempotency.js";

describe("S1 Expo config-plugin fizibilitesi", () => {
  it(
    "HF-S1-T02: expo prebuild üç ardışık çalıştırmada idempotent kalır",
    async () => {
      const result = await runPrebuildIdempotencyCheck({
        projectRoot: resolve("examples/basic"),
        runs: 3,
      });

      expect(result.runs).toBe(3);
      expect(result.changedFiles).toEqual([]);

      const androidRoot = resolve("examples/basic/android/app/src/main");
      const [layout, manifest, provider, recoveryProvider] = await Promise.all([
        readFile(resolve(androidRoot, "res/layout/homeframe_widget.xml"), "utf8"),
        readFile(resolve(androidRoot, "AndroidManifest.xml"), "utf8"),
        readFile(
          resolve(
            androidRoot,
            "java/dev/homeframe/basic/widget/HomeframeWidgetProvider.java",
          ),
          "utf8",
        ),
        readFile(
          resolve(
            androidRoot,
            "java/dev/homeframe/basic/widget/HomeframeRecoveryProvider.java",
          ),
          "utf8",
        ),
      ]);

      expect(layout).toContain('android:id="@+id/homeframe_root"');
      expect(layout).toContain('android:screenReaderFocusable="true"');
      expect(layout).not.toContain('android:contentDescription="Homeframe event countdown"');
      expect(provider).not.toContain('"Event countdown"');
      expect(recoveryProvider).toContain("HomeframeWidgetProvider.refresh(context);");
      expect(manifest).toContain(
        'android:name="dev.homeframe.basic.widget.HomeframeRecoveryProvider"',
      );
    },
    300_000,
  );
});
