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

## Functions

| Function                                              | Description                                                                         |
| ----------------------------------------------------- | ----------------------------------------------------------------------------------- |
| [`iskeyword(v)`](#fn-iskeyword)                       | Return `true` when `v` is a reserved Lua keyword.                                   |
| [`isidentifier(v)`](#fn-isidentifier)                 | Return `true` when `v` is a valid non-keyword Lua identifier.                       |
| [`kwlist()`](#fn-kwlist)                              | Return Lua keywords as a [`mods.List`](https://luamod.github.io/mods/modules/list). |
| [`kwset()`](#fn-kwset)                                | Return Lua keywords as a [`mods.Set`](https://luamod.github.io/mods/modules/set).   |
| [`normalize_identifier(s)`](#fn-normalize-identifier) | Normalize an input into a safe Lua identifier.                                      |

<a id="fn-iskeyword"></a>

### `iskeyword(v)`

Return `true` when `v` is a reserved Lua keyword.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
kw.iskeyword("function") --> true
kw.iskeyword("hello") --> false
```

<a id="fn-isidentifier"></a>

### `isidentifier(v)`

Return `true` when `v` is a valid non-keyword Lua identifier.

**Parameters**:

- `v` (`any`): Value to validate.

**Return**:

- `ok` (`boolean`): Whether the check succeeds.

**Example**:

```lua
kw.isidentifier("hello_world") --> true
kw.isidentifier("local") --> false
```

<a id="fn-kwlist"></a>

### `kwlist()`

Return Lua keywords as a
[`mods.List`](https://luamod.github.io/mods/modules/list).

**Return**:

- `words` (`mods.List<string>`): List of Lua keywords.

**Example**:

```lua
kw.kwlist():contains("and") --> true
```

<a id="fn-kwset"></a>

### `kwset()`

Return Lua keywords as a
[`mods.Set`](https://luamod.github.io/mods/modules/set).

**Return**:

- `words` (`mods.Set<string>`): Set of Lua keywords.

**Example**:

```lua
kw.kwlset():contains("and") --> true
```

<a id="fn-normalize-identifier"></a>

### `normalize_identifier(s)`

Normalize an input into a safe Lua identifier.

**Parameters**:

- `s` (`string`): Input string.

**Return**:

- `ident` (`string`): Normalized Lua identifier.

**Example**:

```lua
kw.normalize_identifier(" 2 bad-name ") --> "_2_bad_name"
```
