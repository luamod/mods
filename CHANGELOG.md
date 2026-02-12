# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `mods.utils`, utility helpers ([c440cfe](https://github.com/luamod/mods/commit/c440cfe)).

### Fixed

- `mods.validate`: prevent unrelated assignments from overriding `on_fail` ([64eedad](https://github.com/luamod/mods/commit/64eedad)).
- `mods.validate`: normalize path validator failure messages for invalid/non-matching paths ([fe6ccb1](https://github.com/luamod/mods/commit/fe6ccb1)).

### Removed

- Removed the `examples/` directory from the repository ([a01a69d](https://github.com/luamod/mods/commit/a01a69d)).

## [0.2.0] - 2026-02-11

### Added

- `mods.is`, type predicates for Lua values and filesystem paths ([afd88a7](https://github.com/luamod/mods/commit/afd88a7)).
- `mods.operator`, operator helpers as functions ([d620ef9](https://github.com/luamod/mods/commit/d620ef9)).
- `mods.template`, simple template rendering with value replacement ([96e833c](https://github.com/luamod/mods/commit/96e833c)).
- `mods.validate`, validation predicates with customizable failure handling via `validate.on_fail` ([31d9b91](https://github.com/luamod/mods/commit/31d9b91)).

### Changed

- Lazy-load bundled modules on access ([d7d6fac](https://github.com/luamod/mods/commit/d7d6fac)).
- Lazy-load `mods.List` and `mods.Set` dependencies in `mods.List`, `mods.Set`, `mods.str`, and `mods.tbl` ([1e66b3c](https://github.com/luamod/mods/commit/1e66b3c)).

## [0.1.0] - 2026-02-08

### Added

- `mods.List`, Python-style list helpers ([7d2f3c8](https://github.com/luamod/mods/commit/7d2f3c8)).
- `mods.Set`, set operations and helpers ([ec0d08d](https://github.com/luamod/mods/commit/ec0d08d)).
- `mods.str`, string utilities modeled after Python's `str` ([244838a](https://github.com/luamod/mods/commit/244838a)).
- `mods.stringcase`, string case conversion helpers ([4a02745](https://github.com/luamod/mods/commit/4a02745)).
- `mods.tbl`, table utilities ([f4cbf78](https://github.com/luamod/mods/commit/f4cbf78)).

[Unreleased]: https://github.com/luamod/mods/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/luamod/mods/releases/tag/v0.2.0
[0.1.0]: https://github.com/luamod/mods/releases/tag/v0.1.0
