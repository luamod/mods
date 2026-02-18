---@meta mods.keyword

---Lua keyword helpers.
---@class mods.keyword
local M = {}

---Return `true` when `s` is a reserved Lua keyword.
---
---```lua
---print(kw.iskeyword("function")) --> true
---print(kw.iskeyword("hello")) --> false
---```
---@param v any
---@return boolean ok
---@nodiscard
function M.iskeyword(v) end

---Return `true` when `s` is a valid non-keyword Lua identifier.
---
---```lua
---print(kw.isidentifier("hello_world")) --> true
---print(kw.isidentifier("local")) --> false
---```
---@param v any
---@return boolean ok
---@nodiscard
function M.isidentifier(v) end

---Return Lua keywords as a `mods.List` of strings.
---
---```lua
---local words = keyword.kwlist()
---print(words[1]) --> "and"
---```
---@return mods.List<string> words
---@nodiscard
function M.kwlist() end

---Return Lua keywords as a `mods.Set` of strings.
---
---```lua
---local words = kw.kwset()
---print(words["and"]) --> true
---```
---@return mods.Set<string> words
---@nodiscard
function M.kwset() end

---Normalize an input into a safe Lua identifier.
---
---```lua
---print(kw.normalize_identifier(" 2 bad-name ")) --> "_2_bad_name"
---```
---@param s any
---@return string ident
---@nodiscard
function M.normalize_identifier(s) end

return M
