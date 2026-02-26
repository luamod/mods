---@meta mods.keyword

---
---Lua keyword helpers.
---
---## Usage
---
---```lua
---kw = require "mods.keyword"
---
---kw.iskeyword("local"))         --> true
---kw.isidentifier("hello_world") --> true
---```
---
---@class mods.keyword
local M = {}

---
---Return `true` when `s` is a reserved Lua keyword.
---
---```lua
---kw.iskeyword("function") --> true
---kw.iskeyword("hello") --> false
---```
---
---@param v any
---@return boolean ok
---@nodiscard
function M.iskeyword(v) end

---
---Return `true` when `s` is a valid non-keyword Lua identifier.
---
---```lua
---kw.isidentifier("hello_world") --> true
---kw.isidentifier("local") --> false
---```
---
---@param v any
---@return boolean ok
---@nodiscard
function M.isidentifier(v) end

---
---Return Lua keywords as a [`mods.List`](https://luamod.github.io/mods/modules/list).
---
---```lua
---kw.kwlist():contains("and") --> true
---```
---
---@return mods.List<string> words
---@nodiscard
function M.kwlist() end

---
---Return Lua keywords as a [`mods.Set`](https://luamod.github.io/mods/modules/set).
---
---```lua
---kw.kwlset():contains("and") --> true
---```
---
---@return mods.Set<string> words
---@nodiscard
function M.kwset() end

---
---Normalize an input into a safe Lua identifier.
---
---```lua
---kw.normalize_identifier(" 2 bad-name ") --> "_2_bad_name"
---```
---
---@param s any
---@return string ident
---@nodiscard
function M.normalize_identifier(s) end

return M
