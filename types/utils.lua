---@meta mods.utils

---Small shared utility helpers used by modules in this library.
---@class mods.utils
local M = {}

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
