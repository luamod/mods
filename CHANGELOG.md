<!-- markdownlint-disable-file -->

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0](https://github.com/luamod/mods/compare/v0.1.0...v0.2.0) (2026-02-14)


### Added

* add is module and typings ([afd88a7](https://github.com/luamod/mods/commit/afd88a7c7617698fe3ce21e3af9c43c3f897b06f))
* add operator module ([d620ef9](https://github.com/luamod/mods/commit/d620ef9cd05c6d78c2d3fe9653e7afb9012f5d12))
* add simple template module ([96e833c](https://github.com/luamod/mods/commit/96e833cd51365c085a290dc1098a1fbf8ea499c8))
* add utils module ([c440cfe](https://github.com/luamod/mods/commit/c440cfe81e99c7f3f60a255f20b35eb4262e6604))
* add validate module ([60005b7](https://github.com/luamod/mods/commit/60005b7aba90cd6dc77bdd5ce475dbb9eb622f5b))
* lazy-load List and Set dependencies ([1e66b3c](https://github.com/luamod/mods/commit/1e66b3c70cca4ce8c5f2fbe5dd4e883c43111217))
* lazy-load mods in init ([d7d6fac](https://github.com/luamod/mods/commit/d7d6facd64bc691d6801beed149a3bf0c2d4e362))
* **validate:** add on_fail hook for validation failures ([31d9b91](https://github.com/luamod/mods/commit/31d9b910421915ca4b757af85bb4388fcb766512))


### Fixed

* align validate aliases and stabilize message template tests ([15c11b8](https://github.com/luamod/mods/commit/15c11b87fff47d394f9adb434d39c39afe1e8dff))
* capture full module description ([6827765](https://github.com/luamod/mods/commit/68277650b3f3cee4b12cae7e933de17440f6b8ad))
* **docs:** correct llms domain url prefix ([64105c1](https://github.com/luamod/mods/commit/64105c134869911a8eed3654a3f7f7d03d268651))
* **docs:** disable clean urls for llms home markdown route ([cba6745](https://github.com/luamod/mods/commit/cba6745bfe4136813277b1b5658c949bf01724c2))
* **docs:** hide llms copy buttons on home page ([adff331](https://github.com/luamod/mods/commit/adff3319df756c918c04cfa4e612433b6ff60e81))
* generate is docs from assigned functions ([ee8a348](https://github.com/luamod/mods/commit/ee8a348028f796435474b01d2401a03d8845fe5e))
* improve docs generator anchors and aliases tabs ([c37bcf5](https://github.com/luamod/mods/commit/c37bcf542857727d4960e2a291ca049579cdff60))
* improve gen-docs aliases and anchor handling ([5e699ed](https://github.com/luamod/mods/commit/5e699edcce6209a9ef80782a4a0b930bb18a6961))
* preserve function names in docs ([bdabe36](https://github.com/luamod/mods/commit/bdabe369c3b00c8c578aa87367b7c2acdf371102))
* remove hardcoded not-alias generation in gen-docs ([3355096](https://github.com/luamod/mods/commit/3355096c2b1b42cb4f389537163e5ee6c532bf93))
* use rawget for _TEST hook ([28f791c](https://github.com/luamod/mods/commit/28f791cd374f385e7403bf9d0b0cb4375b2df5fd))
* **validate:** harden alias lookup ([879f48f](https://github.com/luamod/mods/commit/879f48f189654ec9590d9d87339483154c03e81a))
* **validate:** normalize path validator failure messages ([fe6ccb1](https://github.com/luamod/mods/commit/fe6ccb196748997d820ce4542b1a10e6d2bf8378))
* **validate:** prevent unrelated assignments from overriding on_fail ([64eedad](https://github.com/luamod/mods/commit/64eedad2dec5657b10d1cc247f9f9697ee6b482f))


### Changed

* alias List.setify to Set ([22cfceb](https://github.com/luamod/mods/commit/22cfcebeea37d11a4233836dd6be95fffce58aa6))
* align list runtime and types ([9fd4506](https://github.com/luamod/mods/commit/9fd450662a8be946525dbe1c098e003d1c6a1e21))
* align set runtime and types ([0245833](https://github.com/luamod/mods/commit/0245833d2b05b3e7425b40bae910ce0a655b3212))
* align tbl runtime and types ([c0ef23d](https://github.com/luamod/mods/commit/c0ef23d09f6668cd0b87c7796e8d9b874163e423))
* simplify docs generator ([74ba39b](https://github.com/luamod/mods/commit/74ba39b7761d5383a21475680cc755713c8a1f19))
* simplify list internals ([e6ecbe5](https://github.com/luamod/mods/commit/e6ecbe5e2c9c9712a3e879c81c79061dc105e233))
* simplify set implementation ([84a9aba](https://github.com/luamod/mods/commit/84a9aba7cb7d8f920e50e9090b53c3068dd1de9f))
* **stringcase:** streamline swap and sentence transforms ([ae78911](https://github.com/luamod/mods/commit/ae78911992472a2c5c217479dd250b0613dcc096))
* **str:** optimize splitlines and title paths ([6b87560](https://github.com/luamod/mods/commit/6b87560f944850218823058483cb244316834f8e))
* **str:** return List for split variants and optimize rsplit ([db267b3](https://github.com/luamod/mods/commit/db267b3762d8b3418bdfffb5c585cb3dc7f81064))
* **str:** speed up predicates and startswith fast path ([746f883](https://github.com/luamod/mods/commit/746f883f53c3518fad9c0b04627a41fc7860a111))
* sync validate quote with snippet source ([79ffe41](https://github.com/luamod/mods/commit/79ffe41e35d993eb0aef8ecc4a4001fb36d91192))
* tidy is module ([630994b](https://github.com/luamod/mods/commit/630994bdb93e1c408e9190b86f4ca5028d1a404e))
* tidy shared helpers in str module ([3edd895](https://github.com/luamod/mods/commit/3edd895f12f2984453e9b2f9a29195829450200a))
* tighten list type annotations ([05f20ed](https://github.com/luamod/mods/commit/05f20ed4a991c05e279244bfa0d14363b5fc66cb))
* tighten set type annotations ([2811fe5](https://github.com/luamod/mods/commit/2811fe5f55f03029bfed5b963bb80c42694f99fe))
* use str helpers in docs generator ([6b46c98](https://github.com/luamod/mods/commit/6b46c9829a099537c4671403f89db754d64b8436))
* **validate:** reuse shared quote helper ([1adf011](https://github.com/luamod/mods/commit/1adf011203456aff2beb2ec39f12fd6e1e425f73))
* **validate:** use mods.is predicates ([83cc71b](https://github.com/luamod/mods/commit/83cc71bf77a80776b07a014f46ea2df69f7bde6e))

## [Unreleased]

### Added

- `mods.utils`, utility helpers
  ([c440cfe](https://github.com/luamod/mods/commit/c440cfe)).

### Changed

- `mods.List`: align runtime dependency loading and `setify()` return type with
  `mods.Set` ([9fd4506](https://github.com/luamod/mods/commit/9fd4506)).
- `mods.Set`: align runtime dependency loading with type expectations
  ([0245833](https://github.com/luamod/mods/commit/0245833)).
- `mods.str`: refactor shared helper usage for whitespace splitting, fill char
  handling, and non-empty pattern checks
  ([3edd895](https://github.com/luamod/mods/commit/3edd895)).
- `mods.str`: return `mods.List` from split variants and optimize reverse split
  handling ([db267b3](https://github.com/luamod/mods/commit/db267b3)).
- `mods.str`: optimize splitlines and title code paths
  ([6b87560](https://github.com/luamod/mods/commit/6b87560)).
- `mods.str`: speed up predicates and add startswith fast path
  ([746f883](https://github.com/luamod/mods/commit/746f883)).
- `mods.stringcase`: streamline swap and sentence transforms
  ([ae78911](https://github.com/luamod/mods/commit/ae78911)).
- `mods.tbl`: align `keys()` and `values()` return types with runtime
  `mods.List` results
  ([c0ef23d](https://github.com/luamod/mods/commit/c0ef23d)).
- `mods.validate`: use `mods.is` predicates
  ([83cc71b](https://github.com/luamod/mods/commit/83cc71b)).

### Fixed

- `mods.validate`: prevent unrelated assignments from overriding `on_fail`
  ([64eedad](https://github.com/luamod/mods/commit/64eedad)).
- `mods.validate`: normalize path validator failure messages for
  invalid/non-matching paths
  ([fe6ccb1](https://github.com/luamod/mods/commit/fe6ccb1)).

### Removed

- Removed the `examples/` directory from the repository
  ([a01a69d](https://github.com/luamod/mods/commit/a01a69d)).

## [0.2.0] - 2026-02-11

### Added

- `mods.is`, type predicates for Lua values and filesystem paths
  ([afd88a7](https://github.com/luamod/mods/commit/afd88a7)).
- `mods.operator`, operator helpers as functions
  ([d620ef9](https://github.com/luamod/mods/commit/d620ef9)).
- `mods.template`, simple template rendering with value replacement
  ([96e833c](https://github.com/luamod/mods/commit/96e833c)).
- `mods.validate`, validation predicates with customizable failure handling via
  `validate.on_fail` ([31d9b91](https://github.com/luamod/mods/commit/31d9b91)).

### Changed

- Lazy-load bundled modules on access
  ([d7d6fac](https://github.com/luamod/mods/commit/d7d6fac)).
- Lazy-load `mods.List` and `mods.Set` dependencies in `mods.List`, `mods.Set`,
  `mods.str`, and `mods.tbl`
  ([1e66b3c](https://github.com/luamod/mods/commit/1e66b3c)).

## [0.1.0] - 2026-02-08

### Added

- `mods.List`, Python-style list helpers
  ([7d2f3c8](https://github.com/luamod/mods/commit/7d2f3c8)).
- `mods.Set`, set operations and helpers
  ([ec0d08d](https://github.com/luamod/mods/commit/ec0d08d)).
- `mods.str`, string utilities modeled after Python's `str`
  ([244838a](https://github.com/luamod/mods/commit/244838a)).
- `mods.stringcase`, string case conversion helpers
  ([4a02745](https://github.com/luamod/mods/commit/4a02745)).
- `mods.tbl`, table utilities
  ([f4cbf78](https://github.com/luamod/mods/commit/f4cbf78)).

[Unreleased]: https://github.com/luamod/mods/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/luamod/mods/releases/tag/v0.2.0
[0.1.0]: https://github.com/luamod/mods/releases/tag/v0.1.0
