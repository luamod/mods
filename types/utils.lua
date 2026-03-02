---@meta mods.utils

---
---Small shared utility helpers used by modules in this library.
---
---## Usage
---
---```lua
---utils = require "mods.utils"
---
---print(utils.quote('hello "world"')) --> 'hello "world"'
---```
---
---@class mods.utils
local M = {}

---
---Smart-quote a string for readable Lua-like output.
---
---```lua
---print(utils.quote('He said "hi"')) -- 'He said "hi"'
---print(utils.quote('say "hi" and \\'bye\\'')) -- "say \"hi\" and 'bye'"
---```
---
---@param v string String to quote.
---@return string out Quoted string.
---@nodiscard
function M.quote(v) end

---
---Format a key chain as a Lua-like table access path.
---
---```lua
---p1 = utils.keypath("t", "a", "b", "c")        --> "t.a.b.c"
---p2 = utils.keypath("ctx", "users", 1, "name") --> "ctx.users[1].name"
---p3 = utils.keypath("ctx", "invalid-key")      --> 'ctx["invalid-key"]'
---p4 = utils.keypath()                          --> ""
---```
---
---@param ... any Additional arguments.
---@return string path Rendered key path.
---@nodiscard
function M.keypath(...) end

return M
