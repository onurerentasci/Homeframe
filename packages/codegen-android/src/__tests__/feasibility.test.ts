import { readFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { describe, expect, it } from "vitest";
import { generateAndroidLayout } from "../spike/generate-android-layout.js";

const testDirectory = dirname(fileURLToPath(import.meta.url));

describe("S1 Android codegen fizibilitesi", () => {
  it("HF-S1-T01: IR JSON çıktısı Android XML golden ile eşleşir", async () => {
    const [fixture, golden] = await Promise.all([
      readFile(join(testDirectory, "fixtures/event-countdown.ir.json"), "utf8"),
      readFile(join(testDirectory, "__golden__/event-countdown.xml"), "utf8"),
    ]);

    const generated = generateAndroidLayout(JSON.parse(fixture) as unknown);

    expect(generated).toBe(golden);
  });
});
