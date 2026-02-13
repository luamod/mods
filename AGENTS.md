# AGENTS Guidelines for This Repository

This repo contains Lua modules in `src/mods`, type stubs in `types/` (kept aligned with `src/mods` behavior), and docs in `docs/` with module pages under `docs/modules/` (VitePress).

## Repository structure

```text
.
├── src/
│   └── mods/              runtime Lua modules
├── types/                 Lua type stubs and API signatures
├── spec/                  test suite (Busted)
├── docs/                  documentation source (VitePress)
│   └── modules/           per-module documentation pages
├── scripts/               project helper scripts
├── .github/
│   └── workflows/         CI pipelines (GitHub Actions)
└── CHANGELOG.md           release notes for user-visible changes
```

## Build and test commands

- Install JS dependencies: `npm install`
- Run Lua tests: `busted`
- Run a focused spec file: `busted spec/<module>_spec.lua`
- Run lint: `luacheck .`
- Format Markdown (requires globally installed Prettier): `prettier --write "**/*.md"`
- Build docs: `npm run build`
- Docs dev server (optional): `npm run dev`

## Code style

- Match existing Lua style in `src` and `spec`.
- Keep Lua formatting stable; only touch formatting when the change requires it.
- Respect existing `-- stylua: ignore` blocks.
- Ensure code is compatible with all supported Lua versions (5.1+).
- Prefer simple, efficient implementations; avoid unnecessary allocations or slow paths in hot code.

## Commit messages

- Use Conventional Commits 1.0.0 for all commit messages.
- Preferred workflow types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `ci`, `build`, `perf`.
- Prefer scoped subjects when useful (e.g., `fix(validate): normalize path error message`).

## Change scope

- Keep changes focused and small.
- Update docs or types when behavior changes.
- When adding a new module under `src/mods/`, also update:
  - `src/mods/init.lua` exports.
  - `types/mods.lua` type surface.
  - `README.md` modules table.
  - `docs/modules/index.md` modules table.
  - `build.modules` in `mods-0.1.0-1.rockspec`.
- Ensure user-visible changes use visible commit types (`feat`, `fix`, `perf`, `refactor`); update `CHANGELOG.md` manually only when explicitly needed.
- When manually editing changelog entries, include either a linked commit SHA or a linked PR number.

## Testing

- Add or update tests when behavior changes and tests exist.
- When adding multiple related cases, prefer table-driven tests (case tables) when practical.
- Prefer running module-focused tests while iterating, then run broader checks before finishing.

## CI context

- CI uses GitHub Actions; Lua tooling and LuaRocks are part of the workflow.
