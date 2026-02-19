---@meta mods.repr

---Render any Lua value as a readable string.
---
---```lua
---repr({ a = 1, msg = 'He said "hi"' })
----- result:
----- {
-----   a = 1,
-----   msg = 'He said "hi"'
----- }
---```
---@alias mods.repr fun(v:any):string

---@type mods.repr
local repr

return repr
