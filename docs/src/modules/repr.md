---
editLinkTarget: types/repr.lua
description: Fast, readable string rendering for Lua values and nested tables.
---

# `repr` <Badge type="warning" text="Unreleased" />

Render any Lua value as a readable string.

## Import

```lua
local mods = require("mods.repr")
```

## Usage

```lua
local out = repr({
  user = { name = "Ada", role = "Engineer" },
  count = 3,
  msg = 'He said "hi"',
})
-- result:
-- {
--   count = 3,
--   msg = 'He said "hi"',
--   user = {
--     name = "Ada",
--     role = "Engineer"
--   }
-- }

out = repr({
  user = {
    name = "Ada",
    meta = { role = "Engineer" },
  },
})
-- result:
-- {
--   user = {
--     meta = {
--       role = "Engineer"
--     },
--     name = "Ada"
--   }
-- }
```
