# AGENTS Guidelines for This Repository

This repo contains Lua modules in `src/mods`, type stubs in `types/` (kept
aligned with `src/mods` behavior), and docs in `docs/` with module pages under
`docs/modules/` (VitePress).

## Repository structure

```text
.
├── src/
│   └── mods/              runtime Lua modules
├── types/                 Lua type stubs and API signatures
├── spec/                  test suite (Busted)
├── docs/                  documentation source (VitePress)
│   └── modules/           per-module documentation pages
├── .github/
│   └── workflows/         CI pipelines (GitHub Actions)
└── CHANGELOG.md           release notes for user-visible changes
```

## Build and test commands

- Install docs dependencies: `npm --prefix docs install`
- Run all Lua tests: `busted`
- Run one spec file while iterating: `busted spec/<module>_spec.lua`
- Run Lua lint: `luacheck .`
- Run focused Lua lint: `luacheck src spec types`
- Run Markdown lint: `markdownlint-cli2 'docs/**/*.md' '!docs/.vitepress/**'`
- Format Markdown: `prettier --write "**/*.md"`
- Build docs: `npm --prefix docs run docs:build`
- Run docs dev server: `npm --prefix docs run docs:dev`

## Code style

- Match existing Lua style in `src` and `spec`.
- Keep Lua formatting stable; only touch formatting when the change requires it.
- Respect existing `-- stylua: ignore` blocks.
- Ensure code is compatible with all supported Lua versions (5.1+).
- Prefer simple, efficient implementations; avoid unnecessary allocations or
  slow paths in hot code.
- Avoid broad formatting-only edits outside the files required for the task.

## Change scope

- Keep changes focused and small.
- Update docs or types when behavior changes.
- If runtime behavior changes in `src/mods`, update matching type stubs in
  `types/`.
- If public module behavior changes, update corresponding docs in
  `docs/src/modules/`.
- For cross-cutting refactors, separate mechanical edits from behavior changes
  when practical.

## Module additions

If adding a new module under `src/mods/`, also update:

- `src/mods/init.lua` exports.
- `types/mods.lua` type surface.
- `README.md` modules table.
- `docs/src/modules/index.md` modules table.
- Rockspec template module entries in `mods.rockspec.template`.

## Testing

- Add or update tests when behavior changes and tests exist.
- When adding multiple related cases, prefer table-driven tests (case tables)
  when practical.
- Prefer running module-focused tests while iterating, then run broader checks
  before finishing.

## CI parity

- Run local checks that mirror CI before finishing: tests, `luacheck`, docs lint
  (`markdownlint-cli2`), and docs build when docs are touched.
- When Markdown files change, run `prettier --write "**/*.md"` before commit.
- If docs tooling changes, validate `npm --prefix docs run docs:build` still
  succeeds.
