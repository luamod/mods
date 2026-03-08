# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.5.0](https://github.com/luamod/mods/compare/v0.4.0...v0.5.0) (2026-03-08)


### Features

* **fs:** add filesystem module and helpers ([99f9d46](https://github.com/luamod/mods/commit/99f9d4611d5be4f9c74123f1ddc6a0c5115f84ce))
* **mods:** expose fs module ([ed61252](https://github.com/luamod/mods/commit/ed612522924affa6f339c0e204571f804ae09cf8))
* **ntpath:** add ntpath module ([d58b6eb](https://github.com/luamod/mods/commit/d58b6ebe4f8e8ec793cf57e256f48e0a75a471e7))
* **path:** add home and improve expanduser errors ([5c1c5eb](https://github.com/luamod/mods/commit/5c1c5eb4f33f2416f268e0f2e0901cc1fce4a84f))
* **path:** add shared _splitext helper module ([d89f172](https://github.com/luamod/mods/commit/d89f172207c39c0843c23b88896e0f9195103b26))
* **path:** expose path modules ([05f176f](https://github.com/luamod/mods/commit/05f176f2e290de382b1d1bfc84bf6d6556635ad0))
* **posixpath:** add lexical posix path module ([909b137](https://github.com/luamod/mods/commit/909b137c73e709bb1e6051c09776535aa9c27bdb))
* **runtime:** add is_windows host flag ([bbdc895](https://github.com/luamod/mods/commit/bbdc89509feb07fa1cc3cd5d48ad5866a0ae7788))
* **utils:** add assert_arg helper ([9633b25](https://github.com/luamod/mods/commit/9633b258b63a22351b2313653b7068dcf99c632d))


### Bug Fixes

* **docs:** support include fragments in export ([6c2160e](https://github.com/luamod/mods/commit/6c2160ecb52c0fdbac504ea046635c65a7ad1618))
* **posixpath:** return empty string for empty commonpath input ([e841e73](https://github.com/luamod/mods/commit/e841e7377d891504c22a700afda9cb9832c17d96))
* **utils:** derive assert_arg caller from error level ([57f6977](https://github.com/luamod/mods/commit/57f6977069e1f89595eb4b9fcb06778bbe837902))

## [0.4.0](https://github.com/luamod/mods/compare/v0.3.0...v0.4.0) (2026-03-02)


### Features

* **fs:** add internal filesystem helper module ([#8](https://github.com/luamod/mods/issues/8)) ([1c13573](https://github.com/luamod/mods/commit/1c13573e322b0c2ab3b4617cdba99ab3369adb95))
* **keyword:** add keyword module with docs, types, and tests ([#6](https://github.com/luamod/mods/issues/6)) ([d0103c1](https://github.com/luamod/mods/commit/d0103c1d11fd62b57f4b0a5d3ae8060a7ac9eb4d))
* **List:** add and document __add operator behavior ([44420a5](https://github.com/luamod/mods/commit/44420a58d4e13dcdfca52e969141014c3f2e6405))
* **List:** add equals method and __eq metamethod ([f5099fe](https://github.com/luamod/mods/commit/f5099fe8e781228c0bf47d67aafb42618d32983c))
* **List:** add keypath() method ([08f15d8](https://github.com/luamod/mods/commit/08f15d8d47742d107e2f09ba62605ae8326b38a4))
* **List:** add lexicographic lt/le comparisons ([967dd74](https://github.com/luamod/mods/commit/967dd74a81ee4b006ca3eaaffdd16183623e3e23))
* **List:** add mul method and __mul operator ([a24d77b](https://github.com/luamod/mods/commit/a24d77b71624c96647c8ee3009c7db4bf261a28b))
* **List:** add native concat method ([3110103](https://github.com/luamod/mods/commit/31101037669599ccd1fced988c4c5642501f053f))
* **List:** add optional quoted mode to join ([a095afb](https://github.com/luamod/mods/commit/a095afb6524d7dbee1bd739699279ebcc7acf4fb))
* **List:** add tostring method and metamethod ([94f8516](https://github.com/luamod/mods/commit/94f8516be17549799b0214175708e82899a8b028))
* **List:** make join stringify values safely ([fb89a80](https://github.com/luamod/mods/commit/fb89a809755cc4c9140634227fed6b7c667cc7fa))
* **List:** support subtraction operator for difference ([211bc1a](https://github.com/luamod/mods/commit/211bc1adde5c977712e9dd934d5fc5b766ba065b))
* **repr:** add repr module ([#7](https://github.com/luamod/mods/issues/7)) ([da6bcec](https://github.com/luamod/mods/commit/da6bcec36eb0e0c4980e45944d0271a58a56bbb7))
* **runtime:** add runtime metadata module ([dd38008](https://github.com/luamod/mods/commit/dd38008dc191343148a2a33ac5f5211721030d40))
* **Set:** add __add metamethod for union ([60c989e](https://github.com/luamod/mods/commit/60c989e76578533cfb77e0c5312e08673f857335))
* **Set:** add __lt and __le subset comparisons ([bc77e7f](https://github.com/luamod/mods/commit/bc77e7ffb4e2e5832cb3b3ec3b31b2580ff699a9))
* **Set:** add __sub metamethod for difference ([347300f](https://github.com/luamod/mods/commit/347300fa2d90acf7fb8ea1130ff368d8102dfe8e))
* **Set:** add & operator for intersection ([b22cc21](https://github.com/luamod/mods/commit/b22cc214797dd274d0d6a71426cf93d38a465084))
* **Set:** add ^ operator for symmetric difference ([3a9b379](https://github.com/luamod/mods/commit/3a9b3790b930e52bb2311bf61e7c35b683eb3ba9))
* **Set:** add | operator for union ([9478734](https://github.com/luamod/mods/commit/9478734b485e142eab1c12bed883f4f2c310b66c))
* **Set:** add contains method ([b11f050](https://github.com/luamod/mods/commit/b11f0502fe7a47787a16401330c45735d95735bd))
* **Set:** add equality method and __eq metamethod ([f51af8d](https://github.com/luamod/mods/commit/f51af8df943d4c8ecc25166dbf3617c36c490c2e))
* **tbl:** add keypath() function ([4b2f590](https://github.com/luamod/mods/commit/4b2f590e352d0921dace1482a08eff195ce8e30f))
* **tbl:** add same function ([c8e0c55](https://github.com/luamod/mods/commit/c8e0c556c58431f4834bbdb52978a06ff830c557))
* **utils:** add lazy repr resolver with inspect fallback ([aec7f60](https://github.com/luamod/mods/commit/aec7f60c15534b66d62aac70c597ab0baa0e1725))


### Bug Fixes

* **is:** add __index for case-insensitive type lookups ([6423e02](https://github.com/luamod/mods/commit/6423e025fdc9979469e43377b295946e26d867bf))
* **str:** return single values from gsub-backed helpers ([d8ab831](https://github.com/luamod/mods/commit/d8ab83140a2fb95ab535d0616c94ceb8c8e80b6c))
* **template:** validate template and view argument types ([e55f1a2](https://github.com/luamod/mods/commit/e55f1a2df5daa61dddef615c20d461464da96f00))

## [0.3.0](https://github.com/luamod/mods/compare/v0.2.0...v0.3.0) (2026-02-17)


### Features

* add utils module ([c440cfe](https://github.com/luamod/mods/commit/c440cfe81e99c7f3f60a255f20b35eb4262e6604))


### Bug Fixes

* **docs:** correct llms domain url prefix ([64105c1](https://github.com/luamod/mods/commit/64105c134869911a8eed3654a3f7f7d03d268651))
* **docs:** disable clean urls for llms home markdown route ([cba6745](https://github.com/luamod/mods/commit/cba6745bfe4136813277b1b5658c949bf01724c2))
* **docs:** hide llms copy buttons on home page ([adff331](https://github.com/luamod/mods/commit/adff3319df756c918c04cfa4e612433b6ff60e81))
* **docs:** hide llms copy buttons on index page ([b08c287](https://github.com/luamod/mods/commit/b08c287becc4cc2c3d42cab59120c64431c7399f))
* **validate:** harden alias lookup ([879f48f](https://github.com/luamod/mods/commit/879f48f189654ec9590d9d87339483154c03e81a))
* **validate:** normalize path validator failure messages ([fe6ccb1](https://github.com/luamod/mods/commit/fe6ccb196748997d820ce4542b1a10e6d2bf8378))
* **validate:** prevent unrelated assignments from overriding on_fail ([64eedad](https://github.com/luamod/mods/commit/64eedad2dec5657b10d1cc247f9f9697ee6b482f))


### Performance Improvements

* **stringcase:** streamline swap and sentence transforms ([ae78911](https://github.com/luamod/mods/commit/ae78911992472a2c5c217479dd250b0613dcc096))
* **str:** optimize splitlines and title paths ([6b87560](https://github.com/luamod/mods/commit/6b87560f944850218823058483cb244316834f8e))
* **str:** speed up predicates and startswith fast path ([746f883](https://github.com/luamod/mods/commit/746f883f53c3518fad9c0b04627a41fc7860a111))

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

[0.2.0]: https://github.com/luamod/mods/releases/tag/v0.2.0
[0.1.0]: https://github.com/luamod/mods/releases/tag/v0.1.0
