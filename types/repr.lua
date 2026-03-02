---@meta mods.repr
---
---Render any Lua value as a readable string.
---
---## Usage
---
---```lua
---repr = require "mods.repr"
---
---print(repr("Hello world!")) --> "Hello world!"
---
---view = { user = { name = "Ada", tags = { "lua", "docs" } } }
---print(repr(view))
-----> {
-----    user = {
-----      name = "Ada",
-----      tags = {
-----        [1] = "lua",
-----        [2] = "docs"
-----      }
-----    }
-----  }
---```
---

---
---Convert a Lua value to a readable string representation.
---
---```lua
---repr("Hello")      --> '"Hello"'
---repr({ "a", "b" }) --> '{ "a", "b" }'
---repr()             --> "nil"
---```
---
---@param v any Value to render.
---@return string out Readable string representation.
---@nodiscard
local function repr(v) end

return repr
