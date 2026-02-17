---
description: Common utility helpers.
---

# `utils`

Common utility helpers.

## Import

```lua
local utils = require("mods.utils")
```

## Quick Reference

| Function                               | Description                                           |
| -------------------------------------- | ----------------------------------------------------- |
| [`isidentifier(s)`](#fn-isidentifiers) | Checks if a string is a valid non-keyword identifier. |
| [`quote(v)`](#fn-quotev)               | Smart-quotes a string for readable Lua-like output.   |

## Functions

### `isidentifier(s)` {#fn-isidentifiers}

Returns `true` when `s` is a valid Lua identifier and not a reserved keyword.

```lua
print(utils.isidentifier("hello_world"))
-- true

print(utils.isidentifier("local"))
-- false

print(utils.isidentifier("2bad"))
-- false
```

### `quote(v)` {#fn-quotev}

Smart-quotes a string for readable Lua-like output.

```lua
print(utils.quote('He said "hi"'))
-- 'He said "hi"'

print(utils.quote([[say "hi" and 'bye']]))
-- "say \"hi\" and 'bye'"
```
