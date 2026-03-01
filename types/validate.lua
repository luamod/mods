---@meta mods.validate

---@class modsValidateMessages
---@field [string] string
---
---@field boolean? string
---@field function? string
---@field nil? string
---@field number? string
---@field string? string
---@field table? string
---@field thread? string
---@field userdata? string
---
---@field callable? string
---@field false? string
---@field falsy? string
---@field integer? string
---@field true? string
---@field truthy? string
---
---@field block? string
---@field char? string
---@field device? string
---@field dir? string
---@field fifo? string
---@field file? string
---@field link? string
---@field socket? string

---
---Validation checks for values and filesystem path types.
---
---## Usage
---
---```lua
---local validate = require "mods.validate"
---
---ok, err = validate.number("nope") --> false, "expected number, got string"
---ok, err = validate(123, "number") --> true, nil
---```
---
---## Callable Behavior
---> `validate(v, tp)` dispatches to the registered validator `tp`.
---> If `tp` is omitted, it defaults to `"truthy"`.
--->
---> ```lua
---> validate()         --> false, "expected truthy value, got no value"
---> validate(1)        --> true, nil
---> validate(1, "nil") --> false, "expected nil, got number"
---> ```
---
---## Validator Names
---
---Validator names are case-insensitive for field access.
---
---```lua
---validate.number(1) --> true, nil
---validate.NumBer(1) --> true, nil
---```
---
---`tp` in `validate(v, tp)` is matched as-is (case-sensitive):
---
---```lua
---validate(1, "number") --> true, nil
---validate(1, "NuMbEr") --> false, "expected NuMbEr, got number"
--- ```
---
---## Custom Messages
---
---Customize validator error messages through `validate.messages`.
---Keys are validator names (for example: `number`, `truthy`, `file`, ...).
---
---```lua
---validate.messages.number = "need {{expected}}, got {{got}}"
---ok, err = validate.number("x") --> false, "need number, got string"
---```
---
---Available placeholders:
---
---* <code v-pre>{{expected}}</code>: The check target (for example `number`,
---  `string`, `truthy`).
---* <code v-pre>{{got}}</code>: The detected failure kind (usually a Lua type;
---  path validators use `invalid path`).
---* <code v-pre>{{value}}</code>: The passed value, formatted for display (strings
---  are quoted).
---
---> [!NOTE]
--->
---> When the passed value is `nil`, rendered value text uses `no value`.
---
---## Default Messages
---
---Defaults by category:
---
---* Type checks: `expected {{expected}}, got {{got}}`
---* Value checks: `expected {{expected}} value, got {{value}}`
---* Path checks: `{{value}} is not a valid {{expected}} path`
---
---@class mods.validate
---@field [string] fun(...):(ok:boolean,errmsg:string?)
---
---Validation checks for values and filesystem path types.
---entry to customize the error string returned by validators. Templates can
---use <code v-pre>{{expected}}</code>, <code v-pre>{{got}}</code>, and
---<code v-pre>{{value}}</code>.
---
---@field messages modsValidateMessages
---@overload fun(v:any, tp?:modsIsType|string):(boolean, string?)
local M = {}

---
---Register or override a validator function by name.
---* If `msg` is provided, it becomes the default message template for that validator.
---* If `msg` is omitted, failures use: `expected {{expected}}, got {{got}}`.
---
---```lua
---validate.register("odd", function(v)
---  return type(v) == "number" and v % 2 == 1
---end, "{{value}} does not satisfy {{expected}}")
---
---ok, err = validate.odd(3)     --> true, nil
---ok, err = validate.odd("x")   --> false, '"x" does not satisfy odd'
---ok, err = validate(2, "odd")  --> false, "2 does not satisfy odd"
---```
---
---@param name string
---@param check fun(v: any):ok:boolean
---@param msg? string
---@return nil
function M.register(name, check, msg) end

--------------------------------------------------------------------------------
---------------------------------- Type Checks ---------------------------------
--------------------------------------------------------------------------------
---
---Basic Lua type validators (and their negated variants).
---

---
---Returns `true` when `v` is a boolean. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.boolean(true) --> true, nil
---ok, err = validate.is.boolean(1)    --> false, "expected boolean, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.boolean = function(v) end
M.Boolean = M.boolean

---
---@name function
---
---Returns `true` when `v` is a function. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.Function(function() end) --> true, nil
---ok, err = validate.is.Function(1)
-----> false, "expected function, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.Function = function(v) end
M["function"] = M.Function

---
---@name nil
---
---Returns `true` when `v` is `nil`. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.Nil(nil) --> true, nil
---ok, err = validate.is.Nil(0)   --> false, "expected nil, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.Nil = function(v) end
M["nil"] = M.Nil

