module.exports = {
  env: {
    es2021: true,
    node: true,
  },
  parserOptions: {
    ecmaVersion: 2022,
    sourceType: "module",
  },
  ignorePatterns: ["tmp/", "!.*.cjs", "!.*.js", "!package.json"],
  plugins: ["json-files", "simple-import-sort", "sort-class-members"],
  extends: [
    "eslint:recommended",
    "plugin:import/recommended",
    "plugin:node/recommended",
    "plugin:prettier/recommended",
  ],
  rules: {
    "json-files/sort-package-json": "error",
    "no-process-exit": "off",
    "no-prototype-builtins": "off",
    "no-unused-vars": [
      "error",
      {
        argsIgnorePattern: "^_$",
        varsIgnorePattern: "^_$",
      },
    ],
    "prefer-const": "error",
    "simple-import-sort/exports": "error",
    "simple-import-sort/imports": "error",
    "sort-class-members/sort-class-members": [
      "error",
      {
        order: [
          "[static-properties]",
          "[static-methods]",
          "[properties]",
          "[conventional-private-properties]",
          "constructor",
          "[methods]",
          "[conventional-private-methods]",
        ],
        groups: {
          methods: [{ type: "method", sort: "alphabetical" }],
        },
      },
    ],
  },
};
