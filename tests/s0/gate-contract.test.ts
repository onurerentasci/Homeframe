import { mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { spawnSync } from "node:child_process";
import { afterEach, describe, expect, it } from "vitest";

const temporaryRoots: string[] = [];

afterEach(async () => {
  await Promise.all(
    temporaryRoots.splice(0).map((root) => rm(root, { force: true, recursive: true })),
  );
});

function runVitest(root: string) {
  const packageManagerPath = process.env.npm_execpath;
  if (packageManagerPath === undefined) {
    throw new Error("npm_execpath bulunamadı; test pnpm üzerinden çalıştırılmalı.");
  }

  return spawnSync(
    process.execPath,
    [
      packageManagerPath,
      "exec",
      "vitest",
      "run",
      "--passWithNoTests",
      "--globals",
      "--root",
      root,
    ],
    {
      cwd: process.cwd(),
      encoding: "utf8",
      env: {
        ...process.env,
        NO_COLOR: "1",
      },
    },
  );
}

describe("S0 kapı sözleşmesi", () => {
  it("HF-S0-T01: boş test paketi hata üretmez", async () => {
    const emptyRoot = await mkdtemp(join(tmpdir(), "homeframe-empty-suite-"));
    temporaryRoots.push(emptyRoot);

    const result = runVitest(emptyRoot);

    expect(result.status).toBe(0);
    expect(`${result.stdout}\n${result.stderr}`).toContain("No test files found");
  });

  it("HF-S0-T02: test koşucusu kasıtlı hatayı kırmızıya çevirir", async () => {
    const failingRoot = await mkdtemp(join(tmpdir(), "homeframe-red-suite-"));
    temporaryRoots.push(failingRoot);
    await writeFile(
      join(failingRoot, "intentional-failure.test.ts"),
      [
        'it("intentional red contract", () => {',
        "  expect(1).toBe(2);",
        "});",
        "",
      ].join("\n"),
      "utf8",
    );

    const result = runVitest(failingRoot);

    expect(result.status).not.toBe(0);
    expect(`${result.stdout}\n${result.stderr}`).toContain("intentional red contract");
  });
});