---
---Returns `true` when `v` is a number. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.number(42)  --> true, nil
---ok, err = validate.is.number("x") --> false, "expected number, got string"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.number = function(v) end
M.Number = M.number

---
---Returns `true` when `v` is a string. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.string("hello") --> true, nil
---ok, err = validate.is.string(1)       --> false, "expected string, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.string = function(v) end
M.String = M.string

---
---Returns `true` when `v` is a table. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.table({}) --> true, nil
---ok, err = validate.is.table(1)  --> false, "expected table, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.table = function(v) end
M.Table = M.table

---
---Returns `true` when `v` is a thread. Otherwise returns `false` and an error
---message.
---
---```lua
---co = coroutine.create(function() end)
---ok, err = validate.is.thread(co) --> true, nil
---ok, err = validate.is.thread(1)  --> false, "expected thread, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.thread = function(v) end
M.Thread = M.thread

---
---Returns `true` when `v` is userdata. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.userdata(io.stdout) --> true, nil
---ok, err = validate.is.userdata(1)         --> false, "expected userdata, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.userdata = function(v) end
M.Userdata = M.userdata

--------------------------------------------------------------------------------
--------------------------------- Value Checks ---------------------------------
--------------------------------------------------------------------------------
---
---Value-state validators (exact true/false, truthy/falsy, callable, integer).
---

---
---@name false
---
---Returns `true` when `v` is exactly `false`. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is.False(false) --> true, nil
---ok, err = validate.is.False(true)  --> false, "expected false, got true"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.False = function(v) end
M["false"] = M.False

---
---@name true
---
---Returns `true` when `v` is exactly `true`. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is.True(true)  --> true, nil
---ok, err = validate.is.True(false) --> false, "expected true, got false"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.True = function(v) end
M["true"] = M.True

---
---Returns `true` when `v` is falsy. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.falsy(false) --> true, nil
---ok, err = validate.is.falsy(1)     --> false, "expected falsy, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.falsy = function(v) end
M.Falsy = M.falsy

---
---Returns `true` when `v` is callable. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.callable(type) --> true, nil
---ok, err = validate.is.callable(1)    --> false, "expected callable, got number"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.callable = function(v) end
M.Callable = M.callable

---
---Returns `true` when `v` is an integer. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.integer(1)   --> true, nil
---ok, err = validate.is.integer(1.5) --> false, "expected integer, got 1.5"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.integer = function(v) end
M.Integer = M.integer

---
---Returns `true` when `v` is truthy. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.truthy(1)     --> true, nil
---ok, err = validate.is.truthy(false) --> false, "expected truthy, got boolean"
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.truthy = function(v) end
M.Truthy = M.truthy

--------------------------------------------------------------------------------
--------------------------------- Path Checks ----------------------------------
--------------------------------------------------------------------------------
---
---Filesystem path-kind validators backed by LuaFileSystem (`lfs`).
---
---Filesystem path kind checks.
---
---> [!IMPORTANT]
--->
---> Path checks require **LuaFileSystem**
---> ([`lfs`](https://github.com/lunarmodules/luafilesystem))
---> and raise an error it is not installed.

---
---Returns `true` when `v` is a block device path. Otherwise returns `false`
--- and an error message.
---
---```lua
---ok, err = validate.is.block(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.block = function(v) end
M.Block = M.block

---
---Returns `true` when `v` is a char device path. Otherwise returns `false` and
---an error message.
---
---```lua
---ok, err = validate.is.char(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.char = function(v) end
M.Char = M.char

---
---Returns `true` when `v` is a block or char device path. Otherwise returns
---`false` and an error message.
---
---```lua
---ok, err = validate.is.device(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.device = function(v) end
M.Device = M.device

---
---Returns `true` when `v` is a directory path. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is.dir(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.dir = function(v) end
M.Dir = M.dir

---
---Returns `true` when `v` is a FIFO path. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.fifo(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.fifo = function(v) end
M.Fifo = M.fifo

---
---Returns `true` when `v` is a file path. Otherwise returns `false` and an error
---message.
---
---```lua
---ok, err = validate.is.file(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.file = function(v) end
M.File = M.file

---
---Returns `true` when `v` is a symlink path. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is.link(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.link = function(v) end
M.Link = M.link

---
---Returns `true` when `v` is a socket path. Otherwise returns `false` and an
---error message.
---
---```lua
---ok, err = validate.is.socket(".")
---```
---
---@param v any
---@return boolean ok
---@return string? err
M.socket = function(v) end
M.Socket = M.socket

return M
