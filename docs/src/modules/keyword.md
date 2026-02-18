---
description: Lua keyword helpers for reserved-word checks.
---

# `keyword`

Lua keyword helpers.

## Import

```lua
local kw = require("mods.keyword")
```

## Dependencies

- [`mods.List`] is used by `kwlist()`.
- [`mods.Set`] is used by `kwset()`.

> [!NOTE]
>
> These dependencies are lazy-loaded internally 💤, so requiring `mods.keyword`
> does not immediately load them.

## Quick Reference

| Function                                               | Description                                        |
| ------------------------------------------------------ | -------------------------------------------------- |
| [`iskeyword(s)`](#fn-iskeywords)                       | Return `true` when `s` is a reserved Lua keyword.  |
| [`isidentifier(s)`](#fn-isidentifiers)                 | Return `true` for valid non-keyword identifiers.   |
| [`kwlist()`](#fn-kwlist)                               | Return Lua keywords as a [`mods.List`] of strings. |
| [`kwset()`](#fn-kwset)                                 | Return Lua keywords as a [`mods.Set`] of strings.  |
| [`normalize_identifier(s)`](#fn-normalize_identifiers) | Normalize input to a safe identifier.              |

## Functions

### `iskeyword(s)` {#fn-iskeywords}

Return `true` when `s` is a reserved Lua keyword.

> [!NOTE]
>
> `goto` is treated as a keyword on Lua 5.2+ and not on Lua 5.1/LuaJIT.

```lua
print(kw.iskeyword("function")) --> true
print(kw.iskeyword("hello"))    --> false
```

### `kwlist()` {#fn-kwlist}

Return Lua keywords as a [`mods.List`] of strings.

```lua
local keywords = kw.kwlist()
print(keywords[1])         --> "and"
print(keywords[#keywords]) --> "while"
```

### `kwset()` {#fn-kwset}

Return Lua keywords as a [`mods.Set`] of strings.

```lua
local words = kw.kwset()
print(words["and"])   --> true
print(words["hello"]) --> nil
```

### `isidentifier(s)` {#fn-isidentifiers}

Return `true` when `s` is a valid non-keyword Lua identifier.

```lua
print(kw.isidentifier("hello_world")) --> true
print(kw.isidentifier("local"))       --> false
```

### `normalize_identifier(s)` {#fn-normalize_identifiers}

Normalize input to a safe Lua identifier.

```lua
print(kw.normalize_identifier(" 2 bad-name ")) --> "_2_bad_name"
print(kw.normalize_identifier("local"))        --> "local_"
print(kw.normalize_identifier("end"))          --> "end_"
print(kw.normalize_identifier("   "))          --> "_"
print(kw.normalize_identifier(false))          --> "false_"
```

[`mods.List`]: /modules/list
[`mods.Set`]: /modules/set
