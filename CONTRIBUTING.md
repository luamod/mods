# Contributing

Thanks for your interest in contributing!

## Ways to Contribute

- Open an [issue](https://github.com/luamod/mods/issues) to discuss bugs or
  feature ideas.
- Submit a [pull request](https://github.com/luamod/mods/pulls) with clear scope
  and tests when possible.

## Tests

Run tests with [Busted](https://github.com/lunarmodules/busted):

```sh
# All tests
busted

# One spec file while iterating
busted spec/<module>_spec.lua
```

## Linting

- Run Lua lint with [LuaCheck](https://github.com/mpeterv/luacheck):

  ```sh
  luacheck .
  ```

- Run Markdown lint for docs with
  [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2):

  ```sh
  # Global install
  markdownlint-cli2 'docs/**/*.md' '!docs/.vitepress/**'

  # Without global install
  npx --yes markdownlint-cli2 'docs/**/*.md' '!docs/.vitepress/**'
  ```

## Documentation

- Docs are built with [VitePress](https://vitepress.dev/) and live in
  [`docs/`](docs/).
- For docs setup, build, preview, and local development commands, see
  [`docs/README.md`](docs/README.md).

## Contribution Guidelines

- Keep changes focused and small.
- Update [`docs/`](docs/) or [`types/`](types/) where appropriate.
- Add or update tests when behavior changes.
- If adding a module under [`src/mods/`](src/mods/), also update:
  [`src/mods/init.lua`](src/mods/init.lua), [`types/mods.lua`](types/mods.lua),
  [`README.md`](README.md#modules),
  [`docs/modules/index.md`](docs/modules/index.md), and
  [`mods-0.1.0-1.rockspec`](mods-0.1.0-1.rockspec).
- Do not edit `CHANGELOG.md` unless explicitly needed. When manually adding a
  changelog entry, include a linked commit SHA or PR number.

## Commit Messages

This project follows
[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) 1.0.0.
