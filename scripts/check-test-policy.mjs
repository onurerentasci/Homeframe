import { readdir, readFile } from "node:fs/promises";
import { extname, join, relative } from "node:path";

const workspaceRoot = process.cwd();
const ignoredDirectories = new Set([
  ".git",
  ".gradle",
  "build",
  "coverage",
  "dist",
  "node_modules",
]);
const inspectedExtensions = new Set([".js", ".jsx", ".kt", ".kts", ".ts", ".tsx"]);
const forbiddenPatterns = [
  { label: "focused/disabled JS test", pattern: /\b(?:describe|it|test)\.(?:only|skip)\s*\(/u },
  { label: "disabled JS test alias", pattern: /\b(?:fdescribe|fit|xdescribe|xit|xtest)\s*\(/u },
  { label: "ignored Kotlin/JUnit test", pattern: /@Ignore\b/u },
];

async function collectFiles(directory) {
  const entries = await readdir(directory, { withFileTypes: true });
  const files = [];

  for (const entry of entries) {
    if (entry.name.startsWith(".tmp-homeframe-")) {
      continue;
    }

    const path = join(directory, entry.name);
    if (entry.isDirectory()) {
      if (!ignoredDirectories.has(entry.name)) {
        files.push(...(await collectFiles(path)));
      }
      continue;
    }

    if (entry.isFile() && inspectedExtensions.has(extname(entry.name))) {
      files.push(path);
    }
  }

  return files;
}

const violations = [];
for (const file of await collectFiles(workspaceRoot)) {
  const contents = await readFile(file, "utf8");
  for (const { label, pattern } of forbiddenPatterns) {
    if (pattern.test(contents)) {
      violations.push(`${relative(workspaceRoot, file)}: ${label}`);
    }
  }
}

if (violations.length > 0) {
  console.error(`Test politikası ihlali:\n${violations.join("\n")}`);
  process.exitCode = 1;
} else {
  console.log("Test politikası: skip/only/@Ignore bulunmadı.");
}
