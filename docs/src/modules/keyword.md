---
desc: "Lua keyword helpers."
---

# `keyword`

Lua keyword helpers.

## Usage

```lua
kw = require "mods.keyword"

kw.iskeyword("local"))         --> true
kw.isidentifier("hello_world") --> true
```

## Dependencies

Dependencies below are lazy-loaded 💤 on first access.

- [`mods.Set`](https://luamod.github.io/mods/modules/set)
- [`mods.List`](https://luamod.github.io/mods/modules/list)

## Functions

| Function                                        | Description                                                                         |
| ----------------------------------------------- | ----------------------------------------------------------------------------------- |
| [`iskeyword`](#iskeyword)                       | Return `true` when `s` is a reserved Lua keyword.                                   |
| [`isidentifier`](#isidentifier)                 | Return `true` when `s` is a valid non-keyword Lua identifier.                       |
| [`kwlist`](#kwlist)                             | Return Lua keywords as a [`mods.List`](https://luamod.github.io/mods/modules/list). |
| [`kwset`](#kwset)                               | Return Lua keywords as a [`mods.Set`](https://luamod.github.io/mods/modules/set).   |
| [`normalize_identifier`](#normalize-identifier) | Normalize an input into a safe Lua identifier.                                      |

### `iskeyword`

Return `true` when `s` is a reserved Lua keyword.

```lua
kw.iskeyword("function") --> true
kw.iskeyword("hello") --> false
```

### `isidentifier`

Return `true` when `s` is a valid non-keyword Lua identifier.

```lua
kw.isidentifier("hello_world") --> true
kw.isidentifier("local") --> false
```

### `kwlist`

Return Lua keywords as a
[`mods.List`](https://luamod.github.io/mods/modules/list).

```lua
kw.kwlist():contains("and") --> true
```

### `kwset`

Return Lua keywords as a
[`mods.Set`](https://luamod.github.io/mods/modules/set).

```lua
kw.kwlset():contains("and") --> true
```

### `normalize_identifier`

Normalize an input into a safe Lua identifier.

```lua
kw.normalize_identifier(" 2 bad-name ") --> "_2_bad_name"
```
