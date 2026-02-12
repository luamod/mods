---@meta mods.utils

---Small shared utility helpers used by modules in this library.
---@class mods.utils
local M = {}

---Return true if `s` is a valid non-keyword Lua identifier.
---
---```lua
---print(utils.isidentifier("name"))  -- true
---print(utils.isidentifier("local")) -- false
---```
---@param s string
---@return boolean ok
---@nodiscard
function M.isidentifier(s) end

---Smart-quote a string for readable Lua-like output.
---
---```lua
---print(utils.quote('He said "hi"')) -- 'He said "hi"'
---print(utils.quote('say "hi" and \\'bye\\'')) -- "say \"hi\" and 'bye'"
---```
---@param v string
---@return string out
---@nodiscard
function M.quote(v) end

return M
