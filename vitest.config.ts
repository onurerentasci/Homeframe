import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    coverage: {
      exclude: ["packages/*/src/index.ts"],
      include: ["packages/*/src/**/*.ts"],
      provider: "v8",
      reporter: ["text", "json-summary"],
    },
    exclude: [
      "**/node_modules/**",
      "**/dist/**",
      "**/build/**",
      ".tmp-homeframe-*/**",
    ],
    include: ["tests/**/*.test.ts", "packages/**/*.test.ts"],
  },
});
