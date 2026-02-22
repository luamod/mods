---@meta mods.repr

---Render any Lua value as a readable string.
---
---## Usage
---
---```lua
---repr = require "mods.repr"
---
---print(repr("Hello world!")) --> "Hello world!"
---
---print(repr({ user = { name = "Ada", tags = { "lua", "docs" } } }))
-----> {
-----    user = {
-----      name = "Ada",
-----      tags = {
-----        [1] = "lua",
-----        [2] = "docs"
-----      }
-----    }
-----  }
---
---```
---@alias mods.repr fun(v:any):string

---@type mods.repr
local repr

return repr
