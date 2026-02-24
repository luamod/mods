---@meta mods.is

---@alias modsIsType
---|'boolean'
---|'Boolean'
---|'function'
---|'Function'
---|'nil'
---|'Nil'
---|'number'
---|'Number'
---|'string'
---|'String'
---|'table'
---|'Table'
---|'thread'
---|'Thread'
---|'userdata'
---|'Userdata'
---
---|'false'
---|'False'
---|'falsy'
---|'Falsy'
---|'integer'
---|'Integer'
---|'true'
---|'True'
---|'truthy'
---|'Truthy'
---
---|'block'
---|'Block'
---|'callable'
---|'Callable'
---|'char'
---|'Char'
---|'device'
---|'Device'
---|'dir'
---|'Dir'
---|'fifo'
---|'Fifo'
---|'file'
---|'File'
---|'link'
---|'Link'
---|'socket'
---|'Socket'

---
---Type predicates for Lua values and filesystem path kinds.
---
---## Usage
---
---```lua
---is = require "mods.is"
---
---ok = is.number(3.14)       --> true
---ok = is("hello", "string") --> true
---ok = is.table({})          --> true
---```
---
---> [!NOTE]
--->
---> Function names exist in both lowercase and capitalized forms, and `is` is
---> also callable as `is(v, tp)`.
--->
---> ```lua
---> is.table({})          --> true
---> is.Table({})          --> true
---> is("hello", "string") --> true
---> is("hello", "String") --> true
---> ```
---
---## Dependencies
---
---Dependencies below are lazy-loaded 💤 on first access.
---
---* [`lfs`](https://github.com/lunarmodules/luafilesystem) (optional; required
---  only for filesystem/path checks)
---
---@class mods.is
---@overload fun(v:any, tp:modsIsType):boolean
local M = {}

--------------------------------------------------------------------------------
---------------------------------- Type Checks ---------------------------------
--------------------------------------------------------------------------------
---
---Core Lua type checks (`type(v)` family).
---

---
---Returns `true` when `v` is a boolean.
---
---```lua
---is.boolean(true)
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.boolean = function(v) end
M.Boolean = M.boolean

---
---Returns `true` when `v` is a function.
---
---```lua
---is.Function(function() end)
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.Function = function(v) end
M["function"] = M.Function

---
---Returns `true` when `v` is `nil`.
---
---```lua
---is.Nil(nil)
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.Nil = function(v) end
M["nil"] = M.Nil

---
---Returns `true` when `v` is a number.
---
---```lua
---is.number(3.14)
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.number = function(v) end
M.Number = M.number

---
---Returns `true` when `v` is a string.
---
---```lua
---is.string("hello")
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.string = function(v) end
M.String = M.string

---
---Returns `true` when `v` is a table.
---
---```lua
---is.table({})
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.table = function(v) end
M.Table = M.table

---
---Returns `true` when `v` is a thread.
---
---```lua
---is.thread(coroutine.create(function() end))
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.thread = function(v) end
M.Thread = M.thread

---
---Returns `true` when `v` is userdata.
---
---```lua
---is.userdata(io.stdout)
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.userdata = function(v) end
M.Userdata = M.userdata

--------------------------------------------------------------------------------
--------------------------------- Value Checks ---------------------------------
--------------------------------------------------------------------------------
---
---Truthiness, exact-value, and callable checks.
---

---
---Returns `true` when `v` is exactly `false`.
---
---```lua
---is.False(false)
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.False = function(v) end
M["false"] = M.False

---
---Returns `true` when `v` is exactly `true`.
---
---```lua
---is.True(true)
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.True = function(v) end
M["true"] = M.True

---
---Returns `true` when `v` is falsy.
---
---```lua
---is.falsy(false)
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.falsy = function(v) end
M.Falsy = M.falsy

---
---Returns `true` when `v` is callable.
---
---```lua
---is.callable(function() end)
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.callable = function(v) end
M.Callable = M.callable

---
---Returns `true` when `v` is an integer.
---
---```lua
---is.integer(42)
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.integer = function(v) end
M.Integer = M.integer

---
---Returns `true` when `v` is truthy.
---
---```lua
---is.truthy("non-empty")
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.truthy = function(v) end
M.Truthy = M.truthy

--------------------------------------------------------------------------------
--------------------------------- Path Checks ----------------------------------
--------------------------------------------------------------------------------
---
---Filesystem path kind checks.
---
---> [!IMPORTANT]
--->
---> Path checks require **LuaFileSystem**
---> ([`lfs`](https://github.com/lunarmodules/luafilesystem))
---> and raise an error it is not installed.

---
---Returns `true` when `v` is a block device path.
---
---Raises an error if [`lfs`](https://github.com/lunarmodules/luafilesystem) is not installed.
---
---```lua
---is.block("/dev/sda")
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.block = function(v) end
M.Block = M.block

---
---Returns `true` when `v` is a char device path.
---
---```lua
---is.char("/dev/null")
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.char = function(v) end
M.Char = M.char

---
---Returns `true` when `v` is a block or char device path.
---
---```lua
---is.device("/dev/null")
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.device = function(v) end
M.Device = M.device

---
---Returns `true` when `v` is a directory path.
---
---```lua
---is.dir("/tmp")
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.dir = function(v) end
M.Dir = M.dir

---
---Returns `true` when `v` is a FIFO path.
---
---```lua
---is.fifo("/path/to/fifo")
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.fifo = function(v) end
M.Fifo = M.fifo

---
---Returns `true` when `v` is a file path.
---
---```lua
---is.file("README.md")
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.file = function(v) end
M.File = M.file

---
---Returns `true` when `v` is a symlink path.
---
---```lua
---is.link("/path/to/link")
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.link = function(v) end
M.Link = M.link

---
---Returns `true` when `v` is a socket path.
---
---```lua
---is.socket("/path/to/socket")
---```
---
---@param v any
---@return boolean ok
---@nodiscard
M.socket = function(v) end
M.Socket = M.socket

return M
