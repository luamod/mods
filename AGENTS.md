These instructions apply to automated agents working in this repo.

## Project overview

- This repo contains standalone Lua modules under `src/mods` (e.g., `mods.List`, `mods.Set`, `mods.tbl`, `mods.stringcase`).
- Documentation lives in `docs` and is built with VitePress.

## Build and test commands

- Install JS dependencies: `npm install`
- Run Lua tests: `busted`
- Run lint: `luacheck .`
- Build docs: `npm run build`
- Docs dev server (optional): `npm run dev`

## Code style

- Match existing Lua style in `src` and `spec`.
- Keep Lua formatting stable; only touch formatting when the change requires it.
- Respect existing `-- stylua: ignore` blocks.

## Commit messages

- Use Conventional Commits 1.0.0 for all commit messages (e.g., `feat: ...`, `fix: ...`, `chore: ...`).

## Change scope

- Keep changes focused and small.
- Update docs or types when behavior changes.

## Testing

- Add or update tests when behavior changes and tests exist.

## Pull request guidelines

- Open an issue for bugs or feature ideas when scope is unclear.
- Submit a PR with clear scope and tests when possible.

## Security considerations

- Follow `SECURITY.md` for vulnerability reporting (use GitHub Security Advisories).

## CI context

- CI uses GitHub Actions; Lua tooling and LuaRocks are part of the workflow.
