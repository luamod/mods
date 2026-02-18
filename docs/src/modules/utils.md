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
| [`quote(v)`](#fn-quotev)               | Smart-quotes a string for readable Lua-like output.   |

## Functions

### `quote(v)` {#fn-quotev}

Smart-quotes a string for readable Lua-like output.

```lua
print(utils.quote('He said "hi"'))
-- 'He said "hi"'

print(utils.quote([[say "hi" and 'bye']]))
-- "say \"hi\" and 'bye'"
```
