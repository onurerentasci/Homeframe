import { spawn } from "node:child_process";
import { createHash } from "node:crypto";
import { readdir, readFile } from "node:fs/promises";
import { join, relative, resolve } from "node:path";

export type PrebuildIdempotencyOptions = {
  projectRoot: string;
  runs: number;
};

export type PrebuildIdempotencyResult = {
  changedFiles: string[];
  runs: number;
};

async function runExpo(projectRoot: string, arguments_: string[]): Promise<void> {
  const executable = resolve(projectRoot, "node_modules/.bin/expo");

  await new Promise<void>((resolvePromise, reject) => {
    const child = spawn(executable, arguments_, {
      cwd: projectRoot,
      env: { ...process.env, CI: "1" },
      stdio: "pipe",
    });
    let output = "";

    child.stdout.on("data", (chunk: Buffer) => {
      output += chunk.toString();
    });
    child.stderr.on("data", (chunk: Buffer) => {
      output += chunk.toString();
    });
    child.once("error", reject);
    child.once("close", (code) => {
      if (code === 0) {
        resolvePromise();
      } else {
        reject(new Error(`expo prebuild başarısız (exit ${String(code)}):\n${output}`));
      }
    });
  });
}

async function snapshot(root: string): Promise<Map<string, string>> {
  const result = new Map<string, string>();

  async function visit(directory: string): Promise<void> {
    const entries = await readdir(directory, { withFileTypes: true });
    entries.sort((left, right) => left.name.localeCompare(right.name));

    for (const entry of entries) {
      if (entry.name === ".gradle" || entry.name === "build") {
        continue;
      }

      const absolutePath = join(directory, entry.name);
      if (entry.isDirectory()) {
        await visit(absolutePath);
      } else if (entry.isFile()) {
        const contents = await readFile(absolutePath);
        result.set(
          relative(root, absolutePath),
          createHash("sha256").update(contents).digest("hex"),
        );
      }
    }
  }

  await visit(root);
  return result;
}

function diffSnapshots(
  before: ReadonlyMap<string, string>,
  after: ReadonlyMap<string, string>,
): string[] {
  const names = new Set([...before.keys(), ...after.keys()]);
  return [...names]
    .filter((name) => before.get(name) !== after.get(name))
    .sort((left, right) => left.localeCompare(right));
}

export async function runPrebuildIdempotencyCheck(
  options: PrebuildIdempotencyOptions,
): Promise<PrebuildIdempotencyResult> {
  if (!Number.isInteger(options.runs) || options.runs < 1) {
    throw new RangeError("runs pozitif bir tam sayı olmalı.");
  }

  const projectRoot = resolve(options.projectRoot);
  const androidRoot = join(projectRoot, "android");
  await runExpo(projectRoot, ["prebuild", "--platform", "android", "--clean", "--no-install"]);
  const baseline = await snapshot(androidRoot);
  const changedFiles = new Set<string>();

  for (let run = 0; run < options.runs; run += 1) {
    await runExpo(projectRoot, ["prebuild", "--platform", "android", "--no-install"]);
    const current = await snapshot(androidRoot);
    for (const changedFile of diffSnapshots(baseline, current)) {
      changedFiles.add(changedFile);
    }
  }

  return { changedFiles: [...changedFiles].sort(), runs: options.runs };
}
