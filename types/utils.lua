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
---@field lfs LuaFileSystem Lazy-loaded on first key access.
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

---
---Format a list-like table as a comma-separated argument string.
---
---```lua
---utils.list_args({ "a", 1, true }) --> '"a", 1, true'
---```
---
---> [!NOTE]
--->
---> Requires [`inspect`](https://github.com/kikito/inspect.lua)
---
---@param v table|any Value to format.
---@return string out Argument list string.
---@nodiscard
function M.list_args(v) end

---
---Assert argument value using `mods.validate` and raise a Lua error on failure.
---
---```lua
---utils.assert_arg(1, "ok", "string") --> "ok"
---utils.assert_arg(2, 123, "string")
-----> raises: bad argument #2 (expected string, got number)
---utils.assert_arg(3, "x", "number", 2, "need {{expected}}, got {{got}}")
-----> raises: bad argument #3 (need number, got string)
---```
---
---> [!NOTE]
--->
---> When the caller function name is available, error text includes
---> `to '<function>'` (Lua-style bad argument context).
---
---@generic T
---@param argn integer Argument index for error context.
---@param v T Value to check.
---@param tp? modsIsType Validator name (defaults to `"truthy"`).
---@param level? integer Optional error level for `error(...)` (defaults to `2`).
---@param msg? string Optional override template passed to `mods.validate`.
---@return T validatedValue Same input value on success.
function M.assert_arg(argn, v, tp, level, msg) end

return M
